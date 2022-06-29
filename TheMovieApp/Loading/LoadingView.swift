//
//  LoadingView.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 29/06/22.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        // The indicator should be animating when
        // the view appears.
        // Setting the autoresizing mask to flexible for all
        // directions will keep the indicator in the center
        // of the view and properly handle rotation.
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        
        // Setting the autoresizing mask to flexible for
        // width and height will ensure the blurEffectView
        // is the same size as its parent view.
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurEffectView
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        // Add the blurEffectView with the same
        // size as view
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
        
        // Add the loadingActivityIndicator in the
        // center of view
        loadingActivityIndicator.center = CGPoint(
            x: bounds.midX,
            y: bounds.midY
        )
        addSubview(loadingActivityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: AnimatesAlpha {
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
    private var _loadingView: LoadingView? {
        guard let loadingView = objc_getAssociatedObject(self, &AssociatedKeys.loadingViewKey) as? LoadingView else {
            let view = LoadingView()
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &AssociatedKeys.loadingViewKey, view, policy)
            return view
        }
        return loadingView
    }

    /// Because we allow to override prepareLoadingState for StatefulObject
    /// we need to allow hideLoadingView to be called outside the UI module
    public func hideLoadingView(animated: Bool = true) {
        _loadingView?.hide(animated: animated) { [weak self] in
            self?._loadingView?.removeFromSuperview()
        }
    }

    /// Because we allow to override prepareLoadingState for StatefulObject
    /// we need to allow showLoadingView to be called outside the UI module
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



