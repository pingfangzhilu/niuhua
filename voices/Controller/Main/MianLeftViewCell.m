//
//  MianLeftViewCell.m
//  voices
//
//  Created by pc on 16/10/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MianLeftViewCell.h"

@implementation MianLeftViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{


    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreateUI];
    }

    return self;
}
- (void)CreateUI
{
  self.headimge =[[UIImageView alloc]init];
    
    
    [self.contentView addSubview:_headimge];
    
    [_headimge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@34);
        make.height.equalTo(@34);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
    }];
    
    
    
    UIView *lineview =[[UIView alloc]init];
    lineview.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self.contentView addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(_headimge.mas_right).with.offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
        
    }];
    
    self.mySwitch =[[UISwitch alloc]init];
    
//            [self.mySwitch setOn:NO];
//    [self.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.mySwitch];
    
    [self.mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
        
    }];
    self.mySwitch.transform = CGAffineTransformMakeScale(0.75, 0.7);
  
    
    
    //
   self.centLabel =[[UILabel alloc]init];
     self.centLabel.font =[UIFont systemFontOfSize:15];
    
    [self.contentView addSubview: self.centLabel];
    [ self.centLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.headimge.mas_right).with.offset(10);
        make.right.equalTo(self.mySwitch.mas_left).with.offset(-5);
        make.height.equalTo(@20);
        
        
        
    }];
    


}



//-(void)switchAction:(id)sender
//{
//    UISwitch *switchButton = (UISwitch*)sender;
//    BOOL isButtonOn = [switchButton isOn];
//    if (isButtonOn) {
////        showSwitchValue.text = @"是";
//        NSLog(@"shi");
//        
//    }else {
////        showSwitchValue.text = @"否";
//        NSLog(@"no");
//    }
//}







@end
