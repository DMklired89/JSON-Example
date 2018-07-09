//
//  Messages.h
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 31.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDVMessages : NSObject

// Данные о сообщениях из json файла
@property (nonatomic, strong) NSString *messageDate;
@property (nonatomic, strong) NSString *messageNetwork;
@property (nonatomic, strong) NSString *messageContent;
@property (nonatomic, strong) NSString *messageTitle;
@property (nonatomic, strong) NSString *messageType;
@property (nonatomic, strong) NSURL *messageSource;

// Переопределенный метод
-(id) initWithMessages: (NSDictionary *) dict;

@end
