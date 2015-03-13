//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Ebook.h"
#import "Entidades/Podcast.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

/*!
 keys: "filmes", "musicas", "ebooks", "podcasts"
 */

- (void)buscarMidias:(NSString *)termo {
    _midias = [[NSMutableDictionary alloc] init];
    if (!termo) {
        termo = @"";
    }

    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];

    if(jsonData == nil){
        NSLog(@"Erro ao receber dados do JsonData");
        [_notifCenter postNotificationName:@"iTunesManagerDisFinishedSearch" object:self userInfo:_midias];
        return;
    }
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];

    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return;
    }

    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    NSMutableArray *ebooks = [[NSMutableArray alloc] init];
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];

    // Definição do bloco de atribuição de dados compartilhados

    for (NSDictionary *item in resultados) {
        if([[item objectForKey:@"kind"]isEqualToString:@"feature-movie"]){
            Filme *filme = [[Filme alloc] initWithDictionary:item];

            [filmes addObject:filme];
        }
        if([[item objectForKey:@"kind"]isEqualToString:@"ebook"]){
            Ebook *ebook = [[Ebook alloc] initWithDictionary:item];

            [ebooks addObject:ebook];
        }
        if([[item objectForKey:@"kind"]isEqualToString:@"song"]){
            Musica *musica = [[Musica alloc] initWithDictionary:item];

            [musicas addObject:musica];
        }
        if([[item objectForKey:@"kind"]isEqualToString:@"podcast"]){
            Podcast *podcast = [[Podcast alloc] initWithDictionary:item];

            [podcasts addObject:podcast];
        }
    }
    if([filmes count]>0)    [_midias setObject:filmes forKey:@"filmes"];
    if([musicas count]>0)    [_midias setObject:musicas forKey:@"musicas"];
    if([ebooks count]>0)    [_midias setObject:ebooks forKey:@"ebooks"];
    if([podcasts count]>0)    [_midias setObject:podcasts forKey:@"podcasts"];

    [_notifCenter postNotificationName:@"iTunesManagerDisFinishedSearch" object:self userInfo:_midias];
    return;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    _notifCenter = [NSNotificationCenter defaultCenter];
    return self;
}


@end
