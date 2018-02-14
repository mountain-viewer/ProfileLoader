//
//  WebViewController.m
//  ProfileLoader
//
//  Created by whoami on 12/15/17.
//  Copyright © 2017 Mountain Viewer. All rights reserved.
//

#import "WebViewController.h"
#import "FormViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
- (IBAction)doneButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"back" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"back"]) {
        FormViewController *vc = (FormViewController *)segue.destinationViewController;
        vc.resultURL = self.currentURL;
        vc.userID = self.userID;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.initialURL]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.currentURL = self.webView.request.URL.absoluteString;
    NSLog(@"%@", self.currentURL);
    
    NSString *string = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    if ([string rangeOfString:@"profile_id"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        NSString *pattern = [string substringWithRange:NSMakeRange([string rangeOfString:@"profile_id"].location, 50)];
        
        // Intermediate
        NSString *numberString;
        
        NSScanner *scanner = [NSScanner scannerWithString:pattern];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&numberString];
        
        self.userID = numberString;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
