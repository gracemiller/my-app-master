
import UIKit

class DetailViewController: UIViewController {
    
    var place: CustomPointAnnotation!
    var person: String!
    @IBOutlet weak var descTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(person)
        
        self.title = place.name
        descTextField.text = place.desc
        imageView.image = UIImage(named: place.name)
        backgroundImageView.image = UIImage(named: "\(place.name)-background")

    }
    
    
}