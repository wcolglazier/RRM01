//
//  Task.swift
//  RRM01
//
//  Created by william colglazier on 10/08/2023.
//

import SwiftUI

struct Task2: Identifiable {
    var id: UUID = .init()
    var taskTitle: String
    var creationDate: Date = .init()
    var isCompleted: Bool = false
    //var tint: Color
}

var sampleTasks: [Task2] = [
    .init(taskTitle: "Record Video", creationDate: .updateHour(-5), isCompleted: true),
    .init(taskTitle: "Redesign Website", creationDate: .updateHour(-3)),
    .init(taskTitle: "Go for a Walk", creationDate: .updateHour(-4)),
    .init(taskTitle: "Edit Video", creationDate: .updateHour(0)),
    .init(taskTitle: "Publish Video", creationDate: .updateHour(2)),
    .init(taskTitle: "Tweet about new Video!", creationDate: .updateHour(12)),
]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
