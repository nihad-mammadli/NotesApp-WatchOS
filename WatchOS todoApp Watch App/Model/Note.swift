//
//  Task.swift
//  WatchOS todoApp Watch App
//
//  Created by Nebula on 26.07.24.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
