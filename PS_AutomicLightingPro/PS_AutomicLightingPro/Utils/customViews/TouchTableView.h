//
//  TouchTableView.h
//  MyApp
//
//  Created by Apple on 15/2/1.
//  Copyright (c) 2015年 dlt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;


@end
@interface TouchTableView : UITableView
{
 
}

@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;

@end
