//
//  Command.h
//  OSX-client-cam
//
//  Created by Remi Robert on 23/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject

+ (void)analyse:(NSString *)path;
+ (void)speech:(NSString *)text;

@end
