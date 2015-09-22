//
//  AddTaskViewController.m
//  FreeTime
//
//  Created by Wilson Huang on 2015-08-16.
//  Copyright (c) 2015 Wilson Huang. All rights reserved.
//

#import "AddTaskViewController.h"
#import "DBManager.h"

@interface AddTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addTaskTitletxt;
@property (strong, nonatomic) DBManager* dbmanager;
@property (weak, nonatomic) IBOutlet UITextField *addTaskDescriptiontxt;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (weak, nonatomic) IBOutlet UILabel *importantLabel;
@property (weak, nonatomic) IBOutlet UILabel *urgentLabel;
//important checkbox
@property BOOL importantCheckBox;
//urgent checkbox
@property (weak, nonatomic) IBOutlet UIButton *importantButton;
@property (weak, nonatomic) IBOutlet UIButton *urgentButton;
@property BOOL urgentCheckBox;

@end

@implementation AddTaskViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.importantCheckBox = false;
    self.urgentCheckBox = false;
    
    
    [self.importantButton setBackgroundImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [self.importantButton setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [self.importantButton setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    [self.importantButton addTarget:self action:@selector(importantCheckBoxChecked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.urgentButton setBackgroundImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [self.urgentButton setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [self.urgentButton setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    [self.urgentButton addTarget:self action:@selector(urgentCheckBoxChecked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.addTaskTitletxt setReturnKeyType:UIReturnKeyDone];
    [self.addTaskTitletxt setDelegate:self];
    [self.addTaskDescriptiontxt setReturnKeyType:UIReturnKeyDone];
    [self.addTaskDescriptiontxt setDelegate:self];
    
    CGRect buttonFrame = CGRectMake(self.view.frame.size.width * 0.25,
                                    self.view.frame.size.height * 0.75,
                                    self.view.frame.size.width * 0.5,
                                    80);
    
    UIColor *colorOfButton = [[UIColor alloc] initWithRed:0.02 green:0.7 blue:0.7 alpha:1.0];
    UIButton *addTaskButton = [[UIButton alloc]initWithFrame:buttonFrame];
    [addTaskButton addTarget:self action:@selector(addTaskButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [addTaskButton setTitle:@"Add Task" forState:UIControlStateNormal];
    [addTaskButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [addTaskButton setBackgroundColor: colorOfButton];
    

    
    [self.view addSubview:addTaskButton];
    
    self.dbmanager = [[DBManager alloc] initWithDatabaseFilename:@"freeTimeDB.sql"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)importantCheckBoxChecked:(id) sender{
    self.importantCheckBox = !self.importantCheckBox;
    [sender setSelected:self.importantCheckBox];
    return;
}

-(void)urgentCheckBoxChecked:(id)sender{
    self.urgentCheckBox = !self.urgentCheckBox;
    [sender setSelected:self.urgentCheckBox];
    return;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addTaskButtonPressed{
    NSString* important = self.importantCheckBox? @"yes" : @"no";
    NSString* urgent = self.urgentCheckBox? @"yes" : @"no";
    //table is named tasks
    NSString* query = [NSString stringWithFormat:@"insert into tasks values(null,'%@', '%@', '%@', '%@');", self.addTaskTitletxt.text, self.addTaskDescriptiontxt.text, important, urgent];
    [self.dbmanager executeQuery:query];
    if (self.dbmanager.affectedRows != 0) {
        NSLog(@"The query used was <%@>", query);
        [self.homePage reloadTable];
        // Pop the view controller.
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
