//
//  UIView+LayoutProperty.m
//  Facechat
//
//  Created by admin on 29/9/17.
//  Copyright © 2017年 广州美人信息技术有限公司. All rights reserved.
//

#import "UIView+LayoutProperty.h"

@implementation UIView (LayoutProperty)
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect oldFrame = self.frame;
    oldFrame.size = size;
    self.frame = oldFrame;
}

- (CGFloat)terminalX {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTerminalX:(CGFloat)terminalX {
    CGRect frame = self.frame;
    frame.origin.x = terminalX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)terminalY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTerminalY:(CGFloat)terminalY {
    CGRect frame = self.frame;
    frame.origin.y = terminalY - frame.size.height;
    self.frame = frame;
}

- (CGPoint)terminal {
    return CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
}

- (void)setTerminal:(CGPoint)terminal {
    CGRect frame = self.frame;
    frame.origin.x = terminal.x - frame.size.width;
    frame.origin.y = terminal.y - frame.size.height;
    self.frame = frame;
}
@end
