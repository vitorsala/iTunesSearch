//
//  LoadingAlert2View.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 15/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "LoadingAlert2View.h"

@implementation LoadingAlert2View


-(instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

        CGRect screen = [[UIScreen mainScreen]bounds];

        _subView = [[UIView alloc]initWithFrame:CGRectMake(25, 200, screen.size.width-50, 80)];
        _subView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _subView.layer.cornerRadius = 10;

        _label = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, _subView.bounds.size.width-10,20)];
        _label.text = text;
        _label.textAlignment = NSTextAlignmentCenter;
//        _label.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];

        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((screen.size.width/2)-30, 50, 10, 10)];
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activity.transform = CGAffineTransformMakeScale(2, 2);

        [_subView addSubview:_label];
        [_subView addSubview:_activity];
        [self addSubview:_subView];


        self.hidden = YES;
    }
    return self;
}

-(void)show{
    self.hidden = NO;
    [_activity startAnimating];
}

-(void)hide{
    self.hidden = YES;
    [_activity stopAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
