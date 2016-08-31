//
//  GoodsToolBar.m
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "GoodsToolBar.h"
#import "Masonry.h"

@implementation GoodsToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = MFont(15);
        [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(15);
            make.top.mas_equalTo(self.mas_top).with.offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
            make.width.mas_equalTo(@40);
        }];
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_chooseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _chooseBtn.titleLabel.font = MFont(15);
        [_chooseBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(-15);
            make.top.mas_equalTo(self.mas_top).with.offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
            make.width.mas_equalTo(@40);
        }];
    }
    return self;
}

- (void)cancelClick:(UIButton *)sender{
    [self.delegate goodsToolBarCancel:self];
}
- (void)chooseClick:(UIButton *)sender{
    [self.delegate goodsToolBarChoose:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
