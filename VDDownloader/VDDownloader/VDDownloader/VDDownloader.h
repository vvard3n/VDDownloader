//
//  VDDownloader.h
//  VDDownloader
//
//  Created by Harwyn T'an on 8/10/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  任务状态枚举
 */
//NS_ENUM(NSInteger, VDTaskStatus) {
//    /**
//     *  正在下载
//     */
//    VDTaskStatusDownloading = 0,
//    /**
//     *  已下载
//     */
//    VDTaskStatusDownloaded,
//    /**
//     *  下载错误
//     */
//    VDTaskStatusError
//};

@interface VDDownloader : NSObject
/**
 *  任务使用线程数量
 */
@property (nonatomic, assign) NSInteger threadUse;
/**
 *  保存路径
 */
@property (nonatomic, copy) NSString *downloadPath;
/**
 *  任务状态
 */
//@property (nonatomic, assign) VDTaskStatus taskStatus;
- (void)downloadFileWithUrlstr:(NSString *)urlstr;
+ (instancetype)downloadTaskWithUrlstr:(NSString *)urlStr success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock;
@end
