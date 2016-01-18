//
//  JCCrescentMenuDataSource.h
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JCCrescentMenu;

@protocol JCCrescentMenuDataSource <NSObject>

-(UIButton*)centerButtonForCrescentMenu: (JCCrescentMenu*)crescentMenu;

-(int)numberOfButtonsInCrescentMenu:(JCCrescentMenu*)crescentMenu;

-(UIButton*)crescentMenu:(JCCrescentMenu*)crescentMenu buttonAtIndex:(int)index;

@optional

-(UIButton*)openButtonForCrescentMenu:   (JCCrescentMenu*)crescentMenu;
-(UIButton*)closeButtonForCrescentMenu:  (JCCrescentMenu*)crescentMenu;

@end
