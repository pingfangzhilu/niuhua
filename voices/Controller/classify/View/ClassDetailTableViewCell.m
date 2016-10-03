//
//  ClassDetailTableViewCell.m
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ClassDetailTableViewCell.h"

@implementation ClassDetailTableViewCell

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

    self.HeaadImagv =[[UIImageView alloc]init];
//    self.HeaadImagv.image =[UIImage imageNamed:@""];
   
    [self.contentView addSubview:self.HeaadImagv];
    
    [self.HeaadImagv mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        
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
    
    

   
    
    self.ArrowImgv =[[UIImageView alloc]init];
//    self.ArrowImgv.image =[UIImage imageNamed:@""];
    
    [self.contentView addSubview:self.ArrowImgv];
    
    [self.ArrowImgv mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.width.equalTo(@5);
        make.height.equalTo(@20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
        
    }];
    
    
    
    self.PassImagv =[[UIImageView alloc]init];
    
//    self.PassImagv.image =[UIImage imageNamed:@""];
    [self.contentView addSubview:self.PassImagv];
    
    [self.PassImagv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.height.equalTo(@10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.left.equalTo(self.HeaadImagv.mas_right).with.offset(10);
        
    }];
    
    
    self.PassLabel =[[UILabel alloc]init];
    self.PassLabel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.PassLabel];
    [self.PassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.PassImagv.mas_right).with.offset(5);
        make.centerY.equalTo(self.PassImagv.mas_centerY);
        make.height.equalTo(@15);
        make.width.equalTo(@80);
        
    }];
    
    
    
    self.LookLabel =[[UILabel alloc]init];
    self.LookLabel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.LookLabel];
    [self.LookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@45);
        make.height.equalTo(@15);
        make.centerY.equalTo(self.PassImagv.mas_centerY);
        make.right.equalTo(self.ArrowImgv.mas_left).with.offset(-10);
        
    }];
    
    
    self.LookImagv =[[UIImageView alloc]init];
//    self.LookImagv.image =[UIImage imageNamed:@""];
    [self.contentView addSubview:self.LookImagv];
    
    [self.LookImagv mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@10);
        make.width.equalTo(@10);
           make.centerY.equalTo(self.PassImagv.mas_centerY);
        make.right.equalTo(self.LookLabel.mas_left).with.offset(-5);
        
    }];
    
    
    self.TimeLabel =[[UILabel alloc]init];
    self.TimeLabel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.TimeLabel];
    
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.LookImagv.mas_left).with.offset(-5);
        make.height.equalTo(@15);
        make.centerY.equalTo(self.PassImagv.mas_centerY);
        make.width.equalTo(@35);
        
        
    }];
    
    self.TimeImagv =[[UIImageView alloc]init];
//    self.TimeImagv.image =[UIImage imageNamed:@""];
    [self.contentView addSubview:self.TimeImagv];
    
    [self.TimeImagv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@10);
        make.width.equalTo(@10);
        make.right.equalTo(self.TimeLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(self.TimeLabel.mas_centerY);
        
        
    }];
    
//    self.PassLabel =[[UILabel alloc]init];
//    self.PassLabel.font =[UIFont systemFontOfSize:12];
//    [self.contentView addSubview:self.PassLabel];
//    [self.PassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.height.equalTo(@15);
//        make.centerY.equalTo(self.PassImagv.mas_centerY);
//        make.left.equalTo(self.PassImagv.mas_right).with.offset(5);
//        make.right.equalTo(self.TimeImagv.mas_left).with.offset(-5);
//    }];
    
    
    

        self.CentLabel =[[WSMyLable alloc]init];
    
        self.CentLabel.font =[UIFont systemFontOfSize:16];
    
          [self.CentLabel setVerticalAlignment:VerticalAlignmentTop];
    
        self.CentLabel.numberOfLines =0;
    
        [self.contentView addSubview:self.CentLabel];
    
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.bottom.equalTo(self.TimeLabel.mas_top).with.offset(-5);
         make.left.equalTo(self.HeaadImagv.mas_right).with.offset(10);
        
        make.right.equalTo(self.ArrowImgv.mas_left).with.offset(-10);
    }];
    

    
    
    


}


@end
