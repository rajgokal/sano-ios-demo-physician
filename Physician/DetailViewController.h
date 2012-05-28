//
//  DetailViewController.h
//  Physician
//
//  Created by Raj Gokal on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@class ASBSparkLineView;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, strong) Patient *currentPatient;

// these are all linked in the xib document
@property (nonatomic, weak) IBOutlet ASBSparkLineView *sparkLineView1;
@property (nonatomic, weak) IBOutlet ASBSparkLineView *sparkLineView2;
@property (nonatomic, weak) IBOutlet ASBSparkLineView *sparkLineView3;
@property (nonatomic, weak) IBOutlet ASBSparkLineView *sparkLineView4;
@property (nonatomic, weak) IBOutlet ASBSparkLineView *sparkLineView5;
@property (nonatomic, weak) IBOutlet ASBSparkLineView *sparkLineView6;
@property (nonatomic, strong) NSArray *allSparklines;

-(IBAction)toggleShowOverlays:(id)sender;
-(IBAction)toggleCurrentValues:(id)sender;

@end
