//
//  ViewController.m
//  VDDownloader
//
//  Created by Harwyn T'an on 8/10/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import "ViewController.h"
#import "VDDownloader/VDDownloader.h"
#import "VDDownloader/VDDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[VDDownloadManager manager] downloadTaskWithUrlstr:@"http://192.168.28.89/sogou.zip" success:^{
        NSLog(@"Done");
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    } error:^(NSError *error) {
        NSLog(@"Error:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
