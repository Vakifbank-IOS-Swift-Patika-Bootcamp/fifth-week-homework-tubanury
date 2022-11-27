//
//  Episode.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 25.11.2022.
//

import Foundation

struct Episode: Codable {
    let episodeID: Int
    let title, season, airDate: String
    let characters: [String]
    let episode: String
    let series: Series

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title, season
        case airDate = "air_date"
        case characters, episode, series
    }
}

enum Series: String, Codable {
    case breakingBad = "Breaking Bad"
}


typealias EpisodesResponse = [Episode]
