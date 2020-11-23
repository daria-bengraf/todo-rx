//
//  AimEnum.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 11.10.2020.
//  Copyr.ight © 2020 Dariya Bengraf. All rights reserved.
//

import Foundation
import UIKit

@objc enum Aim: Int, CaseIterable {
    case goals
    case routine
    case habits
    case joy
    
    var title: String {
        switch self {
            case .goals:    return "Goal"
            case .routine:  return "Routine"
            case .habits:   return "Habbit"
            case .joy:      return "Joy"
        }
    }
    
    var color: UIColor {
        switch self {
            case .goals:    return .systemGreen
            case .routine:  return .blue
            case .habits:   return .orange
            case .joy:      return .systemPink
        }
    }
    
    static func titles() -> [String] {
        return Aim.self.allCases.map { $0.title.capitalized }
    }
    
    func getInt() -> Int16 {
        return Int16(self.rawValue)
    }
}
