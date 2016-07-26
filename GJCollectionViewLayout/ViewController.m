//
//  ViewController.m
//  GJCollectionViewLayout
//
//  Created by tongguan on 16/7/26.
//  Copyright © 2016年 MinorUncle. All rights reserved.
//

#import "ViewController.h"
#import "GJCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView* _collection;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GJCollectionViewLayout* _layout = [[GJCollectionViewLayout alloc]init];
    _layout.maxItemSize = CGSizeMake(200, 200);
    _layout.minItemSize = CGSizeMake(50, 50);
    _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:_layout];
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collection];
    CGSize size = _collection.bounds.size;
    size.width*=3;
    _layout.contentSize = size;
    
    _collection.delegate = self;
    _collection.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row %2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    GJCollectionViewLayout* layout = (GJCollectionViewLayout*)collectionView.collectionViewLayout;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    NSLog(@"touch");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
