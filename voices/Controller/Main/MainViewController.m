//
//  MainViewController.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainViewController.h"



@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self CreteUI];
    
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
