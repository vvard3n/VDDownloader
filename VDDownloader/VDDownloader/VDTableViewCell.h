//
//  VDTableViewCell.h
//  VDDownloader
//
//  Created by Harwyn T'an on 8/13/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VDCellModel.h"

@interface VDTableViewCell : UITableViewCell

@property (nonatomic, strong) VDCellModel *model;

@property (nonatomic, weak)UILabel *title;
@property (nonatomic, weak)UIProgressView *progressView;
@property (nonatomic, weak)UIButton *pauseBtn;
@end
