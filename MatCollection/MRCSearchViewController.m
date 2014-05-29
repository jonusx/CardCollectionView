//
//  MRCSearchViewController.m
//  MatCollection
//
//  Created by pair on 5/29/14.
//  Copyright (c) 2014 mathew cruz. All rights reserved.
//

#import "MRCSearchViewController.h"
#import "MRCCollectionViewController.h"

@interface MRCSearchViewController ()
@end

@implementation MRCSearchViewController

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
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MRCCollectionViewController *controller = segue.destinationViewController;
    controller.searchTerm = self.searchTextField.text;
}


@end
