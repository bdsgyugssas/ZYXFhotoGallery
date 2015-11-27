//
//  YXLineLayout.m
//  YXPhotoGallery
//
//  Created by 郑雨鑫 on 15/11/27.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "YXLineLayout.h"

@implementation YXLineLayout



- (void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(100, 100);
    self.minimumLineSpacing = 50;
    CGFloat insetsLR = self.collectionView.frame.size.width/2-50;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, insetsLR, 0, insetsLR);
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
  
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        if (![self isInAmplifierRegion:attr]) continue;
      
        CGFloat scale = [self scaleWith:attr];
        
        attr.transform3D = CATransform3DMakeScale( scale, scale, 0);
        
    }

    return array;

}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect lastRect;
    
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat length = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        CGFloat distance = attr.center.x - (lastRect.origin.x+lastRect.size.width/2);
        if (ABS(length) > ABS(distance)) {
            length = distance;
        }
    }

    CGPoint point = CGPointMake(proposedContentOffset.x+length, proposedContentOffset.y);
    return point;

    
}

/**
 *  是否在屏幕上
 */
- (BOOL)isInAmplifierRegion:(UICollectionViewLayoutAttributes *)attributes
{
    CGRect rect1;
    rect1.origin = self.collectionView.contentOffset;
    rect1.size = self.collectionView.frame.size;
    
    if (CGRectIntersectsRect(rect1, attributes.frame)) {
        return YES;
    }
    return NO;

}

/**
 *  判断缩放比例
 */
- (CGFloat)scaleWith:(UICollectionViewLayoutAttributes *)attributes
{
    CGFloat viewW = self.collectionView.frame.size.width;
    CGFloat currentCenterX = self.collectionView.contentOffset.x+viewW/2;
    if (ABS(currentCenterX-attributes.center.x)>(viewW/2-20)) {
        return 1;
    }
    CGFloat scale = ((viewW/2-20)-(ABS(currentCenterX-attributes.center.x)))/viewW+1;

    return scale;
}
@end
