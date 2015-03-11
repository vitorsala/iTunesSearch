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
- (NSDictionary *)buscarMidias:(NSString *)termo {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    if (!termo) {
        termo = @"";
    }

    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];

    if(jsonData == nil){
        NSLog(@"Erro ao receber dados do JsonData");
        return result;
    }
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];

    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return result;
    }

    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    NSMutableArray *ebooks = [[NSMutableArray alloc] init];
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];

    // Definição do bloco de atribuição de dados compartilhados
    void (^sharedInfo)(Entity*,NSDictionary *) = ^(Entity *e, NSDictionary *r){
        [e setNome:[r objectForKey:@"trackName"]];
        [e setTrackId:[r objectForKey:@"trackId"]];
        [e setData:[r objectForKey:@"releaseDate"]];
        [e setPais:[r objectForKey:@"country"]];
        [e setImgUrl:[r objectForKey:@"artworkUrl60"]];
    };

    for (NSDictionary *item in resultados) {
        if([[item objectForKey:@"kind"]isEqualToString:@"feature-movie"]){
            Filme *filme = [[Filme alloc] init];

            sharedInfo(filme,item); // Executa o bloco para atribuir dados semelhantes.

            [filme setArtista:[item objectForKey:@"artistName"]];
            [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [filme setPreco:[item objectForKey:@"trackPrice"]];
            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setTipo:NSLocalizedString(@"Movie", "Categoria \"Filme\"")];
            [filmes addObject:filme];
        }
        if([[item objectForKey:@"kind"]isEqualToString:@"ebook"]){
            Ebook *ebook = [[Ebook alloc] init];

            sharedInfo(ebook,item);

            [ebook setAutor:[item objectForKey:@"artistName"]];
            [ebook setDescricao:[item objectForKey:@"description"]];
            [ebook setGeneros:[item objectForKey:@"genres"]];
            [ebook setPais:[item objectForKey:@"country"]];
            [ebook setTipo:NSLocalizedString(@"Ebook", "Categoria \"Ebook\"")];
            [ebooks addObject:ebook];
        }
        if([[item objectForKey:@"kind"]isEqualToString:@"song"]){
            Musica *musica = [[Musica alloc] init];

            sharedInfo(musica,item);

            [musica setArtista:[item objectForKey:@"artistName"]];
            [musica setNumFaixas:[item objectForKey:@"trackCount"]];
            [musica setNumDaFaixa:[item objectForKey:@"trackNumber"]];
            [musica setColecao:[item objectForKey:@"collectionName"]];
            [musica setTipo:NSLocalizedString(@"Music", "Categoria \"Musica\"")];
            [musicas addObject:musica];
        }
        if([[item objectForKey:@"kind"]isEqualToString:@"podcast"]){
            Podcast *podcast = [[Podcast alloc] init];

            sharedInfo(podcast,item);

            [podcast setArtista:[item objectForKey:@"artistName"]];
            [podcast setColecao:[item objectForKey:@"primaryGenreName"]];
            [podcast setTipo:NSLocalizedString(@"Podcast", "Categoria \"Podcast\"")];
            [podcasts addObject:podcast];
        }
    }

    [result setObject:filmes forKey:@"filmes"];
    [result setObject:musicas forKey:@"musicas"];
    [result setObject:ebooks forKey:@"ebooks"];
    [result setObject:podcasts forKey:@"podcasts"];

    return result;
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
    return self;
}


@end
