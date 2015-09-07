//
//  JWIOSFileManager.m
//  iOSFileManager
//
//  Created by John Wong on 9/7/15.
//  Copyright (c) 2015 John Wong. All rights reserved.
//

#import "JWIOSFileManager.h"
#import "JWHTTPServer.h"
#import "JWFileListConnection.h"

#import <ifaddrs.h>
#import <arpa/inet.h>

@interface JWIOSFileManager()

@end

@implementation JWIOSFileManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _server = [[JWHTTPServer alloc] init];
        _server.port = 10000;
        _server.type = @"_ifm._tcp.";
        NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
        _server.documentRoot = webPath;
        _server.connectionClass = JWFileListConnection.class;
        _server.docRoot = NSHomeDirectory();
    }
    return self;
}

- (void)setPort:(UInt16)value {
    _server.port = value;
}

- (UInt16)port {
    return _server.listeningPort;
}

- (void)setType:(NSString *)value {
    _server.type = value;
}

- (NSString *)type {
    return _server.type;
}

- (void)start {
    NSError *error = nil;
    BOOL result = [_server start:&error];
    if (result) {
        NSLog(@"%@: %@", NSStringFromClass(self.class), [self accessUrl]);
    } else {
        NSLog(@"%@: %@", NSStringFromClass(self.class), error.description);
    }
}

- (NSString *)accessUrl {
    return [NSString stringWithFormat:@"http://%@:%@", [self.class ipAddress], @(self.port)];
}

+ (NSString *)ipAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end