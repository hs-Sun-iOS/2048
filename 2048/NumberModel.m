//
//  NumberModel.m
//  2048
//
//  Created by sunhaosheng on 15/6/8.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import "NumberModel.h"

@implementation NumberModel

- (instancetype)initWithNumber:(NSInteger)num
{
    self = [super init];
    if (self) {
        self.number = num;
    }
    return self;
}

@end
