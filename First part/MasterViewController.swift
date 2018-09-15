import UIKit
import Foundation

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Note.loadNotes()
        noteTable = self.tableView
        
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController
        {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func insertNewObject(_ sender: Any) {
        allNotes.insert(Note(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        self.performSegue(withIdentifier: "showDetail", sender: self)
        nameFilePicker?.reloadAllComponents()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = allNotes[indexPath.row]
                currentNoteindex = indexPath.row
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object

            }
            else {
                currentNoteindex = 0
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = allNotes[indexPath.row]
        cell.textLabel!.text = object.name
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete {
            allNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        Note.saveNotes()
        noteTable?.reloadData()
        nameFilePicker?.reloadAllComponents()

    }
}
