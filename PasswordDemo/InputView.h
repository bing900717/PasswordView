//
//  InputView.h
//  PasswordDemo
//
//  Created by yaoxiaobing on 16/1/23.
//  Copyright © 2016年 bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

@property (nonatomic, copy) void(^textChangeBlock)(NSString *text);
@property (nonatomic, copy) NSString *tip;

- (void)clear;

@end
