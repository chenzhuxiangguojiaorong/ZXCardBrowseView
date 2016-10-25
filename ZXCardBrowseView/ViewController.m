//
//  ViewController.m
//  ZXCardBrowseView
//
//  Created by ios on 16/10/25.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"
#import "ZXCarBrowseViewLayout.h"
#import "ZXCarBrowseCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ViewController {
    UICollectionView *collectionView1;
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ZXCarBrowseViewLayout *layout = nil;
    layout = [[ZXCarBrowseViewLayout alloc] init];
    layout.itemSize = CGSizeMake(250, 350);
    collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400) collectionViewLayout:layout];
    collectionView1.backgroundColor = [UIColor whiteColor];
    collectionView1.delegate = self;
    collectionView1.dataSource = self;
    
    [self.view addSubview:collectionView1];
    
    collectionView1.showsHorizontalScrollIndicator = NO;
    collectionView1.showsVerticalScrollIndicator = NO;
    [collectionView1 registerNib:[UINib nibWithNibName:NSStringFromClass([ZXCarBrowseCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

}
- (void)viewDidLoad {
    [super viewDidLoad];

}

//- (NSIndexPath *)curIndexPath {
//    NSArray *indexPaths = [collectionView1 indexPathsForVisibleItems];
//    NSIndexPath *curIndexPath = nil;
//    NSInteger curzIndex = 0;
//    for (NSIndexPath *path in indexPaths.objectEnumerator) {
//        UICollectionViewLayoutAttributes *attributes = [collectionView1 layoutAttributesForItemAtIndexPath:path];
//        if (!curIndexPath) {
//            curIndexPath = path;
//            curzIndex = attributes.zIndex;
//            continue;
//        }
//        if (attributes.zIndex > curzIndex) {
//            curIndexPath = path;
//            curzIndex = attributes.zIndex;
//        }
//    }
//    return curIndexPath;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSIndexPath *curIndexPath = [self curIndexPath];
//    if (indexPath.row == curIndexPath.row) {
//        return YES;
//    }
//    [collectionView1 scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    
//    return NO;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     [collectionView1 scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    NSLog(@"click %ld", indexPath.row);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXCarBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
