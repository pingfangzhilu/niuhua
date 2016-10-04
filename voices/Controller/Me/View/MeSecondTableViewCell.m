//
//  MeSecondTableViewCell.m
//  voices
//
//  Created by pc on 16/10/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeSecondTableViewCell.h"

@implementation MeSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self CreateUI];
    }
    return self;

}


 - (void)CreateUI
{
        UIView *topline =[[UIView alloc]init];
        topline.backgroundColor  =[DisplayUtil hexStringToColor:@"e6e6e6"];
        [self.contentView addSubview:topline];
        [topline mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(@0.5);
            make.top.equalTo(self.contentView.mas_top);
    
        }];
    
    
    UIView *BottomLine =[[UIView alloc]init];
    BottomLine.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self.contentView addSubview:BottomLine];
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];

    self.firstImagev =[[UIImageView alloc]init];
    self.firstImagev.image =[UIImage imageNamed:@"menu_star"];
    [self.contentView addSubview:self.firstImagev];
    
    [self.firstImagev mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@10);
        make.height.equalTo(@10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        
    }];
    
    self.CentLabel =[[UILabel alloc]init];
    self.CentLabel.font =[UIFont systemFontOfSize:18];
    self.CentLabel.text =@"我的收藏";
    [self.contentView addSubview:self.CentLabel];
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@30);
        make.left.equalTo(self.firstImagev.mas_right).with.offset(0);
        make.width.equalTo(@100);
        
        
        
    }];
    
    self.ArrayImag =[[UIImageView alloc]init];
    self.ArrayImag.image =[UIImage imageNamed:@"bottom_menu_collect"];
    [self.contentView addSubview:self.ArrayImag];
    [self.ArrayImag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
        
    }];
    
    
    
}

@end
