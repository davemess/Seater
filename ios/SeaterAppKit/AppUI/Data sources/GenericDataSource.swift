//
//  GenericDataSource.swift
//  AppUI
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// A generic data storage.
private struct GenericDataSet<T> {
    let title: String
    let items: [T]
}

/// A generic datasource for use where string-indexed sets of data are stored.
public class GenericDataSource<T> {
    
    private var data: [GenericDataSet<T>] = []
    
    // MARK: - subscripts
    
    private subscript(section: Int) -> GenericDataSet<T> {
        return data[section]
    }
    
    public subscript(section: Int) -> String {
        let dataSet: GenericDataSet<T> = data[section]
        return dataSet.title
    }
    
    public subscript(section: Int, index: Int) -> T? {
        let dataSet: GenericDataSet<T> = data[section]
        let items = dataSet.items
        return items[index]
    }
    
    // MARK: - lifecycle
    
    public init(sections: [String], items: [[T]]) {
        load(sections: sections, items: items)
    }
    
    // MARK: - private
    
    private func load(sections: [String], items: [[T]]) {
        for (index, title) in sections.enumerated() {
            let data = items[index]
            let dataSet = GenericDataSet(title: title, items: data)
            self.data.append(dataSet)
        }
    }
    
    // MARK: - data source
    
    public func numberOfSections() -> Int {
        return data.count
    }
    
    public func numberOfItemsInSection(section: Int) -> Int {
        let dataSet: GenericDataSet = self[section]
        return dataSet.items.count
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        let section = indexPath.section
        let index = indexPath.item
        return self[section, index]
    }
}

public extension GenericDataSource {
    
    func update(with sections: [String], items: [[T]]) {
        load(sections: sections, items: items)
    }
    
}
