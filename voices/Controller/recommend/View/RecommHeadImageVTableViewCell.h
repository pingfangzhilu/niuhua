//
//  RecommHeadImageVTableViewCell.h
//  voices
//
//  Created by pc on 16/10/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayUtil.h"
#import "Masonry.h"
@interface RecommHeadImageVTableViewCell : UITableViewCell

- (void)contString :(NSString *)TextString;

@property (nonatomic,strong)UIImageView *BigHeadImagv;

@property (nonatomic,strong)UILabel *ZhuantiLabel;

@end
