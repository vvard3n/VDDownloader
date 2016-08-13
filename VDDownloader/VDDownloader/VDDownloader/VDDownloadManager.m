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
@property (nonatomic, strong) NSMutableArray *downloadTasks;
@end

@implementation VDDownloadManager
//下载列表
- (NSMutableArray *)downloadTasks {
    if (!_downloadTasks) {
        _downloadTasks = [NSMutableArray array];
    }
    return _downloadTasks;
}

- (void)downloadTaskWithUrlstr:(NSString *)urlStr success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock {
    VDDownloader *downloadTask = [VDDownloader downloadTaskWithUrlstr:urlStr success:^{
        if(successBlock) {
//            [self.downloadTasks removeObject:downloadTask];
            successBlock();
        }
    } progress:^(float progress) {
        if(progressBlock) {
            progressBlock(progress);
        }
    } error:^(NSError *error) {
        if(errorBlock) {
//            [self.downloadTasks removeObject:downloadTask];
            errorBlock(error);
        }
    }];
    [self.downloadTasks addObject:downloadTask];
    NSLog(@"任务开始，添加到队列");
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
