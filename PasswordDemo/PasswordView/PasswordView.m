//
//  PasswordView.m
//  PasswordDemo
//
//  Created by yaoxiaobing on 16/1/23.
//  Copyright © 2016年 bing. All rights reserved.
//

#import "PasswordView.h"

#define NumberOfPasswordBits 6 //密码位数
#define CellMark @"Password"

@interface PasswordView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger numberOfInputBits;

@end


@implementation PasswordView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.borderColor = [UIColor grayColor].CGColor;
    self.collectionView.layer.borderWidth = 1.0f;
    [self.textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellMark];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self becomeFirstResponder];
}


#pragma mark - 清楚状态

- (void)cleanLastState
{
    self.textField.text = nil;
    self.numberOfInputBits = 0;
}

#pragma mark - 监听输入
- (void)textChanged:(UITextField *)textField
{
    NSString *text = textField.text;
    if (text.length >= NumberOfPasswordBits) {
        textField.text = [text substringToIndex:NumberOfPasswordBits];
    }
    if (self.textChangedBlock) {
        self.textChangedBlock(textField.text);
    }
    
    self.numberOfInputBits = textField.text.length;
}


#pragma mark - FirstResponder
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return  [self.textField becomeFirstResponder];
    
}


#pragma mark - CollectionViewDelegate,DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return NumberOfPasswordBits;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellMark forIndexPath:indexPath];
    if (!cell.backgroundView) {
        cell.backgroundView = [[UIImageView alloc] init];
    }
    UIImageView * imageView = (UIImageView *)cell.backgroundView;
    if (indexPath.row < self.numberOfInputBits) {
        if (indexPath.item == NumberOfPasswordBits -1) {
            imageView.image =  [UIImage imageNamed:@"set_password_input_no_border"];
        } else {
            imageView.image =  [UIImage imageNamed:@"set_password_input_border"];
        }
    } else {
        if (indexPath.item == NumberOfPasswordBits -1) {
            imageView.image =  [UIImage imageNamed:@"set_password_empty_no_border"];
        } else {
            imageView.image =  [UIImage imageNamed:@"set_password_empty_border"];
        }
    }
    return cell;
}


- (void)setNumberOfInputBits:(NSInteger)numberOfInputBits
{
    _numberOfInputBits = numberOfInputBits;
    [self.collectionView reloadData];
}
@end
