//
//  SectionedDataSource.swift
//  AppUI
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// Defines a protocol for supplying data to a sectioned view (eg. table view, collection view).
public protocol SectionedDataSource {
    associatedtype Element
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> Element
    func indexPath(of item: Element) -> IndexPath?
}

public class SectionedDataSource<T> {

}
