//
//  FlowLayout.m
//  CustomWaterFlow
//
//  Created by DYS on 15/12/12.
//  Copyright © 2015年 DYS. All rights reserved.
//

#import "WGWaterFlowLayout.h"
@interface WGWaterFlowLayout ()
{
    CGFloat width;
}
@property (nonatomic, strong) NSMutableArray *attrsArray;
@property (nonatomic, strong) NSMutableDictionary *maxYDict;
@end

@implementation WGWaterFlowLayout


- (instancetype)init{
    if (self = [super init]) {
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        
        self.colCount = 3;
    }
    return self;
}

- (NSMutableDictionary *)maxYDict{
    if (_maxYDict == nil) {
        _maxYDict = [[NSMutableDictionary alloc] init];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout
{
    [super prepareLayout];

    //清空最大的y值
    for (NSInteger i = 0; i < self.colCount; i ++) {
        NSString *column = [NSString stringWithFormat:@"%ld",i];
        self.maxYDict[column] = @(0.0);
    }
    
    //这句必须加
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }

    
}

- (CGSize)collectionViewContentSize{

    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];

    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 假设最短的那一列的第0列
    __block NSString *minColumn = @"0";
    //1. 找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    //2. 计算尺寸
    width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.colCount - 1) * self.minimumInteritemSpacing)/self.colCount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    //3. 计算位置
    CGFloat x = self.sectionInset.left + (width + self.minimumInteritemSpacing) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.minimumLineSpacing;
    
    //4. 更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    //5. 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return  self.attrsArray;
}



@end
