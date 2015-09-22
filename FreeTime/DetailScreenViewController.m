//
//  DetailScreenViewController.m
//  FreeTime
//
//  Created by Wilson Huang on 2015-07-15.
//  Copyright (c) 2015 Wilson Huang. All rights reserved.
//

#import "DetailScreenViewController.h"
#import "ToastView.h"

@interface DetailScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *taskTitleUILabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionUILabel;
@property (weak, nonatomic) IBOutlet UIImageView *importantImageView;
@property (weak, nonatomic) IBOutlet UIImageView *urgentImageView;


@end

@implementation DetailScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.importantImageView.image = [self.important isEqualToString:@"yes"] ? [UIImage imageNamed:@"selectedcheckbox.png"] : [UIImage imageNamed:@"notselectedcheckbox.png"];
    
    self.urgentImageView.image = [self.urgent isEqualToString:@"yes"] ? [UIImage imageNamed:@"selectedcheckbox.png"] : [UIImage imageNamed:@"notselectedcheckbox.png"];
    
    self.taskTitleUILabel.text = self.taskTitle;
    self.descriptionUILabel.text = self.descriptions;
    
    [self.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // Do any additional setup after loading the view.
    
}

-(void) viewWillAppear{
    
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

- (void)backButtonPressed: (id) sender{
    [self.homePage deselectTableRow:self.tableRowPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
