//
//  BushGiftTypeView.m
//  Hand-paintedGift
//
//  Created by Bepa on 2017/2/7.
//  Copyright © 2017年 Bepa. All rights reserved.
//

#define SCREEN_LayoutScaleBaseOnIPHEN6(x) (([UIScreen mainScreen].bounds.size.width)/375.00*  x)
// 屏幕尺寸相关
#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "BushGiftTypeView.h"
#import "Masonry.h"

typedef NS_ENUM(NSUInteger , GiftType) {
    kTypeForGiftLollipop = 0, //棒棒糖：0
//    kTypeForGiftGem = 1,    // 钻石：1
    kTypeForGiftHeart = 1,    // 爱心：2
    kTypeForGiftKiss = 2,     // 飞吻：3
//    kTypeForGiftBBT = 1
};

@interface BushGiftTypeView ()<UIGestureRecognizerDelegate> {
    CGPoint lastPoint;
}

@property (nonatomic, strong) UIButton* titleBtn;
@property (nonatomic, strong) UIView* navBarView;
@property (nonatomic, assign) GiftType type;
@property (nonatomic, strong) UIButton* giftImgBtn;
@property (nonatomic, strong) NSMutableArray* pointsAry;
@property (nonatomic, strong) UILabel* contentLabel;
@property (nonatomic, strong) UIImage* giftImg;
@property (nonatomic, strong) UIView* Hand_paintedGiftView;

@property (nonatomic, strong) NSArray* giftNameAry;
@property (nonatomic, strong) NSString* giftNameStr;

@property (nonatomic, strong) NSArray* giftTypeAry;
@property (nonatomic, copy) NSString* giftTypeStr;
@property (nonatomic, copy) NSString* giftTypeString;
@end

@implementation BushGiftTypeView


- (id)initWithFrame:(CGRect)frame giftTypeAry:(NSArray* )giftTypeAry giftNameAry:(NSArray* )giftNameAry titleAry:(NSArray* )titleAry {
    self = [super initWithFrame:frame];
    if (self) {

//        self.type = kTypeForGiftLollipop;
//        _giftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lollipop@2x" ofType:@"png"]];
        _giftTypeString = [giftTypeAry objectAtIndex:0];
        _giftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",_giftTypeString] ofType:@"png"]];

        _pointsAry = [NSMutableArray array];
        
        [self initNavBarView];
        _giftNameAry = giftNameAry;
        _giftTypeAry = giftTypeAry;
        _giftNameStr = giftNameAry.firstObject;
        _giftTypeStr = giftTypeAry.firstObject;
        
        UIView* Hand_paintedGiftView = [[UIView alloc] init];
        Hand_paintedGiftView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.55];
        [self addSubview:Hand_paintedGiftView];
        [Hand_paintedGiftView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(_navBarView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@(ScreenWidth));
        }];
        
        _Hand_paintedGiftView = Hand_paintedGiftView;
        
        UILabel* tipLabel = [[UILabel alloc] init];
        tipLabel.text = @"在中间区域绘制礼物";
        tipLabel.textColor = UIColor.whiteColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:15];
        [Hand_paintedGiftView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.centerX.equalTo(Hand_paintedGiftView);
            make.centerY.equalTo(Hand_paintedGiftView).offset(SCREEN_LayoutScaleBaseOnIPHEN6(20));
        }];
        
        UIView* bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.85];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(Hand_paintedGiftView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(64)));
        }];
        
        // 计数的内容显示
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.hidden = YES;
       
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        [bottomView addSubview:_contentLabel];
        _contentLabel.backgroundColor = [UIColor clearColor];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.left.equalTo(bottomView).offset(SCREEN_LayoutScaleBaseOnIPHEN6(10));
            make.top.equalTo(bottomView).offset(SCREEN_LayoutScaleBaseOnIPHEN6(15));
            make.width.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(300)));
            make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(40)));
        }];
        
        
        UIView* giftTypeView = [[UIView alloc] init];
        giftTypeView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.87];
        [self addSubview:giftTypeView];
        [giftTypeView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(bottomView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(164)));
        }];
        
        
        float giftTypeWidth = (ScreenWidth-giftTypeAry.count*2)/giftTypeAry.count;
        for (int i = 0; i < giftTypeAry.count; i ++) {
            _giftImgBtn = [[UIButton alloc] init];
            [_giftImgBtn setImage:[UIImage imageNamed:giftTypeAry[i]] forState:UIControlStateNormal];
            [_giftImgBtn setTitle:[NSString stringWithFormat:@"%@",giftNameAry[i]] forState:UIControlStateNormal];
            [_giftImgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            _giftImgBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [_giftImgBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            _giftImgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
            _giftImgBtn.titleEdgeInsets = UIEdgeInsetsMake(60,-70, 0, 0);
            _giftImgBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.87];
            _giftImgBtn.tag = 0+i;
            [_giftImgBtn addTarget:self action:@selector(clickGiftTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [giftTypeView addSubview:_giftImgBtn];
            [_giftImgBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                make.left.equalTo(giftTypeView).offset(giftTypeAry.count+giftTypeWidth*i);
                make.top.equalTo(giftTypeView.mas_top).offset(SCREEN_LayoutScaleBaseOnIPHEN6(5));
                make.width.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(110)));
                make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(120)));
            }];
        }
        
        // 赠送
        _giveBtn = [[UIButton alloc] init];
        [_giveBtn setBackgroundColor:[UIColor colorWithRed:173/255.f green:173/255.f blue:173/255.f alpha:1.f]];
        [_giveBtn setTitle:@"赠送" forState:UIControlStateNormal];
        _giveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_giveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_giveBtn setTitleColor:[UIColor colorWithRed:252/255.f green:82/255.f blue:81/255.f alpha:1.f] forState:UIControlStateSelected];
        _giveBtn.hidden = YES;
        [self addSubview:_giveBtn];
        [_giveBtn mas_makeConstraints:^(MASConstraintMaker* make) {
            make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(80)));
            make.width.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(80)));
            make.right.equalTo(giftTypeView).offset(-SCREEN_LayoutScaleBaseOnIPHEN6(15));
            make.top.equalTo(giftTypeView).offset(-SCREEN_LayoutScaleBaseOnIPHEN6(35));
        }];
        _giveBtn.layer.cornerRadius = 40;
        [_giveBtn addTarget:self action:@selector(giveGiftClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* topLineView = [[UIView alloc] init];
        topLineView.backgroundColor = [UIColor lightGrayColor];
        topLineView.alpha = .55;
        [giftTypeView addSubview:topLineView];
        [topLineView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(_giftImgBtn.mas_bottom).offset(3);
            make.left.right.equalTo(giftTypeView);
            make.height.equalTo(@(1));
        }];
        
        float titleBtnWidth = (ScreenWidth-titleAry.count*2)/titleAry.count;
        for (int i = 0; i < titleAry.count; i ++) {
            _titleBtn = [[UIButton alloc] init];
            [_titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_titleBtn setTitleColor:[UIColor colorWithRed:36/255.f green:203/255.f blue:173/255.f alpha:1.f] forState:UIControlStateSelected];
            [_titleBtn setTitle:titleAry[i] forState:UIControlStateNormal];
            _titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            _titleBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.87];
            _titleBtn.tag = 1000 + i;
            [_titleBtn addTarget:self action:@selector(clickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [giftTypeView addSubview:_titleBtn];
            [_titleBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                make.left.equalTo(giftTypeView).offset(titleAry.count+titleBtnWidth*i);
                make.bottom.equalTo(giftTypeView.mas_bottom);
                make.width.equalTo(@(titleBtnWidth));
                make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(47)));
            }];
        }
        
    }
    return self;
}
- (void)initNavBarView {
    _navBarView = [[UIView alloc] init];
    _navBarView.backgroundColor = UIColor.blackColor;
    _navBarView.alpha = .85;
    [self addSubview:_navBarView];
    [_navBarView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(64)));
    }];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"个性礼物";
    titleLabel.textColor = UIColor.whiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [_navBarView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(_navBarView);
        make.centerY.equalTo(_navBarView).offset(10);
    }];
    
    UIButton* clearnBtn = [[UIButton alloc] init];
    [clearnBtn setTitle:@"清除" forState:UIControlStateNormal];
    [clearnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearnBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_navBarView addSubview:clearnBtn];
    [clearnBtn mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.right.equalTo(_navBarView.mas_right).offset(-SCREEN_LayoutScaleBaseOnIPHEN6(25));
    }];
    [clearnBtn addTarget:self action:@selector(clearnHand_paintedGiftView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_navBarView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(_navBarView.mas_left).offset(SCREEN_LayoutScaleBaseOnIPHEN6(25));
        make.width.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(30)));
    }];
    [backBtn addTarget:self action:@selector(backClickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer* )gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer* )otherGestureRecognizer {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch* >* )touches withEvent:(UIEvent* )event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    NSLog(@"touchesBegan:x:=%f y:=%f  and Hand_paintedGiftViewFram x = %f y = %f w = %f h = %f",point.x,point.y,_Hand_paintedGiftView.frame.origin.x,_Hand_paintedGiftView.frame.origin.y,_Hand_paintedGiftView.frame.size.width,_Hand_paintedGiftView.frame.size.height);
    /*
     2017-02-07 13:24:41.104 Hand-paintedGift[8811:132035] touchesBegan:x:=216.666656 y:=195.666656  and Hand_paintedGiftViewFram x = 0.000000 y = 64.000000 w = 414.000000 h = 414.000000
     */
    
    
    _giveBtn.hidden = NO;
    _contentLabel.hidden = NO;
    if (64 < point.y  && point.y < (64 +ScreenWidth) ) {
        // new gitfpic
        
//        [_pointsAry addObject:[NSValue valueWithCGPoint:point]];
        if (_pointsAry.count <= 99) {
            UIImageView* imageView = [[UIImageView alloc] init];
            [imageView setImage:_giftImg];
            [_Hand_paintedGiftView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker* make) {
                make.top.equalTo(_Hand_paintedGiftView).offset(point.y - 64 -15);
                make.left.equalTo(_Hand_paintedGiftView).offset(point.x - 15);
                make.width.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(30)));
            }];
            
            NSString* x = [NSString stringWithFormat:@"%d",(int)point.x];
            NSString* y = [NSString stringWithFormat:@"%d",(int)point.y];
            
            NSDictionary* pointDic = [NSDictionary dictionaryWithObjectsAndKeys:x,@"x",y,@"y", nil];
            
            NSString* dicStr = [self dictionaryToJson:pointDic];
            [_pointsAry addObject:dicStr];
            
            lastPoint = point;
            
            if (_pointsAry.count < 10) {
                _contentLabel.text =[NSString stringWithFormat:@"⚠️至少要画10个%@，才能送出去",_giftNameStr];
                
            }else
            {
                _contentLabel.text = [NSString stringWithFormat:@"画了%zd个%@，共计消耗%zd￥",_pointsAry.count,_giftNameStr,_pointsAry.count*10];
                [_giveBtn setBackgroundColor:[UIColor colorWithRed:252/255.f green:82/255.f blue:81/255.f alpha:1.f]];
            }
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch* >* )touches withEvent:(UIEvent* )event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    NSLog(@"touchesMoved:x:=%f y:=%f",point.x,point.y);

    if (64 < point.y  && point.y< (64 +ScreenWidth) ) {
        if ( fabs(point.x - lastPoint.x) > 20 || fabs(point.y - lastPoint.y) >20) {
            // new gitfpic
            
//             [_pointsAry addObject:[NSValue valueWithCGPoint:point]];
            
            if (_pointsAry.count <= 99) {
                UIImageView* imageView = [[UIImageView alloc] init];
                //            UIImage* img = [UIImage imageNamed:@"10271s@2x.1"];

                [imageView setImage:_giftImg];
                [_Hand_paintedGiftView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker* make) {
                    make.top.equalTo(_Hand_paintedGiftView).offset(point.y - 64 -15);
                    make.left.equalTo(_Hand_paintedGiftView).offset(point.x - 15);
                    make.width.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(30)));
                }];

                NSString* x = [NSString stringWithFormat:@"%d",(int)point.x];
                NSString* y = [NSString stringWithFormat:@"%d",(int)point.y];
                
                NSDictionary* pointDic = [NSDictionary dictionaryWithObjectsAndKeys:x,@"x",y,@"y", nil];
                
                NSString* dicStr = [self dictionaryToJson:pointDic];
                [_pointsAry addObject:dicStr];
                
                lastPoint = point;
                if (_pointsAry.count < 10) {
                    _contentLabel.text =[NSString stringWithFormat:@"⚠️至少要画10个%@，才能送出去",_giftNameStr];

                }else
                {
                    _contentLabel.text = [NSString stringWithFormat:@"画了%zd个%@，共计消耗%zd￥",_pointsAry.count,_giftNameStr,_pointsAry.count*10];
                    [_giveBtn setBackgroundColor:[UIColor colorWithRed:252/255.f green:82/255.f blue:81/255.f alpha:1.f]];
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch* >* )touches withEvent:(UIEvent* )event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    NSLog(@"touchesEnded:x:=%f y:=%f",point.x,point.y);
}

- (void)clearnHand_paintedGiftView {
    [_pointsAry removeAllObjects];
    _giveBtn.hidden = YES;
    _contentLabel.hidden = YES;
    [_giveBtn setBackgroundColor:[UIColor colorWithRed:173/255.f green:173/255.f blue:173/255.f alpha:1.f]];
    for (UIImageView* subImgView in _Hand_paintedGiftView.subviews) {
        if ([subImgView isKindOfClass:[UIImageView class]]) {
            [subImgView removeFromSuperview];
        }
    }
}

#pragma mark - 赠送礼物
- (void)giveGiftClick {
//    NSLog(@"%@",[_pointsAry componentsJoinedByString:@","]);
//    if ([self.delegate respondsToSelector:@selector(touchWithPointDataString:)]) {
//        NSString* pointDataString = [_pointsAry componentsJoinedByString:@","];
//        [self.delegate touchWithPointDataString:pointDataString];
//    }
    if (_pointsAry.count >= 10) {
        if (self.delegate) {
            NSString* pointDataStr = [_pointsAry componentsJoinedByString:@"-"];
            NSString* infoStr = [NSString stringWithFormat:@"shlw-UserNickNameString-%@-%@",_giftTypeStr,pointDataStr];
            [self.delegate sendHandPaintedGitWithGiftInfoString:infoStr];
            
            [self removeFromSuperview];
        }
    }
}

- (void)backClickBtn {
    [self removeFromSuperview];
}

- (void)clickGiftTypeBtn:(UIButton* )sender {
    
    _giftNameStr = [_giftNameAry objectAtIndex:sender.tag];
    _giftTypeStr = [_giftTypeAry objectAtIndex:sender.tag];
    
//    switch (sender.tag) {
//        case 0:
//            // lollipopBtn
//            [self clearnHand_paintedGiftView];
//            self.type = kTypeForGiftLollipop;
//            
//            _giftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lollipop@2x" ofType:@"png"]];
//            break;
//        case 1:
//            // heartBtn
//            [self clearnHand_paintedGiftView];
//            self.type = kTypeForGiftHeart;
//            _giftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heart@2x" ofType:@"png"]];
//            break;
//        case 2:
//            // kissBtn
//            [self clearnHand_paintedGiftView];
//            self.type = kTypeForGiftKiss;
//            _giftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kiss@2x" ofType:@"png"]];
//            break;
//            
//        default:
//            break;
//    }

        for (int i = 0; i <= sender.tag ; i ++) {
            [self clearnHand_paintedGiftView];
            _giftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",_giftTypeStr] ofType:@"png"]];
        }
}

- (void)clickTypeBtn:(UIButton* )btn {
    
}
- (NSString* )dictionaryToJson:(NSDictionary* )dic {
    NSError* parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)dealloc {
    NSLog(@"zi ding yi shou hui ban  shi fang le");
}

@end
