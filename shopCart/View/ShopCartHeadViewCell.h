//
//  ShopCartHeadViewCell.h
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"
@class ShopCartHeadViewCell;
@protocol ShopCartHeadViewCellDelegate <NSObject>

- (void)shopCartHeadViewCell:(ShopCartHeadViewCell *)cell withSelectedStore:(NSInteger)storeId;

@end


@interface ShopCartHeadViewCell : UITableViewCell
/**店铺全选btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**店铺小图标*/
@property (nonatomic, strong) UIImageView *shopIcon;
/**店铺名称*/
@property (nonatomic, strong) UILabel *shopNameLabel;
/**更多*/
@property (nonatomic, strong) UIImageView *moreImage;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) ShopCartModel *model;
@property (weak, nonatomic) id<ShopCartHeadViewCellDelegate> delegate;

@end
