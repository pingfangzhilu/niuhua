//
//  DisplayUtil.h
//  ZuKeBang
//
//  Created by 雪念飞叶 on 15/11/30.
//  Copyright © 2015年 壹房一家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DisplayUtil : NSObject

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

+ (void)setupInsetsTableView :(UITableView *)tableView;

+(NSString*)DataTOjsonString:(id)object;

+ (CGSize)getSize:(CGFloat)fontSize withString:(NSString *)fontText;

@end
