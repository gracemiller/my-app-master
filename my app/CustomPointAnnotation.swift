import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    
    var name: String!
    var imageName = "lock"
    var desc: String?
    var isLocked = true
    var region: CLCircularRegion {
        return CLCircularRegion(center: coordinate, radius: 3, identifier: name)
    }
    var people = ["Jon", "Kyle", "Grace", "Luke", "Sara"]
    
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
    
    let balloonLocation = CLLocationCoordinate2DMake(50.719293, -1.878641)
    let dropPin = CustomPointAnnotation(name: "Balloon")
    dropPin.coordinate = balloonLocation
    dropPin.title = "Balloon"
    dropPin.desc = "BALLOON asdasdkhj idsfb sdhfb isdbfiu sdfgisld Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.f"
    points.append(dropPin)
    
    let arcadeLocation = CLLocationCoordinate2DMake(50.7161, -1.875780)
    let dropPinTwo = CustomPointAnnotation(name: "Arcade")
    dropPinTwo.coordinate = arcadeLocation
    dropPinTwo.title = "Arcade"
    dropPinTwo.desc = "ARCADE asdasdkhj idsfb sdhfb isdbfiu sdfgisld Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.f"
    points.append(dropPinTwo)
    

    let beachLocation = CLLocationCoordinate2DMake(50.716252, -1.873429)
    let dropPinThree = CustomPointAnnotation(name: "Beach")
    dropPinThree.coordinate = beachLocation
    dropPinThree.title = "Beach"
    dropPinThree.desc = "BEACH bfiu sdfgisld Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.f"
    points.append(dropPinThree)

    
    return points
}