//
//  DemoViewController.m
//  PasswordDemo
//
//  Created by yaoxiaobing on 16/1/23.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "DemoViewController.h"
#import "InputView.h"
#import "Masonry.h"

@interface DemoViewController ()


@property (nonatomic, strong) InputView *fistInputView;
@property (nonatomic, strong) InputView *lastInputView;

@property (nonatomic, copy) NSString *fistInput;
@property (nonatomic, copy) NSString *lastInput;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.fistInputView];
    [self.view addSubview:self.lastInputView];
    
    [self.fistInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.lastInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.lastInputView.hidden = YES;
    [self.fistInputView becomeFirstResponder];
}

#pragma mark - 
- (void)check
{
    __weak typeof(self)weakself = self;
    if ([self.fistInput isEqualToString:self.lastInput]) {
    
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself.view endEditing:YES];
            [weakself.navigationController popViewControllerAnimated:YES];
        }];

        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入正确" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    } else {
    
        UIAlertAction *actionRetry = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself switchToFirstInputMode];
        }];

        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself.view endEditing:YES];
            [weakself.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证失败" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:actionCancel];
        [alertVC addAction:actionRetry];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}






#pragma mark -
- (void)switchToFirstInputMode
{
    //clean
    [self.fistInputView clear];
    [self.lastInputView clear];
    
    
    self.lastInputView.hidden = YES;
    self.fistInputView.hidden = NO;
    [self.fistInputView becomeFirstResponder];
}

- (void)switchToLastInputMode
{
    self.fistInputView.hidden = YES;
    self.lastInputView.hidden = NO;
    [self.lastInputView becomeFirstResponder];
}

#pragma mark -
- (InputView *)fistInputView
{
    if (!_fistInputView) {
        _fistInputView = [[InputView alloc] init];
        _fistInputView.tip = @"请输入密码";
        __weak typeof(self) weakself = self;
        _fistInputView.textChangeBlock = ^(NSString *text){
            weakself.fistInput = text;
        };
    }
    return _fistInputView;

}

- (InputView *)lastInputView
{
    if (!_lastInputView) {
        _lastInputView = [[InputView alloc] init];
        _lastInputView.tip = @"请再次输入密码";

        __weak typeof(self) weakself = self;
        _lastInputView.textChangeBlock = ^(NSString *text){
            weakself.lastInput = text;
        };
    }
    return _lastInputView;
}

- (void)setFistInput:(NSString *)fistInput
{
    _fistInput = fistInput;
    if (fistInput.length == 6) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self switchToLastInputMode];
        });
    }

}

- (void)setLastInput:(NSString *)lastInput
{
    _lastInput = lastInput;
    if (lastInput.length == 6) {
        [self check];
    }
}

@end
