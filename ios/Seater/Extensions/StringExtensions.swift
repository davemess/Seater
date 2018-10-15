//
//  StringExtensions.swift
//  Seater
//
//  Created by David Messing on 10/14/18.
//  Copyright © 2018 davemess. All rights reserved.
//

import Foundation

extension String {
    
    func removeWhitespace() -> String {
        let characterSet = CharacterSet.whitespaces
        let components = self.components(separatedBy: characterSet)
        let filteredComponents = components.filter { !$0.isEmpty }
        let string = filteredComponents.joined(separator: " ")
        
        return string
    }
}
