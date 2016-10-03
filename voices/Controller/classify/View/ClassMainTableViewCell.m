//
//  ClassMainTableViewCell.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ClassMainTableViewCell.h"
#import "DisplayUtil.h"
#import "Masonry.h"
@implementation ClassMainTableViewCell

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

    self.firstIMavg =[[UIImageView alloc]init];
    
//    self.firstIMavg.image =[UIImage imageNamed:@""];
    
    [self.contentView addSubview:self.firstIMavg];
    
    [self.firstIMavg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        
    }];
    
    
    self.headImage =[[UIImageView alloc]init];
//    self.headImage.image =[UIImage imageNamed:@""];
    [self.contentView addSubview:self.headImage];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@50);
        make.width.equalTo(@50);
        make.left.equalTo(self.firstIMavg.mas_right).with.offset(15);
        make.centerY.equalTo(self.firstIMavg.mas_centerY);
    }];
    
    
    self.IMavg =[[UIImageView alloc]init];
//    self.IMavg.image =[UIImage imageNamed:@""];
    [self.contentView addSubview:self.IMavg];
    [self.IMavg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.width.equalTo(@10);
    }];
    
    
    
    
    self.CentLabel =[[UILabel alloc]init];
    self.CentLabel.font =[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.CentLabel];
    
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.firstIMavg.mas_centerY);
        make.left.equalTo(self.headImage.mas_right).with.offset(10);
        make.right.equalTo(self.IMavg.mas_left).with.offset(-5);
        make.height.equalTo(@50);
        
        
    }];
    
    
    
    UIView *topline =[[UIView alloc]init];
    topline.backgroundColor =[UIColor grayColor];
    [self.contentView addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@1);
        make.top.equalTo(self.contentView.mas_top);
        
    }];
    
    
    UIView *BottomLine =[[UIView alloc]init];
    BottomLine.backgroundColor =[UIColor grayColor];
    [self.contentView addSubview:BottomLine];
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    
    
    



}


@end
