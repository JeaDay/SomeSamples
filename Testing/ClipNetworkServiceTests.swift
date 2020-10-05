//
//  ClipNetworkServiceTests.swift
//  TheNewBekan_UnitTests
//
//  Created by Kamil Krzyszczak on 03/04/2020.
//  Copyright © 2020 TechCentrix. All rights reserved.
//

import OHHTTPStubs
@testable import TheNewBekan
import XCTest

// swiftlint:disable:next type_body_length
final class ClipNetworkServiceTests: XCTestCase {
    
    // MARK: Properties
    
    private let testTimeout: TimeInterval = 3.0
    private var service: ClipNetworkService?
    
    // MARK: Lifecycle
    
    override func setUp() {
        service = ClipNetworkService()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    
    func test_getAvailability() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.availableToConnect(for: Mocked.identifier)).absoluteString,
             error: false)
        service?.getAvailability(for: Mocked.identifier,
                                 completion: { (response: AvailabilityResponse?, error: Error?) in
                                    guard error == nil else { return }
                                    guard let response = response else { return }
                                    XCTAssert(response.ownerFirstName == "Janusz")
                                    expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_getAvailabilityWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.availableToConnect(for: Mocked.identifier)).absoluteString,
             error: true)
        service?.getAvailability(for: Mocked.identifier,
                                 completion: { (_, error: Error?) in
                                    XCTAssertNotNil(error)
                                    expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_addClipWithJoined() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let payload = JoinClipPayload(shareCode: Mocked.shareCode)
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.addClip(with: payload)).absoluteString,
             error: false)
        service?.addClip(with: payload,
                         completion: { (clip: Clip?, error: Error?) in
                            guard error == nil else { return }
                            guard let clip = clip else { return }
                            XCTAssert(clip.id == Mocked.clipId)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_addClipWithJoinedWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let payload = JoinClipPayload(shareCode: Mocked.shareCode)
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.addClip(with: payload)).absoluteString,
             error: true)
        service?.addClip(with: payload,
                         completion: { (_, error: Error?) in
                            XCTAssertNotNil(error)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_addClip() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips).absoluteString,
             error: false)
        let payload = AddClipPayload(name: "Test",
                                     firmwareRevision: "999.0",
                                     hardwareRevision: "999.0",
                                     softwareRevision: "999.0",
                                     lastAdHocMessage: "Last AdHoc Message Test",
                                     batteryLevel: 100,
                                     identifier: Mocked.identifier)
        service?.addClip(with: payload,
                         completion: { (clip: Clip?, error: Error?) in
                            guard error == nil else { return }
                            guard let clip = clip else { return }
                            XCTAssert(clip.id == Mocked.clipId)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_addClipWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips).absoluteString,
             error: true)
        let payload = AddClipPayload(name: "Test",
                                     firmwareRevision: "999.0",
                                     hardwareRevision: "999.0",
                                     softwareRevision: "999.0",
                                     lastAdHocMessage: "Last AdHoc Message Test",
                                     batteryLevel: 100,
                                     identifier: Mocked.identifier)
        service?.addClip(with: payload,
                         completion: { (_, error: Error?) in
                            XCTAssertNotNil(error)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_update() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.clip(for: clip)).absoluteString,
             error: false)
        let payload = UpdateClipPayload(clip: clip)
        service?.update(clip: Mocked.clip,
                        with: payload, completion: { (clip: Clip?, error: Error?) in
                            guard error == nil else { return }
                            XCTAssert(clip?.id == Mocked.clipId)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_updateWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.clip(for: clip)).absoluteString,
             error: true)
        let payload = UpdateClipPayload(clip: clip)
        service?.update(clip: Mocked.clip,
                        with: payload, completion: { (_, error: Error?) in
                            XCTAssertNotNil(error)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_delete() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.clip(for: clip)).absoluteString,
             error: false)
        service?.delete(clip: clip,
                        completion: { (success: Bool, error: Error?)in
                            guard error == nil else { return }
                            XCTAssert(success)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_deleteWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.clip(for: clip)).absoluteString,
             error: true)
        service?.delete(clip: clip,
                        completion: { (success: Bool, error: Error?)in
                            XCTAssertNotNil(error)
                            XCTAssertFalse(success)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_unshare() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let payload = UnshareClipPayload(clipId: Mocked.clipId,
                                         userId: Mocked.userId)
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.unshareClip(with: payload)).absoluteString,
             error: false)
        service?.unshare(with: payload,
                         completion: { (success: Bool, error: Error?) in
                            guard error == nil else { return }
                            XCTAssert(success)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_unshareWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let payload = UnshareClipPayload(clipId: Mocked.clipId,
                                         userId: Mocked.userId)
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.unshareClip(with: payload)).absoluteString,
             error: true)
        service?.unshare(with: payload,
                         completion: { (success: Bool, error: Error?) in
                            XCTAssertNotNil(error)
                            XCTAssertFalse(success)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_share() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        let payload = ShareClipToPhoneNumberPayload(phoneNumber: "123 456 789")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.share(clip: clip)).absoluteString,
             error: false)
        service?.share(clip: clip,
                       with: payload,
                       completion: { (success: Bool, error: Error?) in
                        guard error == nil else { return }
                        XCTAssert(success)
                        expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_shareWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        let payload = ShareClipToPhoneNumberPayload(phoneNumber: "123 456 789")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.share(clip: clip)).absoluteString,
             error: true)
        service?.share(clip: clip,
                       with: payload,
                       completion: { (success: Bool, error: Error?) in
                        XCTAssertNotNil(error)
                        XCTAssertFalse(success)
                        expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_getClips() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.list).absoluteString,
             error: false)
        service?.getClips(with: { (response: ArrayResponse<Clip>?, error: Error?) in
            guard error == nil else { return }
            guard let response = response else { return }
            XCTAssert(!response.data.isEmpty)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_getClipsWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.list).absoluteString,
             error: true)
        service?.getClips(with: { (_, error: Error?) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_getMessages() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let payload = AdHocMessagePayload(message: "AdHoc Message Test",
                                          firmwareRevision: "999.0",
                                          hardwareRevision: "999.0",
                                          softwareRevision: "999.0")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.adhoc).absoluteString,
             error: false)
        service?.getMessages(with: payload,
                             completion: { (response: ArrayResponse<String>?, error: Error?)  in
                                guard error == nil else { return }
                                guard let response = response else { return }
                                XCTAssert(response.data.count == 8)
                                expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_getMessagesWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let payload = AdHocMessagePayload(message: "AdHoc Message Test",
                                          firmwareRevision: "999.0",
                                          hardwareRevision: "999.0",
                                          softwareRevision: "999.0")
        mock(endpoint: URL.url(forService: .clip, endpoint: .clips, path: Path.adhoc).absoluteString,
             error: true)
        service?.getMessages(with: payload,
                             completion: { (_, error: Error?)  in
                                XCTAssertNotNil(error)
                                expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_games() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .game).absoluteString,
             error: false)
        service?.games(completion: { (response: ArrayResponse<NetworkGame>?, error: Error?) in
            guard error == nil else { return }
            guard let response = response else { return }
            XCTAssert(response.data.count == 5)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gamesWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .game).absoluteString,
             error: true)
        service?.games(completion: { (response: ArrayResponse<NetworkGame>?, error: Error?) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gamesActive() {
          let expectation = XCTestExpectation(description: "\(#function)")
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.active).absoluteString,
               error: false)
          service?.gamesActive(completion: { (response: ArrayResponse<NetworkGame>?, error: Error?) in
              guard error == nil else { return }
              guard let response = response else { return }
              XCTAssert(response.data.count == 5)
              expectation.fulfill()
          })
          wait(for: [expectation], timeout: testTimeout)
      }
    
    func test_gamesActiveWithError() {
          let expectation = XCTestExpectation(description: "\(#function)")
          mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.active).absoluteString,
               error: true)
          service?.gamesActive(completion: { (response: ArrayResponse<NetworkGame>?, error: Error?) in
              XCTAssertNotNil(error)
              expectation.fulfill()
          })
          wait(for: [expectation], timeout: testTimeout)
      }
    
    func test_gameRound() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        let payload = GameRoundPayload(game: "NAME",
                                       values: [],
                                       numberOfRounds: 5,
                                       category: GameCategory(displayedName: "family", id: "FAMILY"))
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.round(for: clip.id)).absoluteString,
             error: false)
        service?.gameRound(clip: Mocked.clip,
                           payload: payload,
                           completion: { (response: RoundResponse?, error: Error?) in
                            guard error == nil else { return }
                            guard let response = response else { return }
                            XCTAssert(response.values.count == 5)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameRoundWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        let payload = GameRoundPayload(game: "NAME",
                                       values: [],
                                       numberOfRounds: 5,
                                       category: GameCategory(displayedName: "family", id: "FAMILY"))
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.round(for: clip.id)).absoluteString,
             error: true)
        service?.gameRound(clip: Mocked.clip,
                           payload: payload,
                           completion: { (_, error: Error?) in
                            XCTAssertNotNil(error)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameStart() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        let payload = GameStartPayload(category: GameCategory(displayedName: "family", id: "FAMILY"),
                                       animation: .scrollLeftRight,
                                       game: "NAME",
                                       numberOfRounds: 5,
                                       interval: 5,
                                       values: [],
                                       unique: false)
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.gameStart(for: clip.id)).absoluteString,
             error: false)
        service?.gameStart(clip: clip,
                           payload: payload,
                           completion: { (response: GameResponse?, error: Error?) in
                            guard error == nil else { return }
                            guard let response = response else { return }
                            XCTAssert(response.values.count == 5)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameStartWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let clip = Mocked.clip
        let payload = GameStartPayload(category: GameCategory(displayedName: "family", id: "FAMILY"),
                                       animation: .scrollLeftRight,
                                       game: "NAME",
                                       numberOfRounds: 5,
                                       interval: 5,
                                       values: [],
                                       unique: false)
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.gameStart(for: clip.id)).absoluteString,
             error: true)
        service?.gameStart(clip: clip,
                           payload: payload,
                           completion: { (_, error: Error?) in
                            XCTAssertNotNil(error)
                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameAddToFavourite() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let identifier = Mocked.gameIdentifier
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.addToFavourite(for: identifier)).absoluteString,
             error: false)
        service?.gameAddToFavourite(with: identifier,
                                    completion: { (success: Bool, error: Error?) in
                                        XCTAssertNil(error)
                                        XCTAssert(success)
                                        expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameAddToFavouriteWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let identifier = Mocked.gameIdentifier
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.addToFavourite(for: identifier)).absoluteString,
             error: true)
        service?.gameAddToFavourite(with: identifier,
                                    completion: { (success: Bool, error: Error?) in
                                        XCTAssertNotNil(error)
                                        XCTAssertFalse(success)
                                        expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameDeleteFromFavourite() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let identifier = Mocked.gameIdentifier
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.deleteFromFavourite(for: identifier)).absoluteString,
             error: false)
        service?.gameDeleteFromFavourite(with: identifier,
                                         completion: { (success: Bool, error: Error?) in
                                            XCTAssertNil(error)
                                            XCTAssert(success)
                                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    func test_gameDeleteFromFavouriteWithError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        let identifier = Mocked.gameIdentifier
        mock(endpoint: URL.url(forService: .clip, endpoint: .game, path: Path.deleteFromFavourite(for: identifier)).absoluteString,
             error: true)
        service?.gameDeleteFromFavourite(with: identifier,
                                         completion: { (success: Bool, error: Error?) in
                                            XCTAssertNotNil(error)
                                            XCTAssertFalse(success)
                                            expectation.fulfill()
        })
        wait(for: [expectation], timeout: testTimeout)
    }
    
    // MARK: Mocks
    
    private let baseClips = "https://dev.techcentrix.com/clip/api/clips"
    private let baseGames = "https://dev.techcentrix.com/clip/api/games"
    
    struct Mocked {
        static let gameIdentifier: String = "TEST"
        static let shareCode: String = "DD69DD"
        static let major: Int = 123
        static let minor: Int = 456
        static let clipId: String = "97196cd1-c319-4b12-b841-8f54a309d37f"
        static let userId: String = "b0f63c26-cad2-4903-952e-7287065eb571"
        static let identifier: ClipBeaconIdentifier = ClipBeaconIdentifier(major: Mocked.major, minor: Mocked.minor)
        static let clip: Clip = Clip()
    }
    
    // swiftlint:disable:next function_body_length
    func mock(endpoint: String, error: Bool) {
        switch endpoint {
        case "\(baseClips)/\(Mocked.major).\(Mocked.minor)/available-to-connect":
            mocked(endpoint: endpoint,
                   path: "AvailableToConnectResponse.json",
                   error: error)
        case "\(baseClips)/\(Mocked.clipId)/unshare/\(Mocked.userId)":
            mocked(endpoint: endpoint,
                   empty: true,
                   error: error)
        case "\(baseClips)/\(Mocked.clipId)/shareCode":
            mocked(endpoint: endpoint,
                   empty: true,
                   error: error)
        case "\(baseClips)/":
            mocked(endpoint: endpoint,
                   path: "SingleClipResponse.json",
                   error: error)
        case "\(baseClips)/\(Mocked.shareCode)/addClip":
            mocked(endpoint: endpoint,
                   path: "SingleClipResponse.json",
                   error: error)
        case "\(baseClips)/list":
            mocked(endpoint: endpoint,
                   path: "ClipListResponse.json",
                   error: error)
        case "\(baseClips)/\(Mocked.clipId)":
            mocked(endpoint: endpoint,
                   path: "SingleClipResponse.json",
                   error: error)
        case "\(baseClips)":
            mocked(endpoint: endpoint,
                   path: "SingleClipResponse.json",
                   error: error)
            case "\(baseGames)/active":
            mocked(endpoint: endpoint,
                   path: "GamesResponse.json",
                   error: error)
        case "\(baseGames)":
            mocked(endpoint: endpoint,
                   path: "GamesResponse.json",
                   error: error)
        case "\(baseClips)/adhoc":
            mocked(endpoint: endpoint,
                   path: "AdhocResponse.json",
                   error: error)
        case "\(baseGames)/\(Mocked.clipId)/round":
            mocked(endpoint: endpoint,
                   path: "GameRoundResponse.json",
                   error: error)
        case "\(baseGames)/\(Mocked.gameIdentifier)/addToFavourite":
            mocked(endpoint: endpoint,
                   empty: true,
                   error: error)
        case "\(baseGames)/\(Mocked.gameIdentifier)/deleteFromFavourite":
            mocked(endpoint: endpoint,
                   empty: true,
                   error: error)
        case "\(baseGames)/\(Mocked.clipId)/start":
            mocked(endpoint: endpoint,
                   path: "GameStartResponse.json",
                   error: error)
        default:
            XCTFail("Missing mock for \(endpoint)")
        }
    }
    
    private func mocked(endpoint: String, path: String = "", empty: Bool = false, error: Bool) {
        if error {
            stub(condition: isAbsoluteURLString(endpoint)) { _ in
                return OHHTTPStubsResponse(data: Data(count: 0),
                                           statusCode: 403,
                                           headers: ["Content-Type": "application/json"])
            }
        } else {
            if empty {
                stub(condition: isAbsoluteURLString(endpoint)) { _ in
                    return OHHTTPStubsResponse(data: Data(count: 0),
                                               statusCode: 200,
                                               headers: ["Content-Type": "application/json"])
                }
            } else {
                stub(condition: isAbsoluteURLString(endpoint) && !isMethodDELETE() ) { _ in
                    return self.fileStub(with: path)
                }
                
                stub(condition: isAbsoluteURLString(endpoint) && isMethodDELETE()) { _ in
                    return OHHTTPStubsResponse(data: Data(count: 0),
                                               statusCode: 200,
                                               headers: ["Content-Type": "application/json"])
                }
            }
        }
    }
    
    private func fileStub(with path: String) -> OHHTTPStubsResponse {
        guard let path = OHPathForFile(path, type(of: self)) else {
            return OHHTTPStubsResponse()
        }
        return fixture(filePath: path,
                       headers: ["Content-Type": "application/json"])
    }
}
