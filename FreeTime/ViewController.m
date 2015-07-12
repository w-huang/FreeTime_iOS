//
//  ViewController.m
//  FreeTime
//
//  Created by Prime One Media on 2015-06-07.
//  Copyright (c) 2015 Wilson Huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSArray* data;



@implementation ViewController

+ (void) initialize{
    data = @[@"item 1",@"item 2",@"item 3",@"item 4",@"item 5",@"item 6",@"item 7",@"item 8"];
}

- (void)viewDidLoad {
        [super viewDidLoad];
    //add tableView

    CGRect frame = CGRectMake(0,20,self.view.frame.size.width, self.view.frame.size.height * 0.85);
    CGRect buttonFrame = CGRectMake(0, self.view.frame.size.height * 0.85 + 20, self.view.frame.size.width, self.view.frame.size.height * 0.15 - 20);
    UITableView *toDoList = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    toDoList.dataSource = self;
    toDoList.delegate = self;
    
    //addTask button
    UIColor *colorOfButton = [[UIColor alloc] initWithRed:0.02 green:0.7 blue:0.7 alpha:1.0];
    UIButton *addTaskButton = [[UIButton alloc]initWithFrame:buttonFrame];
    [addTaskButton setTitle:@"Add Task" forState:UIControlStateNormal];
    [addTaskButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [addTaskButton setBackgroundColor: colorOfButton];
    
    
    [self.view addSubview:addTaskButton];
    [self.view addSubview:toDoList];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//datasource protocols

- (UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //this was googled quickly; the only part that may require changing in the future is the identifier for reused cells.
    NSString *MyIdentifier = @"myIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [data objectAtIndex: indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //sections will be devided by quadrant
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //here we would either 1) make the call to sync with cloud and then update, or just use already-updated array
    return 5;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Urgent and Important - Do it now";
            break;
        case 1:
            return @"Important but not Urgent - Schedule it";
            break;
        case 2:
            return @"Urgent but not important - Delegate it";
            break;
        case 3:
            return @"Not important, Not urgent - Eliminate it.";
            break;
        default:
            return @"entered default";
    }
}*/

//delegate protocols

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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, tableView.frame.size.width, 18)];
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


/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0,0,self.view.frame.size.width, 80);
    UIView *banner = [[UIView alloc] initWithFrame:frame];
    
    
    return banner;
}*/

@end
