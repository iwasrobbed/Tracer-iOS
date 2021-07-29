//
//  ItemLoggerListView.swift
//  Tracer
//
//  Created by Rob Phillips on 5/9/18.
//  Copyright © 2018 Keepsafe Inc. All rights reserved.
//

import UIKit

final class ItemLoggerListView: UIView, Viewing {
    
    // MARK: - Instantiation
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    // MARK: - View Model
    
    func display(loggedItem: LoggedItem) {
        // Newest events should be inserted at the top
        loggedItems.insert(loggedItem, at: 0)
        tableView.reloadData()
    }
    
    // MARK: - Clearing
    
    func clearAll() {
        loggedItems.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Private Properties
    
    private lazy var tableView: UITableView = { [unowned self] in
        let table = UITableView(frame: .zero)
        table.register(ItemLoggerListCell.self, forCellReuseIdentifier: ItemLoggerListCell.identifier)
        table.dataSource = self
        table.estimatedRowHeight = 100
        table.tableFooterView = UIView(frame: .zero)
        return table
    }()
    
    private var loggedItems = [LoggedItem]()
    
    // MARK: - Unsupported Initializers
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - UITableViewDataSource

extension ItemLoggerListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loggedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemLoggerListCell.identifier, for: indexPath) as? ItemLoggerListCell else { fatalError("Could not dequeue cell") }
        let item = loggedItems[indexPath.row]
        cell.loggedItem = item
        return cell
    }
    
}

// MARK: - Private API

private extension ItemLoggerListView {
    
    func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        let superview = self
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: superview.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)])
    }
    
}
