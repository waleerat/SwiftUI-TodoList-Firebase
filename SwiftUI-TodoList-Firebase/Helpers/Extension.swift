//
//  Extension.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import Foundation
import SwiftUI

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.2f", self) : String(self)
    }
    
    var twoDigitNumber: String {
        return String(format: "%.2f", self)
    }
}

 
extension LinearGradient {
    static let blackOpacityGradient = LinearGradient(
        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.95)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let BackgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.65)]),
        startPoint: .top,
        endPoint: .bottom
    )
}
