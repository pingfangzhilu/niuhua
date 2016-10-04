//
//  MEviewTableViewCell.m
//  voices
//
//  Created by pc on 16/10/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MEviewTableViewCell.h"

@implementation MEviewTableViewCell

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
    UIView *BottomLine =[[UIView alloc]init];
    BottomLine.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self.contentView addSubview:BottomLine];
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).with.offset(70);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    
    self.HeadImagev =[[UIImageView alloc]init];
    
    [self.contentView addSubview:self.HeadImagev];
    [self.HeadImagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@48);
        make.height.equalTo(@48);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        
        
        
    }];
    
    
    self.CentLabel =[[UILabel alloc]init];
    self.CentLabel.font =[UIFont systemFontOfSize:14];
    self.CentLabel.textColor =[UIColor grayColor];
    [self.contentView addSubview:self.CentLabel];
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.HeadImagev.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.equalTo(@30);
        
    }];
    
    
    

}

@end
