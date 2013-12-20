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
    NSInteger endIndex = MIN(MAX((NSInteger)ceilf(self.collectionView.contentOffset.y/CGRectGetHeight(self.collectionView.frame)), 0), numItems-1);
    self.forwardIndex = endIndex;
    
    
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
    NSUInteger theRow = indexPath.row;
    CGRect pageRect = CGRectMake(self.collectionView.bounds.origin.x, theRow * CGRectGetHeight(self.collectionView.bounds), self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGFloat pageTop = pageRect.origin.y;
    
    CGFloat theDelta = self.collectionView.contentOffset.y - pageTop;
    CGFloat specialDelta = (pageRect.origin.y + pageRect.size.height) - theDelta;
	CGRect theViewBounds = self.collectionView.bounds;
    
    
    MRCLayoutAttributes *theAttributes = [MRCLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CATransform3D theTransform = CATransform3DIdentity;
    theTransform = CATransform3DTranslate(theTransform, 0.0f, theDelta, 0.0f);
    
    if (self.forwardIndex == theRow) {
        theViewBounds.origin.y = specialDelta - pageRect.size.height;
        theAttributes.anchorPoint = CGPointMake(0.5, 0.5);
    }
    else
    {
        theTransform.m34 = 1.0f / -850.0f;
        theTransform = CATransform3DTranslate(theTransform, 0.0f, -theDelta, -theDelta/2);
        theViewBounds.origin.y = pageTop + theDelta/1.5 + (pageRect.size.height/2);
        CGFloat rotation = ((((abs(theDelta)/theViewBounds.size.height)*35)));
        theTransform = CATransform3DRotate(theTransform, rotation * M_PI/180.0f, 1, 0, 0);
        theAttributes.anchorPoint = CGPointMake(0.5, 1.0);
    }
    
    theAttributes.transform3D = theTransform;
    theAttributes.frame = theViewBounds;
    theAttributes.zIndex = theRow;
    return theAttributes;
}

@end
