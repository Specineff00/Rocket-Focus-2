//
//  TimeInterval+Additions.swift
//  Rocket Focus 2
//
//  Created by Yogesh Nikash Ramsorrun on 20/10/2022.
//

import Foundation

extension TimeInterval {
    func toHoursMinutesSeconds() -> (Int, Int, Int) {
        let seconds = Int(self)
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
