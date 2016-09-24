//
//  BMDefine.h
//  EnjoyFood
//
//  Created by zwl on 15/3/27.
//  Copyright (c) 2015年 赵文龙. All rights reserved.
//

#ifndef BlueMobiFrame_BMDefine_h
#define BlueMobiFrame_BMDefine_h

/**
 *  @brief 获取一个控件的最大Y坐标
 *
 *  @param view 视图对象
 *
 *  @return Y坐标
 */
#define DEF_FRAME_MAX_Y(view) (view.frame.origin.y+view.frame.size.height)

/**
 *  @brief 获取一个控件的最小Y坐标
 *
 *  @param view 视图对象
 *
 *  @return Y坐标
 */
#define DEF_FRAME_MIN_Y(view) (view.frame.origin.y)

/**
 *  @brief 获取一个控件的最大X坐标
 *
 *  @param view 视图对象
 *
 *  @return X坐标
 */
#define DEF_FRAME_MAX_X(view) (view.frame.origin.x+view.frame.size.width)

/**
 *  @brief 获取一个控件的最小X坐标
 *
 *  @param view 视图对象
 *
 *  @return X坐标
 */
#define DEF_FRAME_MIN_X(view) (view.frame.origin.x)

/**
 *  @brief 获取一个控件的宽度
 *
 *  @param view 视图对象
 *
 *  @return 宽度
 */
#define DEF_FRAME_W(view) (view.frame.size.width)

/**
 *  @brief 获取一个控件的高度
 *
 *  @param view 视图对象
 *
 *  @return 高度
 */
#define DEF_FRAME_H(view) (view.frame.size.height)

/**
 *  @brief 设置一个控件的X坐标
 *
 *  @param view 视图对象
 *
 *  @return void
 */
#define DEF_SET_FRAME_X(view,x) view.frame = CGRectMake(x,view.frame.origin.y,view.frame.size.width,view.frame.size.height)

/**
 *  @brief 设置一个控件的Y坐标
 *
 *  @param view 视图对象
 *
 *  @return void
 */
#define DEF_SET_FRAME_Y(view,y) view.frame = CGRectMake(view.frame.origin.x, y,view.frame.size.width,view.frame.size.height)

/**
 *  @brief 设置一个控件的高度
 *
 *  @param view 视图对象
 *
 *  @return void
 */
#define DEF_SET_FRAME_H(view,h) view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width, h);

/**
 *  @brief 设置一个控件的宽度
 *
 *  @param view 视图对象
 *
 *  @return void
 */
#define DEF_SET_FRAME_W(view,w) view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y,w,view.frame.size.height);

/**
 *	@brief	设置白色
 */
#define DEF_WhiteColor [UIColor whiteColor]

/**
 *	@brief	设置黑色
 */
#define DEF_BlackColor [UIColor blackColor]

/**
 *	@brief	设置蓝色
 */
#define DEF_BlueColor [UIColor blueColor]

/**
 *	@brief	设置绿色
 */
#define DEF_GreenColor [UIColor greenColor]

/**
 *	@brief	设置灰色
 */
#define DEF_GrayColor [UIColor grayColor]

/**
 *	@brief	设置红色
 */
#define DEF_RedColor [UIColor redColor]

/**
 *	@brief	设置橘色
 */
#define DEF_OrangeColor [UIColor orangeColor]

/**
 *	@brief	设置紫色
 */
#define DEF_PurpleColor [UIColor purpleColor]

/**
 *	@brief	设置黄色
 */
#define DEF_YellowColor [UIColor yellowColor]

/**
 *	@brief	设置透明
 */
#define DEF_ClearColor [UIColor clearColor]

/**
 *	@brief	视图的背景颜色
 */
#define DEF_ViewBackColor [UIColor colorWithRed:241/255.0 green:238/255.0 blue:237/255.0 alpha:1.0]
/**
 *  @brief 橘色，如同tabarbtn选中颜色
 */
#define DEF_TabarBtnColor [UIColor colorWithRed:246.0/255 green:170.0/255 blue:39.0/255 alpha:1]

/**
 *  @brief 女士性别的颜色
 */
#define DEF_GirlColor [UIColor colorWithRed:245.0/255 green:115.0/255 blue:101.0/255 alpha:1]

/**
 *  @brief 深灰色
 */
#define DEF_DarkGrey [UIColor colorWithRed:197.0/255 green:188.0/255 blue:185.0/255 alpha:1]

/**
 *	@brief	按钮的背景颜色类似于黄色
 */
#define DEF_ButtonBackColor [UIColor colorWithRed:255/255.0 green:170/255.0 blue:61/255.0 alpha:1.0]
/**
 *  @brief 深棕色，如同tabar背景色
 */
#define DEF_TabarBtnDarkGrayColor [UIColor colorWithRed:92/255.0 green:69/255.0 blue:56/255.0 alpha:1.0]

/**
 *  @brief 淡红色，如同tabar背景色
 */
#define DEF_LightRedColor [UIColor colorWithRed:233/255.0 green:95/255.0 blue:112/255.0 alpha:1.0]

/**
 *  @brief 深绿色
 */
#define DEF_DarkGreenColor [UIColor colorWithRed:30.0/255 green:185.0/255 blue:55.0/255 alpha:1]

/**
 *  @brief 亮灰色，
 */
#define DEF_Border_LightGrayColor  [[UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1.0] CGColor]

/**
 *  @brief 橘色，如同tabarbtn选中颜色
 */
#define DEF_Border_OrangeColor [[UIColor colorWithRed:246.0/255 green:170.0/255 blue:39.0/255 alpha:1]CGColor]

/**
 *  @brief 绿色，
 */
#define DEF_Border_GreenColor [[UIColor colorWithRed:18.0/255 green:255.0/255 blue:39.0/255 alpha:1]CGColor]

/**
 *  @brief 红色，
 */
#define DEF_Border_RedColor [[UIColor colorWithRed:255.0/255 green:10.0/255 blue:10.0/255 alpha:1]CGColor]

/**
 *  @brief 白色，
 */
#define DEF_Border_WhiteColor [[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1]CGColor]

/**
 *  @brief 导航左边的按纽
 */
#define NAVBAR_LEFTBNT_TAG (1)
/**
 *  @brief 导航右边的按纽
 */
#define NAVBAR_RIGHTBNT_TAG (2)
/**
 *  @brief 导航右1的按纽
 */
#define NAVBAR_MIDBNT_TAG (3)

/**
 *  @brief 从手机选择
 */
#define CHOOSEPICTURE_FROMPHONE_TAG (1)
/**
 *  @brief 从我的相机
 */
#define CHOOSEPICTURE_FROMPHOTO_TAG (2)
/**
 *  @brief 取消
 */
#define CHOOSEPICTURE_CANCEL_TAG (4)


#define CUSTOMALTERVIEW_ICONBNT_TAG (1)
#define CUSTOMALTERVIEW_OKBNT_TAG (2)

/*
 *默认的键盘高度
 */
#define DEFAULT_KEYBROAD_HEIGHT (256)

/*
 *弹出SCENEACION动画的时间
 */
#define SCENEACION_ANIMATION  (0.4f)

/*
 *弹出图片动画的时间
 */
#define POPCHOOSEPIC_ANIMATION  (0.2f)

/*
 *弹出PICKVIEW动画的时间
 */
#define POPPICKVIEW_ANIMATION  (0.2f)

/**
 *
 */
#define DEF_CALCUATION_SIZE(str,font,w,h) [str sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(w,h) lineBreakMode:UILineBreakModeWordWrap]


#endif
