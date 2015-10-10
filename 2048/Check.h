//
//  Check.h
//  2048
//
//  Created by sunhaosheng on 15/6/8.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NumberModel;
@interface Check : UIButton

@property (nonatomic,strong) NumberModel *numberModel;

@property (nonatomic,assign) BOOL isNewNumber; // 该check是否将要显示的是新随机产生的数字  reason： 需要加上动画

@property (nonatomic,assign) BOOL isCombined;  // 该check是否将要显示的是合并的数字  reason：需要加上动画

@property (nonatomic,assign) int steps; // 需要移动的步数

- (instancetype)initWithFrame:(CGRect)frame AndNumberModel:(NumberModel *)numberModel;

@end