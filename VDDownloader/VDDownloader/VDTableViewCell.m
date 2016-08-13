//
//  VDTableViewCell.m
//  VDDownloader
//
//  Created by Harwyn T'an on 8/13/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import "VDTableViewCell.h"

@interface VDTableViewCell ()


@end

@implementation VDTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *title = [[UILabel alloc] init];
        _title = title;
        [self.contentView addSubview:title];
        UIProgressView *progressView = [[UIProgressView alloc] init];
        _progressView = progressView;
        [self.contentView addSubview:progressView];
        UIButton *pauseBtn = [[UIButton alloc] init];
        _pauseBtn = pauseBtn;
        [_pauseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_pauseBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:pauseBtn];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *title = [[UILabel alloc] init];
        _title = title;
        [self.contentView addSubview:title];
        UIProgressView *progressView = [[UIProgressView alloc] init];
        _progressView = progressView;
        [self.contentView addSubview:progressView];
        UIButton *pauseBtn = [[UIButton alloc] init];
        _pauseBtn = pauseBtn;
        [_pauseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_pauseBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:pauseBtn];
    }
    return self;
}

- (void)setModel:(VDCellModel *)model {
    _model = model;
//    self.tag = model.taskTag;
    self.title.text = model.title;
    self.progressView.progress = model.progress;
    if (!model.isPause) {
        self.pauseBtn.titleLabel.text = @"暂停";
    }
    else {
        self.pauseBtn.titleLabel.text = @"继续";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect kScreenBounds = [UIScreen mainScreen].bounds;
    self.title.frame = CGRectMake(0, 0, kScreenBounds.size.width - 50, 40);
    self.progressView.frame = CGRectMake(0, 40, kScreenBounds.size.width, 10);
    self.pauseBtn.frame = CGRectMake(CGRectGetMaxX(self.title.frame), 0, 30, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
