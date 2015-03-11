//
//  Podcast.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface Podcast : Entity

@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *colecao;
@property (nonatomic, strong) NSString *data;

@end
