//
//  MessageDetailWebViewController.m
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 10.06.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import "EDVMessageDetailWebViewController.h"
#import "EDVMessages.h"
#import "EDVMessageTableViewController.h"

@interface EDVMessageDetailWebViewController ()

@end

@implementation EDVMessageDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // URL request
    NSURL *url = self.message.messageSource;
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [request debugDescription];
    return YES;
}

@end
