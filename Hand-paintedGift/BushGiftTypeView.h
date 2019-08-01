//
//  BushGiftTypeView.h
//  Hand-paintedGift
//
//  Created by Bepa on 2017/2/7.
//  Copyright © 2017年 Bpea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BushGiftTypeView;
@protocol BushGiftTypeViewDelegate <NSObject>
- (void)sendHandPaintedGitWithGiftInfoString:(NSString* )GiftInfoString;
@end

@interface BushGiftTypeView : UIView

@property (nonatomic, weak) id<BushGiftTypeViewDelegate>delegate;

@property (nonatomic, strong) UIButton* clearBtn;
// 赠送按钮
@property (nonatomic, strong) UIButton* giveBtn;


/**
 handPaintedGiftView
 
 @param frame       viewFrame
 @param giftTypeAry 礼物样式数组
 @param giftNameAry 礼物名称数组
 @param titleAry    礼物类别数组
 
 @return 无需返回值
 */
- (id)initWithFrame:(CGRect)frame giftTypeAry:(NSArray* )giftTypeAry giftNameAry:(NSArray* )giftNameAry titleAry:(NSArray* )titleAry;


@end
