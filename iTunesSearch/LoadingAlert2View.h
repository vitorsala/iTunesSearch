//
//  LoadingAlert2View.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 15/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Classe criada com o intuito de tirar as limitações do UIAlertView, para a exibição de atividade.
 */
@interface LoadingAlert2View : UIView

@property UIView *subView;
@property UIActivityIndicatorView *activity;
@property UILabel *label;

-(instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text;
-(void)show;
-(void)hide;
@end
