//
//  YouLikeTableViewCell.m
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "YouLikeTableViewCell.h"

@implementation YouLikeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.likeViewL = [[GuessLikeView alloc]initWithFrame:CGRectMake(0, 0, YouLikeCellW, YouLikeCellH)];
        [self.contentView addSubview:self.likeViewL];
        self.likeViewR = [[GuessLikeView alloc]initWithFrame:CGRectMake(YouLikeCellW + YouLikeInset, 0, YouLikeCellW, YouLikeCellH)];
        [self.contentView addSubview:self.likeViewR];
    }
    return self;
}
- (void)setShopArray:(NSMutableArray *)shopArray{
    _shopArray = shopArray;
    //如果有一个 隐藏likeViewR
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
