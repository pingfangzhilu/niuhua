//
//  WSMyLable.h
//  WeiShang
//
//  Created by 曾赟 on 16/8/5.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface WSMyLable : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
@end
