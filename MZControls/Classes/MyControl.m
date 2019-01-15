//  MyControl.h
//  LoL
//
//  Created by LoL on 15/4/12.
//  Copyright (c) 2015年 _LoL_. All rights reserved.

#import "MyControl.h"
#import <sys/utsname.h>


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

+(void)vc:(id)vc
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"确定要拨打%@?",[MyControl getObjectForKey:@"hotline"]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[MyControl getObjectForKey:@"hotline"]]]];
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
        textSize = [text sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];
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
/**
 ** view左右上角或左右下角_圆角设置
 */
+(UIView*)maskCornerWithView:(UIView *)view StyleType:(WXRectCorner)styleType{

    UIBezierPath *maskPath =[UIBezierPath bezierPath];
    if (styleType==WXRectCornerTopLeftRight) {
        maskPath= [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5 , 5)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else{
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5 , 5)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }
    return view;
}
/** 返回圆角设置*/
+(CAShapeLayer*)maskLayerView:(UIView *)view maskPAth:(UIBezierPath*)maskPath{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
/**单个圆角设置*/
+(UIView*)maskOneCornerWithView:(UIView *)view StyleType:(UIRectCorner)styleType{
    
    UIBezierPath *maskPath =[UIBezierPath bezierPath];
    if (styleType==UIRectCornerTopLeft) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(5 , 5)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else if (styleType==UIRectCornerTopRight){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(5 , 5)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else if (styleType==UIRectCornerBottomLeft){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(5 , 5)];
        view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }else{
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners: UIRectCornerBottomRight cornerRadii:CGSizeMake(5 , 5)];
       view.layer.mask = [self maskLayerView:view maskPAth:maskPath];
    }
    return view;
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
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
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
/**
 ** 字符串判空
 */
+(BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if (aStr == nil || aStr == NULL) {
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
@end
