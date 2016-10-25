//
//  ZXCarBrowseViewLayout.m
//  ZXCardBrowseView
//
//  Created by ios on 16/10/25.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ZXCarBrowseViewLayout.h"


#define Scale (0.85)

@implementation ZXCarBrowseViewLayout{
    CGFloat _viewWidth;
    CGFloat _itemWidth;
}

- (void)prepareLayout {
    [super prepareLayout];
    if (self.visibleCount < 1) {
        self.visibleCount = 5;
    }
   self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _viewWidth = CGRectGetWidth(self.collectionView.frame);
    _itemWidth = self.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, (_viewWidth - _itemWidth) / 2, 0, (_viewWidth - _itemWidth) / 2);

}

- (CGSize)collectionViewContentSize {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(cellCount * _itemWidth, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger minIndex = 0;
    NSInteger maxIndex = cellCount-1;
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    CGFloat cY = self.collectionView.contentOffset.x + _viewWidth / 2;
    CGFloat attributesY = _itemWidth * indexPath.row + _itemWidth / 2;
    CGFloat dis = ABS(attributesY - cY);
    CGFloat scale = 1;
    if (dis<self.itemSize.width) {
         scale = 1-dis*(1-Scale)/self.itemSize.width;
    } else {
        scale = Scale;
    }
    attributes.zIndex = -dis;

    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    CGFloat centerY = attributesY;

    attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame)/2+10+(CGRectGetHeight(self.collectionView.frame) - self.itemSize.height)/2 +(scale- Scale)*(CGRectGetHeight(self.collectionView.frame) - self.itemSize.height)/(Scale-1));
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat index = roundf(( proposedContentOffset.x + (_viewWidth - _itemWidth)/2) / _itemWidth);
    proposedContentOffset.x = _itemWidth * index + (_itemWidth - _viewWidth)/ 2;
    return proposedContentOffset;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

@end
