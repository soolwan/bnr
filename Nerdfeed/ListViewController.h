//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Sean Coleman on 11/21/13.
//  Copyright (c) 2013 Sean Coleman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;

@interface ListViewController : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;

    RSSChannel *channel;
}

@property (nonatomic, strong) WebViewController *webViewController;

- (void)fetchEntries;

@end
