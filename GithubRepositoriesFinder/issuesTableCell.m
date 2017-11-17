//
//  issuesTableCell.m
//  GithubRepositoriesFinder
//
//  Created by JocTrejo on 16/11/17.
//  Copyright © 2017 JocTrejo. All rights reserved.
//

#import "issuesTableCell.h"

@implementation issuesTableCell

@synthesize loginLabel = _loginLabel;
@synthesize titleLabel = _titleLabel;
@synthesize bodyLabel = _bodyLabel;
@synthesize createdAt = _createdAt;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
