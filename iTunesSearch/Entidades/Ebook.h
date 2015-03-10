//
//  Ebook.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ebook : NSObject

@property (nonatomic, strong) NSString *titulo;
@property (nonatomic, strong) NSString *autor;
@property (nonatomic, strong) NSString *descricao;
@property (nonatomic, strong) NSArray *generos;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *imgUrl;

@end
