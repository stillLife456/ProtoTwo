//
//  Node.swift
//  ProtoTwo
//
//  Created by Don on 2016-10-04.
//  Copyright © 2016 Don. All rights reserved.
//

import Foundation
import UIKit



class Node {
    
    var value: String
    var children: [Node] = []
    weak var parent: Node? // add the parent property
        
    init(value: String) {
        self.value = value
        }
    
    func add(child: Node){
        children.append(child)
        child.parent = self
        
    }
}

