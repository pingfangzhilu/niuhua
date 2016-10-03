//
//  ZYMyTableViewHeader.m
//  voices
//
//  Created by pc on 16/10/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZYMyTableViewHeader.h"
#import "DisplayUtil.h"
#import "Masonry.h"
@implementation ZYMyTableViewHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreateUI];
    }
    
    return self;
}

-(void)CreateUI
{

    UIView *BottomLine =[[UIView alloc]init];
    BottomLine.backgroundColor =[DisplayUtil hexStringToColor:@"e6e6e6"];
    [self addSubview:BottomLine];
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@0.5);
        make.left.equalTo(BottomLine.superview.mas_left);
        make.right.equalTo(BottomLine.superview.mas_right);
        make.bottom.equalTo(BottomLine.superview.mas_bottom);
        
    }];
    
    
    self.ImageV =[[UIImageView alloc]init];
    self.ImageV.image =[UIImage imageNamed:@"ic_column_label"];
    [self addSubview:self.ImageV];
    
    [self.ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@3);
        make.height.equalTo(@11);
        make.centerY.equalTo(self.ImageV.superview.mas_centerY);
        make.left.equalTo(self.ImageV.superview.mas_left).with.offset(10);
        
    }];
    
    
    self.MoreBtn =[[UIButton alloc]init];
    [self.MoreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
   [self.MoreBtn setTitleColor:[DisplayUtil hexStringToColor:@"999999"] forState:UIControlStateNormal];
//    [self.MoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.MoreBtn.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:10]];
    
    
    
    self.MoreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.MoreBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    [self addSubview:self.MoreBtn];
    
    [self.MoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.MoreBtn.superview.mas_right).with.offset(-13);
        make.width.equalTo(@80);
        make.centerY.equalTo(self.ImageV.mas_centerY);
        make.height.equalTo(@30);
        //        make.top.equalTo(lineV.mas_bottom);
//        make.bottom.equalTo(self.MoreBtn.superview.mas_bottom);
    }];
    

    
    
    self.CentLabel =[[UILabel alloc]init];
    self.CentLabel.font =[UIFont systemFontOfSize:16];
    [self addSubview:self.CentLabel];
    [self.CentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ImageV.mas_right).with.offset(10);
        make.centerY.equalTo(self.CentLabel.superview.mas_centerY);
        make.right.equalTo(self.MoreBtn.mas_left).with.offset(-10);
        make.height.equalTo(@30);
//        make.bottom.equalTo(self.CentLabel.superview.mas_bottom);
//        make.top.equalTo(self.CentLabel.superview.mas_top);
     }];
    
    
    
    
    
    
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
