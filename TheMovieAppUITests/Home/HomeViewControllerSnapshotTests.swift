//
//  HomeViewSnapshotTests.swift
//  TheMovieAppUITests
//
//  Created by guilherme.garcia on 29/07/22.
//
@testable import TheMovieApp
import XCTest
import SnapshotTesting

class HomeViewControllerSnapshotTests: XCTestCase {

    func test_HomeViewControllerSuccess() {
        assertSnapshot(for: .content, and: "Success")
    }
    
    func test_HomeViewControllerFailure() {
        assertSnapshot(for: .empty(.withError(and: .none)), and: "Failure")
    }
    
}

extension HomeViewControllerSnapshotTests {
    private func assertSnapshot(for state: State, and imageName: String) {
        let sut = makeSut(for: state)
        let result = verifySnapshot(matching: sut, as: .image(on: .iPhone8Plus), named: imageName, testName: "HomeViewControllerTests")
        XCTAssertNil(result)
    }

    private func makeSut(for state: State) -> UIViewController {
        let presenter = HomePresenter()
        let worker = HomeWorkerSpy()
        let result: GenresRequestResult? = createResult(for: state)
        worker.contentToBeReturned = result
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
        return viewController
    }
    
    func createMockError() -> Error {
        let error = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Invalid access token"])
        return error
    }
    
    func createResult(for state: State) -> GenresRequestResult? {
        let result: GenresRequestResult?
        switch state {
        case .loading:
            result = nil
        case .content:
            result = .success(GenreResult.fixture().genres)
        case .empty(_):
            result = .failure(createMockError())
        }
        return result
    }
}

