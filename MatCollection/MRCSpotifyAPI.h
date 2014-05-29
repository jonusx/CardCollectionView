//
//  MRCSpotifyAPI.h
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCSpotifyAPI : NSObject

- (NSArray *)searchSpotifyFor:(NSString *)searchTerm;

- (void)asyncSearchSpotifyFor:(NSString *)searchTerm completion:(void (^)(NSArray *searchResults, NSError *error))completionBlock;

@end
