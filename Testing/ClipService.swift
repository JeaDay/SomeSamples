//
//  ClipService.swift
//  TechCentrix
//
//  Created by Kuba Reinhard on 19/12/2019.
//  Copyright © 2018 TechCentrix. All rights reserved.
//

import Foundation

class ClipNetworkService {
    let clientManager: NetworkClientManagerProtocol
    let processor: ResponseProcessorProtocol
    
    init(clientManager: NetworkClientManagerProtocol = Toybox.shared.networkClientManager, processor: ResponseProcessorProtocol = ResponseProcessor()) {
        self.clientManager = clientManager
        self.processor = processor
    }
    
    func getAvailability(for identifier: ClipBeaconIdentifier, completion: ((_ response: AvailabilityResponse?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.availableToConnect(for: identifier))
        
        self.clientManager.performRequest(with: url, method: .get) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func addClip(with payload: AddClipPayload, completion: ((_ pet: Clip?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips)
        self.clientManager.performRequest(with: url, method: .post, body: payload.json) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func addClip(with payload: JoinClipPayload, completion: ((_ pet: Clip?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.addClip(with: payload))
        self.clientManager.performRequest(with: url, method: .post) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func update(clip: Clip, with payload: UpdateClipPayload, completion: ((_ pet: Clip?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.clip(for: clip))
        self.clientManager.performRequest(with: url, method: .put, body: payload.json) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func delete(clip: Clip, completion: ((Bool, Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.clip(for: clip))
        self.clientManager.performRequest(with: url, method: .delete) { (data: Data?, error: Error?) in
            if let data: Data = data, data.isEmpty {
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
    
    func unshare(with payload: UnshareClipPayload, completion: ((Bool, Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.unshareClip(with: payload))
        self.clientManager.performRequest(with: url, method: .post) { (data: Data?, error: Error?) in
            if let data: Data = data, data.isEmpty {
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
    
    func share(clip: Clip, with payload: ShareClipToPhoneNumberPayload, completion: ((Bool, Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.share(clip: clip))
        self.clientManager.performRequest(with: url, method: .post, body: payload.json) { (data: Data?, error: Error?) in
            if let data: Data = data, data.isEmpty {
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
    
    func getClips(with completion: ((_ clipListResponse: ArrayResponse<Clip>?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.list)
        self.clientManager.performRequest(with: url, method: .get) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func getMessages(with payload: AdHocMessagePayload, completion: ((_ messagesResponse: ArrayResponse<String>?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .clips, path: Path.adhoc)
        self.clientManager.performRequest(with: url, method: .put, body: payload.json) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    // MARK: Games
    
    func games( completion: ((_ messagesResponse: ArrayResponse<NetworkGame>?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .game)
        self.clientManager.performRequest(with: url, method: .get) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func gamesActive( completion: ((_ messagesResponse: ArrayResponse<NetworkGame>?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .game, path: Path.active)
        self.clientManager.performRequest(with: url, method: .get) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func gameRound(clip: Clip, payload: GameRoundPayload, completion: ((_ round: RoundResponse?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .game, path: Path.round(for: clip.id))
        self.clientManager.performRequest(with: url, method: .post, body: payload.json) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func gameStart(clip: Clip, payload: GameStartPayload, completion: ((_ game: GameResponse?, _ error: Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .game, path: Path.gameStart(for: clip.id))
        self.clientManager.performRequest(with: url, method: .post, body: payload.json) { (data: Data?, error: Error?) in
            if let data: Data = data {
                self.processor.process(data: data, completionHandler: completion)
            } else {
                completion?(nil, error)
            }
        }
    }
    
    func gameAddToFavourite(with identifier: String, completion: ((Bool, Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .game, path: Path.addToFavourite(for: identifier))
        self.clientManager.performRequest(with: url, method: .post) { (data: Data?, error: Error?) in
            if let data: Data = data, data.isEmpty {
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
    
    func gameDeleteFromFavourite(with identifier: String, completion: ((Bool, Error?) -> Void)?) {
        let url: URL = URL.url(forService: .clip, endpoint: .game, path: Path.deleteFromFavourite(for: identifier))
        self.clientManager.performRequest(with: url, method: .post) { (data: Data?, error: Error?) in
            if let data: Data = data, data.isEmpty {
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
}

extension Path {
    static let list: String = "/list"
    static let adhoc: String = "/adhoc"
    
    static let active: String = "/active"
    
    static func gameStart(for identifier: String) -> String {
        return "/\(identifier)/start"
    }
    
    static func round(for identifier: String) -> String {
        return "/\(identifier)/round"
    }
    
    static func addToFavourite(for identifier: String) -> String {
        return "/\(identifier)/addToFavourite"
    }
    
    static func deleteFromFavourite(for identifier: String) -> String {
        return "/\(identifier)/deleteFromFavourite"
    }
    
    static func availableToConnect(for id: ClipBeaconIdentifier) -> String {
        return "/\(id.combined)/available-to-connect"
    }
    
    static func clip(for clip: Clip) -> String {
        return "/\(clip.id)"
    }
    
    static func addClip(with payload: JoinClipPayload) -> String {
        return "/\(payload.shareCode)/addClip"
    }
    
    static func unshareClip(with payload: UnshareClipPayload) -> String {
        return "/\(payload.clipId)/unshare/\(payload.userId)"
    }
    
    static func share(clip: Clip) -> String {
        return "/\(clip.id)/shareCode"
    }
}

enum GameAnimation: String, Codable {
    case scrollLeftRight = "SCROLL_LEFT_RIGHT"
}
