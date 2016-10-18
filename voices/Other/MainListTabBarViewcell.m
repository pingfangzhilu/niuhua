//
//  MainListTabBarViewcell.m
//  voices
//
//  Created by pc on 16/10/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MainListTabBarViewcell.h"

@implementation MainListTabBarViewcell


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

    self.DeleteBtn =[[UIButton alloc]init];
    [self.DeleteBtn setImage:[UIImage imageNamed:@"lay_protype_btn_close"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.DeleteBtn];
    
    [self.DeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@27);
        make.height.equalTo(@27);
        
        
        
    }];
    
    
    self.CentLabel =[[UILabel alloc]init];
    self.CentLabel.font =[UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:self.CentLabel];
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.DeleteBtn.mas_left).with.offset(-10);
        make.height.equalTo(@20);
        
        
    }];


    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
        
    }];
    
    
    
    

}


@end
