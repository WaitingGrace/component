//
//  SwiftConfig.swift
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2020/8/28.
//  Copyright © 2020 WG. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromRGB(rgbValue:UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}




