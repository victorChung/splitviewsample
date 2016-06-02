//
//  MasterViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/12.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()
@property NSArray *arrClass;
@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
//    self.dictItem=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"RecognizerViewController",@"Recognizer",@"UISViewController",@"UI",@"PresentationViewController",@"PresentationView",@"AFNetworkingViewController",@"AFNetworking",nil];
//    self.arrItem =[self.dictItem allKeys];
//    self.arrItem=@[@"Recognizer",@"UI",@"PresentationView",@"Data IO",@"AFNetworking"];
    
    self.arrItem=@[
                   [[NSDictionary alloc] initWithObjectsAndKeys:@"RecognizerViewController",@"class",@"Recognizer",@"name", nil],
                   [[NSDictionary alloc] initWithObjectsAndKeys:@"UISViewController",@"class",@"UI",@"name", nil],
                   [[NSDictionary alloc] initWithObjectsAndKeys:@"PresentationViewController",@"class",@"PresentationView",@"name", nil],
                   [[NSDictionary alloc] initWithObjectsAndKeys:@"AFNetworkingViewController",@"class",@"AFNetworking",@"name", nil]
                   ];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender {
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

//#pragma mark - Segues
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.text = self.arrItem[indexPath.row];
    cell.textLabel.text = [self.arrItem[indexPath.row] objectForKey:@"name"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MyViewController *myVC;
//    switch (indexPath.row) {
//        case 0:{
//            Class class=NSClassFromString(self.arrClass[indexPath.row]);
//            myVC=class.new;
////            myVC=[[RecognizerViewController alloc]init];
//            [self loadToNavigation:myVC title:@"Recognizer"];
//            break;
//        }
//        case 1:{
//            myVC=[[UISViewController alloc] init];
//            [self loadToNavigation:myVC title:@"UI"];
//            break;
//        }
//        case 2:{
//            myVC=[[PresentationViewController alloc] init];
//            [self loadToNavigation:myVC title:@"Presentation"];
//            break;
//        }
//        case 3:{
//            myVC=[[DataIOViewController alloc] init];
//            [self loadToNavigation:myVC title:@"Data IO"];
//            break;
//        }
//            
//        default:
//            break;
//    }
    
    Class class=NSClassFromString([self.arrItem[indexPath.row] objectForKey:@"class"]);
    MyViewController *myVC=class.new;
    [self loadToNavigation:myVC title:[self.arrItem[indexPath.row] objectForKey:@"name"]];
}



- (void) loadToNavigation:(MyViewController *)myVC title:(NSString *)t{
    myVC.view.backgroundColor=[UIColor whiteColor];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:myVC];
    navigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    navigationController.topViewController.title=t;
    NSArray *vcArray = @[self.splitViewController.viewControllers[0],navigationController];
    self.splitViewController.viewControllers = vcArray;
}

@end
