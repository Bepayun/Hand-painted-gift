//                                                                                                                                                                                             
//  ShowHandPaintedGiftView.m
//  Hand-paintedGift
//
//  Created by Bepa on 2017/2/13.
//  Copyright © 2017年 Bepa. All rights reserved.
//

#import "ShowHandPaintedGiftView.h"
#import "Masonry.h"
#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define SCREEN_LayoutScaleBaseOnIPHEN6(x) (([UIScreen mainScreen].bounds.size.width)/375.00*  x)

@implementation ShowHandPaintedGiftView

- (ShowHandPaintedGiftView* )initWithGiftInfoStr:(NSString* )GiftInfoStr {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        [self setUIWithGiftInfoStr:GiftInfoStr];
    }
    return self;
}

- (void)setUIWithGiftInfoStr:(NSString* )GiftInfoStr {
    NSArray* allPointArt = [GiftInfoStr componentsSeparatedByString:@"-"];
    NSMutableArray* allPointMutAry = [NSMutableArray arrayWithArray:allPointArt];
    
    NSString* NickNameStr = allPointMutAry[1];
    NSString* imgStr = allPointMutAry[2];
    
    [allPointMutAry removeObjectAtIndex:0];
    [allPointMutAry removeObjectAtIndex:0];
    [allPointMutAry removeObjectAtIndex:0];
    
    UIImage* img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgStr ofType:@"png"]];
    for (NSString* dicStr in allPointMutAry) {
        NSDictionary* dic = [self dictionaryWithJsonString:dicStr];
        CGPoint point = CGPointMake([[dic objectForKey:@"x"] intValue], [[dic objectForKey:@"y"] intValue]);
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.image = img;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(self).offset(point.y - 15);
            make.left.equalTo(self).offset(point.x - 15);
            make.width.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(30)));
        }];
        CABasicAnimation* momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        momAnimation.fromValue = [NSNumber numberWithFloat:-0.3];
        momAnimation.toValue = [NSNumber numberWithFloat:0.3];
        momAnimation.duration = 0.5;
        momAnimation.repeatCount = CGFLOAT_MAX;
        momAnimation.autoreverses = YES;
        [imageView.layer addAnimation:momAnimation forKey:@"animateLayer"];
    }
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@".  %@送出x%lu个        .",NickNameStr,(unsigned long)allPointMutAry.count];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(SCREEN_LayoutScaleBaseOnIPHEN6(100));
        make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(25)));
    }];
    titleLabel.layer.cornerRadius = 12.5;
    titleLabel.layer.borderWidth = 2;
    titleLabel.layer.borderColor = [UIColor colorWithRed:238/255.f green:118/255.f blue:111/225.f alpha:1.f].CGColor;
    titleLabel.layer.masksToBounds = YES;
    UIImageView* giftImgView = [[UIImageView alloc] init];
    giftImgView.image = img;
    [self addSubview:giftImgView];
    [giftImgView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerY.equalTo(titleLabel);
        make.width.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(30)));
        make.right.equalTo(titleLabel).offset(SCREEN_LayoutScaleBaseOnIPHEN6(3));
    }];
    NSLog(@"new ShowHandPaintedGiftView");
}

- (NSDictionary* )dictionaryWithJsonString:(NSString* )jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (void)dealloc {
    NSLog(@"ShowHandPaintedGiftView dealloc");
}

@end
