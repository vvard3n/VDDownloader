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
#import "VDTableViewCell.h"
#import "VDCellModel.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger taskCount;
@property (nonatomic, strong) NSMutableDictionary *tasks;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 200;
    self.tableView.contentOffset = CGPointMake(0, -20);
    
//    [self.tableView registerClass:[VDTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSString *urlstr = @"http://sw.bos.baidu.com/sw-search-sp/software/797b4439e2551/QQ_mac_5.0.2.dmg";
    [[VDDownloadManager manager] downloadTaskWithUrlstr:urlstr savePath:@"/users/vvard3n/desktop/1.zip" success:^{
        NSLog(@"Done");
    } progress:^(float progress) {
        NSLog(@"%f",progress);
        
    } error:^(NSError *error) {
        NSLog(@"Error:%@",error);
    }];
    [[VDDownloadManager manager] downloadTaskWithUrlstr:urlstr savePath:@"/users/vvard3n/desktop/1.zip" success:^{
        NSLog(@"Done");
    } progress:^(float progress) {
        NSLog(@"%f",progress);
        
    } error:^(NSError *error) {
        NSLog(@"Error:%@",error);
    }];
}

- (NSInteger)taskCount {
    _taskCount = [VDDownloadManager manager].tasksArr.count;
    return _taskCount;
}

- (NSMutableDictionary *)tasks {
    _tasks = [VDDownloadManager manager].downloadTasks;
    return _tasks;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[VDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.tag = indexPath.row;
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    VDDownloader *downloader = (VDDownloader *)object;
    VDTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:downloader.taskTag-1 inSection:0]];
    VDCellModel *model = [[VDCellModel alloc] init];
    model.title = downloader.taskTitle;
    model.progress = downloader.progress;
    model.isPause = downloader.taskStatus;
    cell.model = model;
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[VDDownloadManager manager].tasksArr[indexPath.row] addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
