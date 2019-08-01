//
//  ViewController.m
//  Hand-paintedGift
//
//  Created by Bepa on 17/2/7.
//  Copyright © 2017年 Bepa. All rights reserved.
//

#import "ViewController.h"
#import "BushGiftTypeView.h"
#import "ShowHandPaintedGiftView.h"
#import "Masonry.h"

// 屏幕尺寸相关
#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define SCREEN_LayoutScaleBaseOnIPHEN6(x) (([UIScreen mainScreen].bounds.size.width)/375.00*  x)

typedef NS_ENUM(NSUInteger , GiftType) {
    kTypeForGiftLollipop = 0, // 棒棒糖：0
    kTypeForGiftGem = 1,      // 钻石：1
    kTypeForGiftHeart = 2,    // 爱心：2
    kTypeForGiftKiss = 3,     // 飞吻：3
};

@interface ViewController ()<UIGestureRecognizerDelegate,BushGiftTypeViewDelegate> {
    CGPoint lastPoint;
}
@property (nonatomic, strong) NSArray* giftTypeAry;
@property (nonatomic, strong) UIView* Hand_paintedGiftView;
@property (nonatomic, strong) UIImage* GiftImg;

@property (nonatomic, assign) GiftType type;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = kTypeForGiftLollipop;
    _GiftImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lollipop@2x" ofType:@"png"]];
    UIImageView* bgImgView = UIImageView.new;
    bgImgView.image = [UIImage imageNamed:@"IMG_1135"];
    [self.view addSubview:bgImgView];
    
    [bgImgView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];

    // 手绘礼物按钮
    UIButton* handPaintedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [handPaintedBtn addTarget:self action:@selector(giveHandPaintedBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    handPaintedBtn.backgroundColor = [UIColor clearColor];
    [handPaintedBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HandpaintedGift@2x" ofType:@"png"]] forState:UIControlStateNormal];
    [self.view addSubview:handPaintedBtn];

    [handPaintedBtn mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(self.view).offset(-SCREEN_LayoutScaleBaseOnIPHEN6(10));
        make.width.height.equalTo(@(SCREEN_LayoutScaleBaseOnIPHEN6(35)));
        make.right.equalTo(self.view).offset(-SCREEN_LayoutScaleBaseOnIPHEN6(125));
    }];

}

- (void)giveHandPaintedBtnPressed {
    
//    NSArray* giftTypeArray = [NSArray arrayWithObjects:@"lollipop",@"heart",@"kiss",@"", nil];
    NSArray* giftTypeArray = [NSArray arrayWithObjects:@"lollipop@2x",@"heart@2x",@"kiss@2x",@"", nil];
    NSArray* giftNameArray = [NSArray arrayWithObjects:@"棒棒糖",@"爱心",@"飞吻",@"", nil];
    NSArray* titleArray = [NSArray arrayWithObjects:@"精品",@"个性",@"豪华",@"",@"充值", nil];
    BushGiftTypeView* bushGiftTypeView = [[BushGiftTypeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) giftTypeAry:giftTypeArray giftNameAry:giftNameArray titleAry:titleArray];
    
    bushGiftTypeView.delegate = self;
    [self.view addSubview:bushGiftTypeView];
    
}

- (void)sendHandPaintedGitWithGiftInfoString:(NSString* )GiftInfoString {
    NSLog(@"GiftInfoString%@",GiftInfoString);
    
    ShowHandPaintedGiftView* NewView = [[ShowHandPaintedGiftView alloc] initWithGiftInfoStr:GiftInfoString];
    [self.view addSubview:NewView];
    
    // 调用用户信息
//    [self sendBubbleMassage:GiftInfoString hasImage:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*  NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NewView removeFromSuperview];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

