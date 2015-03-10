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
#import "Entidades/Filme.h"

@interface TableViewController () {
    NSArray *midias;
    NSIndexPath *selectedRow;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Apple"];

    _tableview.dataSource = self;
    _tableview.delegate = self;
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(selectedRow && indexPath.row == selectedRow.row){
        return 220;
    }
    return 70;
}

#pragma mark - Metodos do UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = indexPath;
    [tableView beginUpdates];
    [tableView endUpdates];
    TableViewCell *cell = (TableViewCell *)[self.tableview cellForRowAtIndexPath:indexPath];

    Filme *filme = [midias objectAtIndex:indexPath.row];

    cell.genero.text = filme.genero;
    cell.artista.text = filme.artista;
//    cell.duracao.text = filme.duracao;
    cell.pais.text = filme.pais;
//    cell.trackId.text = filme.trackId;

    [cell genero].hidden = NO;
    [cell artista].hidden = NO;
    [cell duracao].hidden = NO;
    [cell pais].hidden = NO;
    [cell trackId].hidden = NO;

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = nil;

    TableViewCell *cell = (TableViewCell *)[self.tableview cellForRowAtIndexPath:indexPath];

    [tableView beginUpdates];
    [tableView endUpdates];

    [cell genero].hidden = YES;
    [cell artista].hidden = YES;
    [cell duracao].hidden = YES;
    [cell pais].hidden = YES;
    [cell trackId].hidden = YES;
}

@end
