//
//  MessageTableViewController.m
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 03.06.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVMessageTableViewController.h"
#import "EDVMessages.h"
#import "EDVMessageTableViewCell.h"
#import "EDVNetworkService.h"
#import "EDVMessageDetailWebViewController.h"
#import "EDVImageDetailViewController.h"

@interface EDVMessageTableViewController ()

@property (nonatomic, strong) NSArray *parsedJson;
@property (nonatomic, strong) NSMutableArray *messagesArray;
// Массив для сортировки писем по дате
@property (nonatomic, strong) NSArray *sortedArray;
// Массив для заполнения объектами после сортировки
@property (nonatomic, strong) NSMutableArray *arrayForSortedMessages;

@end

@implementation EDVMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSError *error = nil;
    
    // Путь к файлу json
    NSString *path = [[NSBundle mainBundle] pathForResource: @"messages" ofType: @"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile: path];
    
    // Создание массива, в котором будут данные из JSON
    self.parsedJson = [NSJSONSerialization JSONObjectWithData: data options:kNilOptions error: &error];
    self.messagesArray = [[NSMutableArray alloc] init];
    [self.messagesArray addObjectsFromArray: self.parsedJson];
    
    // Сортировка массива по дате
    NSSortDescriptor *sortDescriptor;
    // ascending: NO - сортировка в порядке убывания, YES - возрастания
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"date" ascending: NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
    
    self.sortedArray = [self.messagesArray sortedArrayUsingDescriptors: sortDescriptors];
    
    // Массив для заполнения объетами после сортировки
    self.arrayForSortedMessages = [[NSMutableArray alloc] init];
    
    // Заполнение массива объектами message, сортированными по дате
    for (NSDictionary *dictionary in self.sortedArray) {
        EDVMessages *message = [[EDVMessages alloc] initWithMessages: dictionary];
        [self.arrayForSortedMessages addObject: message];
    }
    
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Количество секций
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Количество строк в секции.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayForSortedMessages count];
}

// Ячейки
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EDVMessageTableViewCell *cell = (EDVMessageTableViewCell *) [tableView
                                                           dequeueReusableCellWithIdentifier: @"Cell"];
    
    EDVMessages *message = [self.arrayForSortedMessages objectAtIndex: indexPath.row];
    
    // Отображение информации
    cell.titleLabel.text = [NSString stringWithFormat: @"%@", message.messageTitle];
    cell.dateMessageLabel.text = [NSString stringWithFormat: @"%@", message.messageDate];
    cell.imageFromURL.image = nil;
    
    // Для предотвращения цикла self->cell->block->self->cell->...
    __weak typeof(self) weakSelf = self;
    
    // Если тип text..
    if ([message.messageType isEqualToString: @"text"]) {
        cell.textMessageLabel.text = [NSString stringWithFormat: @"%@", message.messageContent];
    } else {
        cell.textMessageLabel.text = [NSString stringWithFormat: @""];
    }
    
    // Если тип image..
    if ([message.messageType isEqualToString: @"image"]) {
        [EDVNetworkService loadImageByURL: message.messageSource completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                EDVMessageTableViewCell *updateCell = (id) [weakSelf.tableView cellForRowAtIndexPath: indexPath];
                if (updateCell) {
                    updateCell.imageFromURL.image = image;
                }
            });
        }];
    }
    
    // Если тип social..
    // twitter
    if ([message.messageNetwork isEqualToString: @"twitter"]) {
        if (cell) {
            cell.imageFromURL.image = [UIImage imageNamed: @"twitter.png"];
        }
    }
    // vkontakte
    else if ([message.messageNetwork isEqualToString:@"vkontakte"]) {
        if (cell) {
            cell.imageFromURL.image = [UIImage imageNamed: @"vk.png"];
        }
    }
    // facebook
    else if ([message.messageNetwork isEqualToString:@"facebook"]) {
        if (cell) {
            cell.imageFromURL.image = [UIImage imageNamed: @"facebook.png"];
        }
    }
    
    return cell;
}

#pragma mark - TableViewDelegate Methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    EDVMessages *message = [self.arrayForSortedMessages objectAtIndex: indexPath.row];

    // Если соц сеть..
    if ([message.messageType isEqualToString: @"social"]) {
        // Объект-новый контроллер
        EDVMessageDetailWebViewController *webViewMessageDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewMessageDetail"];
      
        // Передача данных в detailController
        webViewMessageDetail.message = message;
        
        [self.navigationController pushViewController: webViewMessageDetail animated: YES];
    }
    
    // Если image..
    if ([message.messageType isEqualToString: @"image"]) {
    
        // Объект-новый контроллер
        EDVImageDetailViewController *imageDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageDetailView"];
        
        EDVMessageTableViewCell *newCell = [tableView cellForRowAtIndexPath: indexPath];
        imageDetail.preloadedImage = newCell.imageFromURL.image;
        
        [self.navigationController pushViewController: imageDetail animated: YES];
    }
}

@end
