//
//  Player.swift
//  ThreeFour
//
//  Created by Danny Chew on 2/19/17.
//  Copyright © 2017 Danny Chew. All rights reserved.
//

import Foundation
enum PlayerType: Int {
    case Bot = 1
    case HumanPlayer1
    case HumanPlayer2
    
}
class Player {
    var bestMove: Square
    //overriden method
    func move(state: GameState) {
        //do something
    }
    init() {
        bestMove = Square(x: 0, y: 0)
    }
    
}

