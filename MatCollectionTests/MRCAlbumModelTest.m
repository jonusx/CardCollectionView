//
//  MRCAlbumModelTest.m
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MRCSpotifyAlbum.h"

@interface MRCAlbumModelTest : XCTestCase

@end

@implementation MRCAlbumModelTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation {
    MRCSpotifyAlbum *album = [[MRCSpotifyAlbum alloc] initWithAlbumDictionary:@{@"name": @"test album",
                                                                                @"href" : @"spotify:artist:2ye2Wgw4gimLv2eAKyk1NB"}];
    
    XCTAssertTrue([album.name isEqualToString:@"test album"], @"Album name not set properly, %@", album.name);
    XCTAssertTrue([album.albumIdentifier isEqualToString:@"spotify:artist:2ye2Wgw4gimLv2eAKyk1NB"], @"Album identifier not set properly, %@", album.albumIdentifier);
    
}

- (void)testFailedCreationWithNilDictionary {
    MRCSpotifyAlbum *album = [[MRCSpotifyAlbum alloc] initWithAlbumDictionary:nil];
    
    XCTAssertNil(album, @"Instance of album should not be created");
    
}

- (void)testfailedCreation {
    MRCSpotifyAlbum *album = [[MRCSpotifyAlbum alloc] init];
    
    XCTAssertNil(album, @"Instance of album should not be created");
}

- (void)testAlbumConversion {
    NSArray *rawArray = @[@{@"name": @"test album",
                            @"href" : @"spotify:artist:2ye2Wgw4gimLv2eAKyk1NB"}];
    NSArray *convertedArray = [MRCSpotifyAlbum convertDictionaryArray:rawArray];
    
    MRCSpotifyAlbum *album = [convertedArray firstObject];
    
    XCTAssertTrue([album.name isEqualToString:@"test album"], @"Album name not set properly, %@", album.name);
    XCTAssertTrue([album.albumIdentifier isEqualToString:@"spotify:artist:2ye2Wgw4gimLv2eAKyk1NB"], @"Album identifier not set properly, %@", album.albumIdentifier);
}


@end


