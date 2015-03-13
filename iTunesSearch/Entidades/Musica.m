//
//  Musica.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Musica.h"

@implementation Musica
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if(self){
        _artista = [dictionary objectForKey:@"artistName"];
        _numFaixas = [dictionary objectForKey:@"trackCount"];
        _numDaFaixa = [dictionary objectForKey:@"trackNumber"];
        _colecao = [dictionary objectForKey:@"collectionName"];
        self.tipo = NSLocalizedString(@"Music", "Categoria \"Musica\"");
    }
    return self;
}
@end
