//
//  GuessLikeGoodsModel.h
//  meidianjie
//
//  Created by HYS on 16/1/15.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuessLikeGoodsModel : NSObject
/**图片地址*/
@property (nonatomic, copy) NSString *guess_you_like_address;
/**标题*/
@property (nonatomic, copy) NSString *guess_you_like_title;
/**价格*/
@property (nonatomic, copy) NSString *guess_you_like_price;
/**店铺ID*/
@property (nonatomic, copy) NSString *guess_you_like_store_ID;
/**商品ID*/
@property (nonatomic, copy) NSString *guess_you_like_goods_ID;
@end
