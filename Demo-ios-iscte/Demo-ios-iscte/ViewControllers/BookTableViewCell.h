//
//  BookTableViewCell.h
//  OpenLibrary
//
//  Created by Filipe Patricio on 16/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@end
