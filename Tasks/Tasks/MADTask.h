//
//  MADTask.h
//  Tasks
//
//  Created by Katie Porter on 11/10/13.
//  Copyright (c) 2013 Katie Porter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MADTask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dueDate;

@end
