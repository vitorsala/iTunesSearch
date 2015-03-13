//
//  Podcast.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface Podcast : Midia

@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *colecao;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
