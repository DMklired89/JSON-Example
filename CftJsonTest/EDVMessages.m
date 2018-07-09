//
//  Messages.m
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 31.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVMessages.h"

@implementation EDVMessages

// Переопределенный метод init с дополнительными параметрами
-(id) initWithMessages:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        _messageDate = [dict objectForKey: @"date"];
        _messageNetwork = [dict objectForKey: @"network"];
        _messageContent = [dict objectForKey: @"content"];
        _messageTitle = [dict objectForKey: @"title"];
        _messageType = [dict objectForKey: @"type"];
        
        // URL
        NSString *urlString = [dict objectForKey: @"source"];
        if (urlString) {
            _messageSource = [NSURL URLWithString: urlString];
        } 
    }
    return self;
}

@end
