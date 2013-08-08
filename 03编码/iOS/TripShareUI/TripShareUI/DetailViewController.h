//
//  DetailViewController.h
//  TripShareUI
//
//  Created by shulianyong on 13-7-22.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UIButton *btnOK;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
