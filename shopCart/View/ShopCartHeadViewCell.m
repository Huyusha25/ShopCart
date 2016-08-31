//
//  ShopCartHeadViewCell.m
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "ShopCartHeadViewCell.h"
@implementation ShopCartHeadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //店铺全选
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"打钩"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
        
        //店铺小图标
        _shopIcon = [[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"store"];
        
        [self.contentView addSubview:_shopIcon];
        //店铺名称
         _shopNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_shopNameLabel];
        //更多
        _moreImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_more_right"]];
        
        [self.contentView addSubview:_moreImage];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _selectedBtn.width = kFit(30);
    _selectedBtn.height = self.contentView.height;
    _selectedBtn.x = kFit(10);
    _selectedBtn.centerY = CGRectGetMidY(self.contentView.frame);
    
    _shopIcon.x = kFit(5) + CGRectGetMaxX(_selectedBtn.frame);
    _shopIcon.width = kFit(18);
    _shopIcon.height = kFit(18);
    _shopIcon.centerY = CGRectGetMidY(_selectedBtn.frame);
    
   
    _shopNameLabel.x = kFit(8) + CGRectGetMaxX(_shopIcon.frame);
    _shopNameLabel.font = MFont(kFit(TextSize));
    _shopNameLabel.centerY = CGRectGetMidY(_selectedBtn.frame);
    _shopNameLabel.textColor = MColor(10, 10, 10);
    
    _moreImage.x = kFit(5) + CGRectGetMaxX(_shopNameLabel.frame);
    _moreImage.width = kFit(9);
    _moreImage.height = kFit(12);
    _moreImage.centerY = CGRectGetMidY(_selectedBtn.frame);
   
}


//选择点击事件
- (void)selectedClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    ShopCartHeadViewCell *cell = (ShopCartHeadViewCell *)sender.superview.superview;
    if ([self.delegate respondsToSelector:@selector(shopCartHeadViewCell:withSelectedStore:)]) {
        [self.delegate shopCartHeadViewCell:cell withSelectedStore:cell.model.store_id];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(ShopCartModel *)model{
    _model = model;
    NSLog(@"%@", model.store_name);
    _shopNameLabel.text = model.store_name;
    [_shopNameLabel sizeToFit];
    _shopNameLabel.centerY = CGRectGetMidY(_selectedBtn.frame);
}
@end
