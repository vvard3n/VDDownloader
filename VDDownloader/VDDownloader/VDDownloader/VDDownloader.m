//
//  VDDownloader.m
//  VDDownloader
//
//  Created by Harwyn T'an on 8/10/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import "VDDownloader.h"

@interface VDDownloader () <NSURLSessionDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableData *downloadedData;
@property (nonatomic, assign) long long expectedContentLength;
@property (nonatomic, assign) long long currentTotalLength;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSOutputStream *stream;
@property (nonatomic, copy) void(^successBlock)();
@property (nonatomic, copy) void(^progressBlock)(float progress);
@property (nonatomic, copy) void(^errorBlock)(NSError *error);
@end

@implementation VDDownloader

+ (instancetype)downloadTaskWithUrlstr:(NSString *)urlStr success:(void(^)())successBlock progress:(void(^)(float progress))progressBlock error:(void(^)(NSError *error))errorBlock {
    VDDownloader *downloadTask = [[VDDownloader alloc] init];
    [downloadTask downloadFileWithUrlstr:urlStr];
    downloadTask.successBlock = successBlock;
    downloadTask.progressBlock = progressBlock;
    downloadTask.errorBlock = errorBlock;
    return downloadTask;
}

//下载路径，默认为Sandbox
- (NSString *)downloadPath {
    if (!_downloadPath) {
//        _downloadPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _downloadPath = @"/users/vvard3n/desktop/123.zip";
    }
    return _downloadPath;
}

//下载主方法
- (void)downloadFileWithUrlstr:(NSString *)urlstr {
    
    
    NSURL *url = [NSURL URLWithString:urlstr];
    [self getServerHeadWithUrl:url];
    VDDownloadStatus downloadStatus = [self getDownloadStatus];
    if (downloadStatus == VDDownloadStatusDone) {
        NSLog(@"File already exists");
        return;
    }
    [self breakPointWithResumeData:url];
}
/*
 typedef enum : NSInteger {
 VDDownloadStatusDone = -1,
 VDDownloadStatusNone = 0,
 VDDownloadStatusDownloading = 1
 } VDDownloadStatus;
 */
typedef NS_ENUM(NSInteger, VDDownloadStatus) {
    VDDownloadStatusDone        = -1,
    VDDownloadStatusError       = 0,
    VDDownloadStatusNone        = 0,
    VDDownloadStatusDownloading = 1
};

//获取断点续传状态
- (long long)getDownloadStatus {
    //    long long statusNone = VDDownloadStatusNone;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *localFileInfo =[fileManager attributesOfItemAtPath:self.downloadPath error:nil];
    long long localFileSize = localFileInfo.fileSize;
    if (self.expectedContentLength > localFileSize) {
        return localFileSize;
    }
    else if (self.expectedContentLength == localFileSize) {
        return VDDownloadStatusDone;
    }
    else {
        [fileManager removeItemAtPath:self.downloadPath error:nil];
        return VDDownloadStatusError;
    }
    return 0;
}

//断点续传
- (void)breakPointWithResumeData:(NSURL *)url {
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    mutableRequest.HTTPMethod = @"GET";
    [mutableRequest setValue:[NSString stringWithFormat:@"bytes=%lld-", self.currentTotalLength] forHTTPHeaderField:@"Range"];
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        self.connection = [NSURLConnection connectionWithRequest:mutableRequest delegate:self];
        [[NSRunLoop currentRunLoop]run];
    }];
    /*
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    [[session downloadTaskWithRequest:mutableRequest] resume];
     */
}

//从服务器获取文件大小
- (void)getServerHeadWithUrl:(NSURL *)url {
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    mutableRequest.HTTPMethod = @"HEAD";
    NSURLResponse *response;
    [NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:&response error:nil];
    self.expectedContentLength = response.expectedContentLength;
}

#pragma mark NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"VDDownloader--------- Get Response");
    self.stream = [NSOutputStream outputStreamToFileAtPath:self.downloadPath append:YES];
    [self.stream open];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    self.currentTotalLength += data.length;
    float progress = (float)self.currentTotalLength / self.expectedContentLength;
//    NSLog(@"Get Data --- %lu byte\t--- %.2f%%", data.length, progress * 100);
    [self.stream write:data.bytes maxLength:data.length];
    self.progressBlock(progress);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.successBlock();
    NSLog(@"VDDownloader--------- Did Finish Download");
    [self.stream close];
}

@end
