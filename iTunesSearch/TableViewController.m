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
    NSDictionary *midias;
    NSIndexPath *selectedRow;

    NSString *language;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
//    midias = [itunes buscarMidias:@"Apple"];

    _tableview.dataSource = self;
    _tableview.delegate = self;

//    [_btnBuscar setTitle:NSLocalizedString(@"Search", @"String para o botão buscar") forState:UIControlStateNormal];

    
//#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[midias allKeys] objectAtIndex:section];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[midias objectForKey:[[midias allKeys] objectAtIndex:section]] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Entity *midia = [[midias objectForKey:[[midias allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    [celula.nome setText:midia.nome];
    [celula.tipo setText:midia.tipo];


    if(selectedRow && indexPath.row == selectedRow.row && indexPath.section == selectedRow.section){

        celula.label01.text = midia.pais;
        celula.label02.text = @"test2";
        celula.label03.text = @"test3";
        celula.label04.text = @"test4";
        celula.label05.text = @"test5";

        [celula label01].hidden = NO;
        [celula label02].hidden = NO;
        [celula label03].hidden = NO;
        [celula label04].hidden = NO;
        [celula label05].hidden = NO;
    }
    else{

        [celula label01].hidden = YES;
        [celula label02].hidden = YES;
        [celula label03].hidden = YES;
        [celula label04].hidden = YES;
        [celula label05].hidden = YES;
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
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }

    selectedRow = indexPath;

    if([midias count] > 0){
        [tableView beginUpdates];
        [tableView endUpdates];
        TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSNumberFormatter *f = [[NSNumberFormatter alloc]init];
        f.numberStyle = NSNumberFormatterDecimalStyle;

        Entity *midia = [[midias objectForKey:[[midias allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

        cell.label01.text = midia.pais;
        cell.label02.text = @"test2";
        cell.label03.text = @"test3";
        cell.label04.text = @"test4";
        cell.label05.text = @"test5";

        [cell label01].hidden = NO;
        [cell label02].hidden = NO;
        [cell label03].hidden = NO;
        [cell label04].hidden = NO;
        [cell label05].hidden = NO;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = nil;
    if([midias count] > 0){
        TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

        [tableView beginUpdates];
        [tableView endUpdates];

        [cell label01].hidden = YES;
        [cell label02].hidden = YES;
        [cell label03].hidden = YES;
        [cell label04].hidden = YES;
        [cell label05].hidden = YES;
    }
}

- (IBAction)buscar:(id)sender {
    [self tableView:_tableview didDeselectRowAtIndexPath:[_tableview indexPathForSelectedRow]];
    iTunesManager *itunes = [iTunesManager sharedInstance];
    NSString *search = _textoBusca.text;
    search = [search stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    midias = [itunes buscarMidias:search];
    [_tableview reloadData];

}

//#pragma mark outros métodos
//-(void) setCellContent:(UITableCell *)cell withContent:(NSArray *)data{
//
//}
@end
