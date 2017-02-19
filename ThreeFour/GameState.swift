//
//  GameState.swift
//  ThreeFour
//
//  Created by Danny Chew on 2/19/17.
//  Copyright © 2017 Danny Chew. All rights reserved.
//

import Foundation

enum State: Int {
    case gameOver = -1
    case gameContinue = 0
    case win = 1
    case tie = 2
}

class GameState {
    static var playerTurn = true
    var streak: [[Int]] = [[Int]]()
    var grid: [[Int]] = [[Int]]()
    var multiples: [Multiple<Int>] = [Multiple<Int>]()
    var currentStatus: Int
    
    
    required init(streak: [[Int]]) {
        self.streak = streak;
        currentStatus = State.gameContinue.rawValue
    }
    convenience init(grid:[[Int]], streak: [[Int]]) {

        self.init(streak: streak)
        self.grid = grid
    }
    
    //copying from another state source
    convenience init(state: GameState) {
        var temp: [[Int]] = [[Int]]()
        for i in 0..<state.streak.count{
            for j in 0..<state.streak.count {
                temp[i][j] = state.streak[i][j]
            }
        }
        self.init(streak: temp)
    }
    
    func gameOver() -> Bool {
        return checkStreak() != State.gameContinue.rawValue
    }
    
    func checkFactors(n: Int) -> Bool {
        var legalMove: Bool = false
        for i in 1...7 {
            for j in 1...7 {
                if (i*j ==  n) {
                    let m: Multiple<Int> = Multiple<Int>(item: i,item2: j)
                    if (multiples.count < 1) {
                        multiples.append(m)
                    }
                    else {
                        for mul in multiples {
                            if mul.contains(m: m) {
                                multiples.removeAll()
                                multiples.append(m)
                                legalMove = true
                            }
                        }
                    }
                }
            }
        }
        return legalMove
    }
    
    //FIXME:
    func applyMove(y: Int, x: Int) -> Bool {
        if (checkFactors(n: grid[y][x])){
        streak[y][x] = (GameState.playerTurn) ? PlayerType.HumanPlayer1.rawValue : PlayerType.Bot.rawValue
        
        GameState.playerTurn = !GameState.playerTurn
        return true
        }
        return false
    }
    func checkStreak() -> Int {
        //assume array is full
        var arrayFull:Bool = true
        
        //horizontal checking
        for i in 0..<self.streak.count{
            for j in 0..<self.streak.count-2 {
                if streak[i][j] == 0 {
                    arrayFull = false
                }
                if streak[i][j] == streak[i][j+1] {
                    if streak[i][j] == streak [i][j+2] {
                        //streak found
                        let value = streak[i][j]
                        if (value == PlayerType.Bot.rawValue) {
                            return State.gameOver.rawValue
                        }
                        else {
                           return State.win.rawValue
                        }
                    }
                }
            }
        }
        
        //vertical checking
        for j in 0..<self.streak.count{
            for i in 0..<self.streak.count-2 {
                if streak[i][j] == 0 {
                    arrayFull = false
                }
                if streak[i][j] == streak[i+1][j] {
                    if streak[i][j] == streak [i+2][j] {
                        //streak found
                        let value = streak[i][j]
                        if (value == PlayerType.Bot.rawValue) {
                            return State.gameOver.rawValue
                        }
                        else {
                            return State.win.rawValue
                        }
                    }
                }
            }
        }
        
        //diagonal from top left
        for i in 0 ..< self.streak.count-2 {
            if (streak[i][i] == streak[i+1][i+1]) {
                if streak[i][i] == streak[i+2][i+2] {
                    //streak found
                    let value = streak[i][i]
                    if (value == PlayerType.Bot.rawValue) {
                        return State.gameOver.rawValue
                    }
                    else {
                        return State.win.rawValue
                    }
                }
            }
        }
        // at (1,0) checking
        var i = 1
            if (streak[i][i-1] == streak[i+1][i-1+1]) {
                if streak[i][i-1] == streak[i+2][i-1+2] {
                    //streak found
                    let value = streak[i][i-1]
                    if (value == PlayerType.Bot.rawValue) {
                        return State.gameOver.rawValue
                    }
                    else {
                        return State.win.rawValue
                    }
                }
            
        }
        
        // at (0,1) checking
         i = 0
            if (streak[i][i+1] == streak[i+1][i+1+1]) {
                if streak[i][i+1] == streak[i+2][i+1+2] {
                    //streak found
                    let value = streak[i][i+1]
                    if (value == PlayerType.Bot.rawValue) {
                        return State.gameOver.rawValue
                    }
                    else {
                        return State.win.rawValue
                    }
                }
            
        }
        
        //Diagonal from top right
        for i in 0..<streak.count-2 {
            if (streak[i][streak.count-1-i] == streak[i+1][streak.count-1-(i+1)]) {
                if (streak[i][streak.count-1-i] == streak[i+2][streak.count-1-(i+2)]) {
                    //streak found
                    let value = streak[i][streak.count-1-i]
                    if (value == PlayerType.Bot.rawValue) {
                        return State.gameOver.rawValue
                    }
                    else {
                        return State.win.rawValue
                    }
                }
            }
        }
        
        //Diagonal from (1,3)
        i = 1
        if (streak[i][streak.count-i] == streak[i+1][streak.count-(i+1)]) {
            if streak[i][streak.count-i] == streak[i+2][streak.count-(i+2)] {
                //streak found
                let value = streak[i][streak.count-i]
                if (value == PlayerType.Bot.rawValue) {
                    return State.gameOver.rawValue
                }
                else {
                    return State.win.rawValue
                }
            }
            
        }
        //Diagonal from (0,2)
        i = 0
        if (streak[i][streak.count-2-i] == streak[i+1][streak.count-2-(i+1)]) {
            if streak[i][streak.count-2-i] == streak[i+2][streak.count-2-(i+2)] {
                //streak found
                let value = streak[i][streak.count-2-i]
                if (value == PlayerType.Bot.rawValue) {
                    return State.gameOver.rawValue
                }
                else {
                    return State.win.rawValue
                }
            }
            
        }
        if (arrayFull) {
            
            return State.tie.rawValue
        }
        return State.gameContinue.rawValue
        
    }
    
}
