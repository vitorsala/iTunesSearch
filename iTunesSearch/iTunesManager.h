//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesManager : NSObject

@property NSNotificationCenter *notifCenter;
@property NSMutableDictionary *midias;
@property NSIndexPath *indexPath;
/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;

- (void)buscarMidias:(NSString *)termo;

@end
