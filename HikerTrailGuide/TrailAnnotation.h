//
//  TrailAnnotation.h
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/23/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

typedef NS_ENUM(NSInteger, PVAttractionType) {
    PVAttractionDefault = 0,
    PVAttractionRide,
    PVAttractionFood,
    PVAttractionFirstAid
};

@interface TrailAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) PVAttractionType type;

@end
