import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    
    var name: String!
    var imageName = "lock"
    var isLocked = false
    var region: CLCircularRegion {
        return CLCircularRegion(center: coordinate, radius: 20, identifier: name)
    }
    
    init(name: String) {
        self.name = name
    }
    
    func unlock() {
        isLocked = false
    }
    
    func lock() {
        isLocked = true
    }
    
}



func buildAnnotations() -> [CustomPointAnnotation] {
    
    var points = [CustomPointAnnotation]()
    
    //location of locks
    
    let zipLineLocation = CLLocationCoordinate2DMake(50.7150, -1.87470)
    let dropPin = CustomPointAnnotation(name: "ZipLine")
    dropPin.coordinate = zipLineLocation
    dropPin.title = "ZipLine"
    points.append(dropPin)
    
    let arcadeLocation = CLLocationCoordinate2DMake(50.7161, -1.875780)
    let dropPinTwo = CustomPointAnnotation(name: "Arcade")
    dropPinTwo.coordinate = arcadeLocation
    dropPinTwo.title = "Arcade"
    points.append(dropPinTwo)
    
    let beachLocation = CLLocationCoordinate2DMake(50.7148, -1.87463)
    let dropPinThree = CustomPointAnnotation(name: "Beach")
    dropPinThree.coordinate = beachLocation
    dropPinThree.title = "Beach"
    points.append(dropPinThree)

    
    return points
}