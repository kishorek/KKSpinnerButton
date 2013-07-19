//
//  SpinnerButton.h
//  SpinnerButton
//
//  Created by Kishore Kumar on 18/7/13.
//  Copyright (c) 2013 Kishore Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

//Inspired from http://h5bp.github.io/Effeckt.css/dist/buttons.html

typedef enum{
    ZoomIn,
    SlideLeft,
    SlideRight
} SpinnerButtonAnimation;

@interface KKSpinnerButton : UIView

@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) int animationType;
@property(nonatomic, strong) UILabel *titleLabel;

-(void) addTarget:(id) target action:(SEL) selector;
-(void) stopAnimationAndBackToActive;
-(void) stopAnimationAndDisable;

@end
