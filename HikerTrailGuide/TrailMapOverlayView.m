//
//  TrailMapOverlayView.m
//  HikerTrailGuide
//
//  Created by Travis Wade on 11/22/16.
//  Copyright © 2016 Branvis Software. All rights reserved.
//

#import "TrailMapOverlayView.h"

@interface TrailMapOverlayView ()

@property (nonatomic, strong) UIImage *overlayImage;

@end

@implementation TrailMapOverlayView

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage {
    self = [super initWithOverlay:overlay];
    if (self) {
        _overlayImage = overlayImage;
    }
    
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    CGImageRef imageReference = self.overlayImage.CGImage;
    
    MKMapRect theMapRect = self.overlay.boundingMapRect;
    CGRect theRect = [self rectForMapRect:theMapRect];
    
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
}

@end
