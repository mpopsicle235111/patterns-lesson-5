//
//  Task Model.swift
//  Patterns-Hometask-5
//
//  Created by Anton Lebedev on 12.04.2022.
//

import Foundation

///Base protocol for files and folders (folder is also a file actually)
protocol CompositeTask {
    
    var folderTask: CompositeTask? { get }
    var fileTasks: [Task] { get set }
    var taskName: String { get }
    
    func addNewTask(fileTask: Task)
}




class Task : CompositeTask {
    
    //Higher level task is folder, lower level tasks are files in folder
    var folderTask: CompositeTask?
    var fileTasks: [Task] = []
    var taskName: String
    
    //Since there are var variables, we need to initialize them here
    init(taskName: String, folderTask: CompositeTask?) {
        self.taskName = taskName
        self.folderTask = folderTask
    }
    
    /// This func adds lower level tasks to array of childrenTasks
    func addNewTask(fileTask: Task) {
        fileTasks.append(fileTask)
    }
}
