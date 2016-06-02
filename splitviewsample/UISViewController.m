//
//  UISViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/13.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "UISViewController.h"
#import <UIKit/UIKit.h>

@interface UISViewController ()
{
    NSDictionary *dictPicker;
    NSArray *arrPicker;
}

@property (strong,nonatomic) IBOutlet UILabel *labSliderValue;
@property (strong,nonatomic) IBOutlet UILabel *labSegment;
@property (strong,nonatomic) IBOutlet UIButton *btnPicker;
@property (strong,nonatomic) IBOutlet UISlider *slider;
@property (strong,nonatomic) IBOutlet UISegmentedControl *seg;
@property (strong,nonatomic) IBOutlet UIView *pkView;
@property (strong,nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong,nonatomic) IBOutlet UIButton *btnOKPV;
@property (strong,nonatomic) IBOutlet UITextField *txtField;
@property (strong,nonatomic) IBOutlet UIPickerView *txtPV;
@property (strong,nonatomic) IBOutlet UIProgressView *progView;
@property (strong,nonatomic) IBOutlet UILabel *labProg;
@property (strong,nonatomic) IBOutlet UIButton *btnProStop;
@property (strong,nonatomic) IBOutlet UIButton *btnProStart;
@property (strong,nonatomic) IBOutlet NSTimer *proTimer;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actIndicator;
@property (strong,nonatomic) IBOutlet UIButton *btnAlert;
@property (strong,nonatomic) IBOutlet UIButton *btnActionSheet;

@end

@implementation UISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *camItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    self.navigationItem.rightBarButtonItem=camItem;
    
    dictPicker=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],@"white",[UIColor redColor],@"red",[UIColor greenColor],@"green",[UIColor blueColor],@"blue",[UIColor yellowColor],@"yellow",[UIColor lightGrayColor],@"lightGray",[UIColor blackColor],@"black",[UIColor cyanColor],@"cyan",[UIColor orangeColor],@"orange",[UIColor brownColor],@"brown", nil];
    
    arrPicker=[dictPicker allKeys];
    
    [self addView];
}

- (void)addView{
    UILabel *lab1=[[UILabel alloc]init];
    lab1.text=@"show or hide all UI ?";
    lab1.numberOfLines=0;
    
    UISwitch *swt=[[UISwitch alloc] init];
    [swt addTarget:self action:@selector(showOrHideUI:) forControlEvents:UIControlEventValueChanged];
    [swt setOn:YES];
    
    self.labSliderValue=[[UILabel alloc]init];
    self.labSliderValue.text=@"50";
    self.labSliderValue.numberOfLines=0;
    
    self.slider=[[UISlider alloc]init];
    self.slider.maximumValue=100.0;
    self.slider.minimumValue=0;
    self.slider.value=50.0f;
    self.slider.minimumTrackTintColor=[UIColor redColor];
    self.slider.maximumTrackTintColor=[UIColor blueColor];
    self.slider.thumbTintColor=[UIColor greenColor];
    [self.slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    
    self.labSegment=[[UILabel alloc]init];
    self.labSegment.text=@"seg index";
    self.labSegment.numberOfLines=0;
    
    self.seg=[[UISegmentedControl alloc]initWithItems:@[@"one",@"two",@"three"]];
    [self.seg addTarget:self action:@selector(segSelect:) forControlEvents:UIControlEventValueChanged];
    
    
    self.btnPicker=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnPicker setTitle:@"bgColor" forState:UIControlStateNormal];
    [self.btnPicker addTarget:self action:@selector(changeBgColor:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.pkView=[[UIView alloc]init];
    self.pkView.backgroundColor=[UIColor whiteColor];
    //加边框颜色
    self.pkView.layer.borderWidth=1;
    self.pkView.layer.borderColor=[UIColor blueColor].CGColor;
    
    self.pickerView=[[UIPickerView alloc] init];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.tag=1;
    
    self.btnOKPV=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnOKPV setTitle:@"OK" forState:UIControlStateNormal];
    [self.btnOKPV addTarget:self action:@selector(selectPicker:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.pkView addSubview:self.pickerView];
    [self.pkView addSubview:self.btnOKPV];
    
    
    self.txtPV=[[UIPickerView alloc] init];
    self.txtPV.delegate=self;
    self.txtPV.dataSource=self;
    self.txtPV.showsSelectionIndicator=YES;
    self.txtPV.tag=2;
    
    UIBarButtonItem *barOKPV=[[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(txtDone:)];
    UIBarButtonItem *barCancelPV=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(txtCancel:)];
    UIBarButtonItem *barFlexiblePV=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, self.txtPV.frame.origin.y-50, self.view.frame.size.width, 50)];
    
    toolbar.barStyle=UIBarStyleDefault;
    toolbar.items=@[barCancelPV,barFlexiblePV,barOKPV];
    
    self.txtField=[[UITextField alloc] init];
    self.txtField.placeholder=@"click here";
    self.txtField.borderStyle=UITextBorderStyleRoundedRect;
    self.txtField.inputView=self.txtPV;
    self.txtField.inputAccessoryView=toolbar;
    
    
    self.progView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    self.labProg=[[UILabel alloc]init];
    self.labProg.text=@"0";
    self.labProg.numberOfLines=0;
    
    self.btnProStart=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnProStart setTitle:@"start" forState:UIControlStateNormal];
    [self.btnProStart addTarget:self action:@selector(startProgress:) forControlEvents:UIControlEventTouchUpInside];
    self.btnProStop=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnProStop setTitle:@"stop" forState:UIControlStateNormal];
    [self.btnProStop addTarget:self action:@selector(stopProgress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.actIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.btnAlert=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnAlert setTitle:@"alert" forState:UIControlStateNormal];
    [self.btnAlert addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnActionSheet=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnActionSheet setTitle:@"actionSheet" forState:UIControlStateNormal];
    [self.btnActionSheet addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //add subViews
    [self.view addSubview:lab1];
    [self.view addSubview:swt];
    [self.view addSubview:self.labSliderValue];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.labSegment];
    [self.view addSubview:self.seg];
    [self.view addSubview:self.btnPicker];
    [self.view addSubview:self.pkView];
    [self.view addSubview:self.txtField];
    [self.view addSubview:self.progView];
    [self.view addSubview:self.labProg];
    [self.view addSubview:self.btnProStart];
    [self.view addSubview:self.btnProStop];
    [self.view addSubview:self.actIndicator];
    [self.view addSubview:self.btnAlert];
    [self.view addSubview:self.btnActionSheet];
    self.pkView.hidden=YES;
    self.progView.progress=0.0;
    [self.actIndicator stopAnimating];
    
    
    //add Constraint
    lab1.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *lab1Leading=[NSLayoutConstraint constraintWithItem:lab1 attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *lab1Top=[NSLayoutConstraint constraintWithItem:lab1 attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    
    swt.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *swtTrailing=[NSLayoutConstraint constraintWithItem:swt attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *swtTop=[NSLayoutConstraint constraintWithItem:swt attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:lab1 attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *swtLeft=[NSLayoutConstraint constraintWithItem:swt attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:lab1 attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:20];
    
    
    self.labSliderValue.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *labSliderValueLeading=[NSLayoutConstraint constraintWithItem:self.labSliderValue attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *labSliderValueTop=[NSLayoutConstraint constraintWithItem:self.labSliderValue attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:lab1 attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *labSliderValueWidth=[NSLayoutConstraint constraintWithItem:self.labSliderValue attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    
    self.slider.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *sliderTrailing=[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *sliderTop=[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labSliderValue attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *sliderLeft=[NSLayoutConstraint constraintWithItem:self.slider attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.labSliderValue attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:0];
    
    
    self.labSegment.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *labSegmentLeading=[NSLayoutConstraint constraintWithItem:self.labSegment attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *labSegmentTop=[NSLayoutConstraint constraintWithItem:self.labSegment attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.labSliderValue attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *labSegmentWidth=[NSLayoutConstraint constraintWithItem:self.labSegment attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    
    self.seg.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *segTop=[NSLayoutConstraint constraintWithItem:self.seg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labSegment attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *segLeft=[NSLayoutConstraint constraintWithItem:self.seg attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.labSegment attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *segWidth=[NSLayoutConstraint constraintWithItem:self.seg attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:250];
    
    self.btnPicker.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnPickerTop=[NSLayoutConstraint constraintWithItem:self.btnPicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.seg attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *btnPickerLeft=[NSLayoutConstraint constraintWithItem:self.btnPicker attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.seg attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    
    self.pkView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *pkViewBottom=[NSLayoutConstraint constraintWithItem:self.pkView attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:-1];
    NSLayoutConstraint *pkViewLeading=[NSLayoutConstraint constraintWithItem:self.pkView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-1];
    NSLayoutConstraint *pkViewTrailing=[NSLayoutConstraint constraintWithItem:self.pkView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:1];
    NSLayoutConstraint *pkViewHeight=[NSLayoutConstraint constraintWithItem:self.pkView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0];
    
    
    self.btnOKPV.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnOKPVTop=[NSLayoutConstraint constraintWithItem:self.btnOKPV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.pkView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *btnOKPVTrailing=[NSLayoutConstraint constraintWithItem:self.btnOKPV attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.pkView attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnOKPVHeight=[NSLayoutConstraint constraintWithItem:self.btnOKPV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    
    self.pickerView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *pickViewBottom=[NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self.pkView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *pickViewLeading=[NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.pkView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *pickViewTrailing=[NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.pkView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *pickViewTop=[NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnOKPV attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    self.txtField.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *txtFieldTrailing=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldLeft=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.btnPicker attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *txtFieldTop=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.seg attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];

    
    self.progView.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *progViewLeading=[NSLayoutConstraint constraintWithItem:self.progView attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *progViewTop=[NSLayoutConstraint constraintWithItem:self.progView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labSegment attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *progViewWidth=[NSLayoutConstraint constraintWithItem:self.progView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:250];
    
    
    self.labProg.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *labProgTop=[NSLayoutConstraint constraintWithItem:self.labProg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.progView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *labProgLeft=[NSLayoutConstraint constraintWithItem:self.labProg attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.progView attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *labProgWidth=[NSLayoutConstraint constraintWithItem:self.labProg attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    self.labProg.textAlignment=NSTextAlignmentCenter;
    
    self.btnProStart.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnProStartTop=[NSLayoutConstraint constraintWithItem:self.btnProStart attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.progView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *btnProStartLeft=[NSLayoutConstraint constraintWithItem:self.btnProStart attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.labProg attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    self.btnProStop.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnProStopTop=[NSLayoutConstraint constraintWithItem:self.btnProStop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.progView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *btnProStopLeft=[NSLayoutConstraint constraintWithItem:self.btnProStop attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.btnProStart attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    self.actIndicator.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *actIndicatorTop=[NSLayoutConstraint constraintWithItem:self.actIndicator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.progView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *actIndicatorLeft=[NSLayoutConstraint constraintWithItem:self.actIndicator attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.btnProStop attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    
    self.btnAlert.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnAlertLeading=[NSLayoutConstraint constraintWithItem:self.btnAlert attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *btnAlertTop=[NSLayoutConstraint constraintWithItem:self.btnAlert attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.progView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    
    
    self.btnActionSheet.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnActionSheetTop=[NSLayoutConstraint constraintWithItem:self.btnActionSheet attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnAlert attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *btnActionSheetLeft=[NSLayoutConstraint constraintWithItem:self.btnActionSheet attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.btnAlert attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:40];
    
    
    [NSLayoutConstraint activateConstraints:@[lab1Leading,lab1Top,swtTrailing,swtTop,swtLeft]];
    
    [NSLayoutConstraint activateConstraints:@[labSliderValueLeading,labSliderValueTop,labSliderValueWidth,sliderTrailing,sliderTop,sliderLeft]];
    
    [NSLayoutConstraint activateConstraints:@[labSegmentLeading,labSegmentTop,labSegmentWidth,segTop,segLeft,segWidth]];    

    [NSLayoutConstraint activateConstraints:@[pkViewBottom,pkViewLeading,pkViewTrailing,pkViewHeight,btnPickerLeft,btnPickerTop,pickViewTop,pickViewBottom,pickViewLeading,pickViewTrailing,btnOKPVTop,btnOKPVTrailing,btnOKPVHeight]];
    
    [NSLayoutConstraint activateConstraints:@[txtFieldTrailing,txtFieldLeft,txtFieldTop]];
    
    [NSLayoutConstraint activateConstraints:@[progViewLeading,progViewWidth,progViewTop,labProgTop,labProgLeft,labProgWidth,btnProStartTop,btnProStartLeft,btnProStopTop,btnProStopLeft,actIndicatorTop,actIndicatorLeft]];
    
    [NSLayoutConstraint activateConstraints:@[btnAlertLeading,btnAlertTop,btnActionSheetTop,btnActionSheetLeft]];
}

-(IBAction)showOrHideUI:(UISwitch *)sender{
    if (sender.isOn==NO) {
        //some UI get to hide
        self.slider.hidden=YES;
        self.labSliderValue.hidden=YES;
        self.labSegment.hidden=YES;
        self.seg.hidden=YES;
        self.btnPicker.hidden=YES;
        self.txtField.hidden=YES;
    }
    else{
        self.slider.hidden=NO;
        self.labSliderValue.hidden=NO;
        self.labSegment.hidden=NO;
        self.seg.hidden=NO;
        self.btnPicker.hidden=NO;
        self.txtField.hidden=NO;
    }
}

-(IBAction)sliderValueChange:(UISlider *)sender{
    self.labSliderValue.text=[NSString stringWithFormat:@"%d",(int)sender.value];
}

-(IBAction)segSelect:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex==0) {
        self.labSegment.text=@"one";
    }
    else if (sender.selectedSegmentIndex==1){
        self.labSegment.text=@"two";
    }
    else if (sender.selectedSegmentIndex==2){
        self.labSegment.text=@"three";
    }
}

-(IBAction)changeBgColor:(id)sender{
    self.pkView.hidden=NO;
}

-(IBAction)selectPicker:(id)sender{
    self.view.backgroundColor=[dictPicker objectForKey:arrPicker[[self.pickerView selectedRowInComponent:0]]];
    self.pkView.hidden=YES;
}

-(IBAction)txtDone:(id)sender{
    self.txtField.text=arrPicker[[self.txtPV selectedRowInComponent:0]];
    [self.txtField resignFirstResponder];
}

-(IBAction)txtCancel:(id)sender{
    [self.txtField resignFirstResponder];
}

-(IBAction)startProgress:(id)sender{
    if (self.progView.progress>=1.0) {
        self.progView.progress=0;
        self.txtField.text=@"0";
    }
    self.proTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressDetail) userInfo:nil repeats:YES];
    [self.actIndicator startAnimating];
}

-(IBAction)stopProgress:(id)sender{
    [self.proTimer invalidate];
    [self.actIndicator stopAnimating];
}

-(IBAction)showAlert:(id)sender{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"sample title" message:@"sample message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"action OK");
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"action Cancel");
    }];
    [alert addAction:actionOK];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:^{
        NSLog(@"alert present");
    }];
}


-(IBAction)showActionSheet:(UIButton *)sender{
    UIAlertController *actionSheet=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOK=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheet OK");
    }];
    UIAlertAction *actionLib=[UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheet Library");
    }];
    UIAlertAction *actionCam=[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheet Camera");
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheet Cancel");
    }];
    UIAlertAction *actionDestroy=[UIAlertAction actionWithTitle:@"Destroy" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"sheet Destroy");
    }];
    [actionSheet addAction:actionLib];
    [actionSheet addAction:actionCam];
    [actionSheet addAction:actionOK];
    [actionSheet addAction:actionCancel];
    [actionSheet addAction:actionDestroy];
//    actionSheet.modalTransitionStyle=UIModalPresentationFormSheet;
    actionSheet.modalPresentationStyle=UIModalPresentationPopover;
    
    //ipad 要用popover
    UIPopoverPresentationController *popPresenter = [actionSheet popoverPresentationController];
    popPresenter.sourceView=sender;
    popPresenter.sourceRect=sender.bounds;
    [self presentViewController:actionSheet animated:YES completion:^{
        NSLog(@"actionSheet present");
    }];
}

- (void) progressDetail{
    if (self.progView.progress>=1.0) {
        [self.proTimer invalidate];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Completion" message:@"your progress to 100%" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [self.actIndicator stopAnimating];
    }
    self.progView.progress+=0.01;
    self.labProg.text=[NSString stringWithFormat:@"%.0f",self.progView.progress*100];
}


#pragma mark - PickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return arrPicker.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        return 100.0;
    }
    return 60.0;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return arrPicker[row];
}


//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
//    if (pickerView.tag==1) {
//        UIView *newView=[[UIView alloc] init];
//        newView.backgroundColor=[dictPicker objectForKey:arrPicker[row]];
//        return newView;
//    }
//    return view;
//}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    self.view.backgroundColor=[dictPicker objectForKey:arrPicker[row]];
////    self.pickerView.hidden=YES;
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
