//
//  GameLogical.m
//  2048
//
//  Created by sunhaosheng on 15/6/8.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import "GameLogicalManager.h"
#import "NumberModel.h"
#import "Check.h"

@interface GameLogicalManager()<UIAlertViewDelegate>
{
    NSDictionary *numberAndColorDict;
    NSMutableSet *randomNumberSet;
    
    BOOL isConbined; //是否有数字合并
    BOOL isMoved; //格子位置是否发生变化
}

@end

@implementation GameLogicalManager

+ (instancetype)shareManager
{
    static GameLogicalManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GameLogicalManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        numberAndColorDict = [NSDictionary dictionaryWithObjects:@[color(195, 181, 164),color(234, 223, 210),color(233, 219, 189),color(239, 163, 96),color(243, 131, 76),color(244, 102, 72),color(245, 69, 36),color(233, 200, 88),color(210, 180, 67),color(234, 193, 51),color(235, 185, 74),color(235, 185, 74)] forKeys:@[@"0",@"2",@"4",@"8",@"16",@"32",@"64",@"128",@"256",@"512",@"1024",@"2048"]];
        randomNumberSet = [NSMutableSet set];
    }
    return self;
}

- (void)startGame
{
    for (int i = 0; i < 2; i++) {
         [self getOneRandomNumber];
    }
}
- (void)resumeGame
{
    [self.delegate resumeGame];
}

- (void)handleUpMoved:(NSMutableArray *)columnArray
{
    isMoved = NO;
    for (int column = 0; column < 4; column++) {
        isConbined = NO;
        //循环合并三次保证中间不会有空的格子
        for (int times = 0; times < 3; times++) {
            for (int row = 0; row < 3; row++) {
                if ((numberMatrix[column][row] == numberMatrix[column][row + 1] && !isConbined && numberMatrix[column][row+1]+numberMatrix[column][row]!=0) || (numberMatrix[column][row] == 0 && numberMatrix[column][row+1]!=0)) {
                    isMoved = YES;
                    if (numberMatrix[column][row] != 0 && numberMatrix[column][row + 1] != 0) {
                        isConbined = YES;
                        [self.delegate scoreChangedWithAddScore:numberMatrix[column][row]];
                    }
                    numberMatrix[column][row] = numberMatrix[column][row] + numberMatrix[column][row + 1];
                    numberMatrix[column][row + 1] = 0;
                    [self.delegate checkMovedFromColumn:column Row:row + 1 ToColumn:column Row:row];
                }
            }
        }
    }
    
    [self.delegate handleMoveEventFinished];
    
    if (isMoved) {
        [self getOneRandomNumber];
    }
 
}

- (void)handleDownMoved:(NSMutableArray *)columnArray
{
    isMoved = NO;
    for (int column = 0; column < 4; column++) {
        isConbined = NO;
        //循环合并三次保证中间不会有空的格子
        for (int times = 0; times < 3; times++) {
            for (int row = 3; row > 0; row--) {
                if ((numberMatrix[column][row] == numberMatrix[column][row - 1] && !isConbined && numberMatrix[column][row]+numberMatrix[column][row-1]!=0) || (numberMatrix[column][row] == 0 && numberMatrix[column][row-1]!=0)) {
                    isMoved = YES;
                    if (numberMatrix[column][row] != 0 && numberMatrix[column][row - 1] != 0) {
                        isConbined = YES;
                        [self.delegate scoreChangedWithAddScore:numberMatrix[column][row]];
                    }
                    numberMatrix[column][row] = numberMatrix[column][row] + numberMatrix[column][row - 1];
                    numberMatrix[column][row - 1] = 0;
                    [self.delegate checkMovedFromColumn:column Row:row-1 ToColumn:column Row:row];
                }
            }
        }
    }
    [self.delegate handleMoveEventFinished];
    
    if (isMoved) {
        [self getOneRandomNumber];
    }
    
}

- (void)handleLeftMoved:(NSMutableArray *)columnArray
{
    isMoved = NO;
    for (int row = 0; row < 4; row++) {
        isConbined = NO;
        //循环合并三次保证中间不会有空的格子
        for (int times = 0; times < 3; times++) {
            for (int column = 0; column < 3; column++) {
                if ((numberMatrix[column][row] == numberMatrix[column + 1][row] && !isConbined && numberMatrix[column+1][row]+numberMatrix[column ][row] != 0) || (numberMatrix[column][row] == 0 && numberMatrix[column+1][row]!=0)) {
                    isMoved = YES;
                    if (numberMatrix[column][row] != 0 && numberMatrix[column + 1][row] != 0) {
                        isConbined = YES;
                        [self.delegate scoreChangedWithAddScore:numberMatrix[column][row]];
                    }
                    
                    numberMatrix[column][row] = numberMatrix[column][row] + numberMatrix[column + 1][row];
                    numberMatrix[column + 1][row] = 0;
                    [self.delegate checkMovedFromColumn:column+1 Row:row ToColumn:column Row:row];
                }

            }
        }
    }
    [self.delegate handleMoveEventFinished];
    
    if (isMoved) {
        [self getOneRandomNumber];
    }
    
}

- (void)handleRightMoved:(NSMutableArray *)columnArray
{
    isMoved = NO;
    for (int row = 0; row < 4; row++) {
        isConbined = NO;
        //循环合并三次保证中间不会有空的格子
        for (int times = 0; times < 3; times++) {
            for (int column = 3; column > 0; column--) {
                if ((numberMatrix[column][row] == numberMatrix[column - 1][row] && !isConbined && numberMatrix[column][row] + numberMatrix[column - 1][row] != 0) || (numberMatrix[column ][row] == 0 && numberMatrix[column - 1][row] != 0)) {
                    isMoved = YES;
                    if (numberMatrix[column][row] != 0 && numberMatrix[column - 1][row] != 0) {
                        isConbined = YES;
                        [self.delegate scoreChangedWithAddScore:numberMatrix[column][row]];
                    }
                    numberMatrix[column][row] = numberMatrix[column][row] + numberMatrix[column - 1][row];
                    numberMatrix[column - 1][row] = 0;
                    [self.delegate checkMovedFromColumn:column-1 Row:row ToColumn:column Row:row];
                }
            }
        }
    }
    [self.delegate handleMoveEventFinished];
    
    if (isMoved) {
        [self getOneRandomNumber];
    }
    
}



- (void)getOneRandomNumber
{
    BOOL isExistEmptyCheck = NO;

    // 检查是否存在可用的格子
    for (int i = 1; i < 17; i++) {
        if (numberMatrix[(i-1)%4][(i-1)/4] == 0) {
            isExistEmptyCheck = YES;
            break;
        } else
            continue;
    }
    NSNumber *randomNumber;
    if (isExistEmptyCheck) {
        do {
            randomNumber = [NSNumber numberWithInt:arc4random()%16 +1];
        } while (numberMatrix[(randomNumber.intValue-1)%4][(randomNumber.intValue-1)/4] != 0);
    } else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"游戏结束" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新开始", nil];
        [alert show];
        return;
    }

    
    NumberModel *nm;
    NSInteger num = arc4random()%2;
    if (num == 0) {
        nm = [[NumberModel alloc] initWithNumber:num + 2];
    } else
        nm = [[NumberModel alloc] initWithNumber:num + 3];
    
    [self.delegate getRandomTag:randomNumber.intValue AndNumberModel:nm];
    
    numberMatrix[(randomNumber.intValue - 1)%4][(randomNumber.intValue - 1)/4] = nm.number;

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            break;
            
        default:
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            [self resumeGame];
            break;
    }
}

- (UIColor *)colorWithNumber:(NSInteger)number
{
    return [numberAndColorDict valueForKey:[NSString stringWithFormat:@"%ld",(long)number]];
}

@end
