//
//  VDDownloadManager.h
//  VDDownloader
//
//  Created by Harwyn T'an on 8/13/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDDownloadManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *downloadTasks;
@property (nonatomic, strong) NSMutableArray *tasksArr;

+ (instancetype)manager;

- (void)downloadTaskWithUrlstr:(NSString *)urlStr savePath:(NSString *)path success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock;

@end
