//
//  VDDownloadManager.h
//  VDDownloader
//
//  Created by Harwyn T'an on 8/13/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDDownloadManager : NSObject

+ (instancetype)manager;

- (void)downloadTaskWithUrlstr:(NSString *)urlStr success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock;

@end
