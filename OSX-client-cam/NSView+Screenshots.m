//
//  NSView+Screenshots.m
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

#import "NSView+Screenshots.h"

@implementation NSViewScreenshots

+(NSImage *)createFromLayer:(CALayer *)layer {
    NSImage *image = [[NSImage alloc] initWithSize:layer.frame.size];
    [image lockFocus];
    CGContextRef context = [NSGraphicsContext currentContext].graphicsPort;
    [layer renderInContext:context];
    [image unlockFocus];
    return image;
}

@end
