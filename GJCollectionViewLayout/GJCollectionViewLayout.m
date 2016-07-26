//
//  GJCollectionViewLayout.m
//  GJCollectionViewLayout
//
//  Created by tongguan on 16/7/26.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "GJCollectionViewLayout.h"
@interface GJCollectionViewLayout()
{
    CGFloat _itemMargin;
}
@property(strong,nonatomic) NSMutableArray<UICollectionViewLayoutAttributes*>* layoutAttributes;
@end

@implementation GJCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layoutAttributes = [[NSMutableArray alloc]initWithCapacity:4];
        self.contentSize = self.collectionView.bounds.size;
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    NSInteger count = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    NSInteger exist = self.layoutAttributes.count;
    _itemMargin = (self.contentSize.width - self.collectionView.bounds.size.width)/(count-1);
    for (NSInteger i = exist; i< count; i++) {
        NSIndexPath* path = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        attr.size = self.minItemSize;
        attr.center = CGPointMake(self.collectionView.bounds.size.width*0.5+i*_itemMargin, self.contentSize.height*0.5);
        [self.layoutAttributes addObject:attr];
    }
}

-(CGSize)collectionViewContentSize{

    return self.contentSize;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    CGPoint offset = self.collectionView.contentOffset;
    CGRect viewBounds = self.collectionView.bounds;
    CGFloat maxPoint = offset.x + viewBounds.size.width*0.5;
    for (UICollectionViewLayoutAttributes* attr in self.layoutAttributes) {
        CGFloat d = attr.center.x - maxPoint;
        if (d<0) {d *= -1;}
        if (d<_itemMargin) {
            CGSize size = self.maxItemSize;
            size.width -= (self.maxItemSize.width-self.minItemSize.width)*(d/_itemMargin);
            size.height -= (self.maxItemSize.height-self.minItemSize.height)*(d/_itemMargin);
            attr.size = size;
        }else{
            attr.size = self.minItemSize;
        }
    }
    return self.layoutAttributes;
};

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(NSIndexPath *)targetIndexPathForInteractivelyMovingItem:(NSIndexPath *)previousIndexPath withPosition:(CGPoint)position{
    NSLog(@"index:%@,point:%@",previousIndexPath,[NSValue valueWithCGPoint:position]);
    return previousIndexPath;
}
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    NSLog(@"propose:%@",[NSValue valueWithCGPoint:proposedContentOffset]);
    return  proposedContentOffset;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    NSLog(@"withScrollingVelocitypropose0:%@  ,%@",[NSValue valueWithCGPoint:proposedContentOffset],[NSValue valueWithCGPoint:velocity]);

    for (int i = 0; i<self.layoutAttributes.count; i++) {
        CGFloat lenth =  i*_itemMargin;
        CGFloat d = lenth - proposedContentOffset.x;
        if (d <0) {d *=-1;}
        if (d<=_itemMargin*0.5) {
            proposedContentOffset.x = lenth;
            break;
        }
    }
    
    NSLog(@"withScrollingVelocitypropose:%@  ,%@",[NSValue valueWithCGPoint:proposedContentOffset],[NSValue valueWithCGPoint:velocity]);
    return  proposedContentOffset;
}
-(CGPoint)targetContentOffsetForProposedIndexPath:(NSIndexPath*)indexPath{
    return CGPointMake(indexPath.row*_itemMargin, 0);
}


@end
