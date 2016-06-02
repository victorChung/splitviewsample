//
//  ModalNotifViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/14.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "ModalNotifViewController.h"

@interface ModalNotifViewController ()

@property (strong,nonatomic) IBOutlet UITextField *txtField;
@end

@implementation ModalNotifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.txtField=[[UITextField alloc]init];
    self.txtField.placeholder=@"send some data back to upper controller";
    self.txtField.borderStyle=UITextBorderStyleRoundedRect;
    
    
    UIButton *btnModal1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnModal1 setTitle:@"dismiss" forState:UIControlStateNormal];
    [btnModal1 addTarget:self action:@selector(sendBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnPop=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnPop setTitle:@"Pop" forState:UIControlStateNormal];
    [btnPop addTarget:self action:@selector(PopBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.txtField];
    [self.view addSubview:btnModal1];
    [self.view addSubview:btnPop];
    
    
    //add Constraint
    self.txtField.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *txtFieldTop=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *txtFieldLeading=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldTrailing=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    
    btnModal1.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *ModalNotifTop=[NSLayoutConstraint constraintWithItem:btnModal1 attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.txtField attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *ModalNotifLeading=[NSLayoutConstraint constraintWithItem:btnModal1 attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    
    btnPop.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnPopTop=[NSLayoutConstraint constraintWithItem:btnPop attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:btnModal1 attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnPopLeft=[NSLayoutConstraint constraintWithItem:btnPop attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:btnModal1 attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    [NSLayoutConstraint activateConstraints:@[txtFieldTop,txtFieldLeading,txtFieldTrailing,ModalNotifTop,ModalNotifLeading,btnPopTop,btnPopLeft]];
    
    if (self.theData) {
        self.txtField.text=self.theData[@"PresentData"];
    }
}


-(IBAction)sendBack:(id)sender{
    self.theData=[NSDictionary dictionaryWithObjectsAndKeys:self.txtField.text,@"modalData", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ModalNotifData" object:nil userInfo:self.theData];
    [self.txtField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)PopBack:(id)sender{
    self.theData=[NSDictionary dictionaryWithObjectsAndKeys:self.txtField.text,@"modalData", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ModalNotifData" object:nil userInfo:self.theData];
    [self.txtField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
