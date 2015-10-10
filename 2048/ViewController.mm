//
//  ViewController.m
//  2048
//
//  Created by sunhaosheng on 15/6/5.
//  Copyright (c) 2015年 孙浩胜. All rights reserved.
//

#import "ViewController.h"
#import "GameLogicalManager.h"
#import "Check.h"
#import "NumberModel.h"

@interface ViewController () <GameLogicalManagerDelegate>
{
    NSMutableArray *rowArray;
    NSMutableArray *columnArray;
    BOOL isPlaying;
    UIPanGestureRecognizer *panGestureRecognizer;
}
@property (weak, nonatomic) IBOutlet UILabel *socerLabel;
@property (weak, nonatomic) IBOutlet UIView *gameView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUserInterface];
    [GameLogicalManager shareManager].delegate = self;
    isPlaying = NO;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUserInterface
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(115, 115, 370, 370)];
    backgroundView.backgroundColor = color(176, 160, 145);
    backgroundView.userInteractionEnabled = YES;
    [self.gameView addSubview:backgroundView];
    backgroundView.center = CGPointMake(self.gameView.frame.size.width/2, self.gameView.frame.size.height/2);
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
    [backgroundView addGestureRecognizer:panGestureRecognizer];
    
    columnArray = [NSMutableArray arrayWithCapacity:4];
    
    for (int column = 0; column < 4; column++) {
        rowArray = [NSMutableArray arrayWithCapacity:4];
        for (int row = 0; row < 4; row++) {
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10 + column*90, 10 + row*90, 80, 80)];
            bgView.backgroundColor = color(195, 181, 164);
            [backgroundView addSubview:bgView];
            
            Check *checkView = [[Check alloc] initWithFrame:CGRectMake(10 + column*90, 10 + row*90, 80, 80) AndNumberModel:nil];
            checkView.tag = column + 4*row + 1;
            checkView.enabled = NO;
            
            [backgroundView addSubview:checkView];
            
            [rowArray addObject:checkView];
        }
        [columnArray addObject:rowArray];
    }
}

#pragma mark - GameLogicalManagerDelegate
- (void)getRandomTag:(NSInteger)tag AndNumberModel:(NumberModel *)nm
{
    Check *checkView = (Check *)[self.view viewWithTag:tag];
    checkView.isNewNumber = YES;
    checkView.numberModel = nm;
}

- (void)resumeGame
{
    for (NSMutableArray *rowArr in columnArray) {
        for (Check *checkView in rowArr) {
            checkView.numberModel = nil;
        }
    }
    for (int column = 0; column < 4; column++) {
        for (int row = 0; row < 4; row++) {
            [GameLogicalManager shareManager]->numberMatrix[column][row] = 0;
        }
    }
    [[GameLogicalManager shareManager] startGame];
}
/**
 *  更新UI
 */
- (void)handleMoveEventFinished
{
    for (int column = 0; column < 4; column++) {
        for (int row = 0; row < 4; row++){
            ((Check *)columnArray[column][row]).numberModel = [[NumberModel alloc] initWithNumber:[GameLogicalManager shareManager]->numberMatrix[column][row]];
        }
    }
    panGestureRecognizer.enabled = YES;
}

- (void)scoreChangedWithAddScore:(NSInteger)score {
    self.socerLabel.text = [NSString stringWithFormat:@"%zd",score + self.socerLabel.text.integerValue];
}
- (void)checkMovedFromColumn:(int)column Row:(int)row ToColumn:(int)toColumn Row:(int)toRow
{
   
//    Check *checkView = columnArray[column][row];
//    Check *toCheckView = columnArray[toColumn][toRow];
//    Check *tempCheck = checkView;
//    checkView.steps ++;
//    toCheckView.steps = 0;
    NSLog(@"column= %d row= %d to %d , %d",column,row,toColumn,toRow);
    
}

- (IBAction)startGame:(id)sender {
    if (!isPlaying) {
        [[GameLogicalManager shareManager] startGame];
        isPlaying = YES;
    }
}

- (IBAction)resumeBtnClick:(id)sender {
    [[GameLogicalManager shareManager] resumeGame];
}

- (void)panEvent:(UIPanGestureRecognizer *)panGR
{
    CGPoint translationPoint;
    if (panGR.state == UIGestureRecognizerStateEnded) {
        panGR.enabled = NO;
        translationPoint = [panGR translationInView:panGR.view];
        if (translationPoint.x > 0 && abs((int)translationPoint.y) < translationPoint.x) {
            [[GameLogicalManager shareManager] handleRightMoved:columnArray];
            return;
        }
        if (translationPoint.x < 0 && abs((int)translationPoint.x) > abs((int)translationPoint.y)){
            [[GameLogicalManager shareManager] handleLeftMoved:columnArray];
            return;
        }
        if (translationPoint.y < 0 && abs((int)translationPoint.y) > abs((int)translationPoint.x)){
            [[GameLogicalManager shareManager] handleUpMoved:columnArray];
            return;
        }
        if (translationPoint.y > 0 && abs((int)translationPoint.y) > abs((int)translationPoint.x)){
            [[GameLogicalManager shareManager] handleDownMoved:columnArray];
            return;
        }
    }
}

@end
