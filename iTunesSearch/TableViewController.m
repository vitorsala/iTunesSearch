//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "infoViewController.m"
#import "Entidades/Filme.h"
#import "Entidades/Ebook.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "LoadingAlert.h"


@interface TableViewController () {
    NSDictionary *midias;
    NSIndexPath *selectedRow;

    NSString *language;

    LoadingAlert *loadingAlert;
    NSUserDefaults *userDefault;
    void (^setLabelHidden)(TableViewCell *, BOOL);
    UIActivityIndicatorView *activity;
}

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    [itunes.notifCenter addObserver:self selector:@selector(tableUpdate:) name:@"iTunesManagerDisFinishedSearch" object:itunes];

//    [self.view insertSubview:_tableview belowSubview:self.view];
    _tableview.dataSource = self;
    _tableview.delegate = self;

    [_btnBuscar setTitle:NSLocalizedString(@"Search", @"String para o botão buscar") forState:UIControlStateNormal];

    self.navigationItem.title = @"iTunes Search";
    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 0.f)];

    setLabelHidden = ^void(TableViewCell* celula, BOOL hidden){
        [celula label01].hidden = hidden;
        [celula label02].hidden = hidden;
        [celula label03].hidden = hidden;
        [celula label04].hidden = hidden;
        [celula label05].hidden = hidden;
    };


    loadingAlert = [[LoadingAlert alloc]initWithTitle:@"Realizando busca" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];

    userDefault = [NSUserDefaults standardUserDefaults];
    _textoBusca.text = [userDefault objectForKey:@"lastSearch"];
//    _tableview.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *type = [[midias allKeys] objectAtIndex:section];
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0,0,_tableview.frame.size.width,18)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 16, 16)];
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",type]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, tableView.frame.size.width, 18)];
    label.text = type;
    subView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [subView addSubview:imgView];
    [subView addSubview:label];

    return subView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[midias objectForKey:[[midias allKeys] objectAtIndex:section]] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Midia *midia = [[midias objectForKey:[[midias allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    [celula.nome setText:midia.nome];
    [celula.tipo setText:midia.tipo];
    [celula.preco setText:[NSString stringWithFormat:@"%@ USD",midia.preco]];


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *url = [NSURL URLWithString:midia.imgUrl];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];

        dispatch_sync(dispatch_get_main_queue(), ^{ // Sincroniza o método com a main thread.
            [celula.imgView setImage:img];
        });

    });

    if(selectedRow && indexPath.row == selectedRow.row && indexPath.section == selectedRow.section){

        void (^sharedLabel)(NSString*, NSString*, NSString*) = ^void(NSString* lbl1, NSString* lbl2, NSString* lbl3){
            celula.label03.text = lbl1;
            celula.label04.text = lbl2;
            celula.label05.text = lbl3;
        };

        celula.label01.text = midia.pais;
        celula.label02.text = midia.data;
        if([midia isKindOfClass:[Filme class]]){
            Filme *e = (Filme *)midia;
            sharedLabel(
                        e.genero,
                        e.artista,
                        [NSString stringWithFormat:@"%@",e.duracao]
            );
        }
        if([midia isKindOfClass:[Musica class]]){
            Musica *e = (Musica *)midia;
            sharedLabel(
                        e.colecao,
                        e.artista,
                        [NSString stringWithFormat:@"%@",e.numDaFaixa]
                        );

        }
        if([midia isKindOfClass:[Ebook class]]){
            Ebook *e = (Ebook *)midia;
            sharedLabel(
                        e.autor,
                        [e.generos firstObject],
                        e.descricao
                        );

        }
        if([midia isKindOfClass:[Podcast class]]){
            Podcast *e = (Podcast *)midia;
            sharedLabel(
                        e.artista,
                        e.colecao,
                        e.trackId
                        );

        }
        setLabelHidden(celula,NO);
    }
    else{
        setLabelHidden(celula,YES);
    }
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(selectedRow && indexPath.row == selectedRow.row && indexPath.section == selectedRow.section){
        return 220;
    }
    return 70;
}

#pragma mark - Metodos do UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedRow && indexPath.row == selectedRow.row && indexPath.section == selectedRow.section){
        [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];


        infoViewController *infoView = [[infoViewController alloc] init];
        
        [[iTunesManager sharedInstance] setIndexPath:indexPath];

        [self.navigationController pushViewController:infoView animated:YES];

        return;
    }
    else{
        [tableView deselectRowAtIndexPath:selectedRow animated:YES];
    }
    selectedRow = indexPath;

    if([midias count] > 0){
        TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSNumberFormatter *f = [[NSNumberFormatter alloc]init];
        f.numberStyle = NSNumberFormatterDecimalStyle;

        Midia *midia = [[midias objectForKey:[[midias allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

        void (^sharedLabel)(NSString*, NSString*, NSString*) = ^void(NSString* lbl1, NSString* lbl2, NSString* lbl3){
            cell.label03.text = lbl1;
            cell.label04.text = lbl2;
            cell.label05.text = lbl3;
        };

        cell.label01.text = midia.pais;
        cell.label02.text = midia.data;
        if([midia isKindOfClass:[Filme class]]){
            Filme *e = (Filme *)midia;
            sharedLabel(
                        e.genero,
                        e.artista,
                        [NSString stringWithFormat:@"%@",e.duracao]
                        );
        }
        if([midia isKindOfClass:[Musica class]]){
            Musica *e = (Musica *)midia;
            sharedLabel(
                        e.colecao,
                        e.artista,
                        [NSString stringWithFormat:@"%@",e.numDaFaixa]
                        );

        }
        if([midia isKindOfClass:[Ebook class]]){
            Ebook *e = (Ebook *)midia;
            sharedLabel(
                        e.autor,
                        [e.generos firstObject],
                        e.descricao
                        );

        }
        if([midia isKindOfClass:[Podcast class]]){
            Podcast *e = (Podcast *)midia;
            sharedLabel(
                        e.artista,
                        e.colecao,
                        e.trackId
                        );
            
        }

        setLabelHidden(cell,NO);

        [tableView beginUpdates];
        [tableView endUpdates];
    }

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = nil;
    if([midias count] > 0){
        TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

        setLabelHidden(cell,YES);

        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (IBAction)buscar:(id)sender {
    [self.view endEditing:YES];
    [self tableView:_tableview didDeselectRowAtIndexPath:[_tableview indexPathForSelectedRow]];

    iTunesManager *itunes = [iTunesManager sharedInstance];
    NSError *err = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-z]([a-z]| |\\+|\\(|\\)|'|\\^)*$" options:NSRegularExpressionCaseInsensitive error:&err];
    if(err){
        NSLog(@"Error REGEX");
        return;
    }
    NSString *search = _textoBusca.text;
    search = [search stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![regex numberOfMatchesInString:search options:0 range:NSMakeRange(0, search.length)]){
        UIAlertView *fail = [[UIAlertView alloc]initWithTitle:@"Texto inválido" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fail show];
        return;
    }
    [userDefault setValue:search forKey:@"lastSearch"];
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    // execução da busca de forma assíncrona.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [itunes buscarMidias:search];
    });
    [self showAlert];
}

-(void)showAlert {
    [loadingAlert show];
}


#pragma mark outros métodos
// Chamado pela notification do iTunesManager
-(void)tableUpdate:(NSNotification *)notification{
    dispatch_sync(dispatch_get_main_queue(), ^{ // Sincroniza o método com a main thread.
//        [NSThread sleepForTimeInterval:2];  // Teste para o UIActivityIndicatorView
        midias = notification.userInfo;
        [_tableview reloadData];
        [loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    });
}
@end
