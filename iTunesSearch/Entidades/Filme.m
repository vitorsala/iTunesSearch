//
//  Filme.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Filme.h"

@implementation Filme
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if(self){
        _artista = [dictionary objectForKey:@"artistName"];
        _duracao = [dictionary objectForKey:@"trackTimeMillis"];
        _genero = [dictionary objectForKey:@"primaryGenreName"];
        self.tipo = NSLocalizedString(@"Movie", "Categoria \"Filme\"");
    }
    return self;
}
@end
