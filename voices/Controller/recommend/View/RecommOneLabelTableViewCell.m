//
//  RecommOneLabelTableViewCell.m
//  voices
//
//  Created by pc on 16/10/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommOneLabelTableViewCell.h"

@implementation RecommOneLabelTableViewCell

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
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    self.CnetLabel =[[UILabel alloc]init];
    
    self.CnetLabel.font =[UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:self.CnetLabel];
    [self.CnetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView.mas_centerY);
        
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
        make.height.equalTo(@20);
    }];

    
    
    
}

@end
