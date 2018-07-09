//
//  MessageDetailWebViewController.h
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 10.06.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDVMessages;

@interface EDVMessageDetailWebViewController : UIViewController
// webView
@property (weak, nonatomic) IBOutlet UIWebView *webView;

// message для передачи данных из таблицы в webView
@property (strong, nonatomic) EDVMessages *message;
@end
