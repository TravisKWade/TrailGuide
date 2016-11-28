//
//  Trail.h
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/24/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Trail : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D *trail;
@property (nonatomic, readonly) NSInteger trailPointsCount;
    
@end
