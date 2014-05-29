//
//  MRCSpotifyAlbum.m
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import "MRCSpotifyAlbum.h"

static NSString * const SpotifyNameKey = @"name";
static NSString * const SpotifyAlbumIdentifierKey = @"href";

@interface MRCSpotifyAlbum ()
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *albumIdentifier;
@end

@implementation MRCSpotifyAlbum

- (id)init {
    return nil;
}

- (instancetype)initWithAlbumDictionary:(NSDictionary *)albumDictionary {
    self = [super init];
    if (!self || !albumDictionary || [albumDictionary count] == 0) {
        return nil;
    }
    
    _name = albumDictionary[SpotifyNameKey];
    _albumIdentifier = albumDictionary[SpotifyAlbumIdentifierKey];
    
    return self;
}

+ (NSArray *)convertDictionaryArray:(NSArray *)rawDictionaries {
    return nil;
}

@end
