//
//  GameScene.swift
//  ThreeFour
//
//  Created by Danny Chew on 2/19/17.
//  Copyright © 2017 Danny Chew. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var box10 = SKSpriteNode()
    var score = Int()
    var multipleLabel = SKLabelNode()
    var homeButton = SKSpriteNode()
    var gameStarted = Bool()
    var layerPosition = CGPoint()
    let NumColumns = 4
    let NumRows = 4
    var blockHeight = 200
    var blockWidth = 200
    var gridWidth = 10
    var gridHeight = 10
    let spaceBetweenBlock = 4
    var backgroundNode = SKSpriteNode()
    var test = Match()
    var selectedNode: SKNode? = nil

    override func didMove(to view: SKView) {
        createGrid()
    }
    
    func createGrid() {
        //create backgroundImage
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = (self.view?.scene?.size)!
        background.anchorPoint = anchorPoint
        background.zPosition = -1
        addChild(background)
        
        //the grid
        gridWidth = (Int) (self.size.width)
        gridHeight = gridWidth
        
        blockWidth = (gridWidth - (spaceBetweenBlock * (NumColumns + 1))) / NumColumns
        blockHeight = (gridHeight - (spaceBetweenBlock * (NumRows + 1))) / NumRows

        backgroundNode = SKSpriteNode()
        backgroundNode.size = CGSize(width: gridWidth, height: gridHeight)
        backgroundNode.anchorPoint = CGPoint.zero
        
        backgroundNode.zPosition = 0
        backgroundNode.color = UIColor.black
        backgroundNode.position = CGPoint(x: 0, y: 50)
        backgroundNode.name = "background"
        self.addChild(backgroundNode)
        test = Match()
        
        for y in 0..<NumRows {
            for x in 0..<NumColumns {
                let tile = SKSpriteNode()
                tile.anchorPoint = CGPoint(x: 0, y:0)
                
                tile.zPosition = 1
                tile.size = CGSize(width: blockWidth, height: blockHeight)
                tile.position = CGPoint(x: -gridWidth / 2 + ((x * blockWidth) + spaceBetweenBlock * (x+1)), y:-gridWidth / 3 + ((y * blockWidth) + spaceBetweenBlock * (y+1)))
                print(tile.position.x , tile.position.y)
                
               
                tile.name = "node: \(x)_\(y)"
                
           
                let gameValue  = test.getValue(x:x, y:y)
                let label = addLabel(label: String(gameValue))
                               backgroundNode.addChild(tile)
                tile.color = UIColor.white
                tile.addChild(label)
 
                
                
            }
        }
               //   test.play()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        for touch in touches {
            

        }
    }
    func addLabel(label: String) -> SKLabelNode {
        var node = SKLabelNode()
        node.text = label
        node.fontName = "Noteworthy-Bold"
        node.fontSize = 45
        node.fontColor = UIColor.brown
        node.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        node.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        node.zPosition = 1
        node.position = CGPoint(x: blockWidth/2, y: blockHeight/2)
        return node
    }
    

    
      
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
