//
//  RecommSecondTableViewCell.m
//  voices
//
//  Created by pc on 16/10/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommSecondTableViewCell.h"

@implementation RecommSecondTableViewCell

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

    self.headImageV =[[UIImageView alloc]init];
    
    [self.contentView addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@34);
        make.width.equalTo(@34);
        make.left.equalTo(self.headImageV.superview.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
        
    } ];
    
    
    self.CentLabel =[[UILabel alloc]init];
    
    self.CentLabel.font =[UIFont systemFontOfSize:15];
    
        [self.contentView addSubview:self.CentLabel];
    
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.headImageV.mas_centerY);
        make.left.equalTo(self.headImageV.mas_right).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.equalTo(@20);
        
        
    }];
    
    
    
    UIView *BottomLine =[[UIView alloc]init];
    BottomLine.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self.contentView addSubview:BottomLine];
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.CentLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    

}

@end
