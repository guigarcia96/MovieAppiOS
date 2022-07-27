//
//  HomeViewDisplay.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 13/07/22.
//

import UIKit

public final class HomeViewDisplaySpy: UIView, HomeViewDisplay {
    
    var tableViewDelegate: UITableViewDelegate?
    
    var tableViewDataSource: UITableViewDataSource?
    
    public var currentState: State?
    
    public var stateView: UIView?
    
    private (set) var adaptCalled: Bool = false
    private (set) var adaptPassed: State = .loading
    public func adapt(toState state: State, animated: Bool) {
        adaptCalled = true
        adaptPassed = state
    }
    
    
}
