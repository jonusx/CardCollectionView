//
//  MRCLayoutAttributes.m
//  MatCollection
//
//  Created by mathew cruz on 12/19/13.
//  Copyright (c) 2013 mathew cruz. All rights reserved.
//

#import "MRCLayoutAttributes.h"

@implementation MRCLayoutAttributes

- (id)copyWithZone:(NSZone *)zone
{
    MRCLayoutAttributes *attributes = [super copyWithZone:zone];
    
    attributes.forwardCell = self.forwardCell;
    attributes.anchorPoint = self.anchorPoint;
    
    return attributes;
}

@end
