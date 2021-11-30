//
//  PlayByPlayViewModel.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/1/21.
//

import Foundation

struct PlayByPlayViewModel {

    static var plays: [Play] = [
    Play(player: Player(name: "Michael", number: 25), action: Action(breaks: .halves, time: 12.34, stat: .oRebound)),
    Play(player: Player(name: "Jonte", number: 24), action: Action(breaks: .halves, time: 12.44, stat: .offFoul)),
    Play(player: Player(name: "Marques", number: 21), action: Action(breaks: .halves, time: 13.04, stat: .assist)),
    Play(player: Player(name: "Jay Jay", number: 22), action: Action(breaks: .halves, time: 13.25, stat: .defFoul)),
    Play(player: Player(name: "Jason", number: 23), action: Action(breaks: .halves, time: 13.59, stat: .dRebound)),
    Play(player: Player(name: "Michael", number: 25), action: Action(breaks: .halves, time: 14.02, stat: .block))
    ]
    
    static func createPlayWith(player: Player, andAction action: Action) -> Play {
        return Play(player: player, action: action)
    }
    static func addPlayToPlaysArray(_ play: Play) {
        print("this is before the play is added to the array count: \(PlayByPlayViewModel.plays.count)")
        plays.insert(play, at: 0)
        print("play added to pbp array. here is the count now: \(PlayByPlayViewModel.plays.count)")
        //save
    }
}
