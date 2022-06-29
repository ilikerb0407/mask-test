//
//  Bundle+Extension.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation

extension Bundle {
    // swiftlint:disable force_cast
    static func ValueForString(key: String) -> String {
        
        return Bundle.main.infoDictionary![key] as! String
    }

    static func ValueForInt32(key: String) -> Int32 {

        return Bundle.main.infoDictionary![key] as! Int32
    }
    // swiftlint:enable force_cast
}
