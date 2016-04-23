//
//  Book.m
//  OpenLibrary
//
//  Created by Filipe Patricio on 16/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"authors": @"author_name",
             @"coverID": @"cover_i",
             @"year": @"first_publish_year",
             @"edition": @"edition_count",
             };
}



@end
