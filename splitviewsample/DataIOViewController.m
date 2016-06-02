//
//  DataIOViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/17.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "DataIOViewController.h"
#import "PListViewController.h"
#import "CoreDataViewController.h"

@interface DataIOViewController ()

@end

@implementation DataIOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self addView];
}

- (void)addView{
    
    UIButton *PList=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [PList setTitle:@"PList" forState:UIControlStateNormal];
    [PList addTarget:self action:@selector(ShowPList:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *CoreData=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [CoreData setTitle:@"CoreData" forState:UIControlStateNormal];
    [CoreData addTarget:self action:@selector(ShowCoreData:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:PList];
    [self.view addSubview:CoreData];
    
    //add Constraint
    PList.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnReadTop=[NSLayoutConstraint constraintWithItem:PList attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *btnReadLeading=[NSLayoutConstraint constraintWithItem:PList attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    
    CoreData.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *CoreDataTop=[NSLayoutConstraint constraintWithItem:CoreData attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:PList attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *CoreDataLeft=[NSLayoutConstraint constraintWithItem:CoreData attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:PList attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    [NSLayoutConstraint activateConstraints:@[btnReadTop,btnReadLeading,CoreDataTop,CoreDataLeft]];
}


-(IBAction)ShowPList:(id)sender{
    PListViewController *plist=[[PListViewController alloc]init];
    [self.navigationController pushViewController:plist  animated:YES];
}

-(IBAction)ShowCoreData:(id)sender{
    CoreDataViewController *cd=[[CoreDataViewController alloc]init];
    [self.navigationController pushViewController:cd  animated:YES];
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
