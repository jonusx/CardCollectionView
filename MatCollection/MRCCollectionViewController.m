//
//  MRCCollectionViewController.m
//  MatCollection
//
//  Created by mathew cruz on 12/18/13.
//  Copyright (c) 2013 mathew cruz. All rights reserved.
//

#import "MRCCollectionViewController.h"
#import "MRCCell.h"
#import "MRCCardLayout.h"
#import "MRCSpotifyAPI.h"

@interface MRCCollectionViewController ()
@property (nonatomic, strong) MRCSpotifyAPI *spotifyAPI;
@property (nonatomic, strong) NSArray *spotifyAlbums;
@end

@implementation MRCCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.spotifyAPI = [MRCSpotifyAPI new];
    
    typeof(self) __weak weakSelf = self;
    [self.spotifyAPI asyncSearchSpotifyFor:self.searchTerm completion:^(NSArray *searchResults, NSError *error) {
        typeof(weakSelf) __strong strongSelf = weakSelf;
        strongSelf.spotifyAlbums = searchResults;
        [strongSelf.collectionView reloadData];
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
	return [self.spotifyAlbums count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
	MRCCell *theCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *album = self.spotifyAlbums[indexPath.item];
    
    theCell.junkLabel.text = album[@"name"];
	theCell.backgroundColor = (indexPath.row % 2) ? [UIColor redColor] : [UIColor whiteColor];
    
	return theCell ;
}

- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    NSLog(@"%@", fromLayout);
    return nil;
}



@end
