//
//  Protocols.swift
//  edu.ntut.csie.swifttybird
//

import UIKit
import SpriteKit
import CoreGraphics

protocol GameSceneProtocol {
    var scene: SKScene? { get }
    
    var updatables: [Updatable] { get }
    var touchables: [Touchable] { get }

    init?(with scene: SKScene)
}

protocol PhysicsContactable {
    var shouldEnablePhysics: Bool { get set }
    var collisionBitMask: UInt32 { get }
}

protocol Playable: class {
    var isAffectedByGravity: Bool { get set }
    var size: CGSize { get set }
}

protocol Touchable: class {
    var shouldAcceptTouches: Bool { get set }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
}


protocol Updatable: AnyObject {
    var delta: TimeInterval { get }
    var lastUpdateTime: TimeInterval { get }
    var shouldUpdate: Bool { get set }
    
    func update(_ currentTime: TimeInterval)
}
