//
//  RecognizerViewController.m
//  splitViewSample2
//
//  Created by Victor on 16/5/12.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "RecognizerViewController.h"

@interface RecognizerViewController ()
@property (strong,nonatomic) UILabel *labTips;
@end

@implementation RecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title=@"recognizer";
    
    [self addView];
}

- (void)addView{
    UILabel *lab1=[[UILabel alloc] init];
    lab1.text=@"tap cyan district\nfinger:1 tap:1\nfinger:1 tap:2\nfinger:2 swipe:right";
    //自适应行数
    lab1.numberOfLines=0;
    lab1.backgroundColor=[UIColor yellowColor];
    
    self.labTips=[[UILabel alloc] init];
    self.labTips.text=@"tips here";
    //自适应行数
    self.labTips.numberOfLines=0;
    self.labTips.backgroundColor=[UIColor greenColor];
    
    UIView *recognizerView=[[UIView alloc]init];
    recognizerView.backgroundColor=[UIColor cyanColor];
    
    [self.view addSubview:lab1];
    [self.view addSubview:self.labTips];
    [self.view addSubview:recognizerView];
    
    
    UITapGestureRecognizer *singleFingerOne=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    singleFingerOne.delegate = self;
    [recognizerView addGestureRecognizer:singleFingerOne];
    
    UITapGestureRecognizer *singleFingerTwo=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFingerTwo.numberOfTouchesRequired = 1; //手指数
    singleFingerTwo.numberOfTapsRequired = 2; //tap次数
    singleFingerTwo.delegate = self;
    [recognizerView addGestureRecognizer:singleFingerTwo];
    
    UISwipeGestureRecognizer *twoFingerRight=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeEvent:)];
    twoFingerRight.numberOfTouchesRequired=2;
    twoFingerRight.direction=UISwipeGestureRecognizerDirectionRight;
    twoFingerRight.delegate=self;
    [recognizerView addGestureRecognizer:twoFingerRight];
    
    //如果不加下面的话，当单指双击时，会先调用单指单击中的处理，再调用单指双击中的处理
    [singleFingerOne requireGestureRecognizerToFail:singleFingerTwo];
    
    //add Constraint
    lab1.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *lab1Leading=[NSLayoutConstraint constraintWithItem:lab1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16];
//    NSLayoutConstraint *lab1Trailing=[NSLayoutConstraint constraintWithItem:lab1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:16];
    NSLayoutConstraint *lab1Top=[NSLayoutConstraint constraintWithItem:lab1 attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *lab1Width=[NSLayoutConstraint constraintWithItem:lab1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0];
    
    self.labTips.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *labTipsTop=[NSLayoutConstraint constraintWithItem:self.labTips attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:84];
    NSLayoutConstraint *labTipsTrailing=[NSLayoutConstraint constraintWithItem:self.labTips attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16];
    NSLayoutConstraint *labTipsWidth=[NSLayoutConstraint constraintWithItem:self.labTips attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:lab1 attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *labTipsHeight=[NSLayoutConstraint constraintWithItem:self.labTips attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:lab1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    
    
    recognizerView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *recognizerViewLeading=[NSLayoutConstraint constraintWithItem:recognizerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16];
    NSLayoutConstraint *recognizerViewTrailing=[NSLayoutConstraint constraintWithItem:recognizerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16];
    NSLayoutConstraint *recognizerViewTop=[NSLayoutConstraint constraintWithItem:recognizerView attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:lab1 attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *recognizerViewBottom=[NSLayoutConstraint constraintWithItem:recognizerView attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:-20];
    
    //active Constraint after add components to self.view
    [NSLayoutConstraint activateConstraints:@[lab1Top,lab1Leading,lab1Width,recognizerViewTop,recognizerViewLeading,recognizerViewTrailing,recognizerViewBottom,labTipsTop,labTipsTrailing,labTipsWidth,labTipsHeight]];
}

//处理tap事件
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if(sender.numberOfTapsRequired == 1){
        //单指单击
        self.labTips.text=@"单指单击";
        //need some Animations?
        [self animationColor:[UIColor grayColor] options:UIViewAnimationOptionCurveEaseIn];
    }
    else if(sender.numberOfTapsRequired == 2){
        //单指双击
        self.labTips.text=@"单指双击";
        [self animationColor:[UIColor magentaColor] options:UIViewAnimationOptionCurveLinear];
    }
}
//处理swipe事件
- (void)swipeEvent:(UISwipeGestureRecognizer *)sender{
    if (sender.numberOfTouchesRequired==2&&sender.direction==UISwipeGestureRecognizerDirectionRight) {
        self.labTips.text=@"双指右扫";
        [self animationColor:[UIColor brownColor] options:UIViewAnimationOptionAutoreverse];
    }
}

/**
 *  recognizer Animation
 *
 *  @param color <#color description#>
 *  @param opt   <#opt description#>
 */
- (void)animationColor:(UIColor *)color options:(UIViewAnimationOptions)opt{
    self.labTips.alpha=0;
    [UIView animateWithDuration:1 delay:0 options:opt animations:^{
        self.labTips.alpha=1;
        self.labTips.backgroundColor=color;
    } completion:^(BOOL finished) {
        NSLog(@"animation finished");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
