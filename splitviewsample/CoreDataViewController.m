//
//  CoreDataViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/31.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "CoreDataViewController.h"
#import "AppDelegate.h"
#import "MyEntity.h"

@interface CoreDataViewController ()
@property (strong,nonatomic) UITextField *txtField;
@property (strong,nonatomic) UILabel *labReadData;
@property (strong, nonatomic) AppDelegate *myDelegate; // 该视图控制器的委托类，用于获取本程序的Core Data相关类
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"PListView";
    
    // 首先获取本程序的委托，便于获取本程序的Core Data相关类对象
    self.myDelegate = [[UIApplication sharedApplication] delegate];
    
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
    self.txtField.text=[self.txtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self.txtField.text isEqual:@""]) {
        return;
    }
    
    //让CoreData在上下文中创建一个新对象(托管对象)
    MyEntity *myEntity = (MyEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"MyEntity" inManagedObjectContext:self.myDelegate.managedObjectContext];
    
//    [myEntity setTitle:self.txtField.text];
//    [myEntity setDate:[NSDate date]];
    myEntity.title=self.txtField.text;
    myEntity.date=[NSDate date];
    
    NSError *error;
    
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
    
    
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
        NSString *msg=@"set String failed";
        UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:actionOK];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        NSLog(@"Save successful!");
        self.txtField.text=@"";
        self.txtField.placeholder=@"successful!input again?";
        [self performSelector:@selector(ReadFile:) withObject:nil];
    }
    
}

-(IBAction)ReadFile:(id)sender{
    // 创建Fetch请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MyEntity" inManagedObjectContext:self.myDelegate.managedObjectContext];
    [request setEntity:entityDescription]; // 设置请求对象为名为Data的Entity
    
    // 对搜索结果进行排序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sort, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    // 获取Fetch请求得到的结果，是一个数组
    NSArray *fetchResults = [self.myDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (fetchResults) {
        // 输出数组中各个元素的title
        self.labReadData.text=@"data from momd:";
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        for (MyEntity *data in fetchResults) {
            self.labReadData.text=[self.labReadData.text stringByAppendingFormat:@"\n%@ %@" ,data.title,[formatter stringFromDate:data.date]];
                }
    }
    else {
        NSLog(@"%@", error);
    }
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
