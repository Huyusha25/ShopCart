//
//  ShopCartGoodViewCell.h
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"
@class ShopCartGoodViewCell;

@protocol ShopCartGoodViewCellDelegate <NSObject>

- (void)shopCartGoodViewCell:(ShopCartGoodViewCell *)cell withSelectedModel:(ShopCartModel *)model;
- (void)shopCartGoodViewCellChange:(ShopCartGoodViewCell *)cell;
//- (void)shopCartGoodViewCellTextField:(ShopCartGoodViewCell *)cell;
@end

@interface ShopCartGoodViewCell : UITableViewCell
/**选择商品btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**商品图片*/
@property (nonatomic, strong) UIImageView *goodsImage;
/**商品名称 可以两行*/
@property (nonatomic, strong) UILabel *goodNameLabel;
/**颜色分类*/
@property (nonatomic, strong) UILabel *colorTypeLabel;
/**现在价格*/
@property (nonatomic, strong) UILabel *nowPriceLabel;
/**原价*/
@property (nonatomic, strong) UILabel *oldPriceLabel;
/**商品数量*/
@property (nonatomic, strong) UILabel *goodCountLabel;
/**减少商品数量*/
@property (nonatomic, strong) UIButton *cutCount;
/**增加商品*/
@property (nonatomic, strong) UIButton *addCount;
/**修改商品数量*/
@property (nonatomic, strong) UITextField *countTextField;
/**商品数量*/
@property (nonatomic, assign) NSInteger goodCount;
@property (nonatomic, assign) BOOL isSelect;
@property (weak, nonatomic) id<ShopCartGoodViewCellDelegate>delegate;


@property (nonatomic, strong) ShopCartModel *model;

@end
