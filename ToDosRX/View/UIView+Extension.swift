//
//  UIView+Extension.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 23.11.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


extension Reactive where Base: UILabel {
    
    public var textColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.textColor = color
        }
    }
}
