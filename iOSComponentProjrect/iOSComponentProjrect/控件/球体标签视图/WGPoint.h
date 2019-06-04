//
//  WGPoint.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/29.
//  Copyright © 2019 WG. All rights reserved.
//

#ifndef WGPoint_h
#define WGPoint_h

struct WGPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

typedef struct WGPoint WGPoint;


WGPoint WGPointMake(CGFloat x, CGFloat y, CGFloat z) {
    WGPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}


#endif /* WGPoint_h */
