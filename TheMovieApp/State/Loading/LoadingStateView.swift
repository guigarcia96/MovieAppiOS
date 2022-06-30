//
//  LoadingView.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 29/06/22.
//

import UIKit
import SnapKit

class LoadingStateView: UIView {
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        return blurEffectView
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupBlurEffectiveView()
        constraintActivityIndicator()
    }
    
    private func constraintActivityIndicator() {
        addSubview(loadingActivityIndicator)
        loadingActivityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupBlurEffectiveView() {
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
    }
    
}

extension LoadingStateView: AnimatesAlpha {
    public func prepareToShow() {
        loadingActivityIndicator.startAnimating()
    }

    public func prepareToHide() {
        loadingActivityIndicator.stopAnimating()
    }
}

private struct AssociatedKeys {
    static var loadingViewKey = "loadingViewKey"
}

extension UIView {
    private var _loadingView: LoadingStateView? {
        guard let loadingView = objc_getAssociatedObject(self, &AssociatedKeys.loadingViewKey) as? LoadingStateView else {
            let view = LoadingStateView()
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &AssociatedKeys.loadingViewKey, view, policy)
            return view
        }
        return loadingView
    }

    public func hideLoadingView(animated: Bool = true) {
        _loadingView?.hide(animated: animated) { [weak self] in
            self?._loadingView?.removeFromSuperview()
        }
    }

    public func showLoadingView(animated: Bool = true) {
        hideLoadingView(animated: false)
        guard let view = _loadingView else {
            return
        }
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.show(animated: animated)
    }
}



