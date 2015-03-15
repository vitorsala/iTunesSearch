//
//  TableViewCell.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLabelHidden:(BOOL)hidden{
    _label01.hidden = hidden;
    _label02.hidden = hidden;
    _label03.hidden = hidden;
    _label04.hidden = hidden;
    _label05.hidden = hidden;
}

-(void)setLabelValues:(NSString *)label1 :(NSString *)label2 :(NSString *)label3 :(NSString *)label4 :(NSString *)label5{
    _label01.text = label1;
    _label02.text = label2;
    _label03.text = label3;
    _label04.text = label4;
    _label05.text = label5;
}

@end
