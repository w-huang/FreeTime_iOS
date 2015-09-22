//
//  ViewController.m
//  FreeTime
//
//  Created by Prime One Media on 2015-06-07.
//  Copyright (c) 2015 Wilson Huang. All rights reserved.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "DetailScreenViewController.h"
#import "DBManager.h"
#import "ToastView.h"

@interface ViewController ()

@property(strong, nonatomic) DBManager* dbManager;
@property(strong, nonatomic) NSArray* resultsArray;

@property(strong, nonatomic) NSMutableArray *importantAndUrgent;
@property(strong, nonatomic) NSMutableArray *importantNotUrgent;
@property(strong, nonatomic) NSMutableArray *urgentNotImportant;
@property(strong, nonatomic) NSMutableArray *notImportantNotUrgent;

@property(strong, nonatomic) UITableView* toDoList;

@end


@implementation ViewController

- (void) loadData{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"freeTimeDB.sql"];
    
    if(self.resultsArray != nil){
        self.resultsArray = nil;
    }
    
    self.resultsArray = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:@"select * from tasks"]];
    [self sortData];
    
}

- (void) sortData{
    //empty all results arrays
    if(self.importantAndUrgent != nil){
        self.importantAndUrgent = nil;
    }
    if(self.importantNotUrgent != nil){
        self.importantNotUrgent = nil;
    }
    if(self.urgentNotImportant != nil){
        self.urgentNotImportant = nil;
    }
    if(self.notImportantNotUrgent != nil){
        self.urgentNotImportant = nil;
    }
    self.importantAndUrgent = [[NSMutableArray alloc] init];
    self.importantNotUrgent = [[NSMutableArray alloc] init];
    self.urgentNotImportant = [[NSMutableArray alloc] init];
    self.notImportantNotUrgent = [[NSMutableArray alloc] init];
    
    
    for(int i = 0; i < self.resultsArray.count; ++i){
        NSMutableArray* row = [[NSMutableArray alloc] init];
        row = self.resultsArray[i];
        NSString* important = [[NSString alloc] initWithString:row[3]];
        NSString* urgent = [[NSString alloc] initWithString:row[4]];
        
        if([important isEqualToString:@"yes"]){
            if([urgent isEqualToString:@"yes"]){
                [self.importantAndUrgent addObject:row];
            }else{//no
                [self.importantNotUrgent addObject:row];
            }
        }else{
            if ([urgent isEqualToString:@"yes"]) {
                [self.urgentNotImportant addObject:row];
            }else{//no
                [self.notImportantNotUrgent addObject:row];
            }
        }
    }
}

- (void) viewDidAppear:(BOOL)animated{

}

- (void)viewDidLoad {
        [super viewDidLoad];
    self.importantAndUrgent = nil;
    self.importantNotUrgent = nil;
    self.urgentNotImportant = nil;
    self.notImportantNotUrgent = nil;
    
    //add tableView
    
    [self loadData];
    
    
    CGRect frame = CGRectMake(0,20,self.view.frame.size.width, self.view.frame.size.height * 0.85);
    CGRect buttonFrame = CGRectMake(0, self.view.frame.size.height * 0.85 + 20, self.view.frame.size.width, self.view.frame.size.height * 0.15 - 20);
    self.toDoList = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    
    self.toDoList.dataSource = self;
    self.toDoList.delegate = self;
    
    //addTask button
    UIColor *colorOfButton = [[UIColor alloc] initWithRed:0.02 green:0.7 blue:0.7 alpha:1.0];
    UIButton *addTaskButton = [[UIButton alloc]initWithFrame:buttonFrame];
    [addTaskButton addTarget:self action:@selector(addTaskButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [addTaskButton setTitle:@"Add Task" forState:UIControlStateNormal];
    [addTaskButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [addTaskButton setBackgroundColor: colorOfButton];
    
    
    
    [self.view addSubview:addTaskButton];
    [self.view addSubview:self.toDoList];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//====================
//datasource protocols
//====================

- (UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //this was googled quickly; the only part that may require changing in the future is the identifier for reused cells.
    NSString *MyIdentifier = @"myIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[self.importantAndUrgent objectAtIndex:indexPath.row] objectAtIndex:1];
            break;
        case 1:
            cell.textLabel.text = [[self.importantNotUrgent objectAtIndex:indexPath.row] objectAtIndex:1];
            break;
        case 2:
            cell.textLabel.text = [[self.urgentNotImportant objectAtIndex:indexPath.row] objectAtIndex:1];
            break;
        case 3:
            cell.textLabel.text = [[self.notImportantNotUrgent objectAtIndex:indexPath.row] objectAtIndex:1];
            break;
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //sections will be devided by quadrant
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //here we would either 1) make the call to sync with cloud and then update, or just use already-updated array
    
    switch (section) {
        case 0:
            return [self.importantAndUrgent count];
            break;
        case 1:
            return [self.importantNotUrgent count];
            break;
        case 2:
            return [self.urgentNotImportant count];
            break;
        case 3:
            return [self.notImportantNotUrgent count];
            break;
        default:
            NSLog(@"Entered the default statement - something is wrong");
            return 0;
    }
}


//==================
//delegate protocols
//==================

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

//required method for viewforheaderinsection
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

//http://stackoverflow.com/questions/15611374/customize-uitableview-header-section found here

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *list = @[@"Urgent and Important - Do it now",@"Important but not Urgent - Schedule it",@"Urgent but not important - Delegate it",@"Not important, Not urgent - Eliminate it."];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    NSString *string =[list objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    
    //setting the color
    
    UIColor *color;
    //this can be refactored
    switch (section) {
        case 0:
            color = [UIColor colorWithRed:54/255.0 green: 217/255.0 blue:122/255.0 alpha:1.0];
            break;
        case 1:
            color = [UIColor colorWithRed:42/255.0 green:79/255.0 blue:163/255.0 alpha:1.0];
            break;
        case 2:
            color = [UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0];
            break;
        case 3:
            color = [UIColor colorWithRed:201/255.0 green:66/255.0 blue:64/255.0 alpha:1.0];
            break;
        default:
            color = [UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0];
            break;
    }
    [view setBackgroundColor: color]; //your background color...
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailScreenViewController* newVC = (DetailScreenViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"DetailScreenViewController"];
    NSMutableArray *row;
    
    switch (indexPath.section) {
        case 0:
            row = self.importantAndUrgent;
            break;
        case 1:
            row = self.importantNotUrgent;
            break;
        case 2:
            row = self.urgentNotImportant;
            break;
        case 3:
            row = self.notImportantNotUrgent;
            break;
        default:
            break;
    }
    
    newVC.taskTitle = row[indexPath.row][1];
    newVC.descriptions = row[indexPath.row][2];
    newVC.important = row[indexPath.row][3];
    newVC.urgent = row[indexPath.row][4];
    newVC.tableRowPath = indexPath;
    newVC.homePage = self;
    
    [self presentViewController:newVC animated:YES completion:nil];
    
    return;
}

//====================
//addTaskButtonPressed
//====================

- (void)addTaskButtonPressed{
    //insantiate new controller
    AddTaskViewController* newVC = (AddTaskViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    //present it
    newVC.homePage = self;
    [self presentViewController:newVC animated:YES completion:nil];
    
    return;
}

-(void) reloadTable{
    [self loadData];
    [self.toDoList reloadData];
}

-(void) deselectTableRow:(NSIndexPath*)directory {
    [self.toDoList deselectRowAtIndexPath:directory animated:NO];
    return;
}


/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0,0,self.view.frame.size.width, 80);
    UIView *banner = [[UIView alloc] initWithFrame:frame];
    
    
    return banner;
}*/

@end
