//
//  ViewController.m
//  shopCart
//
//  Created by HYS on 16/8/30.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "ViewController.h"
//#import "RequestManger.h"
#import "MJExtension.h"
#import "ShopCartHeadViewCell.h"
#import "ShopCartGoodViewCell.h"
#import "bottomPriceView.h"
#import "MBProgressHUD+MJ.h"
#import "GoodsToolBar.h"
//#import "GoodsDetailsController.h"
#import "YouLikeTableViewCell.h"

#define goodsToolBarH 44

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ShopCartGoodViewCellDelegate, ShopCartHeadViewCellDelegate, bottomPriceViewDelegate, UITextFieldDelegate, GoodsToolBarDelegate>
@property (weak, nonatomic) UITableView *tableView;
/**购物车的所有内容*/
@property (nonatomic, strong) NSMutableDictionary *shopCartDic;
@property (nonatomic, strong) NSMutableArray *shopNameArray;
/**选着的商品*/
@property (nonatomic, strong) NSMutableArray *selectedArray;
/**选中的店铺*/
@property (nonatomic, strong) NSMutableArray *selectedStoreArr;
/**购物车每件商品的模型数组*/
@property (nonatomic, strong) NSMutableArray *modelArr;
/**总价格*/
@property (nonatomic, assign) double allSum;

@property (nonatomic, strong) GoodsToolBar *goodsToolBar;

@property (weak, nonatomic) UIBarButtonItem *barBtn;

@property (nonatomic, strong) bottomPriceView *bottonView;
@property (weak, nonatomic) UITextField *countText;
@property (nonatomic, assign) NSInteger currentCount;
@property (nonatomic, strong) ShopCartModel *currentModel;
@property (nonatomic, strong) ShopCartGoodViewCell *currentCell;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray new];
    }
    return _modelArr;
}
//一个key对应该商店的所有商品
- (NSMutableDictionary *)shopCartDic{
    if (!_shopCartDic) {
        _shopCartDic = [NSMutableDictionary new];
    }
    return _shopCartDic;
}
- (NSMutableArray *)shopNameArray{
    if (!_shopNameArray) {
        _shopNameArray = [NSMutableArray new];
    }
    return _shopNameArray;
}
/**被选中的商品*/
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    return _selectedArray;
}
/**被选中的店铺*/
- (NSMutableArray *)selectedStoreArr{
    if (!_selectedStoreArr) {
        _selectedStoreArr = [NSMutableArray new];
    }
    return _selectedStoreArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getShopCartData];
}
//请求数据 得到有无选着的店铺设置物品的select
- (void)getShopCartData{
    //先清空选中的
    [self.selectedArray removeAllObjects];
    [self.selectedStoreArr removeAllObjects];
    self.bottonView.isSelectBtn = NO;
    //模拟数据
//    NSDictionary *dic = []
    //请求购物车
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"2fa32c01bbc0106e4fcd2ca29eaafe4d" forKey:@"key"];
//    [MBProgressHUD showMessage:@"加载中" toView:self.view];
//    [RequestManger POST:shopCartList params:dic success:^(id response) {
//        if ([[response objectForKey:@"code"] intValue] == 200) {
//            //请求成功 返回有数据
//            NSDictionary *dict = [response objectForKey:@"datas"];
//            NSArray *array = [dict objectForKey:@"cart_list"];
//            if (self.shopNameArray.count != 0) {
//                [self.shopNameArray removeAllObjects];
//            }
     NSString *path = [[NSBundle mainBundle] pathForResource:@"shoppingCar" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
            for (NSDictionary *dic in array) {
                ShopCartModel *model = [ShopCartModel mj_objectWithKeyValues:dic];
                if (![self.shopNameArray containsObject:@(model.store_id)]) {
                    [self.shopNameArray addObject:@(model.store_id)];
                }
            }
            //字典数组 ==> 模型数组
            _modelArr = [ShopCartModel mj_objectArrayWithKeyValuesArray:array];
            for (NSNumber *number in self.shopNameArray) {
                NSMutableArray *array = [NSMutableArray new];
                for (ShopCartModel *model in _modelArr) {
                    if (model.store_id == [number integerValue]) {
                        [array addObject:model];
                    }
                }
                [self.shopCartDic setObject:array forKey:number];
            }
            NSLog(@"%@", self.shopNameArray);
            [MBProgressHUD hideHUD];
            //结算
            self.bottonView.hidden = NO;
            self.barBtn.enabled = YES;
            self.tableView.height = SScreen_Height - kFit(50);
            [self.tableView reloadData];
//        }else{
//            [MBProgressHUD hideHUD];
//            //请求失败
//            //没有数据
//            //结算隐藏 编辑隐藏 显示空空如也
//            self.bottonView.hidden = YES;
//            self.barBtn.enabled = NO;
//            self.tableView.height = SScreen_Height;
//            [self.tableView reloadData];
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //结算隐藏 编辑隐藏 显示无网络
//        self.bottonView.hidden = YES;
//        self.barBtn.enabled = NO;
//        self.tableView.height = SScreen_Height;
//        [self.tableView reloadData];
//        //网络失败
//        [MBProgressHUD hideHUDForView:self.view];
//    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
    self.navigationItem.rightBarButtonItem = bar;
    self.barBtn = bar;
    [self mainView];
}

- (void)mainView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SScreen_Width, SScreen_Height - kFit(50)) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.bottonView = [[bottomPriceView alloc]initWithFrame:CGRectMake(0, SScreen_Height - kFit(50), SScreen_Width, kFit(50))];
    self.bottonView.delegate = self;
    self.allSum = 0;
    [self.view addSubview:self.bottonView];
    
    
    GoodsToolBar *toolbar = [[GoodsToolBar alloc] initWithFrame:CGRectMake(0, SScreen_Height, SScreen_Width, goodsToolBarH)];
    toolbar.backgroundColor = MColor(230, 230, 230);
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.goodsToolBar = toolbar;
    
    // 监听通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//编辑
- (void)editClick:(UIBarButtonItem *)sender{
    //    if ([sender.title isEqualToString:@"编辑"]) {
    //        self.bottonView.changeStr = @"删除";
    //        [sender setTitle:@"完成"];
    //    }else{
    //        [sender setTitle:@"编辑"];
    //        self.bottonView.changeStr = @"结算(0)";
    //    }
}

#pragma mark - 监听方法
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  
    [UIView animateWithDuration:duration animations:^{
        // Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y >= self.view.height) { //控制器view的高度
            self.goodsToolBar.y = self.view.height;
            //还原
        } else {
            self.goodsToolBar.y = keyboardF.origin.y - self.goodsToolBar.height;
            CGFloat setOff = self.goodsToolBar.y - CGRectGetMaxY(self.currentCell.frame) + self.tableView.contentOffset.y;
            if (setOff < 0) {
                self.tableView.y = setOff;
            }
            NSLog(@"%f, %f", self.tableView.y, CGRectGetMaxY(self.currentCell.frame));
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.shopNameArray.count != 0) {
        return (self.shopNameArray.count + 1);
    }else{
        return 2;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.shopNameArray.count != 0) {
        if (section != self.shopNameArray.count) {
            NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[section]];
            return (array.count + 1);
        }else{
            //猜你喜欢
            return 10;
        }
    }else{
        if (section == 0) {
            //空空如也\网络异常
            return 1;
        }else{
            //猜你喜欢
            return 10;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.shopNameArray.count != 0) {
        if (indexPath.section != self.shopNameArray.count) {
            NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[indexPath.section]];
            if (indexPath.row == 0) {//商店头
                static NSString *ID = @"shopCartHeadCell";
                ShopCartHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[ShopCartHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegate = self;
                }
                cell.model = array[indexPath.row];
                if ([self.selectedStoreArr containsObject:@(cell.model.store_id)]) {
                    cell.selectedBtn.selected = YES;
                }else{
                    cell.selectedBtn.selected = NO;
                }
                return cell;
            }else{//商品
                static NSString *ID = @"shopCartGoodCell";
                ShopCartGoodViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[ShopCartGoodViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegate = self;
                    cell.countTextField.delegate = self;
                }
                cell.model = array[indexPath.row - 1];
                return cell;
            }
            
        }else{//猜你喜欢
            static NSString *ID = @"GuesslikeCell";
            YouLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[YouLikeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //给GuessYouLike的model
            return cell;
        }
    }else{
        if (indexPath.section == 0) {
            //空空如也\网络异常
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noneCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noneCell"];
            }
            cell.textLabel.text = @"空空如也/网络异常";
            return cell;
        }else{//猜你喜欢
            static NSString *ID = @"GuesslikeCell";
            YouLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[YouLikeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //给GuessYouLike的model
            return cell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击进去详情
//    GoodsDetailsController *goodsC = [[GoodsDetailsController alloc]init];
//    [self.navigationController pushViewController:goodsC animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == (self.shopNameArray.count ? self.shopNameArray.count:1)) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SScreen_Width, SScreen_Height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"----猜你喜欢----";
        label.font = MFont(15);
        return label;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.shopNameArray.count == 0) {
        if (section == 0) {
            return kFit(5);
        }else{
            return kFit(38);
        }
    }else{
        if (section == self.shopNameArray.count) {
            return kFit(38);
        }else{
            return kFit(5);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFit(1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.shopNameArray.count == 0) {
        if (indexPath.section == 0) {
            return kFit(200);
        }else{
            return YouLikeCellH + YouLikeInset;
        }
    }else{
        if (indexPath.section != self.shopNameArray.count) {
            if (indexPath.row == 0) {
                return kFit(40);
            }else{
                return kFit(130);
            }
        }else{
            return YouLikeCellH + YouLikeInset;
        }
    }
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置删除按钮
    if (indexPath.row != 0) {
        
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
            //删除操作 给后台发送删除请求
            //删除 缓存数据
            //1.取出对应的商店的所有商品数组
            NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[indexPath.section]];
            //2.0删除对应商品
            ShopCartModel *model = array[indexPath.row - 1];
            [array removeObjectAtIndex:(indexPath.row - 1)];
            //2.1删除已选中商品
            if ([self.selectedArray containsObject:model]) {
                [self.selectedArray removeObject:model];
            }
            if (array.count == 0) {
                //删除已选中商店
                if ([self.selectedStoreArr containsObject:@(model.store_id)]) {
                    [self.selectedStoreArr removeObject:@(model.store_id)];
                }
                [self.shopCartDic removeObjectForKey:self.shopNameArray[indexPath.section]];
                [self.shopNameArray removeObjectAtIndex:indexPath.section];
            }else{
                BOOL isSelect = YES;
                [self.shopCartDic setObject:array forKey:self.shopNameArray[indexPath.section]];
                //看该商店的所有商品是否都在已选里面
                for (ShopCartModel *temp in array) {
                    if (![self.selectedArray containsObject:temp]) {
                        isSelect = NO;
                    }
                }
                //添加商店
                if (isSelect) {
                    if (![self.selectedStoreArr containsObject:@(model.store_id)]) {
                        [self.selectedStoreArr addObject:@(model.store_id)];
                    }
                }
            }
            [self.modelArr removeObject:model];
            //看是否全选中
//            NSEnumerator *e1 = [self.modelArr objectEnumerator];
//            NSEnumerator *e2 = [self.selectedArray objectEnumerator];
            NSSet *s1 = [[NSSet alloc]initWithArray:self.modelArr];
            NSSet *s2 = [[NSSet alloc] initWithArray:self.selectedArray];
            if ([s1 isEqual:s2]) {
                self.bottonView.selectedBtn.selected = YES;
            }
            if (self.modelArr.count == 0) {
                //结算隐藏 编辑隐藏 显示无网络
                self.bottonView.hidden = YES;
                self.barBtn.enabled = NO;
                self.tableView.height = SScreen_Height;
            }
            [tableView reloadData];
        }];
        return @[deleteRowAction];
    }else{
        return nil;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        return YES;
    }else{
        return NO;
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    
}
#pragma mark - ShopCartGoodViewCellDelegate
- (void)shopCartGoodViewCellChange:(ShopCartGoodViewCell *)cell{
    _allSum = 0;
    for (ShopCartModel *model in self.selectedArray) {
        self.allSum += model.goods_price * model.goods_num;
    }
    _bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
}
- (void)shopCartGoodViewCell:(ShopCartGoodViewCell *)cell withSelectedModel:(ShopCartModel *)model{
    if ([self.selectedArray containsObject:model]) {
        [self.selectedArray removeObject:model];
        //每当删除商品
        self.bottonView.selectedBtn.selected = NO;
        model.isSelect = NO;
        self.allSum -= model.goods_price * model.goods_num;
    }else{
        [self.selectedArray addObject:model];
        model.isSelect = YES;
        self.allSum += model.goods_price * model.goods_num;
    }
    BOOL isExist = YES;
    //被选中的商品商店
    NSArray *array = [self.shopCartDic objectForKey:@(model.store_id)];
    for (ShopCartModel *model in array) {
        if (![self.selectedArray containsObject:model]) {
            isExist = NO;
            break;
        }
    }
    NSNumber *num = @(model.store_id);
    if (isExist && (![self.selectedStoreArr containsObject:num])) {
        [self.selectedStoreArr addObject:@(model.store_id)];
    }
    if (!isExist && ([self.selectedStoreArr containsObject:num])) {
        [self.selectedStoreArr removeObject:@(model.store_id)];
    }
    if (self.selectedStoreArr.count == self.shopNameArray.count) {
        //全部店铺添加
        self.bottonView.selectedBtn.selected = YES;
    }
    self.bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    self.bottonView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
    [self.tableView reloadData];
}


#pragma mark - ShopCartHeadViewCellDelegate
- (void)shopCartHeadViewCell:(ShopCartHeadViewCell *)cell withSelectedStore:(NSInteger)storeId{
    NSMutableArray *array = [self.shopCartDic objectForKey:@(storeId)];
    if ([self.selectedStoreArr containsObject:@(storeId)]) {
        [self.selectedStoreArr removeObject:@(storeId)];
        for (ShopCartModel *model in array) {
            [self.selectedArray removeObject:model];
            //每当删除商品
            self.bottonView.selectedBtn.selected = NO;
            self.allSum -= model.goods_price * model.goods_num;
            model.isSelect = NO;
        }
    }else{
        [self.selectedStoreArr addObject:@(storeId)];
        for (ShopCartModel *model in array) {
            if (![self.selectedArray containsObject:model]) {
                [self.selectedArray addObject:model];
                model.isSelect = YES;
                self.allSum += model.goods_price * model.goods_num;
            }
        }
    }
    if (self.selectedStoreArr.count == self.shopNameArray.count) {
        //全部店铺添加
        self.bottonView.selectedBtn.selected = YES;
    }
    self.bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    self.bottonView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
    [self.tableView reloadData];
}

#pragma mark - bottomPriceViewDelegate
- (void)bottomPriceView:(bottomPriceView *)bottonView{
    if (bottonView.selectedBtn.selected) {
        [self.selectedArray removeAllObjects];
        [self.selectedArray addObjectsFromArray:self.modelArr];
        for (ShopCartModel *model in self.modelArr) {
            model.isSelect = YES;
        }
        [self.selectedStoreArr removeAllObjects];
        [self.selectedStoreArr addObjectsFromArray:self.shopNameArray];
        self.allSum = 0.0;
        //计算总价格
        for (ShopCartModel *model in self.selectedArray) {
            self.allSum += model.goods_price * model.goods_num;
        }
    }else{
        [self.selectedArray removeAllObjects];
        [self.selectedStoreArr removeAllObjects];
        for (ShopCartModel *model in self.modelArr) {
            model.isSelect = NO;
        }
        self.allSum = 0.0;
    }
    bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    bottonView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
    [self.tableView reloadData];
}

#pragma mark - GoodsToolBarDelegate
- (void)goodsToolBarChoose:(GoodsToolBar *)goodsToolBar{
    if ([self.countText.text integerValue] >= 99) {
        self.countText.text = [NSString stringWithFormat:@"%d", 99];
    }
    if ([self.countText.text integerValue] <= 0) {
        self.countText.text = [NSString stringWithFormat:@"%d", 1];
    }
    self.currentModel.goods_num = [self.countText.text integerValue];
    self.currentCell.goodCount = [self.countText.text integerValue];
    //上传数量
    
    //重写计算
    if ([self.selectedArray containsObject:self.currentModel]) {
        self.allSum = self.allSum - self.currentModel.goods_price * self.currentCount + self.currentModel.goods_price * [self.countText.text integerValue];
    }
    self.bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    
    self.currentModel = nil;
    self.currentCell = nil;
    self.currentCount = 0;
    [self.countText resignFirstResponder];
}
- (void)goodsToolBarCancel:(GoodsToolBar *)goodsToolBar{
    self.countText.text = [NSString stringWithFormat:@"%lu", self.currentCount];
    [self.countText resignFirstResponder];
    self.currentCount = 0;
    self.currentModel = nil;
    self.currentCell = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.countText = textField;
    self.currentCount = [textField.text integerValue];
    ShopCartGoodViewCell *cell = (ShopCartGoodViewCell *)textField.superview.superview;
    self.currentModel = cell.model;
    self.currentCell = cell;
    NSLog(@"%f", CGRectGetMaxY(cell.frame));
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.y = 0;
    }];
}

//移除
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end


