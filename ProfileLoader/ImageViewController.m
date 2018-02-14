//
//  ImageViewController.m
//  ProfileLoader
//
//  Created by whoami on 2/14/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "ImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageViewController

- (IBAction)backButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"back" sender:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.url]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
