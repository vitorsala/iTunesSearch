//
//  Podcast.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Podcast : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *colecao;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *imgUrl;

@end
