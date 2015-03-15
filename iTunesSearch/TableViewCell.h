//
//  TableViewCell.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UILabel *preco;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label01;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label03;
@property (weak, nonatomic) IBOutlet UILabel *label04;
@property (weak, nonatomic) IBOutlet UILabel *label05;

-(void)setLabelHidden:(BOOL)hidden;

-(void)setLabelValues:(NSString *)label1 :(NSString *)label2 :(NSString *)label3 :(NSString *)label4 :(NSString *)label5;

@end
