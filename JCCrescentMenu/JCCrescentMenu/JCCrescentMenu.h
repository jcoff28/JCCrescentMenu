//
//  JCCrescentMenu.h
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JCCrescentMenuCorner) {
    JCCrescentMenuCornerTopLeft,
    JCCrescentMenuCornerTopRight,
    JCCrescentMenuCornerBottomLeft,
    JCCrescentMenuCornerBottomRight
};

@class JCCrescentMenu;

@protocol JCCrescentMenuDelegate <NSObject>
@optional
-(void)crescentMenu:(JCCrescentMenu*)crescentMenu didPressButton:(UIButton*)button atIndex:(int) index;
-(void)crescentMenu:(JCCrescentMenu*) crescentMenu didPressCenterButton:(UIButton*) index;
-(void)crescentMenuWillOpen:(JCCrescentMenu *)crescentMenu;
-(void)crescentMenuDidOpen:(JCCrescentMenu *)crescentMenu;
-(void)crescentMenuWillClose:(JCCrescentMenu *)crescentMenu;
-(void)crescentMenuDidClose:(JCCrescentMenu *)crescentMenu;
@end

@protocol JCCrescentMenuDataSource <NSObject>
-(UIButton*)centerButtonForCrescentMenu: (JCCrescentMenu*)crescentMenu;
-(int)numberOfButtonsInCrescentMenu:(JCCrescentMenu*)crescentMenu;
-(UIButton*)crescentMenu:(JCCrescentMenu*)crescentMenu buttonAtIndex:(int)index;
@optional
-(UIButton*)openButtonForCrescentMenu:   (JCCrescentMenu*)crescentMenu;
-(UIButton*)closeButtonForCrescentMenu:  (JCCrescentMenu*)crescentMenu;
@end

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
