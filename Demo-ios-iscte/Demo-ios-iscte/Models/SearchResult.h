//
//  SearchResult.h
//  OpenLibrary
//
//  Created by Filipe Patricio on 16/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "Mantle.h"

@interface SearchResult : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSArray *books;
@end
