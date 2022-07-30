//
//  HomeViewSnapshotTests.swift
//  TheMovieAppUITests
//
//  Created by guilherme.garcia on 27/07/22.
//

@testable import TheMovieApp
import SnapshotTesting
import XCTest

class HomeTableViewCellSnapshotTests: XCTestCase {

    func test_HomeTableViewCell_ShouldReturnCorrectly() {
        assertSnapshot(from: "Comedy")
    }

}

extension HomeTableViewCellSnapshotTests {
    private func assertSnapshot(from display: String) {
        let sut = makeSut(with: display)
        let result = verifySnapshot(matching: sut, as: .image, named: "Default", testName: "HomeTableViewCell")
        XCTAssertNil(result)
    }

    private func makeSut(with name: String) -> UIView {
        let cell = HomeTableViewCell(frame: .init(x: 0, y: 0, width: 30, height: 200))
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        cell.display(viewModel: .init(genreName: name))
        cell.layoutIfNeeded()
        return cell.contentView
    }
}
