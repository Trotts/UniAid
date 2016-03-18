import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var map: MKMapView!
    @IBOutlet var buildingTitle: UILabel!
    
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        let location = CLLocationCoordinate2DMake(44.6374003, -63.5871739)
        let myLocation = MKPointAnnotation()
        
        
        myLocation.coordinate=location
        myLocation.title = "UniAid"
        myLocation.subtitle = "CS building"
        map.addAnnotation(myLocation)
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        myPosition = newLocation.coordinate
        
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        map.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  // http://www.dal.ca/campus-maps/building-directory.html get the addresses of all the buildings
}