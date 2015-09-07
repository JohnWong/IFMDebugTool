//
//  JWHTTPServer.m
//  iOSFileManager
//
//  Created by John Wong on 9/7/15.
//  Copyright (c) 2015 John Wong. All rights reserved.
//

#import "JWHTTPServer.h"
#import "JWHTTPConfig.h"

@implementation JWHTTPServer

- (JWHTTPConfig *)config {
    JWHTTPConfig *config = [[JWHTTPConfig alloc] initWithServer:self documentRoot:documentRoot queue:connectionQueue];
    config.docRoot = _docRoot;
    return config;
}

@end
