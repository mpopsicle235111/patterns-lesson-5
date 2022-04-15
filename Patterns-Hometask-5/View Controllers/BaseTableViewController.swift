//
//  BaseTableViewController.swift
//  Patterns-Hometask-5
//
//  Created by Anton Lebedev on 11.04.2022.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    
    @IBAction func addTaskButtonAction(_ sender: Any) {
        
        PopUpMessage().popUpMessage() { [weak self] userInput in
            guard let self = self else { return }
            //We check that the user input is not empty
            guard userInput != "" else { return }
            
            self.chainOfTasks.addNewTask(fileTask: Task(taskName: userInput, folderTask: self.chainOfTasks))
            
            self.tableView.reloadData()
        }
    }
    var chainOfTasks = Task(taskName: "Base Tasks", folderTask: nil)
    
    //For Memento
    private let recordsCaretaker = RecordsCaretaker()
    var runTimeCounter = 0
    var retrievedName : String = ""
    var retrievedNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = chainOfTasks.taskName
        
        //Read from Memento
        var retrievedRecords = recordsCaretaker.retrieveRecords()
        print(retrievedRecords)
        retrievedName = String(retrievedRecords[0])
        retrievedNumber = retrievedRecords[1]
        
        
        //Refresh table for the first-time display
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.reloadData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        //We do not have any subsections here
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //We have as many rows, as we have fileTasks in chainOfTasks folder
        return chainOfTasks.fileTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //for Memento
        let retrievedRecords = recordsCaretaker.retrieveRecords()
        
        //We display occupied cells as Folders, and display the regular cells as plain regular cells
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseFolderCell", for: indexPath) as? BaseFolderCell else { return UITableViewCell() }
       
        if runTimeCounter == 0 {
        let taskName = String("\(chainOfTasks.fileTasks[indexPath.row].taskName)")
        let counterForLevel2Tasks = chainOfTasks.fileTasks[indexPath.row].fileTasks.count
        }
        
        let taskName = String(retrievedRecords[0])
        let counterForLevel2Tasks = Int(retrievedRecords[1])
        
        cell.accessoryType = .disclosureIndicator
        
        cell.configurator(taskName: taskName, counterForLevel2Tasks: counterForLevel2Tasks)
        
        //Write to Memento
        let records = [Record(name: taskName, number: counterForLevel2Tasks)]
        recordsCaretaker.save(records: records)
        runTimeCounter += runTimeCounter
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToLevel2TableViewController", let cell = (sender as? UITableViewCell) {
            guard let ctrl = segue.destination as? Level2TableViewController else { return }
            if let indexPath = tableView.indexPath(for: cell) {
                ctrl.level2Task = chainOfTasks.fileTasks[indexPath.row]
                print(chainOfTasks.fileTasks[1].taskName)
                print(chainOfTasks.fileTasks[1].fileTasks.count)
            }
        }
    }

    //Standard function, kept so we can delete table cells
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //First we delete the fileTasks
            chainOfTasks.fileTasks.remove(at: indexPath.row)
            // Then we delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
