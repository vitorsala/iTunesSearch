//
//  infoViewController.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 12/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "infoViewController.h"
#import "Entidades/Ebook.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "iTunesManager.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *midias = [[iTunesManager sharedInstance] midias];
    NSIndexPath *indexPath = [[iTunesManager sharedInstance] indexPath];

    Midia *midia = [[midias objectForKey:[[midias allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    NSURL *url = [NSURL URLWithString:midia.imgUrl];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];

    _txtNome.text = midia.nome;
    _txtPais.text = midia.pais;
    _txtPreco.text = [NSString stringWithFormat:@"%@", midia.preco ];
    _txtTipo.text = midia.tipo;
    _imgView.image = img;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
