//
//  ViewController.h
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TrailPark.h"
#import "TrailMapOverlayView.h"
#import "TrailMapOverlay.h"

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) TrailPark *park;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

