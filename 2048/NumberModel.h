//
//  NumberModel.h
//  2048
//
//  Created by sunhaosheng on 15/6/8.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@interface NumberModel : NSObject

@property (nonatomic,assign) NSInteger number;

- (instancetype)initWithNumber:(NSInteger)num;
@end
