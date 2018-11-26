//
//  ViewController.swift
//  AR+Paribus
//
//  Created by Ehlers, Drew on 6/6/18.
//  Copyright © 2018 Ehlers, Drew. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    @IBOutlet var sceneView: ARSCNView!
    @IBAction func executeButton1(_ sender: UIButton) {
        let text = "Vendor: Amazon\nPrice: $50.00"
        //let shirt1 = UIImage(named: "art.scnassets/buttonDown1.jpg")
        let shirt2 = UIImage(named: "art.scnassets/buttonDown2.jpg")
        let shirt3 = UIImage(named: "art.scnassets/buttonDown3.jpg")
        getCurrentFrame(img1: shirt1!, img2: shirt2!, img3: shirt3!, description: text)
    }
    @IBAction func executeButton2(_ sender: UIButton) {
        let text = "Vendor: Amazon\nPrice: $50.00"
        let shirt1 = UIImage(named: "art.scnassets/greyJacket1.jpg")
        let shirt2 = UIImage(named: "art.scnassets/greyJacket2.jpg")
        let shirt3 = UIImage(named: "art.scnassets/greyJacket3.jpg")
        getCurrentFrame(img1: shirt1!, img2: shirt2!, img3: shirt3!, description: text)
    }
    @IBAction func executeButton3(_ sender: UIButton) {
        let text = "Vendor: Amazon\nPrice: $50.00"
        let shirt1 = UIImage(named: "art.scnassets/blueShirt1.jpg")
        let shirt2 = UIImage(named: "art.scnassets/blueShirt2.jpg")
        let shirt3 = UIImage(named: "art.scnassets/blueShirt3.jpg")
        getCurrentFrame(img1: shirt1!, img2: shirt2!, img3: shirt3!, description: text)
    }
    func getCurrentFrame(img1: UIImage, img2: UIImage, img3: UIImage, description: String) {
        let image = sceneView.snapshot()
        /*
        let json: [String: Any] = ["image": encoding]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: "http://192.241.147.111:7000/search/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()*/
        
        // Set scale, position, and direction values
        let scaleVector = SCNVector3(x: 0.002, y: 0.002, z: 0.002)
        let position = sceneView.session.currentFrame?.camera.transform.columns.3
        let direction = sceneView.session.currentFrame?.camera.transform.columns.2
        let pos_x = position?.x, pos_y = position?.y, pos_z = position?.z
        let dir_x = direction?.x, dir_y = direction?.y, dir_z = direction?.z
        
        // Text node
        let text = SCNText(string: description, extrusionDepth: 1)
        let textMaterial = SCNMaterial()
        textMaterial.diffuse.contents = UIColor.green
        text.materials = [textMaterial]
        
        let textNode = SCNNode()
        textNode.position = SCNVector3(x: pos_x! - 0.15, y: pos_y! - 0.2, z: pos_z! - 1.0)
        textNode.scale = scaleVector
        textNode.geometry = text
        
        // Image nodes
        let image1 = SCNPlane(width: 50.0, height: 50.0), image2 = SCNPlane(width: 50.0, height: 50.0), image3 = SCNPlane(width: 50.0, height: 50.0)
        let image1Mat = SCNMaterial(), image2Mat = SCNMaterial(), image3Mat = SCNMaterial()
        image1Mat.diffuse.contents = img1; image2Mat.diffuse.contents = img2; image3Mat.diffuse.contents = img3
        image1.materials = [image1Mat]; image2.materials = [image2Mat]; image3.materials = [image3Mat]
        
        var image1Node = SCNNode(), image2Node = SCNNode(), image3Node = SCNNode()
        image1Node.position = SCNVector3(x: pos_x! - 0.15, y: pos_y! - 0.3, z: pos_z! - 1.0)
        image2Node.position = SCNVector3(x: pos_x! - 0.025, y: pos_y! - 0.3, z: pos_z! - 1.0)
        image3Node.position = SCNVector3(x: pos_x! + 0.1, y: pos_y! - 0.3, z: pos_z! - 1.0)
        image1Node.scale = scaleVector; image2Node.scale = scaleVector; image3Node.scale = scaleVector
        image1Node.geometry = image1; image2Node.geometry = image2; image3Node.geometry = image3

        // Add nodes to scene
        sceneView.scene.rootNode.addChildNode(textNode)
        sceneView.scene.rootNode.addChildNode(image1Node)
        sceneView.scene.rootNode.addChildNode(image2Node)
        sceneView.scene.rootNode.addChildNode(image3Node)
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        //self.initialPosition = sceneView.session.currentFrame?.camera.transform.columns.3
        //self.initialDirection = sceneView.session.currentFrame?.camera.transform.columns.2
        
        /**
        let text = SCNText(string: "Product: shirt\nBest deal: Amazon\nPrice: 50$", extrusionDepth: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        text.materials = [material]


        let node = SCNNode()
        node.position = SCNVector3(x: -0.125, y: -0.25, z: -1)
        node.scale = SCNVector3(x: 0.002, y: 0.002, z: 0.002)
        node.geometry = text

        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
         
        while(true){
            var curPos = sceneView.session.currentFrame?.camera.transform.columns.3
            var phone_x = curPos?.x
            var phone_y = curPos?.y
            var phone_z = curPos?.z

            print("Pos")
            print(phone_x)
            print(phone_y)
            print(phone_z)
        }
        
        if let frame = self.sceneView.session.currentFrame{
            let mat = SCNMatrix4(frame.camera.transform)
            //let pos = SCNVector3(mat.m41, mat.m42, mat.m43);
            //print( pos)
            print(mat.m41)
            print(mat.m42)
            print(mat.m43)
        }*/
        
        /**
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
