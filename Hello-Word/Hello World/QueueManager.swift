//
//  QueueManager.swift
//  Hello World
//
//  Created by Ayushi on 2019-10-29.
//  Copyright © 2019 Ayushi. All rights reserved.
//


import Foundation
import UIKit

class BOperation: Operation {
    
    var queueHandler: queueHandler?
    
    private var indexPath: IndexPath?
    
    override var isAsynchronous: Bool {
        get {
            return  true
        }
    }
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    func executing(_ executing: Bool) {
        _executing = executing
    }
    
    func finish(_ finished: Bool) {
        _finished = finished
    }
    
    required init (indexPath: IndexPath?) {
        self.indexPath = indexPath
    }
    
    
    
    /*override func start() {
     if self.isCancelled {
     finish(true)
     }
     main()
     }*/
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        self.executing(true)
        //Asynchronous logic (eg: n/w calls) with callback
        self.getIndexQueueHandler()
    }
    
    func getIndexQueueHandler() {
        sleep(2)
        self.queueHandler?(self.indexPath,nil)
    }
    
}


// QueueManager

typealias queueHandler = (_ indexPath: IndexPath?, _ error: Error?) -> Void

final class QueueManager {
    
    private var completionHandler: queueHandler?
    
    lazy var queue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.bold.queue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    static let shared = QueueManager()
    private init () {}
    
    func getIndexQueue(indexPath: IndexPath?, handler: @escaping queueHandler) {
        
        self.completionHandler = handler
        
        let operation = BOperation(indexPath: indexPath)
        operation.queuePriority = .high
        operation.queueHandler = { (indexPath, error) in
            self.completionHandler?(indexPath, error)
        }
        queue.addOperation(operation)
    }
    
}
