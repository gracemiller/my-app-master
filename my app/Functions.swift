import UIKit
import CoreLocation

func degreesToRadians(value:Double) -> CGFloat {
    return CGFloat(value * M_PI / 180.0)
}

func radiansToDegrees(radians: Double) -> CGFloat {
    return CGFloat(radians * 180.0 / M_PI)
}

func getBearingBetweenTwoPoints(x: CLLocationCoordinate2D, y: CLLocationCoordinate2D) -> CGFloat {
    
    let lat1 = degreesToRadians(x.latitude)
    let lon1 = degreesToRadians(x.longitude)
    
    let lat2 = degreesToRadians(y.latitude);
    let lon2 = degreesToRadians(y.longitude);
    
    let dLon = lon2 - lon1;
    
    let y = sin(dLon) * cos(lat2);
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    var radiansBearing = atan2(y, x);
    
    if radiansBearing < 0.0 {
        radiansBearing += CGFloat(2 * M_PI)
    }
    
    return radiansBearing
}


extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

extension UIColor {
    class func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}