//
//  GuessLikeView.m
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "GuessLikeView.h"
#import "UIImageView+WebCache.h"

@implementation GuessLikeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat gImageW = frame.size.width;
        CGFloat gImageH = kFit(180);
        self.goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, gImageW, gImageH)];
        self.goodsImage.image = [UIImage imageNamed:@"test"];
        [self addSubview:self.goodsImage];
        
        CGFloat gTH = (frame.size.height - gImageH) / 3 * 2.0;
        self.goodsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, gImageH, gImageW - 10, gTH)];
        self.goodsTitleLabel.font = MFont(kFit(13));
        self.goodsTitleLabel.textColor = MColor(85, 85, 85);
        self.goodsTitleLabel.numberOfLines = 0;
        self.goodsTitleLabel.text = @"欧洲站2015新款春装猫头鹰打底衫韩版女装镂空长袖T恤纯棉卫衣";
        [self addSubview:self.goodsTitleLabel];
        
        self.goodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(5, gImageH + gTH, gImageW - 10, (frame.size.height - gImageH) / 3.0)];
        self.goodsPrice.font = MFont(kFit(17));
        self.goodsPrice.textColor = MColor(241, 125, 174);
        self.goodsPrice.text = @"￥59.9";
        [self addSubview:self.goodsPrice];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeGoodsClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)setLikeGoodsModel:(GuessLikeGoodsModel *)likeGoodsModel{
    _likeGoodsModel = likeGoodsModel;
    //需要一张占位图
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:likeGoodsModel.guess_you_like_address] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _goodsTitleLabel.text = likeGoodsModel.guess_you_like_title;
    _goodsPrice.text = [NSString stringWithFormat:@"￥%@", likeGoodsModel.guess_you_like_price];
}
- (void)likeGoodsClick:(UITapGestureRecognizer *)tap{
    
}

@end
