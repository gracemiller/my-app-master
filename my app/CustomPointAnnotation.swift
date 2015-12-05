import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName = "lock"
    var isLocked = true
    
    func unlock() {
        self.imageName = "unlocked"
    }
    
}
