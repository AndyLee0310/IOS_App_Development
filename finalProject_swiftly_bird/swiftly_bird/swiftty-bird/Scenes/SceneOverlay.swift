//
//  SceneOverlay.swift
//  edu.ntut.csie.swifttybird
//

import SpriteKit

func *(lhs: CGSize, value: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * value, height: lhs.height * value)
}

class SceneOverlay {
    let backgroundNode: SKSpriteNode
    let contentNode: SKSpriteNode
    
    init(overlaySceneFileName fileName: String, zPosition: CGFloat) {
        let overlayScene = SKScene(fileNamed: fileName)!
        let contentTemplateNode = overlayScene.childNode(withName: "Overlay") as! SKSpriteNode
        
        backgroundNode = SKSpriteNode(color: contentTemplateNode.color, size: contentTemplateNode.size * UIScreen.main.scale)
        backgroundNode.zPosition = zPosition

        contentNode = contentTemplateNode.copy() as! SKSpriteNode
        contentNode.position = .zero
        backgroundNode.addChild(contentNode)
        
        contentNode.color = .clear
    }
}
