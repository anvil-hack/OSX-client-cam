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

+ (NSString *)save:(NSImage *)image {
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];

    NSString *path = [NSString stringWithFormat:@"/Users/remirobert/dev/mobility-api/files/%@", [[NSUUID UUID] UUIDString]];
    [imageData writeToFile:path atomically: NO];
    return path;
}

@end
