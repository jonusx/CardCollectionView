//
//  MRCSearchViewController.m
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MRCSearchViewController.h"
#import "MRCCollectionViewController.h"

@interface MRCSearchViewControllerTest : XCTestCase

@end

@implementation MRCSearchViewControllerTest

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

- (void)testPrepareForSequeHandoff {
    NSString *searchTerm = @"Garbage";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MRCSearchViewController *searchController = [[[storyboard instantiateInitialViewController] viewControllers] firstObject];
    [searchController view];
    
    searchController.searchTextField.text = searchTerm;
    
    MRCCollectionViewController *collectionController = [storyboard instantiateViewControllerWithIdentifier:@"MRCCollectionViewController"];
    
    UIStoryboardSegue *pushSegue = [UIStoryboardSegue segueWithIdentifier:@"performSearchSegue" source:searchController destination:collectionController performHandler:^{}];
    [searchController prepareForSegue:pushSegue sender:searchController];
    
    XCTAssertTrue([collectionController.searchTerm isEqualToString:searchTerm], @"Search term has not been set properly, %@", collectionController.searchTerm);
    
}

@end
