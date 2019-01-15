//
//  GTCommontHeader.h
//  iphone6 Fix 
//
//  Created by GuanTian Li on 14-11-5.
//  Copyright (c) 2014年 GCI. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef iphone6_Fix_Demo_GTCommontHeader_h
#define iphone6_Fix_Demo_GTCommontHeader_h

CG_INLINE CGFloat GTFixHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*mainFrme.size.height/1096*2;
    return height;
}

CG_INLINE CGFloat GTReHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*1096/(mainFrme.size.height*2);
    return height;
}

CG_INLINE CGFloat GTFixWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*mainFrme.size.width/640*2;
    return width;
}

CG_INLINE CGFloat GTReWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*640/mainFrme.size.width/2;
    return width;
}

//  以iphone5屏幕为适配基础
CG_INLINE CGRect
GTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = GTFixWidthFlaot(x);
    rect.origin.y = GTFixWidthFlaot(y);
    rect.size.width = GTFixWidthFlaot(width);
    rect.size.height = GTFixWidthFlaot(height);
    return rect;
}

#endif

//判断设备类型
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kMainScreen_width [[UIScreen mainScreen] bounds].size.width
#define kMainScreen_height [[UIScreen mainScreen] bounds].size.height

#define kWidth(R) (R)*(kScreenWidth)/375
//这里的375我是针对6为标准适配的,如果需要其他标准可以修改
#define kHeight(R) (iPhone4?(R):((R)*(kScreenHeight)/667))
//这里的667我是针对6s为标准适配的,如果需要其他标准可以修改
