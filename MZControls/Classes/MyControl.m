//  MyControl.h
//  LoL
//
//  Created by LoL on 15/4/12.
//  Copyright (c) 2015年 _LoL_. All rights reserved.

#import "MyControl.h"
#import <sys/utsname.h>
#import <CoreText/CTFramesetter.h>



//苹方字体简体细
#define kPingFangJianXi [[UIDevice currentDevice].systemVersion floatValue] >= 9.0?@"PingFangSC-Regular":@".PingFang-SC-Regular"

//苹方字体简体粗
#define kPingFangJianCu [[UIDevice currentDevice].systemVersion floatValue] >= 9.0?@"PingFangSC-Medium":@".PingFang-SC-Medium"


@implementation MyControl

#pragma mark 创建View
+(UIView*)createViewWithFrame:(CGRect)frame Color:(UIColor *)color
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=color;
    return view;
    
}
#pragma mark 创建label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(float)font Text:(NSString*)text Color:(UIColor *)color
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //设置字体
    label.font=[UIFont systemFontOfSize:font];
    //设置折行方式 NSLineBreakByWordWrapping是按照单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //折行限制 0时候是不限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    //设置背景颜色
    label.backgroundColor=[UIColor clearColor];
    //设置文字
    label.text=text;
    //自适应
    //label.adjustsFontSizeToFitWidth=YES;
    label.textColor=color;
    return label;
}
#pragma mark 创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title Color:(UIColor *)color Font:(float )font TittleColor:(UIColor *)titleColor img:(NSString*)imgName BGImg:(NSString*)bgimgName
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.backgroundColor=color;
    button.titleLabel.font=[UIFont systemFontOfSize:font];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.frame=frame;
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:bgimgName] forState:UIControlStateNormal];
    
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    //用户交互
    imageView.userInteractionEnabled=YES;
    return imageView;
}

#pragma mark 创建textView
+(UITextView *)creatTextViewFrame:(CGRect)frame Font:(float)font textColor:(UIColor *)color text:(NSString *)text;
{
    UITextView *textView=[[UITextView alloc]initWithFrame:frame];
    textView.text=text;
    textView.font=[UIFont systemFontOfSize:font];
    textView.textColor=color;
    return textView;
}

#pragma mark 创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(float)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    textField.font=[UIFont systemFontOfSize:font];
    textField.textColor=color;
    //左边的图片
    UIImage*image=[UIImage imageNamed:leftImageName];
    UIImageView*letfImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    textField.leftView=letfImageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右边的图片
    UIImage*rightImage=[UIImage imageNamed:rightImageName];
    UIImageView*rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rightImage.size.width, rightImage.size.height)];
    textField.rightView=rightImageView;
    textField.rightViewMode=UITextFieldViewModeAlways;
    //清除按钮
    textField.clearButtonMode=YES;
    
    //当再次编辑时候清除
    //textField.clearsOnBeginEditing=YES;
    
    
//    //密码遮掩
//    textField.secureTextEntry
//    //提示框
//    textField.placeholder
    return textField;

}
//适配器 为了适配以前的版本，和现有已经开发的所有功能模块，在原有功能模块基础上进行扩展的方式
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(float)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName placeHolder:(NSString*)placeHolder sucureTextEntry:(BOOL)isOpen
{
   UITextField*textField= [MyControl createTextFieldFrame:frame Font:font textColor:color leftImageName:leftImageName rightImageName:rightImageName bgImageName:bgImageName];
    //适配器扩展出来的方法
    textField.placeholder=placeHolder;
    textField.secureTextEntry=isOpen;
    return textField;
}


//NSUserDefaults
+(void)setObject:(id)object key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(id)getObjectForKey:(NSString *)key
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        return NULL;
    }
}


+(void)removeObjectForKey:(NSString *)key{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}


//转utf-8
+(NSString *)setEncoding:(NSString *)str{
    
    NSString *encodedValue = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedValue;
}

//弹出提示框
+(void)setAlertInfo:(NSString *)info
       andSuperview:(UIView *)view{
    [SGInfoAlert showInfo:info
                  bgColor:[[UIColor blackColor] CGColor]
                   inView:view
                 vertical:0.22 time:2.0 alpha:0];
}

+(void)setZhexianAlertInfo:(NSString *)info
       andSuperview:(UIView *)view{
    [SGInfoAlert showInfo:info
                  bgColor:[[UIColor blackColor] CGColor]
                   inView:view
                 vertical:0.22 time:3.5 alpha:0.5];
}

//null转化
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}
+(NSString *)stringToString:(NSString *)string
{
    return string;
}
+(NSString *)nullToString
{
    return @"";
}

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+(void)vc:(id)vc tel:(NSString*)tel
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"确定要拨打%@?",tel] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",tel]]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

/**
 *  根据文字返回高度
 */
+(CGFloat )heightForString:(NSString *)str CGSizeMake:(CGFloat )width font:(CGFloat)font;
{
    if (str.length!=0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        NSRange allRange = [str rangeOfString: str];
        
        [attrStr addAttribute:NSFontAttributeName
         
                        value:[UIFont systemFontOfSize:font]
         
                        range:allRange];
        
        CGFloat titleHeight;
        
        NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        
        CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                       
                                            options:options
                       
                                            context:nil];
        
        titleHeight = ceilf(rect.size.height);
        
        return titleHeight;
        
    }else{
        return 0;
    }
    
}

/**
 *  根据文字返回size
 */
+ (CGSize)sizeForNoticeTitle:(NSString*)text font:(CGFloat )font{
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:font], NSParagraphStyleAttributeName : style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    else{
        textSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 32) options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    }
    return textSize;
}

//手机号验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//密码验证
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//弹窗
+(void)setAlertViewVC :(id)vc message:(NSString *)message url:(NSString *)url
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

//url 转img
+(UIImage *)getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

//字符串处理
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet {
  NSString *returnVal = @"";
     if (val) {
      returnVal = [val stringByTrimmingCharactersInSet:characterSet];
     }
  return returnVal;
 }
 + (NSString *)trimWhitespace:(NSString *)val {
     return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]]; //去掉前后空格
 }
 + (NSString *)trimNewline:(NSString *)val {
     return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]]; //去掉前后回车符
 }
 + (NSString *)trimWhitespaceAndNewline:(NSString *)val {
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉前后空格和回车符
 }

/**
 *  虚线框view
 *
 *  @param bgColor         <#返回的view的背景色#>
 *  @param frame           <#创建的view的frame,必填#>
 *  @param cornerRadius    <#圆角设置#>
 *  @param lineDashPattern <#虚线间隔,数字数组#>
 *  @param color           <#线的颜色#>
 *
 *  @return 返回一个带虚线框的view
 */
+(UIView*)drawLineWithViewBgColor:(UIColor*)bgColor Frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius lineDashPatternArray:(NSArray<NSNumber *> *)lineDashPattern strokeColor:(UIColor*)color{
    UIView *view = [[UIView alloc] init];
    
    //此处要判断是否有frame，没有直接返回，因为后面的参数很多没有自定义
    view.frame=frame;
    
    if (bgColor) {
        view.backgroundColor=bgColor;
    }else{
        view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    if (cornerRadius) {
        view.layer.cornerRadius=cornerRadius;
    }else{
        view.layer.cornerRadius =5;
    }
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0,frame.size.width, frame.size.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:view.layer.cornerRadius].CGPath;
    
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    //虚线边框
    if (lineDashPattern.count==2) {
        borderLayer.lineDashPattern = lineDashPattern;
    }else{
        borderLayer.lineDashPattern =@[@4,@2];
    }
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    if (color) {
        borderLayer.strokeColor = color.CGColor;
    }else{
        borderLayer.strokeColor = [UIColor grayColor].CGColor;
    }
    
    [view.layer addSublayer:borderLayer];
    
    return view;
}
/**
 ** 为手机号加星号
 */
+(NSString*)phoneHidden:(NSString *)phoneNum{
    
    NSString *phone = phoneNum;
    NSString *prefix = [phone substringToIndex:3];
    NSString *suffix = [phone substringFromIndex:7];
    phone = [NSString stringWithFormat:@"%@****%@",prefix,suffix];
    return phone;
}
/**
 ** 缩放动画
 */
+(void)animationPopupWith:(UIView*)aview duration:(CGFloat)duration{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration ? duration : 0.5f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aview.layer addAnimation:animation forKey:nil];
}
/**
 ** 为label加下划线
 */
+(UILabel*)underLineLabel:(UILabel*)label{
    if (label.text.length==0||label.text==NULL||label.text==nil||[label.text isEqualToString:@""]) return label;
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:label.text attributes:attribtDic];
    //赋值
    label.attributedText = attribtStr;
    return label;
}
/**
 ** 为label添加删除线
 */
+(UILabel*)deleteLineLabel:(UILabel*)label{
    
    if (label.text.length==0||label.text==NULL||label.text==nil||[label.text isEqualToString:@""]) return label;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:label.text
                                                                                  attributes:attribtDic];
    // 赋值
    label.attributedText = attribtStr;
    return label;
}

/** 返回圆角设置*/
+(CAShapeLayer*)maskLayerView:(UIView *)view maskPAth:(UIBezierPath*)maskPath{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}

//设置动画
+(void)animationForView:(UIView*)view Type:(AnimationType)type WithSubtype:(AnimationSubType)subtype{
   
    switch (type) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtype ForView:view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtype ForView:view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtype ForView:view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtype ForView:view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtype ForView:view];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtype ForView:view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtype ForView:view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtype ForView:view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtype ForView:view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtype ForView:view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtype ForView:view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtype ForView:view];
            break;
            
        case CurlDown:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
        default:
            break;
    }
    
    //翻页前后改变背景图
    static int i = 0;//静态变量,使得此属性不能在外部被改变
    if (i == 0) {
        //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
        i = 1;
    }
    else
    {
        //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
        i = 0;
    }
}
#pragma CATransition动画实现
+ (void) transitionWithType:(NSString *) type WithSubtype:(AnimationSubType) subtype ForView : (UIView *) view
{
    
    NSArray*arr=@[kCATransitionFromLeft,kCATransitionFromBottom,kCATransitionFromRight,kCATransitionFromTop];

    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7f;
    
    //设置运动type
    animation.type = type;
    if (subtype<arr.count) {
        //设置子类
        animation.subtype =arr[subtype];
    }
    if (subtype==kWXTransitionFromArc4rand) {
        NSInteger i=arc4random()%4;
        animation.subtype =arr[i];
    }
    //设置运动速度
    animation.timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}
#pragma UIView实现动画
+(void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.7f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

+(UIView*)creatBtnViewWithImg:(NSString*)imgName title:(NSString*)title Num:(NSInteger)num{
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_width/num, GTFixHeightFlaot(70) )];
    view.userInteractionEnabled=YES;
    UIImageView * img=[[UIImageView alloc]initWithFrame:CGRectMake((kMainScreen_width/num- GTFixWidthFlaot(30))/2,GTFixHeightFlaot(10), GTFixWidthFlaot(30), GTFixHeightFlaot(30))];
    img.image=[UIImage imageNamed:imgName];
    [view addSubview:img];
    
    UILabel * titleLabel=[UILabel new];
    titleLabel.text  = title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.frame=CGRectMake(0, GTFixHeightFlaot(40), kMainScreen_width/num, GTFixHeightFlaot(25));
    if (@available(iOS 6.0, *)) {
        titleLabel.textAlignment=NSTextAlignmentCenter;
    } else {
        // Fallback on earlier versions
    }
    [view addSubview:titleLabel];
    return view;
}
+ (NSString *)iphoneType {
    
    //    需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}
//判断是不是5s手机
+(BOOL)is_iPhone5s{

    if ([[MyControl iphoneType] isEqualToString:@"iPhone 5"]||[[MyControl iphoneType] isEqualToString:@"iPhone 5c"]||[[MyControl iphoneType] isEqualToString:@"iPhone 5s"])
    {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)is_iPhone7P{
    if ([[MyControl iphoneType] isEqualToString:@"iPhone 7 Plus"])
    {
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)is_iPad{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform hasPrefix:@"iPad"])
    {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 控件点击动画效果
+(void)shakeAction:(UIView*)control type:(WXAnimationClickType)type{
    
    if (type==WXSimpleType) {
        
            [UIView animateWithDuration:0.1 animations:^{
                control.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    control.transform = CGAffineTransformMakeScale(1.0, 1.0);
                } completion:^(BOOL finished) {
                    //这里实现点击cell后要实现的内容
                }];
            }];
    }else{
        
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [control.layer addAnimation:animation forKey:nil];
    }
}
/**
 *一句话加阴影
 */
+(void)addShadowForSubview:(UIView*)subView superView:(UIView*)superView type:(WXShadowFrame)type{
    
    UIView * shadowView = [[UIView alloc]initWithFrame:subView.frame];
    shadowView.userInteractionEnabled=YES;
    [superView addSubview:shadowView];
    shadowView.layer.shadowColor = subView.backgroundColor.CGColor;
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowRadius = 10.0;
    shadowView.layer.cornerRadius = 10.0;
    if (type==WXShadowRect) {
        shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        shadowView.layer.shadowOpacity = 0.5;
    } else if(type==WXShadowRightBottom){
        shadowView.layer.shadowOffset = CGSizeMake(5, 5);
        shadowView.layer.shadowOpacity = 0.7;
    }else if(type==WXShadowBottom){
        shadowView.layer.shadowOffset = CGSizeMake(8, 8);
        shadowView.layer.shadowOpacity = 1;
    }else{
        shadowView.layer.shadowOffset = CGSizeMake(3, -5);
        shadowView.layer.shadowOpacity = 0.5;
    }
    [shadowView addSubview:subView];
}
//高斯模糊
+(UIImage *)blureImage:(UIImage *)originImage withInputRadius:(CGFloat)inputRadius
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:originImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@(inputRadius) forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
//为label设置变色文字
+(void)LabelAttributedString:(UILabel*)label firstW:(NSString *)oneW toSecondW:(NSString *)twoW color:(UIColor *)color size:(CGFloat)size{
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:oneW].location;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:twoW].location+1;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    //    // 遍历获取字体名称
    //    for(NSString *fontFamilyName in [UIFont familyNames])
    //    {
    //        NSLog(@"family:'%@'",fontFamilyName);
    //        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName])
    //        {
    //            NSLog(@"\tfont:'%@'",fontName);
    //        }
    //        NSLog(@"-------------");
    //    }
    // 改变字体大小及类型//.PingFang-SC-Light
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangTC-Regular" size:size] range:range];//Helvetica-BoldOblique
    // 为label添加Attributed
    [label setAttributedText:noteStr];
}


/*  判断用户输入的密码是否符合规范，符合规范的密码要求：
 *  1. 长度大于8位
 *  2. 密码中必须同时包含数字和字母
*/
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

+(CGFloat)textNodeHeightWithAttString:(NSAttributedString*)attString width:(CGFloat)width{
    
    if (!width) {
        width = [UIScreen mainScreen].bounds.size.width;
    }
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge  CFAttributedStringRef)attString);
    CGSize targetSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attString length]), NULL, targetSize, NULL);
    CFRelease(framesetter);
    
    return fitSize.height;
}

+ (UIView*)gradientLayerForView:(UIView*)view WithSize:(CGRect)frame direction:(WXGradientLayer)direction starColor:(NSString*)startColor endColor:(NSString*)endColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;  // 设置显示的frame
    if (direction == WXGradientLayer_leftToRight || direction == WXGradientLayer_topToEnd) {
        gradientLayer.colors = @[(id)[MyControl colorWithHexString:startColor].CGColor,(id)[MyControl colorWithHexString:endColor].CGColor];
    } else {
        gradientLayer.colors = @[(id)[MyControl colorWithHexString:endColor].CGColor,(id)[MyControl colorWithHexString:startColor].CGColor];
    }
    if (direction == WXGradientLayer_leftToRight || direction == WXGradientLayer_rightToLeft) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
    } else {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }
    [view.layer addSublayer:gradientLayer];
    return view;
}

//为label 指定字符串设置变色文字
+(NSMutableAttributedString *)LabelAttributedString:(NSString*)text string:(NSString*)string color:(UIColor *)color size:(CGFloat)size{
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 需要改变的第一个文字的位置

    // 需要改变的区间
    NSRange range = [text rangeOfString:string];
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    NSRange range2 = [text rangeOfString:text];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangJianXi size:size] range:range2];//Helvetica-BoldOblique
    // 为label添加Attributed
    return noteStr;
}

//为label 指定字符串设置变色文字
+(NSMutableAttributedString *)attributedString:(NSString*)text string1:(NSString*)string1 string2:(NSString*)string2 color1:(NSString *)color1 color2:(NSString *)color2 size1:(CGFloat)size1 size2:(CGFloat)size2 {
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 需要改变的第一个文字的位置
    
    // 需要改变的区间
    NSRange range1 = [text rangeOfString:string1];
    NSRange range2 = [text rangeOfString:string2];
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:[MyControl colorWithHexString:color1] range:range1];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangJianXi size:size1] range:range1];//Helvetica-BoldOblique
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:[MyControl colorWithHexString:color2] range:range2];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangJianXi size:size2] range:range2];//Helvetica-BoldOblique
    // 为label添加Attributed
    return noteStr;
}

+ (BOOL)checkEnterNumText:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([string length] == 0) {
        return NO;
    }
    
    NSString *regex = @"^[0-9.]{1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    return isMatch;
}

//为label 指定字符串设置变色文字
+(NSMutableAttributedString *)attributedString:(NSString*)text string1:(NSString*)string1 string2:(NSString*)string2 color:(UIColor *)color color1:(UIColor *)color1 size1:(CGFloat)size1 size2:(CGFloat)size2 {
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 需要改变的第一个文字的位置
    
    // 需要改变的区间
    NSRange range1 = [text rangeOfString:string1];
    NSRange range2 = [text rangeOfString:string2];
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range1];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangJianXi size:size1] range:range1];//Helvetica-BoldOblique
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:color1 range:range2];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangJianXi size:size2] range:range2];//Helvetica-BoldOblique
    // 为label添加Attributed
    return noteStr;
}

/**
 ** 为label 部分内容加下划线
 */
+(UILabel*)underLineLabel:(UILabel*)label text:(NSString*)text{
    if (label.text.length==0||label.text==NULL||label.text==nil||[label.text isEqualToString:@""]) return label;
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //用label的文字生成一个富文本字符串
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的文字的区间
    NSRange range = [label.text rangeOfString:text];
    //为range范围内的文字添加富文本属性
    [attribtStr addAttributes:attribtDic range:range];
    //赋值
    label.attributedText = attribtStr;
    return label;
}

/**
 字符串最全判空

 @param aStr 传入需要判断的字符串
 @return 如果为空则返回YES 不为空返回NO
 */
+(BOOL)isBlankString:(NSString *)aStr {
    
    if (![aStr isKindOfClass:[NSString class]]) {
        aStr = [NSString stringWithFormat:@"%@",aStr];
    }
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/**
 字符串最全判空
 
 @param aStr 传入需要判断的字符串
 @return 如果为空则返回@"" 不为空返回原字符串
 */
+(NSString*)isNilString:(NSString *)aStr {
    
    if (![aStr isKindOfClass:[NSString class]]) {
        aStr = [NSString stringWithFormat:@"%@",aStr];
    }
    if (!aStr) {
        return @"";
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (!aStr.length) {
        return @"";
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return @"";
    }
    return aStr;
}

/**
 ** view左右上角或左右下角_圆角设置
 */
+(UIView*)maskCornerWithView:(UIView *)view StyleType:(WXRectCorner)styleType cornerRadii:(CGFloat)cornerRadii{
    
    UIBezierPath *maskPath =[UIBezierPath bezierPath];
    
    if (styleType==WXRectCornerTopLeftRight) {
        maskPath= [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else{
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }
    return view;
}
/**
 ** view左右上角或左右下角_圆角设置
 */
+(UIView*)maskCornerWithView:(UIView *)view StyleType:(WXRectCorner)styleType{
    
    return [MyControl maskCornerWithView:view StyleType:styleType cornerRadii:2];
}

/**单个圆角设置*/
+(UIView*)maskOneCornerWithView:(UIView *)view StyleType:(UIRectCorner)styleType cornerRadii:(CGFloat)cornerRadii
{
    UIBezierPath *maskPath =[UIBezierPath bezierPath];
    if (styleType==UIRectCornerTopLeft) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else if (styleType==UIRectCornerTopRight){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadii , cornerRadii)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else if (styleType==UIRectCornerBottomLeft){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else{
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners: UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }
    return view;
}

/**单个圆角设置*/
+(UIView*)maskOneCornerWithView:(UIView *)view StyleType:(UIRectCorner)styleType
{
    return [MyControl maskOneCornerWithView:view StyleType:styleType cornerRadii:2];
}


/**
 判断是否安装app
 
 @param indentf   例如 微信：weixin  tencent sinaweibo
 @param urlScheme 三方提供的appid
 @return          YES 已安装 NO 未安装
 */
+ (BOOL)checkHasAppIndentf:(NSString *)indentf urlScheme:(NSString *)urlScheme
{
    BOOL hasApp = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", indentf, urlScheme]]];
    
    return hasApp;
}


+ (NSString *)returnJson:(id)params
{
    if (params) {
        return @"";
    }
    NSString *jsonString = @"";
    NSError *jsonError = nil;
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:params
                                                      options:NSJSONWritingPrettyPrinted error:&jsonError];
    if (jsonData && !jsonError) {
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    return jsonString;
}


/**
 校验图片URL是否能正确拿到图片对象

 @param imgUrl 将要校验的图片的URL
 @return 返回图片的有效性 YES:图片URL有效能获得图片 NO:图片URL无效,不能拿到图片
 */
+ (BOOL)checkImageUrl:(NSString*)imgUrl {
    
    NSMutableString *imageURL = [NSMutableString stringWithFormat:@"%@", imgUrl];
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)[NSURL URLWithString:imageURL], NULL);
    NSDictionary* imageHeader = (__bridge NSDictionary*) CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    
    if ([imageHeader objectForKey:@"PixelHeight"]) {
        NSLog(@" 校验图片URL  - Image header %@",imageHeader);
        NSLog(@" 校验图片URL  - PixelHeight %@",[imageHeader objectForKey:@"PixelHeight"]);
        NSLog(@" 校验图片URL  - 此图片的URL 有效 %@",imgUrl);
        return YES;//有效图片
    }else {
        return NO;//有效图片
        NSLog(@" 校验图片URL - 此图片的URL 有很大的问题 %@",imgUrl);
    }
    return NO;//无效图片
}


/**
 调整图片的方向
 
 @param image 需要调整方向的图片
 @param dorie orientation 目前陀螺仪检测到的硬件设备的方向
 @param position 摄像头位置:前置摄像头或后置摄像头
 @return 返回一个调整好正常方向的图片
 */
+ (UIImage*)fixImageOrie:(UIImage*)image dorie:(UIDeviceOrientation)dorie position:(AVCaptureDevicePosition)position {
    
    UIImageOrientation orientation = UIImageOrientationUp;
    
    BOOL mirror = position == AVCaptureDevicePositionFront;
    if (position == AVCaptureDevicePositionFront) {
        NSLog(@"前置摄影头");
        
    }else {
        NSLog(@"后置摄影头");
    }
    switch (dorie) {
        case UIDeviceOrientationLandscapeRight:
            orientation = mirror ? UIImageOrientationUpMirrored : UIImageOrientationDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientation = mirror ? UIImageOrientationDownMirrored : UIImageOrientationUp;
            break;
        case UIDeviceOrientationPortrait:
            orientation = mirror ? UIImageOrientationLeftMirrored : UIImageOrientationRight;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = mirror ? UIImageOrientationRightMirrored : UIImageOrientationLeft;
            break;
        default:
            break;
    }
    return [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:orientation];
}

// 获取当前控制器
+ (UIViewController*)currentViewController
{
    UIViewController *currentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (1) {
        if ([currentVC isKindOfClass:[UITabBarController class]]) {
            currentVC = ((UITabBarController *) currentVC).selectedViewController;
        }
        if ([currentVC isKindOfClass:[UINavigationController class]]) {
            currentVC = ((UINavigationController *) currentVC).visibleViewController;
        }
        if (currentVC.presentedViewController) {
            currentVC = currentVC.presentedViewController;
        } else {
            break;
        }
    }
    
    return currentVC;
}

+ (NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 0.5f);
    
    if (data.length>1024 *1024) {
        if (data.length>10240*1024) {//10M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);//压缩之后1M~
        }else if (data.length>5120*1024){//5M~10M
            data=UIImageJPEGRepresentation(myimage, 0.2);//压缩之后1M~2M
        }else if (data.length>2048*1024){//2M~5M
            data=UIImageJPEGRepresentation(myimage, 0.5);//压缩之后1M~2.5M
        }
        //1M~2M不压缩
    }
    return data;
}

+ (void)calulateImageFileSize:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 0.5f);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1000) {
        dataLength /= 1000.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}


/**
 创建二维码
 
 @param string 二维码的内容
 @param size 二维码大小
 @return 返回生成的二维码
 */
+ (UIImage *)createQRcodeWithString:(NSString*)string withSize:(CGFloat)size
{
     return [MyControl createNonInterpolatedUIImageFormCIImage:[MyControl creatQRcodeWithUrlstring:string] withSize:size];
}


/**
  创建二维码

 @param urlString 二维码的内容
 @return 返回生成的二维码 CIImage
 */
+ (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}


/**
   创建二维码

 @param image 生成的二维码图片 CIImage
 @param size 二维码图片的大小
 @return 处理后,返回 UIImage 二维码大小
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/// 判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable {
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    }
    return isEnable;
}

/// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url options:@{} completionHandler:nil];
            } else {
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        } else {
            [application openURL:url];
        }
    }
}


//截取指定 view ,渲染为图片;
+ (UIImage*)shotView:(UIView*)targetView
{
    // 将要被截图的view
    // 背景图片 总的大小
    CGSize size = targetView.frame.size;
    UIGraphicsBeginImageContext(size);
    // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    // 裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, size.width, size.height  );
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    [targetView drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    // 从上下文中,取出UIImage
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    // 添加截取好的图片到图片View里面
    UIImage * image = snapshot;
    //结束上下文(移除栈顶上下文)
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] < 6)
        return [UIColor blackColor];
    if ([cString length] > 8)
        return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    NSString *aString = @"FF";
    if (cString.length > 6) {
        range.location = 6;
        aString = [cString substringFromIndex:6];
        if (aString.length < 2) {
            aString = [NSString stringWithFormat:@"%@0", aString];
        }
    }
    
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}
@end
