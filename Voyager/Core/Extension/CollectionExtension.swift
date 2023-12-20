//
//  CollectionExtension.swift
//  Voyager
//
//  Created by admin on 19.12.2023.
//

import Foundation

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
