//
//  Level2TableViewController.swift
//  Patterns-Hometask-5
//
//  Created by Anton Lebedev on 12.04.2022.
// Line added for pull request

import UIKit

class Level2TableViewController: UITableViewController {
    
    @IBOutlet weak var addNextLevelTaskButton: UIBarButtonItem!
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        guard let videoControllerToDisplay = storyboard?.instantiateViewController(withIdentifier: "BaseTableViewController") else { return }
        //All controllers are contained in window
        //To show controller we add it to the window
        guard let window = self.view.window else { return }
        window.rootViewController = videoControllerToDisplay
    }
    
    
    @IBAction func addNextLevelTaskButtonAction(_ sender: Any) {
        
        PopUpMessage().popUpMessage() { [weak self] userInput in
            guard let self = self else { return }
            guard userInput != "" else { return }
            
            self.level2Task?.addNewTask(fileTask: Task(taskName: userInput, folderTask: self.level2Task))
            self.tableView.reloadData()
        }
    }
    
    var level2Task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = level2Task?.taskName ?? ""
        
        tableView.reloadData()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return the number of rows
        return level2Task?.fileTasks.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Level2FolderCell", for: indexPath) as? Level2FolderCell else { return UITableViewCell()}
        
        let level2TaskName = String("\(String(describing: level2Task?.fileTasks[indexPath.row].taskName ?? ""))" )
        let counterForLevel2Tasks = level2Task?.fileTasks[indexPath.row].fileTasks.count ?? 0
        
        cell.accessoryType = .disclosureIndicator
        
        cell.configurator(taskName: level2TaskName, counterForLevel2Tasks: counterForLevel2Tasks)
        
        return cell 
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToLevel2TableViewController", let cell = (sender as? UITableViewCell) {
            guard let ctrl = segue.destination as? Level2TableViewController else { return }
            if let indexPath = tableView.indexPath(for: cell) {
                ctrl.level2Task = level2Task?.fileTasks[indexPath.row]
            }
        }
    }


    //Standard function, kept so we can delete table cells
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //First we delete the fileTasks
            level2Task?.fileTasks.remove(at: indexPath.row)
            // Then we delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}
