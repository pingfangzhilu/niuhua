//
//  RecommJieSTableViewCell.m
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommJieSTableViewCell.h"

@implementation RecommJieSTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{


    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        [self CreateUI];
    }
    return self;
}
- (void)CreateUI
{

    self.headImageV =[[UIImageView alloc]init];
    self.headImageV.layer.masksToBounds =YES;
    self.headImageV.layer.cornerRadius =15;
    [self.contentView addSubview:self.headImageV];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        
    }];
    
    self.NameLabel =[[UILabel alloc]init];
    self.NameLabel.font =[UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:self.NameLabel];
    
    [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageV.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.equalTo(@20);
        make.left.equalTo(self.headImageV.mas_right).with.offset(10);
        
    }];
    
    
    self.PassImageV =[[UIImageView alloc]init];
    
    self.PassImageV.image =[UIImage imageNamed:@"album_play_count"];
    
    [self.contentView addSubview:self.PassImageV];
    
    [self.PassImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.height.equalTo(@10);
        
        make.top.equalTo(self.headImageV.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
    }];
    
    
    self.genxinLAbel =[[UILabel alloc]init];
    self.genxinLAbel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.genxinLAbel];
    [self.genxinLAbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.PassImageV.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.equalTo(@15);
        make.width.equalTo(@90);
    }];
    
    self.genxinImageV =[[UIImageView alloc]init];
    self.genxinImageV.image =[UIImage imageNamed:@"album_collect_count"];
    [self.contentView addSubview:self.genxinImageV];
    [self.genxinImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@10);
        make.height.equalTo(@10);
        make.right.equalTo(self.genxinLAbel.mas_left).with.offset(-2);
        make.centerY.equalTo(self.genxinLAbel.mas_centerY);
      }];
    
    self.PassLabel =[[UILabel alloc]init];
    self.PassLabel.font =[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.PassLabel];
    [self.PassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.centerY.equalTo(self.PassImageV.mas_centerY);
        make.left.equalTo(self.PassImageV.mas_right).with.offset(2);
        make.right.equalTo(self.genxinImageV.mas_left).with.offset(-2);
        
        
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
    
    


}
@end
