//
//  RecommHeadImageVTableViewCell.m
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommHeadImageVTableViewCell.h"

@implementation RecommHeadImageVTableViewCell

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
    self.BigHeadImagv =[[UIImageView alloc]init];
    
    [self.contentView addSubview:self.BigHeadImagv];
    [self.BigHeadImagv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
        
        
    }];
    
    
    self.ZhuantiLabel =[[UILabel alloc]init];
    
    self.ZhuantiLabel.layer.cornerRadius=2;
    
    self.ZhuantiLabel.layer.borderWidth=1;
    
    self.ZhuantiLabel.layer.borderColor =[UIColor whiteColor].CGColor;
    
    self.ZhuantiLabel.textColor =[UIColor whiteColor];
    self.ZhuantiLabel.numberOfLines=0;
    
    self.ZhuantiLabel.font =[UIFont systemFontOfSize:20];
    
    
    self.ZhuantiLabel.layer.masksToBounds =YES;
    
    [self.BigHeadImagv addSubview:self.ZhuantiLabel];
    
    
    


}


- (void)contString:(NSString *)TextString
{

  CGRect rect = [TextString boundingRectWithSize:CGSizeMake(BOUNDS.size.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    self.ZhuantiLabel.text =TextString;

    [self.ZhuantiLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.BigHeadImagv.mas_left).with.offset(10);
        make.bottom.equalTo(self.BigHeadImagv.mas_bottom).with.offset(-10);
        make.width.equalTo(@(rect.size.width+2));
        make.height.equalTo(@(rect.size.height+1));  // 由于系统计算的那个高度有时候会有1像素到2像素的误差，所以这里把高度+1
    }];

}



@end
