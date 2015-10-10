//
//  GameLogical.h
//  2048
//
//  Created by sunhaosheng on 15/6/8.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define color(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@protocol GameLogicalManagerDelegate;
@class NumberModel;

@interface GameLogicalManager : NSObject
{
    @public
    long numberMatrix[4][4];
}

@property (nonatomic,assign) id<GameLogicalManagerDelegate> delegate;

+ (instancetype)shareManager;

- (UIColor *)colorWithNumber:(NSInteger)number;

- (void)startGame;

- (void)resumeGame;

- (void)handleUpMoved:(NSMutableArray *)columnArray;

- (void)handleDownMoved:(NSMutableArray *)columnArray;

- (void)handleLeftMoved:(NSMutableArray *)columnArray;

- (void)handleRightMoved:(NSMutableArray *)columnArray;

@end

@protocol GameLogicalManagerDelegate <NSObject>

- (void)getRandomTag:(NSInteger)tag AndNumberModel:(NumberModel *)nm;

- (void)resumeGame;

- (void)handleMoveEventFinished;

- (void)scoreChangedWithAddScore:(NSInteger)score;

- (void)checkMovedFromColumn:(int)column Row:(int)row ToColumn:(int)toColumn Row:(int)toRow;

@end