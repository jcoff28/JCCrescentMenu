JCCrescentMenu
---------------

By Jordan Coff

Purpose
--------------

JCCrescentMenu is a flexible, simple, and beautiful menu. It has a minimal footprint when closed, making it perfect for the app that's crunched on screen real estate. Use it, love it, fork it, do stuff.


![Gif of menu opening](JCCrescentMenu/Example/Images/JCCrescentMenuOpen.gif)

![Gif of menu closing](JCCrescentMenu/Example/Images/JCCrescentMenuClose.gif)

![Picture of menus open on all corners](JCCrescentMenu/Example/Images/JCCrescentMenuAllOpen.jpg)


Usage
-----------------------------

1. Drag a UIView onto your storyboard
2. Using autolayout constraints, give the new view a fixed width, and height, and pin it to the corner of your superview (width must equal height)
3. Select your view, go to the identity pane, and set the class to JCCrescentMenu
4. Go to the connections pane, and connect the datasource and delegate properties to whatever class will be managing the menu
5. Create a referencing outlet
6. Initialize the menu

```objc
-(void)viewDidLoad {
	[super viewDidLoad];
	
	[_crescentMenu setCorner:JCCrescentMenuCornerTopRight]; //Defaults to bottom right if you do nothing here
    [_crescentMenu initializeView];
    [_crescentMenu setBackgroundColor:_bgColor];
}
```

The menu gets its content via datasource, and alerts the user of various events via delegation. 

```objc
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
```

Author
-----------------

[Jordan Coff](https://www.github.com/jcoff28 "Jordan Coff Github") 

Please create a Github issue if you have any questions, suggestions, or comments.
