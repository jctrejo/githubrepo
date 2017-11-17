//
//  customTableCell.m
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import "customTableCell.h"

@implementation customTableCell

    @synthesize nameLabel = _nameLabel;
    @synthesize descLabel = _descLabel;
    @synthesize watchersLabel = _watchersLabel;
    @synthesize dateLabel = _dateLabel;
    @synthesize avatarRepo = _avatarRepo;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
