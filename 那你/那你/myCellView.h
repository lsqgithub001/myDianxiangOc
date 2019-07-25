//
//  myCellView.h
//  那你
//
//  Created by 灰常溜 on 2019/7/25.
//  Copyright © 2019 灰常溜. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface myCellView : NSTableCellView
@property (weak) IBOutlet NSImageView *myImage;
@property (weak) IBOutlet NSTextField *myLabel;

@end

NS_ASSUME_NONNULL_END
