//
//  ConversionEngine.swift
//  KoyamaInput
//
//  Created by hiromi_mi on 2022/01/09.
//

import Foundation
import Cocoa

@objc class ConversionEngine : NSObject {
    var formatter: NumberFormatter = NumberFormatter.init()
    func conversionMode() -> NumberFormatter.Style {
        return NumberFormatter.Style.decimal
    }
    
    func convert(string: String) -> String {
        formatter.numberStyle = self.conversionMode()
        guard let number = formatter.number(from: string) else { return "" }
        return formatter.string(from: number)!
    }
}
