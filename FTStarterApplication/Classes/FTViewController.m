//
//  FTViewController.m
//  FTStarterApplication
//
//  Created by Juan-Carlos Foust on 06/03/2013.
//  Copyright (c) 2013 Fototropik. All rights reserved.
//

#import "FTViewController.h"

@interface FTViewController ()

@end

@implementation FTViewController

#pragma mark - Delegates


#pragma mark - Actions, Gestures, Notification Handlers

- (void)exit
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Private


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Segue

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)activityView
//{
//    if ([segue.identifier isEqualToString:<#name#>])  {
//        <#Class Name#> *vc = (<#Class Name#> *)segue.destinationViewController;
//        <#initialization#>
//    }
//}


@end