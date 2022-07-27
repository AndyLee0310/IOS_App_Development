//
//  ScoresScene.swift
//  edu.ntut.csie.swifttybird
//
import SpriteKit
import FirebaseFirestore

class ScoresScene: RoutingUtilityScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        fetchScores()
        advanceRainParticleEmitter(for: 10)
    }
    
    private func advanceRainParticleEmitter(for amount: TimeInterval) {
        let particleEmitter = childNode(withName: "Rain Particle Emitter") as? SKEmitterNode
        particleEmitter?.advanceSimulationTime(amount)
    }
    
    private func fetchScores() {
        var bestScore: Int = 0
        
        if let bestScoreLabel = self.scene?.childNode(withName: "Best Score Label") as? SKLabelNode {
            bestScore = UserDefaults.standard.integer(for: .bestScore)
            bestScoreLabel.text = "Best: \(bestScore)"
        }
        
        if let lastScoreLabel = self.scene?.childNode(withName: "Last Score Label") as? SKLabelNode {
            let lastScore = UserDefaults.standard.integer(for: .lastScore)
            lastScoreLabel.text = "Last: \(lastScore)"
        }
        
        let db = Firestore.firestore()
        let currentDeviceID = UIDevice.current.identifierForVendor!.uuidString
        
        let score = Score(deviceId: currentDeviceID, score: bestScore)
        do {
            try db.collection("leaderboard").document(currentDeviceID).setData(from: score)
        } catch { print(error) }

        db.collection("leaderboard").order(by: "score", descending: true).limit(to: 5).getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let scores = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: Score.self)
            }
            
            for i in scores.indices {
                if let leaderboard = self.scene?.childNode(withName: "Leaderboard\(i+1)") as? SKLabelNode {
                    let deviceId = scores[i].deviceId
                    let prefix = deviceId.prefix(4)
                    let suffix = deviceId.suffix(4)
                    leaderboard.text = "\(prefix)...\(suffix)    \(scores[i].score)"
                    
                    if deviceId == currentDeviceID {
                        leaderboard.fontColor = UIColor.yellow
                    }
                }
            }
        }
    }
}
