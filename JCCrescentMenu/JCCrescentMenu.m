//
//  JCCrescentMenu.m
//  JCCrescentMenu
//
//  Created by Jordan Coff on 12/16/15.
//  Copyright © 2015 Jordan Coff. All rights reserved.
//


#import "JCCrescentMenu.h"

@implementation JCCrescentMenu {
    UIButton* _closeMenuButton;
    UIButton* _openMenuButton;
   
    UIButton* _centerButton;
    UIView* _crescentContainerView;
    
    NSMutableArray* _buttons;
    
    //The x and y values that the frame of the crescent view can be set to to put it just off screen
    CGFloat _hideDistance;
    CGRect _crescentViewOpenRect;
    CGRect _crescentViewClosedRect;
    CGRect _toggleOpenRect;
    CGRect _toggleClosedRect;
    BOOL _menuOpen;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    
    //Set values to 0. If a user sets it to something else between now and the view loading, those values will be used, otherwise they will be set to defaults in initializeViews.
    _crescentButtonSize = 0;
    _centerButtonSize = 0;
    _centerButtonPadding = -1;
    _toggleButtonSize = 0;
    _crescentButtonDistanceFromEdgeToCenter = 0;
    _corner = JCCrescentMenuCornerBottomRight;
}

-(void) initializeView {

    if (_crescentButtonSize <= 0) {
        _crescentButtonSize = 60;
    }
    if (_toggleButtonSize <= 0) {
        _toggleButtonSize = 50;
    }
    if (_centerButtonSize <= 0) {
        _centerButtonSize = self.frame.size.width / 2.;
    }
    
    if (_crescentButtonDistanceFromEdgeToCenter <= 0) {
        _crescentButtonDistanceFromEdgeToCenter = _crescentButtonSize/2. + 10;
    }
    
    _menuOpen = NO;
    _buttons = [NSMutableArray new];
    self.animationDuration = .5;
    _hideDistance = sqrtf((self.frame.size.width * self.frame.size.width / 2.));
    
    
    
    if (_corner == JCCrescentMenuCornerBottomRight) {
        _crescentViewClosedRect = CGRectMake(_hideDistance, _hideDistance, self.frame.size.width * 2., self.frame.size.height * 2.);
        _crescentViewOpenRect = CGRectMake(0, 0, self.frame.size.width * 2., self.frame.size.height * 2.);
    }
    else if (_corner == JCCrescentMenuCornerBottomLeft) {
        _crescentViewClosedRect = CGRectMake((-1* self.frame.size.width) - _hideDistance,_hideDistance, self.frame.size.width * 2., self.frame.size.height * 2.);
        _crescentViewOpenRect = CGRectMake(-1*self.frame.size.width, 0, self.frame.size.width * 2., self.frame.size.height * 2.);
    }
    else if (_corner == JCCrescentMenuCornerTopRight) {
        _crescentViewClosedRect = CGRectMake(_hideDistance, (-1)*self.frame.size.height - _hideDistance, self.frame.size.width * 2., self.frame.size.height * 2.);
        _crescentViewOpenRect = CGRectMake(0, -1*self.frame.size.height, self.frame.size.width * 2., self.frame.size.height * 2.);
    }
    else if (_corner == JCCrescentMenuCornerTopLeft) {
        _crescentViewClosedRect = CGRectMake(-1*self.frame.size.width - _hideDistance, -1*self.frame.size.height - _hideDistance, self.frame.size.width * 2., self.frame.size.height * 2.);
        _crescentViewOpenRect = CGRectMake(-1*self.frame.size.width, -1*self.frame.size.height, self.frame.size.width * 2., self.frame.size.height * 2.);
    }
    
    _crescentContainerView = [[UIView alloc] initWithFrame:_crescentViewClosedRect];
    
    
    [_crescentContainerView.layer setCornerRadius:self.frame.size.width];
    //[_crescentContainerView setBackgroundColor:[UIColor colorWithRed:36./255. green:57./255. blue:71./255. alpha:.75]];
    [self addSubview:_crescentContainerView];
    [self bringSubviewToFront:_crescentContainerView];

    
    [self reloadToggleButton:NO];
    
    [self reloadCenterButton:NO];
    
    [self reloadCrescentButtonsAnimated:NO];
}

//-(void)insertButton:(UIButton*) button atIndex:(int) index animated:(BOOL) animated {
//    [_buttons insertObject:button atIndex:index];
//    [self placeButtonsAnimated:animated];
//}
//-(void)removeButtonAtIndex:(int) index animated:(BOOL) animated{
//    [_buttons[index] removeFromSuperview];
//    [_buttons removeObjectAtIndex:index];
//    [self placeButtonsAnimated:animated];
//}

-(void)reloadToggleButton:(BOOL) animated {
    CGFloat xOrigin = isCornerLeft(_corner) ? 0 : self.frame.size.width - _toggleButtonSize;
    CGFloat yOrigin = isCornerTop(_corner) ? 0 : self.frame.size.height - _toggleButtonSize;
    
    _toggleClosedRect = CGRectMake(xOrigin, yOrigin, _toggleButtonSize, _toggleButtonSize);
    _toggleOpenRect = CGRectMake(isCornerLeft(_corner) ? xOrigin + _hideDistance : xOrigin - _hideDistance, isCornerTop(_corner) ? yOrigin + _hideDistance : yOrigin - _hideDistance, _toggleButtonSize, _toggleButtonSize);
    
    if ([_dataSource respondsToSelector:@selector(closeButtonForCrescentMenu:)]) {
        _closeMenuButton = [_dataSource closeButtonForCrescentMenu:self];
    }
    else {
        _closeMenuButton = [[UIButton alloc] initWithFrame:_toggleClosedRect];
        [_closeMenuButton setImage:[UIImage imageNamed:@"close_menu_iphone"] forState:UIControlStateNormal];
        [_closeMenuButton addTarget:self action:@selector(toggleMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeMenuButton];
        [_closeMenuButton setHidden:YES];
    }
    
    if ([_dataSource respondsToSelector:@selector(openButtonForCrescentMenu:)]) {
        _openMenuButton = [_dataSource openButtonForCrescentMenu:self];
    }
    else {
        _openMenuButton = [[UIButton alloc] initWithFrame:_toggleClosedRect];
        [_openMenuButton setImage:[UIImage imageNamed:@"open_menu_iphone"] forState:UIControlStateNormal];
        [_openMenuButton addTarget:self action:@selector(toggleMenu:) forControlEvents:UIControlEventTouchUpInside];
        [_openMenuButton setHidden:NO];
        [self addSubview:_openMenuButton];
    }
    if (_corner == JCCrescentMenuCornerTopLeft) {
        _openMenuButton.transform = CGAffineTransformMakeRotation(M_PI);
        _closeMenuButton.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else if (_corner == JCCrescentMenuCornerBottomLeft) {
        _openMenuButton.transform = CGAffineTransformMakeRotation(M_PI_2);
        _closeMenuButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else if (_corner == JCCrescentMenuCornerTopRight) {
        _openMenuButton.transform = CGAffineTransformMakeRotation((-1)*M_PI_2);
        _closeMenuButton.transform = CGAffineTransformMakeRotation((-1)*M_PI_2);
    }
    
    [self bringSubviewToFront:_openMenuButton];
    [self bringSubviewToFront:_closeMenuButton];
}

-(void)reloadCenterButton:(BOOL)animated {
    if ([_dataSource respondsToSelector:@selector(centerButtonForCrescentMenu:)]) {
        [self setCenterButton:[_dataSource centerButtonForCrescentMenu:self]];
    }
    else {
        UIButton* cb = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - _centerButtonSize - 5, self.frame.size.height - _centerButtonSize - 5, _centerButtonSize, _centerButtonSize)];
        [cb.layer setCornerRadius:_centerButtonSize/2.];
        [self setCenterButton:cb];
    }
}

-(void)reloadCrescentButtonsAnimated:(BOOL) animated {
    NSArray* subViews = _crescentContainerView.subviews;
    
    for (int i = 0; i < [subViews count]; i++) {
        UIView* view = subViews[i];
        if (view.tag >= 100 && view.tag < 200) {
            [view removeFromSuperview];
            view = nil;
        }
    }
    
    int numButtons = [_dataSource numberOfButtonsInCrescentMenu:self];
    [UIView animateWithDuration:animated ? .5:0. animations:^{
        for (int i = 0; i < numButtons; i++) {
            UIButton* b = [_dataSource crescentMenu:self buttonAtIndex:i];
            b.tag = 100 + i;
            NSAssert(b.frame.size.height == b.frame.size.width, @"Buttons must have a square frame");
            [b addTarget:self action:@selector(crescentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            CGPoint origin = [self positionForButtonAtIndex:i];
            [b setFrame:CGRectMake(origin.x, origin.y, _crescentButtonSize, _crescentButtonSize)];
            b.layer.cornerRadius = _crescentButtonSize/2.;
            [_crescentContainerView addSubview:b];
            [_crescentContainerView bringSubviewToFront:b];
            [_buttons addObject:b];
        }
    }];
}

-(void)setCenterButton:(UIButton *)centerButton {
    if (_centerButton) {
        [_centerButton removeFromSuperview];
    }
    if (_centerButtonPadding < 0) {
        _centerButtonPadding = 5;
    }
    
    _centerButton = centerButton;
    
    CGFloat xOrigin;// = isCornerLeft(_corner) ? _centerButtonPadding : self.frame.size.width - _centerButtonSize - _centerButtonPadding;
    CGFloat yOrigin;// = isCornerTop(_corner) ? _centerButtonPadding : self.frame.size.height - _centerButtonSize - _centerButtonPadding;
    if (_corner == JCCrescentMenuCornerBottomRight) {
        xOrigin = self.frame.size.width - _centerButtonSize - _centerButtonPadding;
        yOrigin = self.frame.size.height - _centerButtonSize - _centerButtonPadding;
    }
    else if (_corner == JCCrescentMenuCornerBottomLeft) {
        xOrigin = self.frame.size.width + _centerButtonPadding;
        yOrigin = self.frame.size.height - _centerButtonSize - _centerButtonPadding;
    }
    else if (_corner == JCCrescentMenuCornerTopRight) {
        xOrigin = self.frame.size.width - _centerButtonSize - _centerButtonPadding;
        yOrigin = self.frame.size.height + _centerButtonPadding;
    }
    else if (_corner == JCCrescentMenuCornerTopLeft) {
        xOrigin = self.frame.size.width + _centerButtonPadding;
        yOrigin = self.frame.size.height + _centerButtonPadding;
    }

    
    
    
    
    //CGFloat xOrigin = isCornerLeft(_corner) ? _centerButtonPadding : self.frame.size.width - _centerButtonSize - _centerButtonPadding;
    //CGFloat yOrigin = isCornerTop(_corner) ? _centerButtonPadding : self.frame.size.height - _centerButtonSize - _centerButtonPadding;
    
    [_centerButton setFrame:CGRectMake(xOrigin, yOrigin, _centerButtonSize, _centerButtonSize)];
    [_centerButton addTarget:self action:@selector(centerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _centerButton.layer.cornerRadius = _centerButtonSize/2.;
    [_crescentContainerView addSubview:_centerButton];
    [_crescentContainerView bringSubviewToFront:_centerButton];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    [_crescentContainerView setBackgroundColor:backgroundColor];
}

-(BOOL)isMenuOpen {
    return _menuOpen;
}

-(void) toggleMenu:(UIButton*) sender {
    //CGRect toggleButtonRect;
    //CGRect crescentViewRect;
    
    
    
    if (_menuOpen) { //close it
        if ([_delegate respondsToSelector:@selector(crescentMenuWillClose:)]) {
            [_delegate crescentMenuWillClose:self];
        }
        
        //CGFloat xOrigin = isCornerLeft(_corner) ? 0 : self.frame.size.width - _toggleButtonSize;
        //CGFloat yOrigin = isCornerTop(_corner) ? 0 : self.frame.size.height - _toggleButtonSize;
        
        //toggleButtonRect = CGRectMake(xOrigin, yOrigin, _toggleButtonSize, _toggleButtonSize);
        //crescentViewRect = CGRectMake(_hideDistance, _hideDistance, _crescentContainerView.frame.size.width, _crescentContainerView.frame.size.height);
    }
    else {
        if ([_delegate respondsToSelector:@selector(crescentMenuWillOpen:)]) {
            [_delegate crescentMenuWillOpen:self];
        }
        
        //CGFloat xOrigin = isCornerLeft(_corner) ? 0 : self.frame.size.width - _toggleButtonSize;
        //CGFloat yOrigin = isCornerTop(_corner) ? 0 : self.frame.size.height - _toggleButtonSize;
        
        //toggleButtonRect = CGRectMake(self.frame.size.width - _toggleButtonSize - _hideDistance, self.frame.size.height - _toggleButtonSize - _hideDistance, _toggleButtonSize, _toggleButtonSize);
        //crescentViewRect = CGRectMake(0, 0, _crescentContainerView.frame.size.width, _crescentContainerView.frame.size.height);
    }
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        [_openMenuButton setFrame:_menuOpen ? _toggleClosedRect : _toggleOpenRect];
        [_closeMenuButton setFrame:_menuOpen ? _toggleClosedRect : _toggleOpenRect];
        [_openMenuButton setHidden:!_menuOpen];
        [_closeMenuButton setHidden:_menuOpen];
        
        [_crescentContainerView setFrame:_menuOpen ? _crescentViewClosedRect : _crescentViewOpenRect];
    } completion:^(BOOL finished) {
        _menuOpen = !_menuOpen;
        if (_menuOpen && [_delegate respondsToSelector:@selector(crescentMenuDidOpen:)]) {
            [_delegate crescentMenuDidOpen:self];
        }
        else if (!_menuOpen && [_delegate respondsToSelector:@selector(crescentMenuDidClose:)]) {
                [_delegate crescentMenuDidClose:self];
        }
    }];
}

-(void)openMenu {
    if (!_menuOpen) [self toggleMenu:nil];
}

-(void)closeMenu {
    if (_menuOpen) [self toggleMenu:nil];
}

-(void)centerButtonPressed:(UIButton*)sender {
    NSLog(@"center button pressed");
    if ([_delegate respondsToSelector:@selector(crescentMenu:didPressCenterButton:)]) {
        [_delegate crescentMenu:self didPressCenterButton:sender];
    }
}

-(void)crescentButtonPressed:(UIButton*)sender {
    int index = -1;
    for (int i = 0; i < [_buttons count]; i++) {
        if ([_buttons[i] isEqual:sender]) {
            index = i;
            break;
        }
    }
    if (index == -1) {
        NSLog(@"COULDN'T FIND THE BUTTON. HAD TO USE THE INDEX FROM THE TAG VALUE");
        index = (int)sender.tag - 100;
    }
    if ([_delegate respondsToSelector:@selector(crescentMenu:didPressButton:atIndex:)]) {
        [_delegate crescentMenu:self didPressButton:sender atIndex:index];
    }
    
}

-(CGPoint) positionForButtonAtIndex:(int) index {
    int numberOfButtons = [_dataSource numberOfButtonsInCrescentMenu:self];
    CGFloat w = self.frame.size.width;
    
    CGFloat r = w - _crescentButtonDistanceFromEdgeToCenter;
    CGFloat buttonTheta = 2 * (asinf((_crescentButtonSize/2.) / r));
    
    CGFloat spaceTheta = (M_PI_2 - (buttonTheta * numberOfButtons)) / (numberOfButtons + 1.);
    
    CGFloat theta = (index+1.)*spaceTheta + (index * buttonTheta) + buttonTheta / 2;
    
    NSAssert(spaceTheta >= 0, @"Buttons are too big or you have too many");
    
    //CGFloat theta = (M_PI * (float)(index+1.)) / (float)((numberOfButtons + 1.) * 2.);
    
    CGFloat x = r * cosf(theta);// + _crescentButtonSize/2.;
    CGFloat y = r * sinf(theta);// + _crescentButtonSize/2.;
    
    
    CGPoint p;
    if (_corner == JCCrescentMenuCornerBottomRight) {
        NSLog(@"here");
        //p = CGPointMake(w-x, w-y);
        p = CGPointMake(w-x - _crescentButtonSize/2., w-y - _crescentButtonSize/2.);
    }
    else if (_corner == JCCrescentMenuCornerBottomLeft) {
        p = CGPointMake(w + y- _crescentButtonSize/2., w-x- _crescentButtonSize/2.);
    }
    else if (_corner == JCCrescentMenuCornerTopRight) {
        p = CGPointMake(w - y - _crescentButtonSize/2., w+x - _crescentButtonSize/2.);
    }
    else if (_corner == JCCrescentMenuCornerTopLeft) {
        p = CGPointMake(w+x - _crescentButtonSize/2., w+y- _crescentButtonSize/2.);
    }
    
    return p;
    
    
//    CGFloat radius = self.frame.size.width;
//    CGFloat sin = sinf(theta);
//    CGFloat cos = cosf(theta);
//    CGPoint pointAlongEdge = CGPointMake(radius - radius * cos, radius - radius * sin);
//    CGFloat dY = sin * _crescentButtonDistanceFromEdgeToCenter;
//    CGFloat dX = cos * _crescentButtonDistanceFromEdgeToCenter;
//    CGPoint ret = CGPointMake(pointAlongEdge.x + dX - _crescentButtonSize/2., pointAlongEdge.y + dY - _crescentButtonSize/2.);
//    
//    //NSLog(@"%d) %@", index, NSStringFromCGPoint(ret));
//    return ret;
}

bool isCornerLeft(JCCrescentMenuCorner corner) {
    return corner == JCCrescentMenuCornerBottomLeft || corner == JCCrescentMenuCornerTopLeft;
}

bool isCornerTop(JCCrescentMenuCorner corner) {
    return corner == JCCrescentMenuCornerTopLeft || corner == JCCrescentMenuCornerTopRight;
}

/*
 If the menu is closed, only respond to the touch event if it's
 on the toggleMenuButton
 */
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (_menuOpen) {
        return [super hitTest:point withEvent:event];
    }
    else {
        CGPoint subPoint = [_openMenuButton convertPoint:point fromView:self];
        return [_openMenuButton hitTest:subPoint withEvent:event];
    }
}

@end

