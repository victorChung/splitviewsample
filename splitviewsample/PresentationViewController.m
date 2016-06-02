//
//  ModalViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/14.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "PresentationViewController.h"
#import "ModalNotifViewController.h"
#import "DelegationViewController.h"
#import "UserDefaultsViewController.h"

@interface PresentationViewController ()

@property (strong,nonatomic) IBOutlet UITextField *txtField;


@end

@implementation PresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addView];
}


- (void)addView{
    self.txtField=[[UITextField alloc]init];
    self.txtField.placeholder=@"just show something";
    self.txtField.borderStyle=UITextBorderStyleRoundedRect;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModalNotifData:) name:@"ModalNotifData" object:nil];
    UIButton *ModalNotif1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ModalNotif1 setTitle:@"ModalNotif1" forState:UIControlStateNormal];
    [ModalNotif1 addTarget:self action:@selector(showModalNotif1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ModalNotif2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ModalNotif2 setTitle:@"ModalNotif2" forState:UIControlStateNormal];
    [ModalNotif2 addTarget:self action:@selector(showModalNotif2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnPush=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnPush setTitle:@"PushNotif3" forState:UIControlStateNormal];
    [btnPush addTarget:self action:@selector(showPushView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnDelegate=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnDelegate setTitle:@"Delegation" forState:UIControlStateNormal];
    [btnDelegate addTarget:self action:@selector(showDelegationView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnUsrDef=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnUsrDef setTitle:@"UserDefaults" forState:UIControlStateNormal];
    [btnUsrDef addTarget:self action:@selector(showUserDefaultsView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIToolbar *tool=[[UIToolbar alloc]init];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    UIBarButtonItem *barBtn2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    UIBarButtonItem *barBtn3=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    UIBarButtonItem *barBtn4=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:nil action:nil];
    UIBarButtonItem *barBtn5=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:nil];
    UIBarButtonItem *barBtn6=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:nil action:nil];
    UIBarButtonItem *barBtn7=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    UIBarButtonItem *barBtnFlex=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    tool.items=@[barBtn1,barBtnFlex,barBtn2,barBtnFlex,barBtn3,barBtnFlex,barBtn4,barBtnFlex,barBtn5,barBtnFlex,barBtn6,barBtnFlex,barBtn7];
    tool.barStyle=UIBarStyleBlackTranslucent;
    
    
    [self.view addSubview:self.txtField];
    [self.view addSubview:ModalNotif1];
    [self.view addSubview:ModalNotif2];
    [self.view addSubview:btnPush];
    [self.view addSubview:btnDelegate];
    [self.view addSubview:btnUsrDef];
    [self.view addSubview:tool];
    
    
    //add Constraint
    self.txtField.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *txtFieldTop=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *txtFieldLeading=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldTrailing=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    
    ModalNotif1.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *ModalNotif1Top=[NSLayoutConstraint constraintWithItem:ModalNotif1 attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.txtField attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *ModalNotif1Leading=[NSLayoutConstraint constraintWithItem:ModalNotif1 attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    
    ModalNotif2.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *ModalNotif2Top=[NSLayoutConstraint constraintWithItem:ModalNotif2 attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:ModalNotif1 attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *ModalNotif2Left=[NSLayoutConstraint constraintWithItem:ModalNotif2 attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:ModalNotif1 attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    btnPush.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnPushTop=[NSLayoutConstraint constraintWithItem:btnPush attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:ModalNotif1 attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnPushLeft=[NSLayoutConstraint constraintWithItem:btnPush attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:ModalNotif2 attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    btnDelegate.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnDelegateTop=[NSLayoutConstraint constraintWithItem:btnDelegate attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:ModalNotif1 attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnDelegateLeft=[NSLayoutConstraint constraintWithItem:btnDelegate attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:btnPush attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    btnUsrDef.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnUsrDefTop=[NSLayoutConstraint constraintWithItem:btnUsrDef attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:ModalNotif1 attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnUsrDefLeft=[NSLayoutConstraint constraintWithItem:btnUsrDef attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:btnDelegate attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    
    tool.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *toolLeading=[NSLayoutConstraint constraintWithItem:tool attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *toolTrailing=[NSLayoutConstraint constraintWithItem:tool attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *toolBottom=[NSLayoutConstraint constraintWithItem:tool attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    
    [NSLayoutConstraint activateConstraints:@[txtFieldTop,txtFieldLeading,txtFieldTrailing,ModalNotif1Top,ModalNotif1Leading,ModalNotif2Top,ModalNotif2Left,btnPushTop,btnPushLeft,btnDelegateTop,btnDelegateLeft,btnUsrDefTop,btnUsrDefLeft]];
    
    [NSLayoutConstraint activateConstraints:@[toolLeading,toolTrailing,toolBottom]];
    
}

- (IBAction)showModalNotif1:(id)sender{
    ModalNotifViewController *mnvc=[[ModalNotifViewController alloc]init];
    mnvc.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    mnvc.modalPresentationStyle=UIModalPresentationFullScreen;
    //    [self presentViewController:mnvc animated:YES completion:nil];
    //此举只是为了说在调用处也可以加导航，不一定要到ModalNotifViewController去实现
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:mnvc];
    nav.topViewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    nav.topViewController.title=@"ModalNotif1";
    nav.topViewController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)showModalNotif2:(id)sender{
    ModalNotifViewController *mnvc=[[ModalNotifViewController alloc]init];
    mnvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    mnvc.modalPresentationStyle=UIModalPresentationFormSheet;
    mnvc.theData=[NSDictionary dictionaryWithObjectsAndKeys:@"this value is transferred by Present",@"PresentData", nil];
    [self presentViewController:mnvc animated:YES completion:nil];
}

-(IBAction)showPushView:(id)sender{
    ModalNotifViewController *mnvc=[[ModalNotifViewController alloc]init];
    [self.navigationController pushViewController:mnvc animated:YES];
}

-(IBAction)showDelegationView:(id)sender{
    DelegationViewController *dvc=[[DelegationViewController alloc]init];
    dvc.delegate=self;
    [self.navigationController pushViewController:dvc animated:YES];
}

-(IBAction)showUserDefaultsView:(id)sender{
    UserDefaultsViewController *udvc=[[UserDefaultsViewController alloc]init];
    [[NSUserDefaults standardUserDefaults] setObject:@"this value was transferred by upper vc" forKey:@"usrDef"];
    [self.navigationController pushViewController:udvc animated:YES];
}


/**
 *  MyPresentationDelegate
 *
 *  @param value
 */
-(void)passValue:(id)value{
    self.txtField.text=[NSString stringWithFormat:@"%@",value];
}

/**
 *  notification
 *
 *  @param notif
 */
- (void)getModalNotifData:(NSNotification *)notif{
    NSDictionary *dict=[notif userInfo];
    self.txtField.text=dict[@"modalData"];
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
