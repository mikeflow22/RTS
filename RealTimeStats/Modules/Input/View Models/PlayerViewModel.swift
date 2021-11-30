//
//  PlayerViewModel.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 10/23/21.
//

import Foundation

class PlayerViewModel {
    private let player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    var name: String {
        player.name
    }
    
    var number: Int {
        player.number
    }
    
    var points: Int {
        player.points
    }
    var fouls: Int {
        player.totalFouls
    }
    var rebounds: Int {
        player.totalRebound
    }
    
    func add2fga() -> Int {
        print("\(player.name)'s 2fg attempts: \(player.fga2)")
        player.fga2 += 1
        return player.fga2
    }
    
    func add2fgm() -> Int {
        print("\(player.name)'s 2fg made: \(player.fgm2)")
        player.fgm2 += 1
       return player.fgm2
    }
}
