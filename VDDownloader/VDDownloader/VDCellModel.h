//
//  VDCellModel.h
//  VDDownloader
//
//  Created by Harwyn T'an on 8/13/16.
//  Copyright © 2016 vvard3n. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) BOOL *isPause;
@property (nonatomic, assign) NSInteger *taskTag;

@end
