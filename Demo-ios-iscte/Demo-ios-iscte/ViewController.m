//
//  ViewController.m
//  Demo-ios-iscte
//
//  Created by Filipe Patricio on 23/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *bookTextField;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *booksTableView;
@property (strong, nonatomic) NSMutableArray *books;
@end

@implementation ViewController

// Lazy instanciation of books
-(NSMutableArray *)books
{
    if(!_books)
    {
        _books = [[NSMutableArray alloc] init];
    }
    return _books;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionButtonTap:(id)sender {
    self.bookNameLabel.text = self.bookTextField.text;
    
    // Add book title to NSMutableArray *books
    [self.books addObject:self.bookTextField.text];
    
    // Reload tableView data after adding a book to array
    [self.booksTableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // Dequeue cell from reusable identifier
    UITableViewCell *bookCell = [tableView dequeueReusableCellWithIdentifier:@"book-cell" forIndexPath:indexPath];
    
    // Get table current index
    NSInteger index = indexPath.row;
    
    // Get book title from NSMutableArray *books
    NSString *bookTitle = self.books[index];
    
    // Set cell's text
    bookCell.textLabel.text = bookTitle;
    
    return bookCell;
}

@end
