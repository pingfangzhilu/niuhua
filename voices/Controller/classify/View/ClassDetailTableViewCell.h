//
//  ClassDetailTableViewCell.h
//  voices
//
//  Created by pc on 16/10/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayUtil.h"
#import "Masonry.h"
#import "WSMyLable.h"

@interface ClassDetailTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *HeaadImagv;

@property (nonatomic,strong)WSMyLable *CentLabel;

@property (nonatomic,strong)UIImageView *ArrowImgv;

@property (nonatomic,strong)UIImageView *PassImagv;

@property (nonatomic,strong)UILabel *PassLabel;

@property (nonatomic,strong)UIImageView *TimeImagv;

@property (nonatomic,strong)UILabel *TimeLabel;

@property (nonatomic,strong)UIImageView *LookImagv;

@property (nonatomic,strong)UILabel *LookLabel;

@end
