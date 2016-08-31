//
//  GuessLikeView.h
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessLikeGoodsModel.h"

@interface GuessLikeView : UIView
@property (nonatomic, strong) GuessLikeGoodsModel *likeGoodsModel;
@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UILabel *goodsPrice;
@end
