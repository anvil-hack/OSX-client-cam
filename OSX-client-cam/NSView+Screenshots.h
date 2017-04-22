//
//  NSView+Screenshots.h
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface NSViewScreenshots : NSObject

+(NSImage *)createFromLayer:(CALayer *)layer;

@end
