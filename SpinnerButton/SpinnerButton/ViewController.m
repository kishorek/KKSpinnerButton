//
//  ViewController.m
//  SpinnerButton
//
//  Created by Kishore Kumar on 18/7/13.
//  Copyright (c) 2013 Kishore Kumar. All rights reserved.
//

#import "ViewController.h"
#import "KKSpinnerButton.h"

@interface ViewController ()
@property(nonatomic, strong) KKSpinnerButton *button;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.button = [[KKSpinnerButton alloc] initWithFrame:CGRectMake(40, 40, 100, 60)];
    self.button.title = @"Submit";
    [self.button addTarget:self action:@selector(callTheButton:)];
    [self.view addSubview:self.button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) callTheButton:(id) sender{
    NSLog(@"Callback happened");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [sender stopAnimationAndBackToActive];
    });

}

@end
