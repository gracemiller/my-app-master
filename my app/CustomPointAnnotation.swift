import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    
    var name: String!
    var imageName = "lock"
    var desc: String?
    var isLocked = true
    var region: CLCircularRegion {
        return CLCircularRegion(center: coordinate, radius: 3, identifier: name)
    }
    var people = ["Brenda", "Jamie", "Ellen", "Luke", "Sara"]
    
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
    dropPin.desc = "The sun came out from behind the clouds this afternoon so decided to take Rusty for a stroll to our favourite bench in the gardens. Sat for a while to enjoy the Autumn warmth and watch the world go by. He was content to sit by my side. He’d have been up chasing those scurrying squirrels when he was a puppy!  Think I will treat myself to an ice-cream from Guiseppe’s on the way home.   Brenda"
    points.append(dropPin)
    
    let arcadeLocation = CLLocationCoordinate2DMake(50.7161, -1.875780)
    let dropPinTwo = CustomPointAnnotation(name: "Arcade")
    dropPinTwo.coordinate = arcadeLocation
    dropPinTwo.title = "Arcade"
    dropPinTwo.desc = "Jamie here at the Arcade again.  Managed to persuade mum to give me her small change so rematch with Sam and Zack – air hockey wars.  And I’m on for victory again!  Chucking it down outside but such a laugh in here.  50 tokens already – might get some candyfloss this week. Will cycle back along the promenade by the beach - no traffic that way."
    points.append(dropPinTwo)
    

    let beachLocation = CLLocationCoordinate2DMake(50.716252, -1.873429)
    let dropPinThree = CustomPointAnnotation(name: "Beach")
    dropPinThree.coordinate = beachLocation
    dropPinThree.title = "Beach"
    dropPinThree.desc = "Hi I’m Ellen  My first visit to Bournemouth to see my boyfriend.  He’s just started uni here.  Been missing him!  Such a great beach!  Sunny day, even been paddling.  Lots of people, it’s buzzing. Never realised Bournemouth had so much going on!  Fish and chips from Harry Ramsden's was great! Xx"
    points.append(dropPinThree)

    
    return points
}