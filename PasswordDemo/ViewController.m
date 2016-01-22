//
//  ViewController.m
//  PasswordDemo
//
//  Created by yaoxiaobing on 16/1/23.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkPasswordAction:(id)sender {
    
    UIViewController *vc = [[NSClassFromString(@"DemoViewController") alloc] init];
    [self.navigationController  pushViewController:vc animated:YES];
    
}

@end
