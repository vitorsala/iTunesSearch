//
//  Entity.h
//  iTunesSearch
//
//  Created by Vitor Kawai Sala on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface Entity : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *imgUrl;

@end
