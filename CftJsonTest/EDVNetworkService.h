//
//  NetworkService.h
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 31.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EDVNetworkService : NSObject

// Загрузка Image по URL
+(void) loadImageByURL: (NSURL *) urlToLoad completion: (void(^)(UIImage *image)) completion;

@end
