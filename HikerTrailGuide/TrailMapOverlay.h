//
//  TrailMapOverlay.h
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TrailPark.h"

@class PVPark;

@interface TrailMapOverlay : NSObject <MKOverlay>

- (instancetype)initWithPark:(TrailPark *)park;

@end
