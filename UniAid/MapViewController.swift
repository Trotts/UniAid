//
//  MapViewController.swift
//  UniAid
//
//  Created by igor epshtein on 2016-03-14.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate,UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet var tb: UITableView!
    @IBOutlet var open: UIBarButtonItem!
    @IBOutlet var map: MKMapView!
    @IBOutlet var buildingTitle: UILabel!
    
    var cordi = Building(BuildingName: NSUserDefaults.standardUserDefaults().valueForKey("building")! as! String).cordinates
    var locationManager = CLLocationManager()
    var buildingName = NSUserDefaults.standardUserDefaults().valueForKey("building")! as! String
    var myPosition = CLLocationCoordinate2D()
    var destination: MKMapItem = MKMapItem()
    var dirArray = [String]()
    
    // MARK: General Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDir()
        buildingTitle.text = "Directions to \(buildingName)"
        NSUserDefaults.standardUserDefaults().removeObjectForKey("building")
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Map Functions
    
    // Gets current coordinate from GPS
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    
        myPosition = newLocation.coordinate
        
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        map.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
        
    }
    
    // Gets the directions to the building from current location
     func getDir() {
        let locCoord = CLLocationCoordinate2D(latitude: cordi.Latitude, longitude: cordi.Longtitude)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        
        let placeMark = MKPlacemark(coordinate: locCoord, addressDictionary: nil)
        destination = MKMapItem(placemark: placeMark)
        
        self.map.removeAnnotations(map.annotations)
        self.map.addAnnotation(annotation)
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
                // Display Route on the map
                let overlays = self.map.overlays
                self.map.removeOverlays(overlays)
                for route in response!.routes as [MKRoute] {
                    self.map.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                    for next in route.steps {
                        self.dirArray.append(next.instructions)
                    }
                    self.tb.dataSource = self
                    self.tb.delegate = self
                    self.tb.reloadData()
                }
            }
        }
    }
    
    // Function to handle the creation of the route on the map
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!
    {
        let drew = MKPolylineRenderer(overlay: overlay)
        drew.strokeColor = UIColor.orangeColor()
        drew.lineWidth = 3.0
        return drew
    }
    // Return the number of directions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirArray.count
    }
    
    // Populate the directions list
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tb.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DirectionCell
        
        cell.directionsTitle.text = dirArray[indexPath.row]
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 12
        cell.layer.borderColor = UIColor.clearColor().CGColor
        return cell
    }
}
