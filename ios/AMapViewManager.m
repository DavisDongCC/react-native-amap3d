#import <MAMapKit/MAMapKit.h>
#import <React/RCTViewManager.h>
#import "AMapView.h"
#import "AMapMarker.h"

#pragma ide diagnostic ignored "OCUnusedClassInspection"
#pragma ide diagnostic ignored "-Woverriding-method-mismatch"

@interface AMapViewManager : RCTViewManager <MAMapViewDelegate>
@end

@implementation AMapViewManager {
}

RCT_EXPORT_MODULE()

- (UIView *)view {
    AMapView *mapView = [AMapView new];
    mapView.centerCoordinate = CLLocationCoordinate2DMake(39.9042, 116.4074);
    mapView.zoomLevel = 10;
    mapView.delegate = self;
    return mapView;
}

RCT_EXPORT_VIEW_PROPERTY(locationEnabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(showsCompass, BOOL)

RCT_EXPORT_VIEW_PROPERTY(showsScale, BOOL)

RCT_EXPORT_VIEW_PROPERTY(showsIndoorMap, BOOL)

RCT_EXPORT_VIEW_PROPERTY(showsLabels, BOOL)

RCT_EXPORT_VIEW_PROPERTY(showsTraffic, BOOL)

RCT_EXPORT_VIEW_PROPERTY(showsBuildings, BOOL)

RCT_EXPORT_VIEW_PROPERTY(zoomLevel, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(maxZoomLevel, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(minZoomLevel, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(zoomEnabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(scrollEnabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(rotateEnabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(tiltEnabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(mapType, MAMapType)

RCT_EXPORT_VIEW_PROPERTY(coordinate, CLLocationCoordinate2D)

RCT_EXPORT_VIEW_PROPERTY(tilt, CGFloat)

RCT_EXPORT_VIEW_PROPERTY(onReady, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(onLongPress, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(onLocation, RCTBubblingEventBlock)

#pragma mark MAMapViewDelegate

- (void)mapInitComplete:(AMapView *)mapView {
    if (!mapView.onReady) {
        return;
    }
    mapView.onReady(@{});
}

- (void)mapView:(AMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if (!mapView.onPress) {
        return;
    }
    mapView.onPress(@{
            @"latitude": @(coordinate.latitude),
            @"longitude": @(coordinate.longitude),
    });
}

- (void)mapView:(AMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    if (!mapView.onLongPress) {
        return;
    }
    mapView.onLongPress(@{
            @"latitude": @(coordinate.latitude),
            @"longitude": @(coordinate.longitude),
    });
}

- (void)mapView:(AMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (!mapView.onLocation) {
        return;
    }
    mapView.onLocation(@{
            @"latitude": @(userLocation.coordinate.latitude),
            @"longitude": @(userLocation.coordinate.longitude),
            @"accuracy": @((userLocation.location.horizontalAccuracy + userLocation.location.verticalAccuracy) / 2),
    });
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(AMapMarker *)marker {
    if (marker.active) {
        [mapView selectAnnotation:marker animated:YES];
    }
    return [marker getAnnotationView];
}

@end
