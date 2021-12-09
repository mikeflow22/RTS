//
//  Rule.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import Foundation

struct Rule: Codable {
    let halves: Int
    let timePerHalf: Double
    let foulLimit: Int
    let bonusLimit: Int
    let doubleBonusLimit: Int
    let timeouts: Int
}
