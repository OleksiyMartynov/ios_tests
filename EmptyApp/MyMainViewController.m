//
//  MyMainViewController.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/7/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyMainViewController.h"

@interface MyMainViewController ()
@property (nonatomic,strong) UITextField* textField;
@end

@implementation MyMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.x+5, 100, 100)];
    self.textField.backgroundColor=[UIColor orangeColor];
    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 50, 50)];
    v.backgroundColor = [UIColor purpleColor];
    
    
    [self.textField addSubview:v];
    [self.view addSubview:self.textField];
    
    //CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2/2);
    //self.textField.transform = transform;
    //v.transform=transform;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
