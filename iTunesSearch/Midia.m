//
//  Entity.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Midia.h"

@implementation Midia

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        _nome = [dictionary objectForKey:@"trackName"];
        _trackId = [dictionary objectForKey:@"trackId"];
        _data = [dictionary objectForKey:@"releaseDate"];
        _pais = [dictionary objectForKey:@"country"];
        _preco = [dictionary objectForKey:@"trackPrice"];
        _imgUrl = [dictionary objectForKey:@"artworkUrl60"];
    }
    return self;
}

@end
