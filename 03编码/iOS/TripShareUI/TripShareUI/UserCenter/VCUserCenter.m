//
//  VCUserCenter.m
//  TripShareUI
//
//  Created by shulianyong on 13-9-14.
//  Copyright (c) 2013年 shulianyong. All rights reserved.
//

#import "VCUserCenter.h"
#import <QuartzCore/QuartzCore.h>

@interface VCUserCenter ()

@end

@implementation VCUserCenter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)layoutView
{
    self.imgHeader.layer.masksToBounds = YES;
    self.imgHeader.layer.cornerRadius = self.imgHeader.bounds.size.height/2;
    self.imgHeader.layer.borderWidth = 3;
    self.imgHeader.layer.borderColor = RGBColor(214, 214, 214).CGColor;
    
    self.btnFavorite.layer.cornerRadius=5;    
    self.btnMessage.layer.cornerRadius = 5;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgHeader:nil];
    [self setLblUserName:nil];
    [self setBtnFavorite:nil];
    [self setBtnMessage:nil];
    [self setLblDescription:nil];
    [super viewDidUnload];
}
@end
