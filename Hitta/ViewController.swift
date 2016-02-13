//
//  ViewController.swift
//  Hitta
//
//  Created by Gustaf Kugelberg on 13/02/16.
//  Copyright © 2016 Unfair. All rights reserved.
//

import UIKit
import MapKit

let tranholmen = CLLocationCoordinate2D(latitude: 59.375129, longitude: 18.087906)

class ViewController: UITableViewController {
    var region = MKCoordinateRegion(center: tranholmen, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @IBOutlet weak var dismissMapButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var mapTapRecognizer: UITapGestureRecognizer!
    
    private var isExpanded = false

    // MARK: Lifetime

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = tranholmen
        annotation.title = "House"
        
        mapView.addAnnotation(annotation)
        mapView.region = region
    }
    
    // MARK: User actions
    
    @IBAction func tappedMap() {
        toggleMap(true)
    }
    
    @IBAction func tappedDismissMap() {
        toggleMap(false)
    }
    
    func toggleMap(expanded: Bool) {
        isExpanded = expanded

        tableView.beginUpdates()
        tableView.endUpdates()
        
        if isExpanded {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), atScrollPosition: .Top, animated: true)
        }
        else {
            UIView.animateWithDuration(0.3) {
                self.mapView.region = self.region
            }
        }
        
        UIView.animateWithDuration(0.25) {
            self.dismissMapButton.alpha = self.isExpanded ? 1 : 0
        }

        tableView.scrollEnabled = !isExpanded
        mapView.scrollEnabled = isExpanded
        mapView.zoomEnabled = isExpanded
        mapTapRecognizer.enabled = !isExpanded
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 2 && isExpanded ? view.frame.height : super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
}