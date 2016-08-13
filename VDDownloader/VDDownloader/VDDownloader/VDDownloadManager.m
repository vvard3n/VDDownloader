//
//  VDDownloadManager.m
//  VDDownloader
//
//  Created by Harwyn T'an on 8/13/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import "VDDownloadManager.h"
#import "VDDownloader.h"

@interface VDDownloadManager ()
@end

@implementation VDDownloadManager
//下载列表
- (NSMutableDictionary *)downloadTasks {
    if (!_downloadTasks) {
        _downloadTasks = [NSMutableDictionary dictionary];
    }
    return _downloadTasks;
}

- (NSMutableArray *)tasksArr {
    if (!_tasksArr) {
        _tasksArr = [NSMutableArray array];
    }
    return _tasksArr;
}

- (void)downloadTaskWithUrlstr:(NSString *)urlStr savePath:(NSString *)path success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock {
    VDDownloader *downloadTask = [VDDownloader downloadTaskWithUrlstr:urlStr savePath:path success:^{
        if(successBlock) {
            successBlock();
        }
    
    } progress:^(float progress) {
        if(progressBlock) {
            progressBlock(progress);
        }
    } error:^(NSError *error) {
        if(errorBlock) {
            errorBlock(error);
        }
    }];
    [self.tasksArr addObject:downloadTask];
    downloadTask.taskTag = self.tasksArr.count;
//    [self.downloadTasks setObject:downloadTask forKey:urlStr];NSLog(@"任务开始，添加到队列");
}

#pragma mark sharedDownloader
static id _sharedManager;
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[VDDownloadManager alloc] init];
    });
    return _sharedManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [super allocWithZone:zone];
    });
    return _sharedManager;
}
- (id)copyWithZone:(NSZone *)zone {
    return _sharedManager;
}

@end
