//
//  ActivitiesViewController.m
//  iosapp
//
//  Created by chenhaoxiang on 1/25/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "OSCActivity.h"
#import "ActivityCell.h"
#import "ActivityDetailsWithBarViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

static NSString * const kActivtyCellID = @"ActivityCell";


@interface ActivitiesViewController ()

@end

@implementation ActivitiesViewController


- (instancetype)initWithUID:(int64_t)userID
{
    self = [super init];
    
    if (self) {
        self.generateURL = ^NSString * (NSUInteger page) {
            return [NSString stringWithFormat:@"%@%@?uid=%lld&pageIndex=%lu&%@", OSCAPI_PREFIX, OSCAPI_EVENT_LIST, userID, (unsigned long)page, OSCAPI_SUFFIX];
        };
        [UIColor colorWithRed:0.999 green:0.2168 blue:0.1797 alpha:1.0];
        self.objClass = [OSCActivity class];
    }
    
    return self;
}


- (NSArray *)parseXML:(ONOXMLDocument *)xml
{
    return [[xml.rootElement firstChildWithTag:@"events"] childrenWithTag:@"event"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:kActivtyCellID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:kActivtyCellID forIndexPath:indexPath];
    OSCActivity *activity = self.objects[indexPath.row];
    
    cell.titleLabel.text       = activity.title;
    cell.titleLabel.textColor = [UIColor titleColor];
    cell.descriptionLabel.text = [NSString stringWithFormat:@"时间：%@\n地点：%@", activity.startTime, activity.location];
    [cell.posterView sd_setImageWithURL:activity.coverURL placeholderImage:nil];
    
    if (activity.status == ActivityStatusActivityFinished && activity.applyStatus == ActivityApplyStatusAttended) {
        cell.tabImageView.hidden = NO;
        [cell.tabImageView setImage:[UIImage imageNamed:@"icon_event_status_attend"]];
    } else if ((activity.status == ActivityStatusGoing || activity.status == ActivityStatusSignUpClosing)  && activity.applyStatus == ActivityApplyStatusDetermined){
        cell.tabImageView.hidden = NO;
        [cell.tabImageView setImage:[UIImage imageNamed:@"icon_event_status_checked"]];
    } else if (activity.status == ActivityStatusActivityFinished && activity.applyStatus == ActivityApplyStatusDetermined) {
        cell.tabImageView.hidden = NO;
        [cell.tabImageView setImage:[UIImage imageNamed:@"icon_event_status_over"]];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSCActivity *activity = self.objects[indexPath.row];
    
    self.label.text = activity.title;
    self.label.font = [UIFont boldSystemFontOfSize:14];
    CGFloat height = [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 84, MAXFLOAT)].height;
    
    self.label.text = [NSString stringWithFormat:@"时间：%@\n地点：%@", activity.startTime, activity.location];
    self.label.font = [UIFont systemFontOfSize:13];
    height += [self.label sizeThatFits:CGSizeMake(tableView.frame.size.width - 84, MAXFLOAT)].height;
    
    return height + 26;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OSCActivity *activity = self.objects[indexPath.row];
    ActivityDetailsWithBarViewController *activityVC = [[ActivityDetailsWithBarViewController alloc] initWithActivityID:activity.activityID];
    [self.navigationController pushViewController:activityVC animated:YES];
}


@end
