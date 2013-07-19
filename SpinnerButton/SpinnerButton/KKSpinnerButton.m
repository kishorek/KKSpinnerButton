//
//  SpinnerButton.m
//  SpinnerButton
//
//  Created by Kishore Kumar on 18/7/13.
//  Copyright (c) 2013 Kishore Kumar. All rights reserved.
//

#import "KKSpinnerButton.h"

#define kAnimationDuration1 0.1
#define kAnimationDuration2 0.2
#define kAnimationDuration3 0.3

@interface KKSpinnerButton ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@property(nonatomic, strong) KKSpinnerButton *strongRef;

@end

@implementation KKSpinnerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = YES;
        self.animationType = SlideRight;
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        
        [self initTitleLabel];
        self.strongRef = self;
    }
    return self;
}

#pragma mark - public
-(void) stopAnimationAndBackToActive{
    [self stopAnimation];
    self.userInteractionEnabled = YES;
}

-(void) stopAnimationAndDisable{
    [self stopAnimation];
}

-(void)addTarget:(id)target action:(SEL)selector{
    self.target = target;
    self.action = selector;
}

#pragma mark - Animations
-(void) startAnimation{
    if (self.animationType == ZoomIn) {
        [self zoomIn];
    } else if (self.animationType == SlideLeft){
        [self slideLeft];
    } else if (self.animationType == SlideRight){
        [self slideRight];
    }
}

-(void) stopAnimation{
    if (self.animationType == ZoomIn) {
        [self zoomInReverse];
    } else if (self.animationType == SlideLeft){
        [self slideLeftReverse];
    } else if (self.animationType == SlideRight){
        [self slideRightReverse];
    }
}

-(void) slideRight{
    [self initSpinner];
    CGRect titleLabelFrame = self.titleLabel.frame;
    
    [UIView animateWithDuration:kAnimationDuration3 animations:^{
        [self.titleLabel setFrame:CGRectMake(-self.bounds.size.width, titleLabelFrame.origin.y, titleLabelFrame.size.width, titleLabelFrame.size.height)];
    } completion:^(BOOL finished) {
        self.spinner.frame = CGRectMake(self.bounds.size.width, titleLabelFrame.origin.y, self.spinner.frame.size.width, self.spinner.frame.size.height);
        
        [self.spinner startAnimating];
        [UIView animateWithDuration:kAnimationDuration1 animations:^{
            self.spinner.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void) slideRightReverse{
    
    [self initTitleLabel];
    self.titleLabel.hidden = YES;
    CGRect titleLabelFrame = [self titleFrame];
    
    [UIView animateWithDuration:kAnimationDuration3 animations:^{
        self.spinner.frame = CGRectMake(-titleLabelFrame.size.width, titleLabelFrame.origin.y, titleLabelFrame.size.width, titleLabelFrame.size.height);;
    } completion:^(BOOL finished) {
        self.titleLabel.frame = CGRectMake(titleLabelFrame.size.width, titleLabelFrame.origin.y, titleLabelFrame.size.width, titleLabelFrame.size.height);
        self.titleLabel.hidden = NO;
        
        [UIView animateWithDuration:kAnimationDuration3 animations:^{
            [self.titleLabel setFrame:titleLabelFrame];
        } completion:^(BOOL finished) {
            [self.spinner stopAnimating];
        }];
    }];
}

-(void) slideLeft{
    [self initSpinner];
    CGRect titleLabelFrame = self.titleLabel.frame;
    
    [UIView animateWithDuration:kAnimationDuration3 animations:^{
        [self.titleLabel setFrame:CGRectMake(self.bounds.size.width, titleLabelFrame.origin.y, titleLabelFrame.size.width, titleLabelFrame.size.height)];
    } completion:^(BOOL finished) {
        self.spinner.frame = CGRectMake(0, titleLabelFrame.origin.y, self.spinner.frame.size.width, self.spinner.frame.size.height);
        
        [self.spinner startAnimating];
        [UIView animateWithDuration:kAnimationDuration1 animations:^{
            self.spinner.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            //self.spinner.frame = CGRectMake(0, titleLabelFrame.origin.y, self.spinner.frame.size.width, self.spinner.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void) slideLeftReverse{

    [self initTitleLabel];
    self.titleLabel.hidden = YES;
    CGRect titleLabelFrame = [self titleFrame];
    
    [UIView animateWithDuration:kAnimationDuration3 animations:^{
        self.spinner.frame = CGRectMake(titleLabelFrame.size.width, titleLabelFrame.origin.y, titleLabelFrame.size.width, titleLabelFrame.size.height);;
    } completion:^(BOOL finished) {
        self.titleLabel.frame = CGRectMake(10-titleLabelFrame.size.width, titleLabelFrame.origin.y, titleLabelFrame.size.width, titleLabelFrame.size.height);
        self.titleLabel.hidden = NO;
        
        [UIView animateWithDuration:kAnimationDuration3 animations:^{
            [self.titleLabel setFrame:titleLabelFrame];
        } completion:^(BOOL finished) {
            [self.spinner stopAnimating];
        }];
    }];
}

-(void) zoomIn{
    [self initSpinner];
    
    [UIView animateWithDuration:kAnimationDuration2 animations:^{
        self.titleLabel.transform = CGAffineTransformScale(self.titleLabel.transform, 2.0, 2.0);
    } completion:^(BOOL finished) {
        self.titleLabel.hidden = YES;
        
        self.spinner.hidden = NO;
        [UIView animateWithDuration:kAnimationDuration1 animations:^{
            self.spinner.transform = CGAffineTransformScale(self.spinner.transform, 2.0, 2.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kAnimationDuration1 animations:^{
                self.spinner.transform = CGAffineTransformScale(self.spinner.transform, 0.5, 0.5);
            } completion:^(BOOL finished) {
                [self.spinner startAnimating];
            }];
        }];
    }];
}

-(void) zoomInReverse{
    
    [self.spinner stopAnimating];
    [self.spinner setHidden:YES];
    [self initTitleLabel];
    
    [UIView animateWithDuration:kAnimationDuration2 animations:^{
        self.spinner.transform = CGAffineTransformScale(self.spinner.transform, 2.0, 2.0);
    } completion:^(BOOL finished) {
        [self.spinner stopAnimating];
        
        self.titleLabel.hidden = NO;
        [self initTitleLabel];
        [UIView animateWithDuration:kAnimationDuration1 animations:^{
            self.spinner.transform = CGAffineTransformScale(self.titleLabel.transform, 2.0, 2.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kAnimationDuration1 animations:^{
                self.spinner.transform = CGAffineTransformScale(self.titleLabel.transform, 0.5, 0.5);
            }];
        }];
    }];
}


#pragma mark - Initializations
-(void) initTitleLabel{
    self.titleLabel.frame = [self titleFrame];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.clipsToBounds = YES;
    if (self.title) {
        self.titleLabel.text = self.title;
    }
}

-(void) initSpinner{
    if (!self.spinner) {
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:self.spinner];
    }
    
    self.spinner.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.spinner.hidden = YES;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void) highlightButton{
    self.backgroundColor = [UIColor redColor];
}

-(void) removeHighlightButton{
    self.backgroundColor = [UIColor grayColor];
}


#pragma Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Began");
    self.userInteractionEnabled = NO;
    [self highlightButton];
    [self startAnimation];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Ended");
    if (self.target) {
        [self.target performSelector:self.action withObject:self];
    }
    [self performSelector:@selector(removeHighlightButton) withObject:nil afterDelay:0.1];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Moved");
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Cancelled");
}

/* Helpers */

-(CGFloat) titleLabelXScale{
    CGAffineTransform t = self.titleLabel.transform;
    return sqrt(t.a * t.a + t.c * t.c);
}

-(CGFloat) titleLabelYScale{
    CGAffineTransform t = self.titleLabel.transform;
    return sqrt(t.b * t.b + t.d * t.d);
}

-(CGRect) titleFrame{
    return CGRectMake(5, self.frame.size.height/2-10, self.frame.size.width-5, 20);
}

@end
