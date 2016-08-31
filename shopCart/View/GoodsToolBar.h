//
//  GoodsToolBar.h
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsToolBar;
@protocol GoodsToolBarDelegate <NSObject>

- (void)goodsToolBarCancel:(GoodsToolBar *)goodsToolBar;
- (void)goodsToolBarChoose:(GoodsToolBar *)goodsToolBar;

@end

@interface GoodsToolBar : UIView
/**取消*/
@property (nonatomic, strong) UIButton *cancelBtn;
/**确定*/
@property (nonatomic, strong) UIButton *chooseBtn;
@property (weak, nonatomic) id<GoodsToolBarDelegate> delegate;


@end
