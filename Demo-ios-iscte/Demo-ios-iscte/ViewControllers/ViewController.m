//
//  ViewController.m
//  Demo-ios-iscte
//
//  Created by Filipe Patricio on 23/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "ViewController.h"

#import "BookTableViewCell.h"
#import "BookDetailViewController.h"

// Models
#import "Book.h"
#import "SearchResult.h"

// Pods
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *bookTextField;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *booksTableView;
@property (strong, nonatomic) NSMutableArray *books; //Of Type "Book"
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) Book *selectedBook;
@end

@implementation ViewController

static NSString *SEARCH_BOOKS_QUERY_URL = @"http://openlibrary.org/search.json?q=%@";

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
    
    NSString *bookName = self.bookTextField.text;
    self.bookNameLabel.text = bookName;
    
    // Add book title to NSMutableArray *books
    //    [self.books addObject:self.bookTextField.text];
    
    // Reload tableView data after adding a book to array
    //    [self.booksTableView reloadData];
    
    //Search book on the API: http://openlibrary.org/
    [self searchBookWithName:bookName];
}

- (void)searchBookWithName:(NSString*)bookName
{
    if(bookName.length > 0)
    {
        [self.activityIndicator startAnimating];
        
        //API REQUEST
        NSString *urlString = [NSString stringWithFormat:SEARCH_BOOKS_QUERY_URL, [bookName stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = nil;
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSError *err;
            SearchResult *searchResult = [MTLJSONAdapter modelOfClass:SearchResult.class
                                                   fromJSONDictionary:responseObject
                                                                error:&err];
            
            //Now the array *books receive objects from type "Book" instead of "NSString"
            self.books = [[NSMutableArray alloc] initWithArray:searchResult.books];
            
            //Reload table data and stop loading
            [self.booksTableView reloadData];
            [self.activityIndicator stopAnimating];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        // Hides keyboard
        [self.view endEditing:YES];
        
    }
    else
    {
        self.bookTextField.placeholder = @"Insert a book to search...";
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // Dequeue cell from reusable identifier
    BookTableViewCell *bookCell = [tableView dequeueReusableCellWithIdentifier:@"book-cell" forIndexPath:indexPath];
    
    // Get table current index
    NSInteger index = indexPath.row;
    
    // Get book title from NSMutableArray *books
    // NSString *bookTitle = self.books[index];
    
    // Now its an object "Book" inside the array so:
    Book *book = self.books[index];
    
    // Set bookcell's title
    NSString *bookTitle = book.title;
    bookCell.bookTitleLabel.text = bookTitle;
    
    // Set bookcell's author
    NSString *bookAuthor = book.authors.firstObject;
    bookCell.bookAuthorLabel.text = bookAuthor;
    
    // Set bookcell's cover image
    NSString *coverUrlString = [NSString stringWithFormat:@"http://covers.openlibrary.org/b/id/%ld-L.jpg", book.coverID];
    [bookCell.bookImageView setImageWithURL:[NSURL URLWithString:coverUrlString]];
    
    return bookCell;
}

#pragma mark UITableViewDelegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Save selected book and perform Segue
    self.selectedBook = self.books[indexPath.row];
    [self performSegueWithIdentifier:@"BookDetailSegue" sender:self];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //Hide keyboard and deselect cell
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma UINavigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BookDetailViewController *vc = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"BookDetailSegue"])
    {
        //Pass book on segue
        vc.book = self.selectedBook;
    }
}

@end
