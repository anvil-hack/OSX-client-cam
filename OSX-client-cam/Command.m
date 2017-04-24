//
//  Command.m
//  OSX-client-cam
//
//  Created by Remi Robert on 23/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

#import "Command.h"

@implementation Command

+ (void)analyse:(NSString *)path {
    NSLog(@"path : %@", path);
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/local/bin/python"];
    [task setArguments:@[@"/Users/remirobert/dev/mobility-api/image-learning/amazonwebbucket.py", path]];
    [task launch];
}

+ (void)speech:(NSString *)text {
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/say"];
    [task setArguments:@[text]];
    [task launch];
}

@end
