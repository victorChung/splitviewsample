//
//  PListViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/16.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "PListViewController.h"

@interface PListViewController ()
@property (strong,nonatomic) UITextField *txtField;
@property (strong,nonatomic) UILabel *labReadData;
@end

@implementation PListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"PListView";
    
    [self addView];
}

- (void)addView{
    UILabel *labKey=[[UILabel alloc]init];
    labKey.text=@"Set \"SampleString\":";
    labKey.numberOfLines=0;
    
    self.txtField=[[UITextField alloc]init];
    self.txtField.placeholder=@"set your new string";
    self.txtField.borderStyle=UITextBorderStyleRoundedRect;
    self.txtField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    UIButton *btnSet=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSet setTitle:@"Set" forState:UIControlStateNormal];
    [btnSet addTarget:self action:@selector(AddNewItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.labReadData=[[UILabel alloc]init];
    self.labReadData.text=@"press button \"Read\" first";
    self.labReadData.numberOfLines=0;
    
    UIButton *btnRead=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnRead setTitle:@"Read" forState:UIControlStateNormal];
    [btnRead addTarget:self action:@selector(ReadFile:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:labKey];
    [self.view addSubview:self.txtField];
    [self.view addSubview:btnSet];
    [self.view addSubview:self.labReadData];
    [self.view addSubview:btnRead];
    
    //add Constraint
    labKey.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *labKeyTop=[NSLayoutConstraint constraintWithItem:labKey attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *labKeyLeading=[NSLayoutConstraint constraintWithItem:labKey attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *labKeyWidth=[NSLayoutConstraint constraintWithItem:labKey attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:175];
    
    self.txtField.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *txtFieldTop=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:labKey attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldLeft=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:labKey attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldRight=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:btnSet attribute:NSLayoutAttributeLeftMargin multiplier:1.0 constant:-25];
    
    btnSet.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnSetTop=[NSLayoutConstraint constraintWithItem:btnSet attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:labKey attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnSetTrailing=[NSLayoutConstraint constraintWithItem:btnSet attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    
    
    self.labReadData.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *labReadDataTop=[NSLayoutConstraint constraintWithItem:self.labReadData attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:labKey attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *labReadDataLeading=[NSLayoutConstraint constraintWithItem:self.labReadData attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *labReadDataTrailing=[NSLayoutConstraint constraintWithItem:self.labReadData attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    
    btnRead.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnReadTop=[NSLayoutConstraint constraintWithItem:btnRead attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.labReadData attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *btnReadLeading=[NSLayoutConstraint constraintWithItem:btnRead attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    
    
    
    [NSLayoutConstraint activateConstraints:@[labKeyTop,labKeyLeading,labKeyWidth,txtFieldTop,txtFieldLeft,txtFieldRight,btnSetTop,btnSetTrailing/*,btnSetLeft*/]];
    
    [NSLayoutConstraint activateConstraints:@[labReadDataTop,labReadDataLeading,labReadDataTrailing]];
    [NSLayoutConstraint activateConstraints:@[btnReadTop,btnReadLeading]];
}


-(IBAction)AddNewItem:(id)sender{
    [self.txtField resignFirstResponder];
    NSString *docDir=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[docDir stringByAppendingPathComponent:@"Sample.plist"];

    NSMutableDictionary *mdict=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    if (!mdict) {
        NSFileManager *fm=[NSFileManager defaultManager];
        [fm createFileAtPath:filePath contents:nil attributes:nil];
        mdict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.txtField.text,@"SampleString", nil];
    }
    else{
        mdict[@"SampleString"]=self.txtField.text;
    }
    
    NSError *error=nil;
    NSData *data=[NSPropertyListSerialization dataWithPropertyList:mdict format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListMutableContainersAndLeaves error:&error];
    BOOL isSuccess=NO;
    if (data) {
        isSuccess=[data writeToFile:filePath atomically:YES];
    }
    
    NSString *msg=@"set String success";
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.txtField.text=@"";
//        NSDictionary *blkDict=[NSDictionary dictionaryWithContentsOfFile:filePath];
        NSData *blkData=[NSData dataWithContentsOfFile:filePath];
        NSError *err;
        NSPropertyListFormat plistFormat=NSPropertyListXMLFormat_v1_0;
        NSMutableDictionary *blkDict=[NSPropertyListSerialization propertyListWithData:blkData options:NSPropertyListMutableContainersAndLeaves format:&plistFormat error:&err];
        
        
        self.labReadData.text=[NSString stringWithFormat:@"SampleString in plist : %@" ,blkDict[@"SampleString"]];
    }];
    if (!isSuccess) {
        msg=@"set String failed";
        actionOK=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

-(IBAction)ReadFile:(id)sender{
    NSString *docDir=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[docDir stringByAppendingPathComponent:@"Sample.plist"];
    NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:filePath];
    self.labReadData.text=[NSString stringWithFormat:@"SampleString in plist : %@" ,dict[@"SampleString"]];
}

//-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.txtField endEditing:YES];
//}



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
