//
//  MainViewController.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainViewController.h"

#import "smartconfig.hpp"

@interface MainViewController ()
{

//    SlewedViewController *Slewed;
    
    BOOL isOpen;

}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self CreteUI];
//    NSString *ss =@"222";
//    const char * filePathChar = [filePath UTF8String];
     InitSmartConnection("",1, 1);
     StartSmartConnection("JYHL_24G", "asdfghjkl", "");
    
    // Do any additional setup after loading the view.
}

- (void)CreteUI
{
    
        
    
    
    MeViewController *me =[[MeViewController alloc]init];

     me.title =@"我的";
    
    
    RecommendViewController *Recommend =[[RecommendViewController alloc]init];
    
    Recommend.title =@"推荐";
    
    ClassifyViewController *Class =[[ClassifyViewController alloc]init ];
    Class.title =@"分类";
    
    
    
    SCNavTabBarController *scnav = [[SCNavTabBarController alloc]init];
    scnav.subViewControllers = @[me,Recommend,Class];
    scnav.scrollAnimation = YES;
    [scnav addParentController:self];
     isOpen = NO;

//    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(huadong:)]];
//    
//       UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
//
//    Slewed = [[SlewedViewController alloc]init];
//    Slewed.view.frame = CGRectMake(0, 0, 10, self.view.frame.size.height-49);
//     Slewed.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:Slewed];
//    [self.view addSubview:Slewed.view];
//    
    
    
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
