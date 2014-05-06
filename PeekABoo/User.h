//
//  User.h
//  PeekABoo
//
//  Created by Stephen Compton on 1/30/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;

@end
