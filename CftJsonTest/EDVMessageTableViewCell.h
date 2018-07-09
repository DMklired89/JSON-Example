//
//  MessageTableViewCell.h
//  CftJsonTest
//
//  Created by Dmitry Edrenov on 03.06.18.
//  Copyright © 2018 Dmitry Edrenov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDVMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageFromURL;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateMessageLabel;

@end
