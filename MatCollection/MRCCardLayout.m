//
//  MRCCardLayout.m
//  MatCollection
//
//  Created by mathew cruz on 12/18/13.
//  Copyright (c) 2013 mathew cruz. All rights reserved.
//

#import "MRCCardLayout.h"
#import "MRCLayoutAttributes.h"

@interface MRCCardLayout ()
@property (nonatomic) NSUInteger forwardIndex;
@end

@implementation MRCCardLayout

+ (Class)layoutAttributesClass
{
    return [MRCLayoutAttributes class];
}

- (CGSize)collectionViewContentSize {
    
    NSUInteger numItems = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    CGSize size = CGSizeMake(CGRectGetWidth(self.collectionView.bounds), numItems*CGRectGetHeight(self.collectionView.frame));
    return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return(YES);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *theLayoutAttributes = [NSMutableArray new];
    
    NSUInteger numItems = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    NSInteger startIndex = MIN(MAX((NSInteger)floorf(self.collectionView.contentOffset.y/CGRectGetHeight(self.collectionView.frame)), 0), numItems);
    self.forwardIndex = startIndex;
    NSInteger endIndex = MIN(MAX((NSInteger)ceilf(self.collectionView.contentOffset.y/CGRectGetHeight(self.collectionView.frame)), 0), numItems);

    for (NSInteger index = startIndex; index <= endIndex; index++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        
        UICollectionViewLayoutAttributes *theAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (theAttributes)
        {
            [theLayoutAttributes addObject:theAttributes];
        }
    }

    return theLayoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    const CGFloat theRow = indexPath.row;
    CGFloat theDelta = self.collectionView.contentOffset.y - (theRow * CGRectGetHeight(self.collectionView.bounds));
    
	CGRect theViewBounds = self.collectionView.bounds;
    MRCLayoutAttributes *theAttributes = [MRCLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CATransform3D theTransform = CATransform3DIdentity;
        theTransform = CATransform3DTranslate(theTransform, 0.0f, theDelta, 0.0f);
    if (self.forwardIndex == indexPath.row) {
        theViewBounds.origin.y = (theRow * self.collectionView.bounds.size.height) + theDelta;
        theAttributes.anchorPoint = CGPointMake(0.5, 0.5);
    }
    else
    {
        theTransform.m34 = 1.0f / -850.0f;
        theTransform = CATransform3DTranslate(theTransform, 0.0f, self.collectionView.bounds.size.height/2, (theDelta/2));
        theViewBounds.origin.y = (theRow * self.collectionView.bounds.size.height) + theDelta/2;
        theTransform = CATransform3DRotate(theTransform, (-((theDelta/2)/self.collectionView.bounds.size.height)*90) * M_PI/180.0f, 1, 0, 0);
        theAttributes.anchorPoint = CGPointMake(0.5, 1.0);
    }
    theAttributes.transform3D = theTransform;
    theAttributes.frame = theViewBounds;
    theAttributes.zIndex = indexPath.row;
    return theAttributes;
}

@end
