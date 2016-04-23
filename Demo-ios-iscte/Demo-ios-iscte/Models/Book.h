//
//  Book.h
//  OpenLibrary
//
//  Created by Filipe Patricio on 16/04/16.
//  Copyright © 2016 Filipe Patricio. All rights reserved.
//

#import "Mantle.h"

@interface Book : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSArray* authors; //Of NSString
@property (assign, nonatomic) NSInteger coverID;
@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger edition;

@end
