//
//  Multiple.swift
//  ThreeFour
//
//  Created by Danny Chew on 2/19/17.
//  Copyright © 2017 Danny Chew. All rights reserved.
//

import Foundation

class Multiple<T: Equatable> {
    var e1: T
    var e2: T
    
    init(item: T, item2: T) {
        self.e1 = item
        self.e2 = item2
    }
    
    func contains(m: Multiple) -> Bool {
        return (e1 == m.e1 || e2 == m.e2) || (e1 == m.e2 || e2 == m.e1)
    }
}
