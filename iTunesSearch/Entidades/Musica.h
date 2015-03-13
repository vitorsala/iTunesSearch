//
//  Musica.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface Musica : Midia

@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *colecao;
@property (nonatomic, strong) NSString *numFaixas;
@property (nonatomic, strong) NSString *numDaFaixa;
@property (nonatomic, strong) NSString *data;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
