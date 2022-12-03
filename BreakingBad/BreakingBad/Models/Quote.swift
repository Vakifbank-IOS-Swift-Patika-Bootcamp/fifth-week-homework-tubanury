//
//  Quote.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 26.11.2022.
//

import Foundation
struct Quote: Codable {
    let quoteID: Int
    let quote, author, series: String

    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case quote, author, series
    }
}

typealias QuotesResponse = [Quote]
