import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var place: CustomPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        let bgImageView = UIImageView(frame: tableView.frame)
        bgImageView.image = UIImage(named: place.name + "-background")
        tableView.backgroundView = bgImageView
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let person = sender as! String
        
        if segue.identifier == "Comments" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.place = place
            vc.person = person
        }
    }
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let person = place.people[indexPath.row]
        
        let cellTitle = cell?.viewWithTag(1) as! UILabel
        cellTitle.text = person
        
        cell?.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        
        

        return cell!
    }
    
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let person = place.people[indexPath.row]
        performSegueWithIdentifier("Comments", sender: person)
    }
    
}
