//
//  MRCSpotifyAPI.m
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import "MRCSpotifyAPI.h"
#import "MRCSpotifyAlbum.h"

//#define USE_MOCK_DATA 0

static NSString * const MRCSPAPISearchEndpoint = @"http://ws.spotify.com/search/1/album.json?q=";


@implementation MRCSpotifyAPI

- (NSArray *)searchSpotifyFor:(NSString *)searchTerm {

#ifdef USE_MOCK_DATA
    NSString *jsonPath = [[NSBundle bundleWithIdentifier:@"com.mcruz.test"] pathForResource:@"mockResults" ofType:@"json"];
    NSData *searchData = [[NSData alloc] initWithContentsOfFile:jsonPath];
#else
    NSURL *URL = [NSURL URLWithString:[MRCSPAPISearchEndpoint stringByAppendingString:searchTerm]];
    
    NSURLResponse *searchResponse;
    NSError *searchError;
    
    NSData *searchData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:&searchResponse error:&searchError];
#endif
    
    NSDictionary *albumResults = [NSJSONSerialization JSONObjectWithData:searchData options:0 error:nil];
    NSArray *convertedAlbums = [MRCSpotifyAlbum convertDictionaryArray:albumResults[@"albums"]];
    return convertedAlbums;
}

- (void)asyncSearchSpotifyFor:(NSString *)searchTerm completion:(void (^)(NSArray *, NSError *))completionBlock {
    
#ifdef USE_MOCK_DATA
    
    NSString *jsonPath = [[NSBundle bundleWithIdentifier:@"com.mcruz.test"] pathForResource:@"mockResults" ofType:@"json"];
    NSData *searchData = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSDictionary *returnedResults = [NSJSONSerialization JSONObjectWithData:searchData options:0 error:nil];
    completionBlock(returnedResults[@"albums"], nil);
#else
    
    NSURL *URL = [NSURL URLWithString:[MRCSPAPISearchEndpoint stringByAppendingString:searchTerm]];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:URL] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *returnedResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *convertedAlbums = [MRCSpotifyAlbum convertDictionaryArray:returnedResults[@"albums"]];
        completionBlock(convertedAlbums, connectionError);
    }];
    
#endif
}

@end
