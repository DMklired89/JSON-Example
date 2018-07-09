//
//  ImageDetailViewController.h
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 11.06.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDVMessages;

@interface EDVImageDetailViewController : UIViewController

// preloadedImage
@property (strong, nonatomic) UIImage *preloadedImage;
// message для передачи данных из таблицы в webView
@property (strong, nonatomic) EDVMessages *message;

@end
