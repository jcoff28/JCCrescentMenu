//
//  ViewController.h
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCCrescentMenu.h"

@interface ViewController : UIViewController <JCCrescentMenuDataSource, JCCrescentMenuDelegate>

@property (strong, nonatomic) IBOutlet JCCrescentMenu *crescentMenu;

@property (strong, nonatomic) IBOutlet JCCrescentMenu * tr;

@property (strong, nonatomic) IBOutlet JCCrescentMenu *tl;

@property (strong, nonatomic) IBOutlet JCCrescentMenu *bl;

@end

