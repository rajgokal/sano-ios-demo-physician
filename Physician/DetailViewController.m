//
//  DetailViewController.m
//  Physician
//
//  Created by Raj Gokal on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "ASBSparkLineView.h"

@interface DetailViewController () {
    NSMutableArray *m_glucoseData;
    NSMutableArray *m_temperatureData;
    NSMutableArray *m_heartRateData;
}

- (void)setup;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize currentPatient;
@synthesize sparkLineView1, sparkLineView2, sparkLineView3;
@synthesize sparkLineView4, sparkLineView5, sparkLineView6;
@synthesize allSparklines;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [_detailItem name];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    // we have two test views to load
    
    UIColor *darkRed = [UIColor colorWithRed:0.6f green:0.0f blue:0.0f alpha:1.0f];
    UIColor *darkGreen = [UIColor colorWithRed:0.0f green:0.6f blue:0.0f alpha:1.0f];
    
    // Loading data into graphs
    self.sparkLineView1.dataValues = m_glucoseData;
    self.sparkLineView1.labelText = @"Glucose";
    self.sparkLineView1.currentValueColor = darkRed;
    self.sparkLineView1.penColor = [UIColor blackColor];
    self.sparkLineView1.penWidth = 1.0f;
    
    self.sparkLineView2.dataValues = m_temperatureData;
    self.sparkLineView2.labelText = @"Potassium";
    self.sparkLineView2.currentValueColor = darkRed;
    self.sparkLineView2.penColor = [UIColor blackColor];
    self.sparkLineView2.penWidth = 1.0f;
    
    self.sparkLineView3.dataValues = m_heartRateData;
    self.sparkLineView3.labelText = @"Calcium";
    self.sparkLineView3.currentValueColor = darkRed;
    self.sparkLineView3.currentValueFormat = @"%.0f";
    self.sparkLineView3.penColor = [UIColor blackColor];
    self.sparkLineView3.penWidth = 1.0f;
    
    self.sparkLineView4.dataValues = m_glucoseData;
    self.sparkLineView4.labelText = @"Chloride";
    self.sparkLineView4.currentValueColor = darkRed;
    self.sparkLineView2.penColor = [UIColor blackColor];
    self.sparkLineView2.penWidth = 1.0f;
    
    self.sparkLineView5.dataValues = m_temperatureData;
    self.sparkLineView5.labelText = @"Sodium";
    self.sparkLineView5.currentValueColor = darkRed;
    self.sparkLineView5.penColor = [UIColor blackColor];
    self.sparkLineView5.penWidth = 1.0f;
    
    self.sparkLineView6.dataValues = m_heartRateData;
    self.sparkLineView6.labelText = @"Creatinine";
    self.sparkLineView6.currentValueColor = darkRed;
    self.sparkLineView6.currentValueFormat = @"%.0f";
    self.sparkLineView6.penColor = [UIColor blackColor];
    self.sparkLineView6.penWidth = 1.0f;
    
    self.allSparklines = [NSArray arrayWithObjects:self.sparkLineView1, self.sparkLineView2, self.sparkLineView3,
                          self.sparkLineView4, self.sparkLineView5, self.sparkLineView6, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


// configure test range overlay limits (note, I'm not medically qualified in any way, these are made up...)
const float glucoseMinLimit = 5.0f;
const float glucoseMaxLimit = 6.8f;
const float tempMinLimit = 36.9f;
const float tempMaxLimit = 37.4f;
const float heartRateMinLimit = 45;
const float heartRateMaxLimit = 85;


#pragma mark - Object Lifecycle

// designated initializer
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

// loads the data sets from the files in the main bundle
- (void)setup {
    
    m_glucoseData = [[NSMutableArray alloc] init];
    m_temperatureData = [[NSMutableArray alloc] init];
    m_heartRateData = [[NSMutableArray alloc] init];
    
    NSArray *dataArray = [NSArray arrayWithObjects:m_glucoseData, m_temperatureData, m_heartRateData, nil];
    NSArray *fileNames = [NSArray arrayWithObjects:@"glucose_data.txt", @"temperature_data.txt", @"heartRate_data.txt", nil];
    
    [fileNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        // read in the dummy data and allocate to the appropriate view
        NSError *err;
        NSString *dataFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:obj];
        NSString *contents = [[NSString alloc] initWithContentsOfFile:dataFile encoding:NSUTF8StringEncoding error:&err];
        
        if (contents) {
            
            NSScanner *scanner = [[NSScanner alloc] initWithString:contents];
            
            NSMutableArray *data = [dataArray objectAtIndex:idx];
            while ([scanner isAtEnd] == NO) {
                float scannedValue = 0;
                if ([scanner scanFloat:&scannedValue]) {
                    NSNumber *num = [[NSNumber alloc] initWithFloat:scannedValue];
                    [data addObject:num];
                }
            }
            
        } else {
            NSLog(@"failed to read in data file %@: %@", [fileNames objectAtIndex:idx], [err localizedDescription]);
        }
        
    }];
    
}



#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

// called when the "Show/Hide Range Overlays" button is touched
- (IBAction)toggleShowOverlays:(id)sender {
    
    for (ASBSparkLineView *obj in self.allSparklines)
        obj.showRangeOverlay = !obj.showRangeOverlay;
    
    NSString *buttonText = [NSString stringWithFormat:@"%@ Range Overlays",
                            (self.sparkLineView1.showRangeOverlay) ? @"Hide" : @"Show"];
    [((UIButton *)sender) setTitle:buttonText forState:UIControlStateNormal];
    
    // if the overlays are enabled, we define the limits, otherwise we reset them (the view will auto-scale)
    if (self.sparkLineView1.showRangeOverlay) {
        
        self.sparkLineView1.rangeOverlayLowerLimit = [NSNumber numberWithFloat:glucoseMinLimit];
        self.sparkLineView1.rangeOverlayUpperLimit = [NSNumber numberWithFloat:glucoseMaxLimit];
        self.sparkLineView2.rangeOverlayLowerLimit = [NSNumber numberWithFloat:tempMinLimit];
        self.sparkLineView2.rangeOverlayUpperLimit = [NSNumber numberWithFloat:tempMaxLimit];
        self.sparkLineView3.rangeOverlayLowerLimit = [NSNumber numberWithFloat:heartRateMinLimit];
        self.sparkLineView3.rangeOverlayUpperLimit = [NSNumber numberWithFloat:heartRateMaxLimit];
        self.sparkLineView4.rangeOverlayLowerLimit = [NSNumber numberWithFloat:glucoseMinLimit];
        self.sparkLineView4.rangeOverlayUpperLimit = [NSNumber numberWithFloat:glucoseMaxLimit];
        self.sparkLineView5.rangeOverlayLowerLimit = [NSNumber numberWithFloat:tempMinLimit];
        self.sparkLineView5.rangeOverlayUpperLimit = [NSNumber numberWithFloat:tempMaxLimit];
        self.sparkLineView6.rangeOverlayLowerLimit = [NSNumber numberWithFloat:heartRateMinLimit];
        self.sparkLineView6.rangeOverlayUpperLimit = [NSNumber numberWithFloat:heartRateMaxLimit];
        
    } else {
        // make them all nil, which will result in an auto-scale of the data values
        for (ASBSparkLineView *obj in self.allSparklines) {
            obj.rangeOverlayLowerLimit = nil;
            obj.rangeOverlayUpperLimit = nil;
        }
    }
}

// called when the "Show/Hide Range Current Values" button is touched
-(IBAction)toggleCurrentValues:(id)sender {
    
    for (ASBSparkLineView *obj in self.allSparklines)
        obj.showCurrentValue = !obj.showCurrentValue;
    
    NSString *buttonText = [NSString stringWithFormat:@"%@ Current Values",
                            (self.sparkLineView1.showCurrentValue) ? @"Hide" : @"Show"];
    [((UIButton *)sender) setTitle:buttonText forState:UIControlStateNormal];
}

@end
