//
//  ViewController.swift
//  Home Decor
//
//  Created by Michael Loukeris on 02/01/2019.
//  Copyright © 2019 Michael Loukeris. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        config.planeDetection = .horizontal
        sceneView.session.run(config)
        
        sceneView.delegate = self
        
    }

    func addCapsuleToTheScene() {
        let capsuleNode = SCNNode(geometry: SCNCapsule(capRadius: 0.03, height: 0.1))
        capsuleNode.position = SCNVector3(0.1, 0.1, -0.1)
        capsuleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        capsuleNode.eulerAngles = SCNVector3(0, 0, Double.pi/2)
        sceneView.scene.rootNode.addChildNode(capsuleNode)
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        
        node.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        let planeNode = createFloorNode(anchor: planeAnchor)
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARPlaneAnchor else {
            return
        }
        
        node.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
    }
    
    
    func createFloorNode(anchor: ARPlaneAnchor) -> SCNNode {
        let floorNode = SCNNode(geometry: SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z)))
        floorNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        floorNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "floor.jpg")
        floorNode.geometry?.firstMaterial?.isDoubleSided = true
        floorNode.eulerAngles = SCNVector3(Double.pi/2, 0, 0)
        return floorNode
    }
}
