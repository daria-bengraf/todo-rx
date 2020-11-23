//
//  BehaviorRelay+Extension.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 22.11.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

extension BehaviorRelay where Element: RangeReplaceableCollection {

    func append(element: Element.Element) {
        var array = self.value
        array.append(element)
        self.accept(array)
    }
}
