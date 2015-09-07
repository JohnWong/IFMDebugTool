//
//  JWFileListConnection.m
//  iOSFileManager
//
//  Created by John Wong on 9/5/15.
//  Copyright (c) 2015 John Wong. All rights reserved.
//

#import "JWFileListConnection.h"
#import "HTTPFileResponse.h"
#import "HTTPDynamicFileResponse.h"

@implementation JWFileListConnection

+ (NSArray *)fileList:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSString *fileName in [fileManager contentsOfDirectoryAtPath:path error:nil]) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        BOOL isDictionary;
        if ([fileManager fileExistsAtPath:absolutePath isDirectory:&isDictionary]) {
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            item[@"iden"] = absolutePath;
            item[@"name"] = fileName;
            if (isDictionary) {
                item[@"type"] = @"d";
                item[@"subs"] = [self fileList:absolutePath];
            } else {
                NSDictionary *attributes = [fileManager attributesOfItemAtPath:absolutePath error:nil];
                item[@"type"] = @"f";
                if (attributes.fileSize < 1024) {
                    item[@"size"] = [NSString stringWithFormat:@"%@B", @(attributes.fileSize)];
                } else if (attributes.fileSize < 1024 * 1024) {
                    item[@"size"] = [NSString stringWithFormat:@"%.1fKB", attributes.fileSize / 1024.0];
                } else {
                    item[@"size"] = [NSString stringWithFormat:@"%.1fMB", attributes.fileSize / 1024.0 / 1024.0];
                }
                
            }
            [mutableArray addObject:item];
        }
    }
    return [mutableArray copy];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    // Use HTTPConnection's filePathForURI method.
    // This method takes the given path (which comes directly from the HTTP request),
    // and converts it to a full path by combining it with the configured document root.
    //
    // It also does cool things for us like support for converting "/" to "/index.html",
    // and security restrictions (ensuring we don't serve documents outside configured document root folder).
    
    NSString *filePath = [self filePathForURI:path];
    
    // Convert to relative path
    
    NSString *documentRoot = [config documentRoot];
    
    
    if (![filePath hasPrefix:documentRoot])
    {
        // Uh oh.
        // HTTPConnection's filePathForURI was supposed to take care of this for us.
        return nil;
    }
    
    NSString *relativePath = [filePath substringFromIndex:[documentRoot length]];
    
    if ([relativePath isEqualToString:@"/index.html"] || [relativePath isEqualToString:@"/"])
    {
        NSArray *fileList = [self.class fileList:NSHomeDirectory()];
        NSData *json = [NSJSONSerialization dataWithJSONObject:fileList options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary *replacement = @{
                                      @"DATA": [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding]
                                      };
        return [[HTTPDynamicFileResponse alloc] initWithFilePath: filePath
                                                                                forConnection: self
                                                                                    separator: @"%%"
                                                                        replacementDictionary: replacement];
    }
    return [super httpResponseForMethod:method URI:path];
}

@end
