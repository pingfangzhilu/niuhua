//
//  LeftViewController.m
//  SlideMenuControllerOC
//
//  Created by ChipSea on 16/2/27.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "LeftViewController.h"


@implementation LeftViewController

-(void)viewDidLoad {
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    _menus = @[@"Main", @"Swift", @"Java", @"Go", @"NonMenu"];
      CGFloat ImavHeight = self.view.frame.size.width*2/3;
    self.tableView =[[UITableView alloc]init];
    
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(@(ImavHeight));
        
        
    }];
    
    
    self.DataArray =@[@""];
    
    UIImageView *headImagev =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ImavHeight, ImavHeight *2/3)];
    headImagev.image =[UIImage imageNamed:@"navigation_header_view_bg"];
   
    self.tableView.tableHeaderView =headImagev;
    
    
    
//    [self.tableView ]
    
    
    
//    self.tableView.separatorColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SwiftViewController *swiftViewController = (SwiftViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"SwiftViewController"];
//    self.swiftViewController = [[UINavigationController alloc] initWithRootViewController: swiftViewController];
//    
//    JavaViewController *javaViewController = (JavaViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"JavaViewController"];
//    self.javaViewController = [[UINavigationController alloc] initWithRootViewController: javaViewController];
//    
//    GoViewController *goViewController = (GoViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"GoViewController"];
//    self.goViewController = [[UINavigationController alloc] initWithRootViewController: goViewController];
//    
//    NonMenuController *nonMenuViewController = (NonMenuController *)[storyboard  instantiateViewControllerWithIdentifier:@"NonMenuController"];
//    nonMenuViewController.delegate = self;
//    self.nonMenuViewController = [[UINavigationController alloc] initWithRootViewController: nonMenuViewController];
//    
//    [_tableView registerCellClass:[BaseTableViewCell class]];
    
//    self.imageHeaderView = (ImageHeaderView *)[ImageHeaderView loadNib];
//    [self.view addSubview:self.imageHeaderView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.imageHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 160);
//    [self.view layoutIfNeeded];
}

-(void)changeViewController:(LeftMenu) menu {
    switch (menu) {
        case LeftMenuMain:
//           [self.slideMenuController changeMainViewController:self.mainViewControler close:YES];
            
            break;
//        case LeftMenuSwift:
//            [self.slideMenuController changeMainViewController:self.swiftViewController close:YES];
//            break;
//        case LeftMenuJava:
//            [self.slideMenuController changeMainViewController:self.javaViewController close:YES];
//            break;
//        case LeftMenuGo:
//            [self.slideMenuController changeMainViewController:self.goViewController close:YES];
//            break;
//        case LeftMenuNonMenu:
//            [self.slideMenuController changeMainViewController:self.nonMenuViewController close:YES];
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
   NSString *iden =@"rrrr";
    RecommSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        cell =[[RecommSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        
    }
    
    
    cell.CentLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self changeViewController:indexPath.row];
}

@end
