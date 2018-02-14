//
//  WebViewController.h
//  ProfileLoader
//
//  Created by whoami on 12/15/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *initialURL;
@property (strong, nonatomic) NSString *currentURL;
@property (strong, nonatomic) NSString *userID;

@end
