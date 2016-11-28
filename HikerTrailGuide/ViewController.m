//
//  ViewController.m
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "ViewController.h"
#import "TrailAnnotation.h"

#define METERS_PER_MILE 1609.344

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstLocationSet = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapView.mapType = MKMapTypeHybrid;
    self.mapView.showsUserLocation = YES;
    
    self.park = [[TrailPark alloc] initWithFilename:@"galena"];

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.park.midCoordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    self.mapView.region = region;
    
    [self addOverlay];
    [self addTrail];
    [self addAnnotations];
    [self addTrailAlternates];
}

- (void) viewDidAppear:(BOOL)animated {
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addOverlay {
    TrailMapOverlay *overlay = [[TrailMapOverlay alloc] initWithPark:self.park];
    
    [self.mapView addOverlay:overlay];
}

- (void) addTrail {
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:self.park.trail count:self.park.trailPointsCount];
    [self.mapView addOverlay:polyLine];
}
    
- (void) addTrailAlternates {
    
}

- (void) addAnnotations {
    
    for (TrailAnnotation *annotation in self.park.trailAnnotations) {
        [self.mapView addAnnotation:annotation];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:TrailMapOverlay.class]) {
        UIImage *magicMountainImage = [UIImage imageNamed:@"galena.png"];
        TrailMapOverlayView *overlayView = [[TrailMapOverlayView alloc] initWithOverlay:overlay overlayImage:magicMountainImage];
        
        return overlayView;
    } else {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = [UIColor redColor];
        renderer.lineWidth = 5;
        
        return renderer;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(!self.firstLocationSet) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        self.firstLocationSet = YES;
    }
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

@end
