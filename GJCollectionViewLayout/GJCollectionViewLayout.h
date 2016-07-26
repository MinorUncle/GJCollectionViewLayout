//
//  GJCollectionViewLayout.h
//  GJCollectionViewLayout
//
//  Created by tongguan on 16/7/26.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  section only 1
 */
@interface GJCollectionViewLayout : UICollectionViewLayout
@property(nonatomic,assign)CGSize contentSize;
@property(nonatomic,assign)CGSize maxItemSize;
@property(nonatomic,assign)CGSize minItemSize;

-(CGPoint)targetContentOffsetForProposedIndexPath:(NSIndexPath*)indexPath;
@end
