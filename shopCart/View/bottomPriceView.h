//
//  bottomPriceView.h
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class bottomPriceView;
@protocol bottomPriceViewDelegate <NSObject>

- (void)bottomPriceView:(bottomPriceView *)bottonView;

@end

@interface bottomPriceView : UIView
/**全选btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**结算btn*/
@property (nonatomic, strong) UIButton *payBtn;
/**合计label*/
@property (nonatomic, strong) UILabel *allPriceLabel;
/**结算字符串*/
@property (nonatomic, copy) NSString *payStr;
/**合计字符串*/
@property (nonatomic, strong) NSString *attAllStr;
@property (nonatomic, strong) NSString *changeStr;
@property (nonatomic, assign) BOOL isSelectBtn;

@property (weak, nonatomic) id<bottomPriceViewDelegate> delegate;

@end
