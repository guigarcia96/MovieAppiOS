//
//  EmptyView.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 29/06/22.
//

import UIKit

public struct EmptyState: Equatable {
    public let image: UIImage?
    public let title: String
    public let subtitle: String
    public let buttonTitle: String?
    public weak var buttonDelegate: EmptyStateViewDelegate?

    public init(image: UIImage?, title: String, subtitle: String, buttonTitle: String? = nil, buttonDelegate: EmptyStateViewDelegate? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.buttonDelegate = buttonDelegate
    }

    public static func withError(and buttonDelegate: EmptyStateViewDelegate?) -> EmptyState {
        let title = "Algo Errado"
        let image = Asset.network.image
        let subtitle = "Desculpe, ocorreu um erro, por favor, tente novamente"

        return EmptyState(
            image: image,
            title: title,
            subtitle: subtitle,
            buttonTitle: "Tente Novamente"
        )
    }

    public static func == (lhs: EmptyState, rhs: EmptyState) -> Bool {
        lhs.image == rhs.image &&
        lhs.title == rhs.title &&
        lhs.subtitle == rhs.subtitle &&
        lhs.buttonTitle == rhs.buttonTitle &&
        lhs.buttonDelegate === rhs.buttonDelegate
    }
}

public protocol EmptyStateViewDelegate: AnyObject {
    func emptyStateViewButtonTouched(forState emptyState: EmptyState)
}

public final class EmptyStateView: UIView {

    public private(set) var emptyState: EmptyState?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = FontFamily.Roboto.regular.font(size: 16)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    private let subtitleLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = FontFamily.Roboto.thin.font(size: 14)
        detailLabel.textColor = .systemGray
        detailLabel.textAlignment = .center
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        return detailLabel
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        return button
    }()

    public init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    private func setup() {
        constrainStack()
        constrainImage()
        constrainButton()
        backgroundColor = .white
        alpha = 0
    }

    private func constrainStack() {
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(contentStackView)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(button)
    }

    private func constrainImage() {

        imageView.snp.makeConstraints { make in
            make.height.equalTo(65).priority(.low)
            make.width.equalTo(65).priority(.low)
        }
    }

    private func constrainButton() {

        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
    }

    @objc private func buttonTouched() {
        guard let emptyState = emptyState else {
            return
        }
        DispatchQueue.main.async {
            emptyState.buttonDelegate?.emptyStateViewButtonTouched(forState: emptyState)
        }
    }

    public func render(emptyState: EmptyState) {
        self.emptyState = emptyState
        nameLabel.text = emptyState.title
        subtitleLabel.text = emptyState.subtitle
        if let image = emptyState.image {
            imageView.isHidden = false
            imageView.image = image
        } else {
            imageView.isHidden = true
        }
        if let buttonTitle = emptyState.buttonTitle {
            button.isHidden = false
            button.setTitle(buttonTitle, for: .normal)
        } else {
            button.isHidden = true
        }
    }
}

extension EmptyStateView: AnimatesAlpha {}

private struct AssociatedKeys {
    static var emptyStateViewKey = "emptyStateViewKey"
}

extension UIView {
    private var _emptyStateView: EmptyStateView? {
        guard let emptyStateView = objc_getAssociatedObject(self, &AssociatedKeys.emptyStateViewKey) as? EmptyStateView else {
            let view = EmptyStateView()
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &AssociatedKeys.emptyStateViewKey, view, policy)
            return view
        }
        return emptyStateView
    }

    public func hideEmptyStateView(animated: Bool = true) {
        _emptyStateView?.hide(animated: animated) { [weak self] in
            self?._emptyStateView?.removeFromSuperview()
        }
    }

    public func showEmptyStateView(_ emptyState: EmptyState, animated: Bool = true) {
        hideEmptyStateView(animated: false)
        guard let view = _emptyStateView else {
            return
        }
        addSubview(view)

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.render(emptyState: emptyState)
        view.show(animated: animated)
    }
}
