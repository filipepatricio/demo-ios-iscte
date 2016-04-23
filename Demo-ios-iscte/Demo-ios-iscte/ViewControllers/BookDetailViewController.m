//
//  BookDetailViewController.m
//  OpenLibrary
//
//  Created by Filipe Patricio on 16/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "BookDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.authors.firstObject;
    if(self.book.coverID)
    {
        self.bookImageView.image = nil;
        NSString *coverUrlString = [NSString stringWithFormat:@"http://covers.openlibrary.org/b/id/%ld-L.jpg", self.book.coverID];
        [self.bookImageView setImageWithURL:[NSURL URLWithString:coverUrlString]];
    }
}

- (IBAction)actionShareTap:(id)sender {
    NSString *stringtoshare= self.book.title;
    UIImage *imagetoshare = self.bookImageView.image; //This is an image to share.
    
    NSArray *activityItems = @[stringtoshare, imagetoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
