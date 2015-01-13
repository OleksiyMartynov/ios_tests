//
//  MyLogInControllerViewController.m
//  EmptyApp
//
//  Created by Oleksiy Martynov on 1/11/15.
//  Copyright (c) 2015 Oleksiy Martynov. All rights reserved.
//

#import "MyLogInControllerViewController.h"
#import "MyHttpRequest.h"
#import "MyUserInfo.h"
#import "MyDownloadManager.h"

@interface MyLogInControllerViewController ()
@property (strong, nonatomic) UITextField* textBox;
@end

@implementation MyLogInControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textBox = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+50, self.view.frame.size.width, self.view.frame.size.height*0.1)];
    self.textBox.backgroundColor = [UIColor whiteColor];
    self.textBox.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    UIButton* loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.textBox.frame.origin.y+self.textBox.frame.size.height ,self.view.frame.size.width, self.view.frame.size.height*0.1)];
    [loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(onLogingButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.textBox];
    [self.view addSubview:loginBtn];
}
-(void)onLogingButtonPress
{
    NSLog(@"button pressed");
    [MyUserInfo setUserName:self.textBox.text];
    NSString* uname = self.textBox.text;
    if(uname==nil || uname.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"text box cannot be empty"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else{
        //geting boards
        [[MyDownloadManager sharedInstance]makeApiCall:kGetBoards completion:^(NSString *data) {
            NSLog(@"s");
            
                          
        } failure:^(long errorCode, NSError *errorObj) {
            NSLog(@"f");
        }];
        //getting pins
        /*
        [[MyDownloadManager sharedInstance]makeApiCall:kGetPins completion:^(NSString *data) {
            NSLog(@"s");
        } failure:^(long errorCode, NSError *errorObj) {
            NSLog(@"f");
        }];*/
    }
    
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
