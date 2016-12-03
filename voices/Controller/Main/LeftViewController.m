//
//  LeftViewController.m
//  SlideMenuControllerOC
//
//  Created by ChipSea on 16/2/27.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "LeftViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Interface.h"
//LeftViewController *OCP=nil ;

@implementation LeftViewController

-(void)viewDidLoad {
    
 
    
    [super viewDidLoad];
    
//      OCP =self;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        nativeInitSystem(ocCallBack);
//    });
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    [self CreteUI];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftVIEWUI:) name:@"leftVIEWUI" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftUI:) name:@"leftUIredata" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shebiUI:) name:@"shebiyunxing" object:nil];
    
}
 - (void)shebiUI:(NSNotification *)notif
{

    NSString *Str  = (NSString *)[notif object];
    if ([Str isEqualToString:@"0"]) {
         [self.AllDataArray replaceObjectAtIndex:4 withObject:@"设备未连接"];
    }
    else
    {
    
     [self.AllDataArray replaceObjectAtIndex:4 withObject:@"设备运行正常"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
 
        
        [self.tableView reloadData];
    });
    
    


}


- (void)leftUI:(NSNotification *)notif
{

    self.power = (NSString *)notif.userInfo[@"leftpower"];
    
    self.powerData =(NSString *)notif.userInfo[@"leftpowerData"];

   self.lockState=(NSString *)notif.userInfo[@"leftlockState"];
   

//

    switch ([self.power intValue]) {
        case 0:
        {
            if ([self.powerData intValue]==25 )
            {
                _menus = @[@"nav_menu_msg", @"nav_menu_search_device", @"navigation_sound", @"ic_25_battery", @"nav_menu_network_ok",@"nav_menu_unlock",@"nav_menu_dev_playlist",@"nav_menu_play_album",@"nav_menu_help_circle"];
                
                
            }else if ([self.powerData intValue]==50 )
            {
                _menus = @[@"nav_menu_msg", @"nav_menu_search_device", @"navigation_sound", @"ic_50_battery", @"nav_menu_network_ok",@"nav_menu_unlock",@"nav_menu_dev_playlist",@"nav_menu_play_album",@"nav_menu_help_circle"];
            }
            else if([self.powerData intValue]==75)
            {
                _menus = @[@"nav_menu_msg", @"nav_menu_search_device", @"navigation_sound", @"ic_75_battery", @"nav_menu_network_ok",@"nav_menu_unlock",@"nav_menu_dev_playlist",@"nav_menu_play_album",@"nav_menu_help_circle"];
                
                
                
            }else
            {
                
                _menus = @[@"nav_menu_msg", @"nav_menu_search_device", @"navigation_sound", @"ic_100_battery", @"nav_menu_network_ok",@"nav_menu_unlock",@"nav_menu_dev_playlist",@"nav_menu_play_album",@"nav_menu_help_circle"];
                
                
            }
        }
            break;
            case 1:
        {
        
             _menus = @[@"nav_menu_msg", @"nav_menu_search_device", @"navigation_sound", @"ic_charge_lightning", @"nav_menu_network_ok",@"nav_menu_unlock",@"nav_menu_dev_playlist",@"nav_menu_play_album",@"nav_menu_help_circle"];
            
            
        }
            break;
        default:
            break;
    }
    

   
    
    
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
         [self.tableView reloadData];
    });
    
   
    

}


- (void)leftVIEWUI:(NSNotification *)notif
{




}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"leftUIredata" object:nil];



}


//- (void)viewWillAppear:(BOOL)animated
//{
//
//    [super viewWillAppear:animated];
//    
//
//}


- (void)wifiNmane
{


    
    //            获取Wi-Fi名称
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        //                NSString *str = info[@"SSID"];
        self.wifiName =info[@"SSID"];
        
        NSLog(@"WIFI====%@", self.wifiName);
//        [self wifiView];
    }

}


#define currentWindow  [UIApplication sharedApplication].keyWindow
- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int heightY = keyboardRect.size.height;
     [currentWindow setNeedsUpdateConstraints];
    
    [self.WhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.equalTo(currentWindow.mas_left).with.offset(20);
//        make.right.equalTo(currentWindow.mas_right).with.offset(-20);
//        make.height.equalTo(@(200));
//        make.centerY.equalTo(currentWindow.mas_centerY);
//        make.top.equalTo(currentWindow.mas_top).with.offset((currentWindow.frame.size.height-heightY-200)*0.5);
          make.centerY.equalTo(currentWindow.mas_centerY).with.offset(-heightY*0.5);
    }];
    
    // 更新约束
//    [UIView animateWithDuration:keyboardDuration animations:^{
    
        [currentWindow layoutIfNeeded];
        
//    }];
    
}



-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    
//    [self.WhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(currentWindow.mas_left).with.offset(20);
//        make.right.equalTo(currentWindow.mas_right).with.offset(-20);
//        make.height.equalTo(@(200));
//        make.centerY.equalTo(currentWindow.mas_centerY);
//        
//        
//    }];
    
}




//void ocCallBack(int type,char *msg,int size)
//{
//        printf("type = %d\n",type);
//    
//    [OCP ocCallMsg:type];
//}
//
//- (void)ocCallMsg:(int)type
//{
//    if (type==SYS_EVENT) {
//        Sysdata_t *sys = nativeGetSysdata();
//    }else if(type==PLAY_EVENT){
//        Mplayer_t * play = nativeGetPlayer();
//        printf("play->playState = %d\n",play->playState);
//        printf("play->name = %s\n",play->musicName);
//    }else{      //NETWORK_EVENT
//    
//    }
//    
//    
//
////    sys->
//}

- (void)CreteUI
{


    self.automaticallyAdjustsScrollViewInsets =NO;
    _menus = @[@"nav_menu_msg", @"nav_menu_search_device", @"navigation_sound", @"nav_menu_battery", @"nav_menu_network_ok",@"nav_menu_unlock",@"nav_menu_dev_playlist",@"nav_menu_play_album",@"nav_menu_help_circle"];
    
    
   NSArray *AAAA = @[@"我的消息",@"搜索设备",@"2",@"机器人电量",@"设备未连接",@"5",@"设备播放列表",@"声音所在专辑",@"帮助与反馈"];
    [self.AllDataArray addObjectsFromArray:AAAA];
    
    CGFloat ImavHeight = self.view.frame.size.width*2/3;
    self.tableView =[[UITableView alloc]init];
    
    
    
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.bounces =NO;
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





}






-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self wifiNmane];
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
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row!=2&&indexPath.row!=5) {
        
        NSString *iden =@"rrrr";
        RecommSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
        if (cell==nil) {
            cell =[[RecommSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
            
        }
        //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headImageV.image =[UIImage imageNamed:_menus[indexPath.row]] ;
        
        cell.CentLabel.text =self.AllDataArray[indexPath.row];
//        [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        return cell;

        
    }
    if (indexPath.row ==2)
    {
    
        UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        UIImageView *headImage =[[UIImageView alloc]init];
        headImage.image =[UIImage imageNamed:@"navigation_sound"];
        [cell addSubview:headImage];
        
        [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@34);
            make.height.equalTo(@34);
            make.left.equalTo(cell.mas_left).with.offset(10);
            make.centerY.equalTo(cell.mas_centerY);
        }];
        
        self.slider =[[UISlider alloc]init];
//        self.slider.minimumValue =0;
//        self.slider.maximumValue =1;
           self.slider.continuous =NO;
        [ self.slider  addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.slider.minimumValue=0;
        self.slider.maximumValue =99;
        self.slider.value = 50;
//        [[XMSDKPlayer sharedPlayer] setVolume:0.5];
        
        [cell addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(headImage.mas_right).with.offset(10);
            make.right.equalTo(cell.mas_right).with.offset(-10);
            make.height.equalTo(@20);
            make.centerY.equalTo(cell.mas_centerY);
            
            
        }];
        UIView *lineview =[[UIView alloc]init];
        lineview.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
        [cell addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.right.equalTo(cell.mas_right);
            make.left.equalTo(headImage.mas_right).with.offset(10);
            make.bottom.equalTo(cell.mas_bottom);
            
            
        }];

//        [[XMSDKPlayer sharedPlayer] setVolume:volumeView.value];
        
        
        return cell;
    
    }else
    {
        
        
        static NSString *iden =@"dwfewe";
        
        MianLeftViewCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
        if (cell==nil) {
            
            cell =[[MianLeftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
      
          [cell.mySwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
        

        if ([self.lockState isEqualToString:@"0"]) {
            [cell.mySwitch setOn:NO];
//            cell.headimge.image =[UIImage imageNamed:@"nav_menu_lock"];
//            cell.centLabel.text =@"设备已锁";
        }else if ([self.lockState isEqualToString:@"1"])
        {
            [cell.mySwitch setOn:YES];
//            cell.headimge.image =[UIImage imageNamed:@"nav_menu_unlock"];
//            cell.centLabel.text =@"设备已解锁";
            
        }
        else
        {
        [cell.mySwitch setOn:NO];
        
        }

        
        
     if ([cell.mySwitch isOn]) {
            
           cell.headimge.image =[UIImage imageNamed:@"nav_menu_unlock"];
           cell.centLabel.text =@"设备已解锁";
            
            
        }else
        {
        
           cell.headimge.image =[UIImage imageNamed:@"nav_menu_lock"];
           cell.centLabel.text =@"设备已锁";
        }
//
//        for (id obj in cell.subviews)
//        {
//            if ([NSStringFromClass([obj class])isEqualToString:@"MianLeftViewCell"])
//            {
//                UIScrollView *scroll = (UIScrollView *) obj;
//                scroll.delaysContentTouches =NO;
//                break;
//            }
//        }

        
        
        
        return cell;
    
    
    }
    
    
    
    
    
  }
-(void)sliderValueChanged:(id)sender
{
    nativeSetVol_Data(self.slider.value);
    
// [[XMSDKPlayer sharedPlayer] setVolume:self.slider.value];

}
-(void)switchIsChanged:(UISwitch *)paramSender{
   
   UISwitch *switchButton = (UISwitch*)paramSender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"YES");
//         self.lockState =@"1";
        nativeUnlockHost();
       
   }else {
       NSLog(@"No");
//         self.lockState =@"0";
        nativeLockHost();
   }
    
//
    
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:5 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self changeViewController:indexPath.row];
    
    
    switch (indexPath.row) {
        case 1:
        {
////            获取Wi-Fi名称
//            id info = nil;
//            NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
//            for (NSString *ifnam in ifs) {
//                info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
////                NSString *str = info[@"SSID"];
//            self.wifiName =info[@"SSID"];
            
                NSLog(@"WIFI====%@", self.wifiName);
                [self wifiView];
//            }
        
        }
            break;
            
            case 5:
        {
       MianLeftViewCell  *cell =[tableView cellForRowAtIndexPath:indexPath];
        
            if ([cell.mySwitch isOn]) {
                [self switchIsChanged:cell.mySwitch];
                
//               [cell.mySwitch setOn:NO];
//                cell.headimge.image =[UIImage imageNamed:@"nav_menu_lock"];
//                cell.centLabel.text =@"设备已锁";
                
            }else
            {
                [self switchIsChanged:cell.mySwitch];
                
//                [cell.mySwitch setOn:YES];
//                
//                cell.headimge.image =[UIImage imageNamed:@"nav_menu_unlock"];
//                cell.centLabel.text =@"设备已解锁";
            }
            
            
        }
             break;
            
            case 7:
        {
         
            
//            DetailsRecommendViewController *details =[[DetailsRecommendViewController alloc]init];
//            details.tagName =@"257813";
//
            
          [self.slideMenuController changeMainViewController:nil close:YES];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"PushDetailView" object:nil];
//            [self.navigationController pushViewController:details animated:YES];
                  
            
        }
             break;
        default:
            break;
    }
    if (indexPath.row==2||indexPath.row==5) {
       
    }
    else
    { NSIndexPath *indexPathxxx=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathxxx,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}

- (void)wifiView
{

    self.BackView =[[UIView alloc]init];
    
    self.BackView.backgroundColor =[UIColor blackColor];
   self.BackView.alpha =0.6;
    
    
    [currentWindow addSubview:self.BackView];
    
    
  
    
    
    [self.BackView mas_makeConstraints:^(MASConstraintMaker *make) {
       
         make.edges.equalTo(currentWindow).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }];
    UITapGestureRecognizer *BackTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BackTap:)];
    
    [self.BackView addGestureRecognizer:BackTap];
    
   self.WhiteView =[[UIView alloc]init];
    self.WhiteView.backgroundColor =[UIColor whiteColor];
    
    [currentWindow addSubview:self.WhiteView];
    
    [self.WhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(currentWindow.mas_left).with.offset(20);
        make.right.equalTo(currentWindow.mas_right).with.offset(-20);
        make.height.equalTo(@(200));
        make.centerY.equalTo(currentWindow.mas_centerY);
        
        
    }];
    
    UILabel *nameStr =[[UILabel  alloc]init];
    nameStr.text =[NSString stringWithFormat:@"当前Wi-Fi:%@",self.wifiName];
    nameStr.textColor =[UIColor grayColor];
    nameStr.font =[UIFont systemFontOfSize:15];
    [self.WhiteView addSubview:nameStr];
    [nameStr mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.WhiteView.mas_left).with.offset(20);
        make.right.equalTo(self.WhiteView.mas_right).with.offset(-20);
        make.top.equalTo(self.WhiteView.mas_top).with.offset(10);
        make.height.equalTo(@20);
        
        
    }];
    
    
//    UILabel *mimaLabel =[[UILabel alloc]init];
//    mimaLabel.textColor =[UIColor greenColor];
//    mimaLabel.font =[UIFont systemFontOfSize:13];
//    mimaLabel.text =@"请输入Wi-Fi密码";
//    
//    [self.WhiteView addSubview:mimaLabel];
//    [mimaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(nameStr.mas_bottom).with.offset(10);
//        make.height.equalTo(@15);
//        make.left.equalTo(self.WhiteView.mas_left).with.offset(20);
//        make.right.equalTo(self.WhiteView.mas_right).with.offset(-20);
//        
//    }];
    
    self.wifiMima =[[UITextField alloc]init];
    self.wifiMima.placeholder =@"请输入Wi-Fi密码";
//    self.wifiMima.keyboardType =UIKeyboardTypeNamePhonePad;
    self.wifiMima.delegate =self;
    
    
    [self.WhiteView addSubview:self.wifiMima];
    
    [self.wifiMima mas_makeConstraints:^(MASConstraintMaker *make) {
        
                make.top.equalTo(nameStr.mas_bottom).with.offset(10);
                make.height.equalTo(@20);
                make.left.equalTo(self.WhiteView.mas_left).with.offset(20);
                make.right.equalTo(self.WhiteView.mas_right).with.offset(-20);
                
            }];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor =[UIColor greenColor];
    [self.WhiteView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.WhiteView.mas_left).with.offset(20);
        make.right.equalTo(self.WhiteView.mas_right).with.offset(-20);
        make.height.equalTo(@(1));
        make.top.equalTo(self.wifiMima.mas_bottom).with.offset(2);
        
    }];
    
    
    
    self.tishiLabel =[[UILabel alloc]init];
    
    self.tishiLabel.textColor =[UIColor redColor];
    
    self.tishiLabel.font =[UIFont systemFontOfSize:13];
    
    self.tishiLabel.text =@"密码长度小于8";
    self.tishiLabel.hidden =YES;
    [self.WhiteView addSubview:self.tishiLabel];
    
    [self.tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(lineView.mas_bottom).with.offset(10);
        make.left.equalTo(self.WhiteView.mas_left).with.offset(20);
        make.right.equalTo(self.WhiteView.mas_right).with.offset(-20);
        make.height.equalTo(@15);
        
    }];
    
    
    self.WifiBtn =[[UILabel alloc]init];
//    [self.WifiBtn setTitle:@"开始配置网络" forState:UIControlStateNormal];
    self.WifiBtn.backgroundColor =[UIColor grayColor];
    self.WifiBtn.text =@"开始配置网络";
    self.WifiBtn.textColor =[UIColor blackColor];
    self.WifiBtn.textAlignment =NSTextAlignmentCenter;
//    [self.WifiBtn addTarget:self action:@selector(BtnCilk:) forControlEvents:UIControlEventTouchUpInside];
//    [self.WifiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BtnCilk:)];
    [self.WifiBtn addGestureRecognizer:tap];
    
    [self.WhiteView addSubview:self.WifiBtn];
    
    
    
    [self.WifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@40);
        make.centerX.equalTo(self.WhiteView.mas_centerX);
        make.width.equalTo(@120);
        make.top.equalTo(self.tishiLabel.mas_bottom).with.offset(20);
        
        
    }];
    self.WifiBtn.alpha =0.4;
    self.WifiBtn.userInteractionEnabled =NO;
    
    
    
    


}


- (void)textchange:(NSNotification *)not{
    
    if (self.wifiMima.text.length<8) {
        
        self.tishiLabel.hidden =NO;
        
        self.WifiBtn.backgroundColor =[UIColor grayColor];
        self.WifiBtn.userInteractionEnabled =NO;
        
        
    }else
    {
        NSLog(@"ka");
        self.tishiLabel.hidden =YES;
        
        self.WifiBtn.userInteractionEnabled =YES;
        
        self.WifiBtn.backgroundColor =[UIColor yellowColor];
        
//        [self searchLoad];
        
    }
    
    
    
    
   
}


- (void)BtnCilk:(UITapGestureRecognizer *)BTn
{
    
//    NSString *ss =@"222";
       const char * filePathChar = [self.wifiName UTF8String];
    const char *mima =[self.wifiMima.text UTF8String];
    InitSmartConnection("",1, 1);
    StartSmartConnection(filePathChar, mima, "");
    NSLog(@"配置");

    [self.BackView removeFromSuperview];
    [self.WhiteView removeFromSuperview];
    
}

- (void)BackTap:(UITapGestureRecognizer *)tap
{

[self.BackView removeFromSuperview]
    ;
    
    [self.WhiteView removeFromSuperview];

}


- (NSMutableArray *)AllDataArray
{


    if (!_AllDataArray) {
        
        _AllDataArray = [[NSMutableArray alloc]init];
    }
    return _AllDataArray;
}

@end
