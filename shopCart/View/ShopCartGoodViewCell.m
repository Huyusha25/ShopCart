//
//  ShopCartGoodViewCell.m
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "ShopCartGoodViewCell.h"
#import "UIImageView+WebCache.h"


@implementation ShopCartGoodViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //选择商品btn
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"打钩"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
        //商品图片
        _goodsImage = [[UIImageView alloc]init];
        [self.contentView addSubview:_goodsImage];
        
        //商品名称
        _goodNameLabel = [[UILabel alloc]init];
        _goodNameLabel.font = MFont(kFit(TextSize));
        _goodNameLabel.numberOfLines = 0;
        [self.contentView addSubview:_goodNameLabel];
        
        //颜色分类
        _colorTypeLabel = [[UILabel alloc]init];
        _colorTypeLabel.font = MFont(kFit(12));
        _colorTypeLabel.textColor = MColor(123, 123, 123);
        _colorTypeLabel.numberOfLines = 0;
        [self.contentView addSubview:_colorTypeLabel];
        
        //现在价格
        _nowPriceLabel = [[UILabel alloc]init];
        _nowPriceLabel.font = MFont(kFit(TextSize));
        _nowPriceLabel.textColor = MColor(235, 101, 158);
        [self.contentView addSubview:_nowPriceLabel];
        
        //之前价格
        _oldPriceLabel = [[UILabel alloc]init];
        _oldPriceLabel.font = MFont(kFit(13));
        _oldPriceLabel.textColor = MColor(123, 123, 123);
        [self.contentView addSubview:_oldPriceLabel];
        //商品数量
        _goodCountLabel = [[UILabel alloc]init];
        _goodCountLabel.font = MFont(kFit(13));
        [_goodCountLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_goodCountLabel];
        
        //减少商品数量
        _cutCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _cutCount.titleLabel.font = MFont(kFit(18));
        _cutCount.layer.borderWidth = 0.5;
        _cutCount.layer.borderColor = MColor(110, 110, 110).CGColor;
        _cutCount.layer.cornerRadius = 5;
        [_cutCount addTarget:self action:@selector(cutCountClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cutCount];
        
        //数量
        _countTextField = [[UITextField alloc]init];
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.borderStyle = UITextBorderStyleNone;
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.font = MFont(kFit(15));
        [self.contentView addSubview:_countTextField];
        
        //加号
        _addCount = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCount.titleLabel.font = MFont(kFit(18));
        _addCount.layer.borderWidth = 0.5;
        _addCount.layer.borderColor = MColor(110, 110, 110).CGColor;
        _addCount.layer.cornerRadius = 5;
        [_addCount addTarget:self action:@selector(addCountClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addCount];
        self.backgroundColor = MColor(245, 245, 245);
    }
    return self;
} 
- (void)layoutSubviews{
    [super layoutSubviews];
    _selectedBtn.x = kFit(10);
    _selectedBtn.width = kFit(30);
    _selectedBtn.height = self.contentView.height;
    _selectedBtn.centerY = CGRectGetMidY(self.contentView.frame);
    
    _goodsImage.width = kFit(90);
    _goodsImage.height = kFit(80);
    _goodsImage.x = kFit(10) + CGRectGetMaxX(_selectedBtn.frame);
    _goodsImage.y = kFit(5);
    
    CGFloat GNX = CGRectGetMaxX(_goodsImage.frame) + kFit(10);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[NSFontAttributeName] = MFont(kFit(TextSize));
    CGRect rect = [_goodNameLabel.text textRectWithSize:CGSizeMake(self.contentView.width - GNX, 40) attributes:dic];
    _goodNameLabel.x = GNX;
    _goodNameLabel.y = kFit(5);
    _goodNameLabel.size = rect.size;
    
    NSMutableDictionary *dicC = [NSMutableDictionary new];
    dicC[NSFontAttributeName] = MFont(kFit(12));
    CGRect rectC = [_colorTypeLabel.text textRectWithSize:CGSizeMake(self.contentView.width - GNX, 30) attributes:dicC];
    _colorTypeLabel.x = GNX;
    _colorTypeLabel.y = kFit(5) + CGRectGetMaxY(_goodNameLabel.frame);
    _colorTypeLabel.size = rectC.size;
    
    //现在价格
    _nowPriceLabel.x = GNX;
    _nowPriceLabel.y = kFit(5) + CGRectGetMaxY(_colorTypeLabel.frame);
    [_nowPriceLabel sizeToFit];
    //之前价格
    _oldPriceLabel.x = CGRectGetMaxX(_nowPriceLabel.frame) + kFit(5);
    _oldPriceLabel.y = _nowPriceLabel.y;
    [_oldPriceLabel sizeToFit];
    
    //线
    CALayer *layer = [CALayer layer];
    CGRect rectL = layer.frame;
    rectL.origin.x = _oldPriceLabel.x - 1;
    rectL.origin.y = CGRectGetMidY(_oldPriceLabel.frame);
    rectL.size.width = _oldPriceLabel.width + 2;
    rectL.size.height = 1;
    layer.frame = rectL;
    layer.backgroundColor = MColor(123, 123, 123).CGColor;
    [self.contentView.layer addSublayer:layer];
    
    //商品数量
    _goodCountLabel.y = CGRectGetMaxY(_goodsImage.frame) + kFit(10);
    _goodCountLabel.x = self.contentView.width - kFit(60);
    _goodCountLabel.width = 50;
    _goodCountLabel.height = 30;
    _goodCountLabel.textAlignment = NSTextAlignmentRight;
    
    //减号
    _cutCount.x = _goodsImage.x;
    _cutCount.y = CGRectGetMaxY(_goodsImage.frame) + kFit(10);
    _cutCount.width = kFit(25);
    _cutCount.height = kFit(25);
    
    CALayer *layerCut = [CALayer layer];
    CGRect rectCut = layerCut.frame;
    rectCut.origin.x = 6;
    rectCut.origin.y = _cutCount.height * 0.5;
    rectCut.size.width = _cutCount.width - 2 * rectCut.origin.x;
    rectCut.size.height = 1;
    layerCut.frame = rectCut;
    layerCut.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_cutCount.layer addSublayer:layerCut];
    //数量
    _countTextField.x = CGRectGetMaxX(_cutCount.frame);
    _countTextField.y = _cutCount.y;
    _countTextField.width = _goodsImage.width - _cutCount.width * 2;
    _countTextField.height = _cutCount.height;
    
    //加号
    _addCount.x = CGRectGetMaxX(_countTextField.frame);
    _addCount.y = _cutCount.y;
    _addCount.width = _cutCount.width;
    _addCount.height = _cutCount.height;
    
    CALayer *layerAdd1 = [CALayer layer];
    CGRect rectAdd1 = layerAdd1.frame;
    rectAdd1.origin.x = 6;
    rectAdd1.origin.y = _cutCount.height * 0.5;
    rectAdd1.size.width = _cutCount.width - 2 * rectCut.origin.x;
    rectAdd1.size.height = 1;
    layerAdd1.frame = rectAdd1;
    layerAdd1.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_addCount.layer addSublayer:layerAdd1];
    CALayer *layerAdd2 = [CALayer layer];
    CGRect rectAdd2 = layerAdd2.frame;
    rectAdd2.origin.y = 6;
    rectAdd2.origin.x = _addCount.width * 0.5;
    rectAdd2.size.width = 1;
    rectAdd2.size.height = _addCount.height - 2 * rectAdd2.origin.y;
    layerAdd2.frame = rectAdd2;
    layerAdd2.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_addCount.layer addSublayer:layerAdd2];
    
}

- (void)setModel:(ShopCartModel *)model{
    _model = model;
    
    _selectedBtn.selected = model.isSelect;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url] placeholderImage:[UIImage imageNamed:@"test"]];
    _goodNameLabel.text = model.goods_name;
    _colorTypeLabel.text = @"颜色分类:最多两行";
    _nowPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", model.goods_price];
    _oldPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", model.goods_price];
    _goodCountLabel.text = [NSString stringWithFormat:@"x%lu", model.goods_num];
    self.goodCount = model.goods_num;
}
- (void)setGoodCount:(NSInteger)goodCount{
    _goodCount = goodCount;
    _goodCountLabel.text = [NSString stringWithFormat:@"x%lu", goodCount];
    _countTextField.text = [NSString stringWithFormat:@"%lu", goodCount];
}
//选择点击事件
- (void)selectedClick:(UIButton *)sender{
    ShopCartGoodViewCell *cell = (ShopCartGoodViewCell *)sender.superview.superview;
    if ([self.delegate respondsToSelector:@selector(shopCartGoodViewCell:withSelectedModel:)]) {
        [self.delegate shopCartGoodViewCell:cell withSelectedModel:cell.model];
    }
}
//减
- (void)cutCountClick:(UIButton *)sender{
    ShopCartGoodViewCell *cell = (ShopCartGoodViewCell *)sender.superview.superview;
    ShopCartModel *model = cell.model;
    if (_goodCount != 1) {
        self.goodCount = self.goodCount - 1;
        model.goods_num = self.goodCount;
        //向服务器发送请求
        [self.delegate shopCartGoodViewCellChange:self];
    }
}
//加
- (void)addCountClick:(UIButton *)sender{
    ShopCartGoodViewCell *cell = (ShopCartGoodViewCell *)sender.superview.superview;
    ShopCartModel *model = cell.model;
    //换成最大库存
    if (_goodCount <= 99) {
        self.goodCount = self.goodCount + 1;
        model.goods_num = self.goodCount;
    }else{
        self.goodCount = 99;
        model.goods_num = self.goodCount;
    }
    //向服务器发送请求
    [self.delegate shopCartGoodViewCellChange:self];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
