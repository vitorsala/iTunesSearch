//
//  infoViewController.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 12/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entity.h"
@interface infoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtPreco;
@property (weak, nonatomic) IBOutlet UITextField *txtPais;
@property (weak, nonatomic) IBOutlet UITextField *txtTipo;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
