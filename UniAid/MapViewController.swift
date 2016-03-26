import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var map: MKMapView!
    @IBOutlet var buildingTitle: UILabel!
    
    var cordi = Building(BuildingName: NSUserDefaults.standardUserDefaults().valueForKey("buildingName")! as! String).cordinates
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    var destination: MKMapItem = MKMapItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("buildingName")
        print(cordi.Latitude)
        print(cordi.Longtitude)
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        map.layer.cornerRadius = 12
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        myPosition = newLocation.coordinate
        
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        map.setRegion(region, animated: true)
//        locationManager.stopUpdatingLocation()
        
    }
    
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        let location = sender.locationInView(self.map)
        let locCoord = self.map.convertPoint(location, toCoordinateFromView: self.map)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        
        let placeMark = MKPlacemark(coordinate: locCoord, addressDictionary: nil)
        destination = MKMapItem(placemark: placeMark)
        
        self.map.removeAnnotations(map.annotations)
        self.map.addAnnotation(annotation)
    }
    
    @IBAction func showDirections(sender: UIButton) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.requestsAlternateRoutes = false
        request.destination = destination
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse?, error: NSError?) -> Void in
            
            if error != nil{
                print("error \(error)")
            }
            else
            {
                let overlays = self.map.overlays
                self.map.removeOverlays(overlays)
                
                for route in response!.routes as [MKRoute] {
                    self.map.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                    
                    for next in route.steps {
                        print(next.instructions)
                    }
                }
            }
        }}
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!
    {
        let drew = MKPolylineRenderer(overlay: overlay)
        drew.strokeColor = UIColor.orangeColor()
        drew.lineWidth = 3.0
        return drew
    }
    
}
