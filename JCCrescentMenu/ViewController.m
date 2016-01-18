//
//  ViewController.m
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray* _imageNames;
    UIColor* _bgColor;
    UIColor* _centerButtonColor;
    UIColor* _outerButtonColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageNames = @[@"glyphicons-101-font.png", @"glyphicons-102-italic.png", @"glyphicons-103-bold.png", @"glyphicons-104-text-underline.png", @"glyphicons-105-text-strike.png"];
 
    
    _bgColor = [UIColor colorWithRed:61./255. green:98./255. blue:113./255. alpha:1.];
    _centerButtonColor = [UIColor colorWithRed:61./255. green:137./255. blue:156./255. alpha:1];
    _outerButtonColor = [UIColor colorWithRed:69./255. green:162./255. blue:152./255. alpha:1];

    
    [_crescentMenu initializeView];
    [_crescentMenu setBackgroundColor:_bgColor];
    
    
    [_tr setCorner:JCCrescentMenuCornerTopRight];
    [_tr initializeView];
    [_tr setBackgroundColor:_bgColor];
    
    [_bl setCorner:JCCrescentMenuCornerBottomLeft];
    [_bl initializeView];
    [_bl setBackgroundColor:_bgColor];
    
    [_tl setCorner:JCCrescentMenuCornerTopLeft];
    [_tl initializeView];
    [_tl setBackgroundColor:_bgColor];

}

-(UIButton*)centerButtonForCrescentMenu: (JCCrescentMenu*)crescentMenu {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIButton* b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [b setBackgroundColor:_centerButtonColor];
    
    UIImage* bgImage = [UIImage imageNamed:@"glyphicons-281-settings.png"];
    [b setImage:bgImage forState:UIControlStateNormal];
    return b;
}

-(int)numberOfButtonsInCrescentMenu:(JCCrescentMenu*)crescentMenu {
    return (int)[_imageNames count];
}

-(UIButton*)crescentMenu:(JCCrescentMenu*)crescentMenu buttonAtIndex:(int)index {
    UIButton* b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    [b setBackgroundColor:_outerButtonColor];
    
    b.alpha = 1.0;
    b.opaque = YES;
    UIImage* bgImage = [UIImage imageNamed:_imageNames[index]];
    [b setImage:bgImage forState:UIControlStateNormal];
    
    return b;
}

-(void)crescentMenu:(JCCrescentMenu *)crescentMenu didPressButton:(UIButton *)button atIndex:(int)index {
    NSLog(@"Button %d pressed", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
