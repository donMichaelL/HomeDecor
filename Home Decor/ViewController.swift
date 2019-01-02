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
        sceneView.session.run(config)
        
        let capsuleNode = SCNNode(geometry: SCNCapsule(capRadius: 0.03, height: 0.1))
        capsuleNode.position = SCNVector3(0.1, 0.1, -0.1)
        capsuleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        capsuleNode.eulerAngles = SCNVector3(0, 0, Double.pi/2)
        sceneView.scene.rootNode.addChildNode(capsuleNode)
    }


}

