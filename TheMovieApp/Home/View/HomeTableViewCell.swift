//
//  HomeTableViewCell.swift
//  TheMovieApp
//
//  Created by guilherme.garcia on 27/06/22.
//

import UIKit
import SnapKit

final class HomeTableViewCell: UITableViewCell {

    private let genreView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 0.6
        return view
    }()

    private let genreImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Roboto.bold.font(size: 18.0)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func setup() {
        setupGenreViewConstraints()
        setupGenreImageConstraints()
        setupGenreLabelConstraints()
    }

    private func setupGenreViewConstraints() {
        contentView.addSubview(genreView)
        genreView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

    private func setupGenreImageConstraints() {
        genreView.addSubview(genreImage)
        genreImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
    }

    private func setupGenreLabelConstraints() {
        genreView.addSubview(genreLabel)
        genreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genreImage.snp.centerY)
            make.leading.equalTo(genreImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension HomeTableViewCell {
    struct ViewModel {
        let genreName: String

        init(genreName: String) {
            self.genreName = genreName
        }
    }

    func display(viewModel: ViewModel) {
        genreLabel.text = viewModel.genreName
        genreImage.image = Asset.popcorn.image
    }
}
