import Foundation
import UIKit

@frozen public enum State: Equatable {
    case loading
    case content
    case empty(EmptyState)
}

public protocol StatefulObject: AnyObject {

    var currentState: State? { get set }

    var stateView: UIView? { get }

    func transition(toState state: State, animated: Bool)

    func adapt(toState state: State, animated: Bool)

    func prepareLoadingState(animated: Bool)
    func prepareContentState(animated: Bool)
    func prepareEmptyState(_ emptyState: EmptyState, animated: Bool)
}

public extension StatefulObject where Self: UIView {
    var stateView: UIView? { self }
}

public extension StatefulObject {

    func transition(toState state: State, animated: Bool = true) {
        switch state {
        case .loading:
            prepareLoadingState(animated: animated)
        case .content:
            prepareContentState(animated: animated)
        case .empty(let filler):
            prepareEmptyState(filler, animated: animated)
        }
        adapt(toState: state, animated: animated)
        currentState = state
    }

    func prepareLoadingState(animated: Bool) {
        stateView?.showLoadingView(animated: animated)
        stateView?.hideEmptyStateView(animated: animated)
    }

    
    func prepareContentState(animated: Bool) {
        stateView?.hideLoadingView(animated: animated)
        stateView?.hideEmptyStateView(animated: animated)
    }

    
    func prepareEmptyState(_ emptyState: EmptyState, animated: Bool) {
        stateView?.hideLoadingView(animated: animated)
        stateView?.showEmptyStateView(emptyState, animated: animated)
    }
}
