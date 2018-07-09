//
//  NetworkService.m
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 31.05.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVNetworkService.h"
#import "EDVMessages.h"

@implementation EDVNetworkService

+(void) loadImageByURL: (NSURL *) urlToLoad completion: (void(^)(UIImage *image)) completion {
    // Работа с изображением в фоновом потоке
    NSURLSessionTask *task = [[NSURLSession sharedSession]
                              dataTaskWithURL: urlToLoad
                              completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            UIImage *image = [UIImage imageWithData: data];
            completion(image);
        }
}];
    [task resume];
}

@end
