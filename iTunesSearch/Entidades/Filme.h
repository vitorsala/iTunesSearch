//
//  Filme.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
@interface Filme : Entity

@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *duracao;
@property (nonatomic, strong) NSString *genero;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
