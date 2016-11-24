//
//  TrailAnnotationView.m
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/23/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "TrailAnnotationView.h"
#import "TrailAnnotation.h"

@implementation TrailAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        TrailAnnotation *trailAnnotation = self.annotation;
        switch (trailAnnotation.type) {
            case PVAttractionFirstAid:
                self.image = [UIImage imageNamed:@"firstaid"];
                break;
            case PVAttractionFood:
                self.image = [UIImage imageNamed:@"food"];
                break;
            case PVAttractionRide:
                self.image = [UIImage imageNamed:@"ride"];
                break;
            default:
                self.image = [UIImage imageNamed:@"star"];
                break;
        }
    }
    
    return self;
}
@end
