//
//  JCCrescentMenuDelegate.h
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//

#import <Foundation/Foundation.h>
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
