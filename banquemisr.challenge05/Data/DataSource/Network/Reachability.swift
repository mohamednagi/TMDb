//
//  Reachability.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Nagi on 24/01/2025.
//

import Network

class Reachability {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var isReachable = false
    static let shared = Reachability()
    
    private init() {
        monitor.pathUpdateHandler = {[weak self] path in
            guard let `self` = self else {return}
            self.isReachable = path.status == .satisfied
        }
        
        monitor.start(queue: queue)
    }
    
    func isReachableNow() -> Bool {
        return isReachable
    }
}
