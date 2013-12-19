//
//  MRCCell.m
//  MatCollection
//
//  Created by mathew cruz on 12/19/13.
//  Copyright (c) 2013 mathew cruz. All rights reserved.
//

#import "MRCCell.h"
#import "MRCLayoutAttributes.h"

@implementation MRCCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    if ([layoutAttributes isKindOfClass:[MRCLayoutAttributes class]]) {
        self.layer.anchorPoint = ((MRCLayoutAttributes *)layoutAttributes).anchorPoint;
    }
    [super applyLayoutAttributes:layoutAttributes];

}

@end
