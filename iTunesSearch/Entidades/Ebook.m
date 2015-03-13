//
//  Ebook.m
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Ebook.h"

@implementation Ebook
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if(self){
        _autor = [dictionary objectForKey:@"artistName"];
        _descricao = [dictionary objectForKey:@"description"];
        _generos = [dictionary objectForKey:@"genres"];
        self.tipo = NSLocalizedString(@"Ebook", "Categoria \"Ebook\"");
    }
    return self;
}
@end
