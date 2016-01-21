//
//  ExactTargetEnhancedPushDataSource.h
//  JB4A-SDK-iOS
//
//  Created by Eddie Roger on 8/23/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <UIKit/UIKit.h> // need UITableViewDataSource, so we use UIKit, not Foundation

/**
 The ExactTargetEnhancedPushDataSource is an interface object for CloudPage support. It was designed to be used as the datasource for a UITableView, and can be allocated and used as such without too much other customization. Of course, you are welcomed to use it any way you want other than that.
 
 Should you wish to customize the display of the Data Source, you should subclass from here. At that time, you may override any typical UITableViewDataSource protocol members. You will likely be the most interested in cellForRowAtIndexPath:. If you do, you can access the current message by asking the messages array for the object corresponding to your NSIndexPath row. It will be an ETMessage object. 
 
 Or, for the most customization, make a new one of these and only access the messages property. If you do that, you'll need to be both the delegate and data source for your table, but you can do whatever you like. The messages array will contain ETMessage objects, and you can see which properties are available on that by checking it's header.
 
 */
@interface ExactTargetEnhancedPushDataSource : NSObject <UITableViewDataSource>

/**
 This array contains ETMessages, suitable for display in a UITableView or other presentation apparatus of your liking. Please see ETMessage for a list of properties available.
 */
@property (nonatomic, strong) NSArray *messages;

/** 
 This is a reference to the tableview in your UIViewController. We need a reference to it to reload data periodically.
 */
@property (nonatomic, weak) UITableView *inboxTableView;

@end
