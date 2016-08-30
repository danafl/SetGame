//
//  HistoryViewController.m
//  set
//
//  Created by Dana Fleischer on 29/08/2016.
//  Copyright © 2016 Dana Fleischer. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController()

@property (weak, nonatomic) IBOutlet UITextView *historyLog;

@end

@implementation HistoryViewController


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.historyLog.attributedText = self.historyText;
}


@end
