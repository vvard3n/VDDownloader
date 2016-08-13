//
//  VDDownloader.h
//  VDDownloader
//
//  Created by Harwyn T'an on 8/10/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, VDTaskStatus) {
    VDTaskStatusDownloading = 0,    //正在下载
    VDTaskStatusDownloaded = 1,         //已下载
    VDTaskStatusError = 1               //下载错误
};

@interface VDDownloader : NSObject
/**
 *  任务使用线程数量
 */
@property (nonatomic, assign) NSInteger threadUse;

/**
 *  进度
 */
@property (nonatomic, assign) float progress;
/**
 *  保存路径
 */
@property (nonatomic, copy) NSString *downloadPath;
/**
 *  任务状态
 */
@property (nonatomic, assign) VDTaskStatus taskStatus;
/**
 *  任务名
 */
@property (nonatomic, copy) NSString *taskTitle;

@property (nonatomic, assign) NSInteger taskTag;
- (void)downloadFileWithUrlstr:(NSString *)urlstr;
+ (instancetype)downloadTaskWithUrlstr:(NSString *)urlStr savePath:(NSString *)path success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock;
@end
