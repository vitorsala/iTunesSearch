//
//  loadingAlert.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "LoadingAlert.h"


@implementation LoadingAlert {
    UIActivityIndicatorView *activity;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){

        activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.center = self.center;
        [self setValue:activity forKey:@"accessoryView"];

    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if(self){
        
        activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.transform = CGAffineTransformMakeScale(2, 2);
        activity.center = self.center;
        activity.layer.zPosition++;

        [self setValue:activity forKey:@"accessoryView"];
    }
    return self;
}

-(void)show{
    [activity startAnimating];
    [super show];
}


-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    [activity stopAnimating];
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

@end
