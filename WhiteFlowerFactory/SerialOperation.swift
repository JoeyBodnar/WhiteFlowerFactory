//
//  SerialOperation.swift
//  NetworkingFramework
//
//  Created by Stephen Bodnar on 8/15/19.
//  Copyright © 2019 Stephen Bodnar. All rights reserved.
//

import Foundation

class SerialOperation: Operation {
    
    @objc public enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    /// Concurrent queue for synchronizing access to `state`.
    private let stateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".rw.state", attributes: .concurrent)
    
    /// Private backing stored property for `state`.
    private var rawState: OperationState = .ready
    
    /// The state of the operation
    @objc private dynamic var state: OperationState {
        get { return stateQueue.sync { rawState } }
        set { stateQueue.sync(flags: .barrier) { rawState = newValue } }
    }
    
    /// Override default so we can decide when it is finished
    open override var isReady: Bool {
        return state == .ready && super.isReady
    }
    public override var isExecuting: Bool {
        return state == .executing
    }
    public override var isFinished: Bool {
        return state == .finished
    }
    
    /// KVN for dependent properties
    open override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        if ["isReady", "isFinished", "isExecuting"].contains(key) {
            return [#keyPath(state)]
        }
        
        return super.keyPathsForValuesAffectingValue(forKey: key)
    }
    
    /// Start
    public final override func start() {
        if isCancelled {
            finish()
            return
        }
        
        state = .executing
        main()
    }
    
    open override func main() {
        fatalError("subclass must implement")
    }
    
    public final func finish() {
        if !isFinished { state = .finished }
    }
}
