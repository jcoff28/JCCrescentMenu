//
//  JCCrescentMenu.h
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JCCrescentMenuDelegate.h"
#import "JCCrescentMenuDataSource.h"

typedef NS_ENUM(NSInteger, JCCrescentMenuCorner) {
    JCCrescentMenuCornerTopLeft,
    JCCrescentMenuCornerTopRight,
    JCCrescentMenuCornerBottomLeft,
    JCCrescentMenuCornerBottomRight
};

@interface JCCrescentMenu : UIView

@property (nonatomic) IBOutlet id delegate;

@property (nonatomic) IBOutlet id dataSource;

@property (nonatomic) JCCrescentMenuCorner corner;

-(void)initializeView;

-(void)reloadCrescentButtonsAnimated:(BOOL) animated;

-(void)setBackgroundColor:(UIColor *)backgroundColor;
-(void)closeMenu;
-(void)openMenu;
-(void)toggleMenu:(UIButton*) sender;
-(BOOL)isMenuOpen;

@property (nonatomic) NSTimeInterval animationDuration;
@property (nonatomic) CGFloat crescentButtonSize;
@property (nonatomic) CGFloat centerButtonSize;
@property (nonatomic) CGFloat centerButtonPadding;
@property (nonatomic) CGFloat toggleButtonSize;
@property (nonatomic) CGFloat crescentButtonDistanceFromEdgeToCenter;
@end
