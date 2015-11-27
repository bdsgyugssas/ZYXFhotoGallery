//
//  ViewController.m
//  YXPhotoGallery
//
//  Created by 郑雨鑫 on 15/11/27.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "YXLineLayout.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *Photos;


@end

@implementation ViewController

static NSString * const ID=@"Photo";

#pragma mark -懒加载
- (NSMutableArray *)Photos
{
    if (_Photos==nil) {
        _Photos=[NSMutableArray array];
        
        for (int i=1; i<21; i++) {
            NSString *photoName=[NSString stringWithFormat:@"%d",i];
            [_Photos addObject:photoName];
        }
    }
    
    return _Photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor=[UIColor grayColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.collectionViewLayout=[[YXLineLayout alloc]init];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:ID];
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.Photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.photoName=self.Photos[indexPath.item];
    return cell;
  
}

#pragma mark -UICollectionViewDelegate

@end
