//
//  Check.m
//  2048
//
//  Created by sunhaosheng on 15/6/8.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import "Check.h"
#import "NumberModel.h"
#import "GameLogicalManager.h"

@implementation Check
- (instancetype)initWithFrame:(CGRect)frame AndNumberModel:(NumberModel *)numberModel
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.numberModel = numberModel;
//        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    }
    return self;
}

- (void)setNumberModel:(NumberModel *)numberModel
{
    _numberModel = numberModel;
    
    
    if (numberModel != nil) {
        if (_isNewNumber) {
            self.transform = CGAffineTransformMakeScale(0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                self.transform = CGAffineTransformMakeScale(1, 1);
                [self updateBackgroundColor:_numberModel.number];
                [self updateLabelText:_numberModel.number];
            }];
        } else
        {
            [self updateBackgroundColor:_numberModel.number];
            [self updateLabelText:_numberModel.number];
            
        }
    } else
    {
        [self updateBackgroundColor:0];
        [self updateLabelText:0];
    }
    _isNewNumber = NO;
    
    
}

- (void)updateLabelText:(NSInteger) number
{
    if (number != 0) {
        [self setTitle:[NSString stringWithFormat:@"%ld",(long)number] forState:UIControlStateNormal];
    } else
    {
        [self setTitle:nil forState:UIControlStateNormal];
        return;
    }
    
    if (number < 8) {
        [self setTitleColor:color(105, 97, 86) forState:UIControlStateNormal];
    } else
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)updateBackgroundColor:(NSInteger)number
{
    self.backgroundColor = [[GameLogicalManager shareManager] colorWithNumber:number];
}

@end
