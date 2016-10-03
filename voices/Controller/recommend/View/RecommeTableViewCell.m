//
//  RecommeTableViewCell.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommeTableViewCell.h"
#import "DisplayUtil.h"
#import "Masonry.h"

@implementation RecommeTableViewCell

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

    self.headImaGv =[[UIImageView alloc]init];
    
    [self.contentView addSubview:self.headImaGv];
    
    [self.headImaGv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
  
    
    }];
    
    self.ArrowIMag =[[UIImageView alloc]init];
    
    self.ArrowIMag.image =[UIImage imageNamed:@"list_icn_arr_right"];
    
    [self.contentView  addSubview:self.ArrowIMag];
    [self.ArrowIMag mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.width.equalTo(@14);
        make.height.equalTo(@14);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    
    
    
    self.CentLabel =[[UILabel alloc]init];
    self.CentLabel.font =[UIFont systemFontOfSize:18];
    
    [self.contentView addSubview:self.CentLabel];
    
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.headImaGv.mas_right).with.offset(10);
        make.right.equalTo(self.ArrowIMag.mas_left).with.offset(-15);
        make.top.equalTo(self.contentView.mas_top).with.offset(20);
        make.height.equalTo(@20);
        
        
        
        
    }];
    
    
    
    
    self.ContenLabe =[[UILabel alloc]init];
    self.ContenLabe.font =[UIFont systemFontOfSize:12];
    self.ContenLabe.textColor =[UIColor blueColor];
    
    [self.contentView addSubview:self.ContenLabe];
    
    [self.ContenLabe mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.headImaGv.mas_right).with.offset(10);
        make.right.equalTo(self.ArrowIMag.mas_left).with.offset(-15);
        
        make.height.equalTo(@20);
        
        make.top.equalTo(self.CentLabel.mas_bottom).with.offset(10);
    }];
    
    
    self.PassImav =[[UIImageView alloc]init];
   self.PassImav.image =[UIImage imageNamed:@"album_play_count"];
    
    [self.contentView addSubview:self.PassImav];
    [self.PassImav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@8);
        make.height.equalTo(@10);
         make.left.equalTo(self.headImaGv.mas_right).with.offset(10);
       make.top.equalTo(self.ContenLabe.mas_bottom).with.offset(10);
        
    }];
    
    self.PassLabel =[[UILabel alloc]init];
    self.PassLabel.font =[UIFont systemFontOfSize:12];
    self.PassLabel.textColor =[DisplayUtil hexStringToColor:@"666666"];
    [self.contentView addSubview:self.PassLabel];
    
    [self.PassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self.PassImav.mas_right).with.offset(5);
        make.centerY.equalTo(self.PassImav.mas_centerY);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
        
    }];
    
    
    self.NewImagv =[[UIImageView alloc]init];
   self.NewImagv.image =[UIImage imageNamed:@"album_collect_count"];
    [self.contentView addSubview:self.NewImagv];
    [self.NewImagv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.height.equalTo(@10);
        make.left.equalTo(self.PassLabel.mas_right).with.offset(10);
        make.centerY.equalTo(self.PassImav.mas_centerY);
        
        
    }];
    
    
    self.NewLabe =[[UILabel alloc]init];
    self.NewLabe.textColor =[DisplayUtil hexStringToColor:@"666666"];
    self.NewLabe.font =[UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:self.NewLabe];
    
    [self.NewLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.NewImagv.mas_right).with.offset(5);
        make.centerY.equalTo(self.PassImav.mas_centerY);
        make.height.equalTo(@20);
        
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        
    }];
    
    
    
    
    
    
//    UIView *topline =[[UIView alloc]init];
//    topline.backgroundColor =[UIColor grayColor];
//    [self.contentView addSubview:topline];
//    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView.mas_left);
//        make.right.equalTo(self.contentView.mas_right);
//        make.height.equalTo(@1);
//        make.top.equalTo(self.contentView.mas_top);
//        
//    }];
    
    
    UIView *BottomLine =[[UIView alloc]init];
    BottomLine.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self.contentView addSubview:BottomLine];
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];

}


@end
