//
//  SearchResult.m
//  OpenLibrary
//
//  Created by Filipe Patricio on 16/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "SearchResult.h"
#import "Book.h"

@implementation SearchResult

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"books": @"docs",
             };
}

+ (NSValueTransformer *)booksJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Book.class];
}

@end
