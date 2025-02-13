//
//  InvitesCard.swift
//  TrendSwiftApp
//
//  Created by 刘孝文 on 2025/2/13.
//

import Foundation
import SwiftUI

struct InvitesCard: Identifiable, Hashable{
    var id: String = UUID().uuidString
    var image: String
}

let InvitesCards: [InvitesCard] = [
    .init(image: "Apple TV 1"),
    .init(image: "Apple TV 2"),
    .init(image: "Apple TV 3"),
    .init(image: "Apple TV 4"),
    .init(image: "Apple TV 5"),
    .init(image: "Apple TV 6")
]
