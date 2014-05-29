//
//  MRCSpotifyAlbum.h
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCSpotifyAlbum : NSObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *albumIdentifier;

- (instancetype)initWithAlbumDictionary:(NSDictionary *)albumDictionary;

+ (NSArray *)convertDictionaryArray:(NSArray *)rawDictionaries;

@end
