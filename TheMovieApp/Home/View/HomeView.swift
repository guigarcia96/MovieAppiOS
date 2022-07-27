//
//  HomeView.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 25/05/22.
//

import UIKit
import SnapKit

protocol HomeViewDisplay: UIView, StatefulObject {
    var tableViewDelegate: UITableViewDelegate? { get set }
    var tableViewDataSource: UITableViewDataSource? { get set }
}

class HomeView: UIView, HomeViewDisplay {

    var currentState: State?
    
    func adapt(toState state: State, animated: Bool) {
        switch state {
        case .content:
            reloadData()
        case .loading, .empty:
            break
        }
        currentState = state
    }
    
    var tableViewDelegate: UITableViewDelegate? {
        get {
            tableView.delegate
        } set {
            tableView.delegate = newValue
        }
    }
    
    var tableViewDataSource: UITableViewDataSource? {
        get {
            tableView.dataSource
        } set {
            tableView.dataSource = newValue
        }
    }
    
    private func reloadData() {
        tableView.reloadData()
    }

    var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        return table
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }

    
    private func setupView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
    
}
