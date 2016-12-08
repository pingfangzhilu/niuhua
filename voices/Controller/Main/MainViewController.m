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
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIImage *selectedImage=[UIImage imageNamed: @"ic_menu_black_24dp"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:selectedImage style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
//
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PushDetailView) name:@"PushDetailView" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DetailsRecommendData:) name:@"DetailsRecommendData" object:nil];
   
   [self CreteUI];
//
    
    
    // Do any additional setup after loading the view.
}

- (void)DetailsRecommendData:(NSNotification *)notif
{
//    self.AllDataArray = (NSArray *)notif.userInfo[@"textOne"];
    self.tagName = (NSString *)notif.userInfo[@"tagName"];
  self.BigHeadURL = (NSString *)notif.userInfo[@"BigHeadURL"];
      self.ZhuantiName = (NSString *)notif.userInfo[@"ZhuantiName"];
      self.headImageVUrl = (NSString *)notif.userInfo[@"headImageVUrl"];
      self.nameStr = (NSString *)notif.userInfo[@"nameStr"];
      self.palyCount = (NSString *)notif.userInfo[@"palyCount"];
      self.genxinCount = (NSString *)notif.userInfo[@"genxinCount"];
      self.ContString = (NSString *)notif.userInfo[@"ContString"];
    



}



- (void)buttonClick:(id)sender{
    
   [self.slideMenuController toggleLeft];
    
    NSLog(@"左边");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:animated];


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
    scnav.subViewControllers = @[Recommend,Class,me];
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

- (void)PushDetailView
{

    
    
    if (self.headImageVUrl==nil && self.nameStr==nil &&self.BigHeadURL ==nil&&self.genxinCount ==nil) {
        
        return;
    }
    else
    {
    
    
    DetailsRecommendViewController *Detais =[[DetailsRecommendViewController alloc]init];
    
        Detais.tagName=self.tagName;
        
    
     
        Detais.BigHeadURL=     self.BigHeadURL;
    Detais.ZhuantiName=    self.ZhuantiName;
  Detais.headImageVUrl=      self.headImageVUrl;
 Detais.nameStr=       self.nameStr;
Detais.palyCount=        self.palyCount;
 Detais.genxinCount=       self.genxinCount;
Detais.ContString=        self.ContString;

    
    
    
    
    [self.navigationController pushViewController:Detais animated:YES];
    }
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
