//
//  ViewController.m
//  c10-sc00-SwitchingViews
//
//  Created by Tom Morton on 9/28/16.
//  Copyright © 2016 Tom Morton. All rights reserved.
//

#import "SwitchingViewController.h"
#import "BlueViewController.h"
#import "RedViewController.h"

@interface SwitchingViewController ()
@property(strong, nonatomic) BlueViewController* blueViewController;
@property(strong, nonatomic) RedViewController* redViewController;
@end

@implementation SwitchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    
    //Setting the Blue controller to overtake the parent frame
    self.blueViewController.view.frame = self.view.frame;
    
    [self switchViewFromViewController:nil toViewController:self.blueViewController ];
    
}

//UIAlert

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if(!self.blueViewController.view.superview){
        self.blueViewController = nil;
    }
    if(!self.redViewController.view.superview){
        self.redViewController = nil;
    }
}

-(IBAction)switchViews:(id)sender{
    //Create view controller if required
    if(!self.redViewController.view.superview){
        if(!self.redViewController){
            self.redViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Red"];
        } else {
            if(!self.blueViewController ){
                self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
            }
        }
    }
    
    //Switch View Controllers
    
    if(!self.redViewController.view.superview){
        self.redViewController.view.frame = self.view.frame;
        [self switchViewFromViewController:self.blueViewController toViewController:self.redViewController];
    } else {
        self.blueViewController.view.frame = self.view.frame;
        [self switchViewFromViewController:self.redViewController toViewController:self.blueViewController];
    }

    
    
}

-(void)switchViewFromViewController:(UIViewController *) fromVC toViewController:(UIViewController * ) toVC{
    if(fromVC != nil){
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    
    if(toVC != nil){
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC didMoveToParentViewController:self];
    }
}

@end
