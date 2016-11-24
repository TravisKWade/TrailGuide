//
//  TrailPark.m
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "TrailPark.h"
#import "TrailAnnotation.h"

@implementation TrailPark

- (instancetype)initWithFilename:(NSString *)filename {
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
        NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        CGPoint midPoint = CGPointFromString(properties[@"midCoord"]);
        _midCoordinate = CLLocationCoordinate2DMake(midPoint.x, midPoint.y);
        
        CGPoint overlayTopLeftPoint = CGPointFromString(properties[@"overlayTopLeftCoord"]);
        _overlayTopLeftCoordinate = CLLocationCoordinate2DMake(overlayTopLeftPoint.x, overlayTopLeftPoint.y);
        
        CGPoint overlayTopRightPoint = CGPointFromString(properties[@"overlayTopRightCoord"]);
        _overlayTopRightCoordinate = CLLocationCoordinate2DMake(overlayTopRightPoint.x, overlayTopRightPoint.y);
        
        CGPoint overlayBottomLeftPoint = CGPointFromString(properties[@"overlayBottomLeftCoord"]);
        _overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(overlayBottomLeftPoint.x, overlayBottomLeftPoint.y);
        
        NSArray *trailPoints = properties[@"trail"];
        
        _trailPointsCount = trailPoints.count;
        
        _trail = malloc(sizeof(CLLocationCoordinate2D)*_trailPointsCount);
        
        for(int i = 0; i < _trailPointsCount; i++) {
            CGPoint p = CGPointFromString(trailPoints[i]);
            _trail[i] = CLLocationCoordinate2DMake(p.x,p.y);
        }
        
        NSArray *annotations = properties[@"annotations"];
        self.trailAnnotations = [[NSMutableArray alloc] init];
        
        for (NSDictionary *attraction in annotations) {
            TrailAnnotation *annotation = [[TrailAnnotation alloc] init];
            CGPoint point = CGPointFromString(attraction[@"location"]);
            annotation.coordinate = CLLocationCoordinate2DMake(point.x, point.y);
            annotation.title = attraction[@"name"];
            annotation.type = [attraction[@"type"] integerValue];
            annotation.subtitle = attraction[@"subtitle"];
            [self.trailAnnotations addObject:annotation];
        }
    }
    
    return self;
}

- (CLLocationCoordinate2D)overlayBottomRightCoordinate {
    return CLLocationCoordinate2DMake(self.overlayBottomLeftCoordinate.latitude, self.overlayTopRightCoordinate.longitude);
}

- (MKMapRect)overlayBoundingMapRect {
    
    MKMapPoint topLeft = MKMapPointForCoordinate(self.overlayTopLeftCoordinate);
    MKMapPoint topRight = MKMapPointForCoordinate(self.overlayTopRightCoordinate);
    MKMapPoint bottomLeft = MKMapPointForCoordinate(self.overlayBottomLeftCoordinate);
    
    return MKMapRectMake(topLeft.x,
                         topLeft.y,
                         fabs(topLeft.x - topRight.x),
                         fabs(topLeft.y - bottomLeft.y));
}

@end
