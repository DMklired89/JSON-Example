//
//  ImageDetailViewController.m
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 11.06.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVImageDetailViewController.h"
#import "EDVNetworkService.h"
#import "EDVMessages.h"

@interface EDVImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation EDVImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Если есть предзагруженная картинка..
    if (self.preloadedImage) {
        self.imageView.image = self.preloadedImage;
    } else {
        // Если нет предзагруженной - загрузить новую 
        __weak typeof(self) weakSelf = self;
        [EDVNetworkService loadImageByURL: self.message.messageSource completion: ^(UIImage *image) {
            weakSelf.imageView.image = image;
        }];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
