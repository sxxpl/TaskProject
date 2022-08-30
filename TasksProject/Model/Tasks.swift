//
//  Tasks.swift
//  TasksProject
//
//  Created by Артем Тихонов on 24.08.2022.
//

import Foundation
protocol TaskProtocol {
    var description:String {get set}
    var inTasks:[TaskProtocol] {get set}
}


struct Tasks:TaskProtocol{
    var description:String = ""
    var inTasks: [TaskProtocol] = []
}
