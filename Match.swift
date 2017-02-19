//
//  Match.swift
//  ThreeFour
//
//  Created by Danny Chew on 2/19/17.
//  Copyright © 2017 Danny Chew. All rights reserved.
//

import Foundation

class Match {
    var gameContext: GameState
    var player1: HumanPlayer
    var player2: AIPlayer
    var randomNum: [[Int]]
    var streak: [[Int]]
    
    init() {
        randomNum = [[Int]]()
        streak = [[Int]] ()
        player1 = HumanPlayer()
        player2 = AIPlayer()
        gameContext = GameState(streak: streak)
        generateRandom()
        initStreak()
        printArray()
    }
    
    func initStreak() {
        streak = [[Int]]()
        for i in 0..<4 {
            streak.append([Int]())
            for _ in 0..<4 {
                streak[i].append(0)
            }
        }
    }
    
    func play() {
        while (!gameContext.gameOver()) {
            if (GameState.playerTurn) {
                print("Players turn")
              player1.move(state: gameContext)
            }
            else{ //bot
                print("Bots turn")
            player2.move(state: gameContext)
            }
        }
        switch (gameContext.checkStreak()) {
        case State.tie.rawValue:
            print("It's a tie!")
        case State.win.rawValue:
            print("WIN LA ")
        case State.gameOver.rawValue:
            print("YOU LLOSE BOOOOOOO")
        default://shouldnt be here
            print("Fatal Error")
        }
    }
    
    func generateRandom() {
        var array:[Int] = [Int]()
        for i in 0..<16 {
            var integer = Int(arc4random_uniform(UInt32(7*7)))
            if (i == 0) {array.append(integer)}
            else {
                while(array.contains(integer) || integer == 0) {
                    integer = Int(arc4random_uniform(UInt32(7*7)))
                }
                array.append(integer)
            }
            
        }
        randomNum = [[Int]]()
        for i in 0..<4 {
            randomNum.append([Int]())
            for j in 0..<4 {
                randomNum[i].append(array[i*4 + j])
            }
        }
    }
    func getValue(x: Int, y:Int)-> Int {
        return randomNum[y][x]
    }
    func printArray() {
        for i in 0..<4 {
            for j in 0..<4 {
                print(randomNum[i][j])
            }
            print("\n")
        }
    }
    
}
