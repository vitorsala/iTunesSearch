//
//  Podcast.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if(self){
        _artista = [dictionary objectForKey:@"artistName"];
        _colecao = [dictionary objectForKey:@"primaryGenreName"];
        self.tipo = NSLocalizedString(@"Podcast", "Categoria \"Podcast\"");
    }
    return self;

}
@end
