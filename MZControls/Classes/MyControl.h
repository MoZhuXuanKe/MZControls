
//  MyControl.h
//  LoL
//
//  Created by LoL on 15/4/12.
//  Copyright (c) 2015年 _LoL_. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SGInfoAlert.h"
#import "GTCommontHeader.h"
//#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"


//阴影位置
typedef NS_OPTIONS(NSUInteger, WXShadowFrame) {
    WXShadowRect                         =  0,//!< 周边.
    WXShadowRightBottom            =  1,  //!< 右下阴影.
    WXShadowBottom                    =  2, //!< 正下面.
    WXShadowTop                          =  3  //!< 正下面.
};
//view圆角
typedef NS_OPTIONS(NSUInteger, WXRectCorner) {
    WXRectCornerTopLeftRight      = 0,//!< 左上_右上_角为圆角.
    WXRectCornerBottomLeftRight =1  //!< 左下_右下_角设圆角.
};
//点击按钮的效果
typedef NS_OPTIONS(NSUInteger, WXAnimationClickType) {
    WXSimpleType      = 0,//!< 简单动画,先小后大
    WXSpringType =1//!< 弹簧动画.先小后大再小,再回复正常大小
};
//动画类型
typedef NS_OPTIONS(NSUInteger, AnimationType){
    
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
};

//出场方向
typedef NS_OPTIONS(NSUInteger, AnimationSubType) {
    kWXTransitionFromLeft = 0,
    kWXTransitionFromBottom,
    kWXTransitionFromRight,
    kWXTransitionFromTop,
    kWXTransitionFromArc4rand,//随机
};

@interface MyControl : NSObject
#pragma mark 创建View
+(UIView*)createViewWithFrame:(CGRect)frame Color:(UIColor *)color;
#pragma mark 创建label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(float)font Text:(NSString*)text Color:(UIColor *)color;
#pragma mark 创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title Color:(UIColor *)color Font:(float )font TittleColor:(UIColor *)titleColor img:(NSString*)imgName BGImg:(NSString*)bgimgName;
#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
#pragma mark 创建textView
+(UITextView *)creatTextViewFrame:(CGRect)frame Font:(float)font textColor:(UIColor *)color text:(NSString *)text;
#pragma mark 创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(float)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName placeHolder:(NSString*)placeHolder sucureTextEntry:(BOOL)isOpen;

//添加NSUserDefaults
+(void)setObject:(id)object key:(NSString *)key;
//获取NSUserDefaults
+(id)getObjectForKey:(NSString *)key;
//移除NSUserDefaults
+(void)removeObjectForKey:(NSString *)key;

//转码
+(NSString *)setEncoding:(NSString *)str;


//弹出提示框
+(void)setAlertInfo:(NSString *)info
       andSuperview:(UIView *)view;

+(void)setZhexianAlertInfo:(NSString *)info
              andSuperview:(UIView *)view;

//null转化
+(NSDictionary *)nullDic:(NSDictionary *)myDic;

+(id)changeType:(id)myObj;

+(NSArray *)nullArr:(NSArray *)myArr;

+(NSString *)stringToString:(NSString *)string;

+(NSString *)nullToString;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;
/**
 *  电话弹出框
 *
 *  @param vc
 */
+(void)vc:(id)vc;

/**
 *  根据文字返回高度
 */
+(CGFloat )heightForString:(NSString *)str CGSizeMake:(CGFloat )width font:(CGFloat)font;


/**
 *  根据文字返回size
 */
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(CGFloat )font;


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;

+(void)setAlertViewVC :(id)vc message:(NSString *)message url:(NSString *)url;

//返回图片
+(UIImage *) getImageFromURL:(NSString *)fileURL;

//字符串处理
#pragma mark 字符串处理
/**
 *  去掉前后$和+符
 */
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;//去掉前后$和+符
/**
 *  去掉前后空格
 */
+ (NSString *)trimWhitespace:(NSString *)val;//去掉前后空格
/**
 *  去掉前后回车符
 */
+ (NSString *)trimNewline:(NSString *)val;//去掉前后回车符
/**
 *  去掉前后空格和回车符
 */
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;//去掉前后空格和回车符



/**
 *  加密
 *
 *  @param plainText <#plainText description#>
 *  @param key       <#key description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
/**
 *  解密
 *
 *  @param cipherText <#cipherText description#>
 *  @param key        <#key description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key;
/**
 *  画一个带虚线边框的view
 *
 *  @param bgColor         <#bgColor description#>
 *  @param frame           <#frame description#>
 *  @param cornerRadius    <#cornerRadius description#>
 *  @param lineDashPattern <#lineDashPattern description#>
 *  @param color           <#color description#>
 *
 *  @return <#return value description#>
 */
+(UIView*)drawLineWithViewBgColor:(UIColor*)bgColor Frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius lineDashPatternArray:(NSArray<NSNumber *> *)lineDashPattern strokeColor:(UIColor*)color;
/**
 *  为手机号加星号(中间4位为星号)
 *
 *  @param phoneNum <#传入手机号#>
 *
 *  @return <#返回加了星号的手机号码#>
 */
+(NSString*)phoneHidden:(NSString *)phoneNum;

+(void)animationPopupWith:(UIView*)aview duration:(CGFloat)duration;
/**
 * * 为 Label 加下划线(label的text属性必须有值)
 *
 * * @param label <#传入需要加下划线的label,label的text的属性必须有值#>
 *
 * * @return <#加了下划线的label#>
 */
+(UILabel*)underLineLabel:(UILabel*)label;

/**
 ** 为label添加删除线
 */
+(UILabel*)deleteLineLabel:(UILabel*)label;
/** 
 ** view的左右上角_左右下角_圆角设置
 */
+(UIView*)maskCornerWithView:(UIView *)view StyleType:(WXRectCorner)styleType;
/**单个圆角设置*/
+(UIView*)maskOneCornerWithView:(UIView *)view StyleType:(UIRectCorner)styleType;

/**
 **  转场动画
 **
 **  @param view    需要设置动画的View
 **  @param type    动画类型
 **  @param subtype 动画出场方向
 */
+(void)animationForView:(UIView*)view Type:(AnimationType)type WithSubtype:(AnimationSubType)subtype;
//创建图上label在下的view
+(UIView*)creatBtnViewWithImg:(NSString*)imgName title:(NSString*)title Num:(NSInteger)num;
/**
 *获取手机型号
 */
+ (NSString *)iphoneType;

+(BOOL)is_iPhone5s;//!< 如果是5s手机,返回yes
+(BOOL)is_iPhone7P;//!< 如果是5s手机,返回yes
+(BOOL)is_iPad;

+(void)shakeAction:(UIView*)control type:(WXAnimationClickType)type;

/**
 *一句话加阴影
 */
+(void)addShadowForSubview:(UIView*)subView superView:(UIView*)superView type:(WXShadowFrame)type;

/**
 ** 高斯模糊
 */
+ (UIImage *)blureImage:(UIImage *)originImage withInputRadius:(CGFloat)inputRadius;

/**
 ** 为label设置变色文字
 */
+(void)LabelAttributedString:(UILabel*)label firstW:(NSString *)oneW toSecondW:(NSString *)twoW color:(UIColor *)color size:(CGFloat)size;

/**
 ** 字符串判空
 */
+(BOOL)isBlankString:(NSString *)aStr;
@end
