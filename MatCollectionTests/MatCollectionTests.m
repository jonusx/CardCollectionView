//
//  MatCollectionTests.m
//  MatCollectionTests
//
//  Created by mathew cruz on 12/18/13.
//  Copyright (c) 2013 mathew cruz. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MRCCollectionViewController.h"
#import "MRCCell.h"
#import "MRCSpotifyAPI.h"
#import "MRCSpotifyAlbum.h"

@interface MatCollectionTests : XCTestCase

@end

@implementation MatCollectionTests

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

- (void)testSearch {
    //searching metallica
    MRCSpotifyAPI *spotifyAPI = [MRCSpotifyAPI new];
    NSArray *searchResults = [spotifyAPI searchSpotifyFor:@"metallica"];
    
    NSDictionary *album = [searchResults firstObject];
    XCTAssertTrue([album[@"name"] isEqualToString:@"Metallica"], @"Album name should be Metallica, returned %@", album[@"name"]);
    XCTAssertTrue([album[@"href"] isEqualToString:@"spotify:album:37lWyRxkf3wQHCOlXM5WfX"], @"Album URL should be 'spotify:album:37lWyRxkf3wQHCOlXM5WfX', returned '%@'", album[@"href"]);
}

- (void)testAsyncSearch {
    BOOL __block keepRunning = YES;
    NSTimeInterval seconds = 5;
    NSTimeInterval timeout = 30;
    NSDate *timeoutDate = [NSDate date];
    NSDictionary * __block album;
    
    NSOperationQueue *completionQueue = [NSOperationQueue currentQueue];
    
    MRCSpotifyAPI *spotifyAPI = [MRCSpotifyAPI new];
    [spotifyAPI asyncSearchSpotifyFor:@"metallica" completion:^(NSArray *searchResults, NSError *error) {
        [completionQueue addOperationWithBlock:^{
            album = [searchResults firstObject];
            keepRunning = NO;
        }];
    }];
    
    while (keepRunning && [[NSDate date] timeIntervalSinceDate:timeoutDate] < timeout) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
    }
    
    XCTAssertTrue([album[@"name"] isEqualToString:@"Metallica"], @"Album name should be Metallica, returned %@", album[@"name"]);
    XCTAssertTrue([album[@"href"] isEqualToString:@"spotify:album:37lWyRxkf3wQHCOlXM5WfX"], @"Album URL should be 'spotify:album:37lWyRxkf3wQHCOlXM5WfX', returned '%@'", album[@"href"]);
}

- (void)testAsyncSearchFailed {
    
    BOOL __block keepRunning = YES;
    NSTimeInterval seconds = 5;
    NSTimeInterval timeout = 30;
    NSDate *timeoutDate = [NSDate date];
    NSArray * __block zeroResults = nil;
    NSOperationQueue *completionQueue = [NSOperationQueue currentQueue];
    
    MRCSpotifyAPI *spotifyAPI = [MRCSpotifyAPI new];
    [spotifyAPI asyncSearchSpotifyFor:@"Rock%20the%20Slugs" completion:^(NSArray *searchResults, NSError *error) {
        [completionQueue addOperationWithBlock:^{
            zeroResults = searchResults;
            keepRunning = NO;
        }];
    }];
    
    while (keepRunning && [[NSDate date] timeIntervalSinceDate:timeoutDate] < timeout) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
    }

    XCTAssertTrue(zeroResults, @"At least an empty array");
    
    XCTAssertTrue(zeroResults.count == 0, @"Something when I didn't want anything");
}

- (void)testAlbumCellDisplay {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MRCCollectionViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MRCCollectionViewController"];
    [controller viewWillAppear:YES];
    [controller viewDidAppear:YES];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    MRCCell *cellToCheck = (MRCCell *)[controller collectionView:controller.collectionView cellForItemAtIndexPath:indexPath];
    
    XCTAssertTrue([cellToCheck.junkLabel.text isEqualToString:@"Metallica"], @"Album name should be Metallica, returned %@", cellToCheck.junkLabel.text);
    
    //Test if cell is displaying album name
}


@end
