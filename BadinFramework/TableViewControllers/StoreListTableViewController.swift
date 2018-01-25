//
//  StoreListTableViewController.swift
//  genericappios
//
//  Created by DC on 08/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit
import SwiftLocation

protocol StoreListTableViewControllerDelegate{
    func didSelectItem(rowId : Int, storeName : String, lat :CLLocation)
}


class StoreListTableViewController: UITableViewController {
    
    var delegate:StoreListTableViewControllerDelegate! = nil
    
    var storeList : StoreList?
    var remoteConfig: RemoteConfig!
    
    
    var ind = 0
    var locationL:CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        
        storeList = StoreList(JSONString: remoteConfig["store_locations"].stringValue!)!
        
        for (index, loc) in (self.storeList?.storeList?.enumerated())!   {
            loc.origPos = index
        }
        
        //  filterListName()
        self.tableView.reloadData()
    /*
        Locator.subscribeHeadingUpdates(accuracy: .city, minInterval: .oneShot, onUpdate: { (_, location) in
            print("A new update of location is available: \(location)")
            //  self.ref.child("users").child(KeychainWrapper.standard.string(forKey: "userId")!).setValue(["username": location.description])
            self.locationL = location
            //  self.nearestStore.bottomText.text = location.description
            //let distanceInMeters = coordinate₀.distance(from: coordinate₁) // result is in meters
            let df = MKDistanceFormatter()
            df.unitStyle = .abbreviated
            if self.storeList != nil
            {
                for (index, loc) in (self.storeList?.getCLocations().enumerated())!   {
                    let distanceInMeters = loc.distance(from: location) // result is in meters
                    self.storeList?.storeList?[index].storeDistance = Int(distanceInMeters)
                    self.storeList?.storeList?[index].storeDistanceS = df.string(fromDistance:  distanceInMeters)
                    
                }
                
                self.filterListDist()
                self.tableView.reloadData()
/* for (index, loc) in (self.storeList?.getCLocations().enumerated())!   {
 let source = MKMapItem( placemark: MKPlacemark(
 coordinate: location.coordinate,
 addressDictionary: nil))
 let destination = MKMapItem(placemark: MKPlacemark(
 coordinate: loc.coordinate,
 addressDictionary: nil))
 
 let directionsRequest = MKDirectionsRequest()
 directionsRequest.source = source
 directionsRequest.destination = destination
 
 let directions = MKDirections(request: directionsRequest)
 
 directions.calculate   { response, error in
 if let route = response?.routes.first {
 print("Distance: \(route.distance), ETA: \(route.expectedTravelTime)")
 let distance = response!.routes.first?.distance // meters
 self.storeList?.storeList?[index].storeDistance = Int(distance!)
 self.storeList?.storeList?[index].storeDistanceS = df.string(fromDistance:  distance!)
 self.tableView.reloadData()
 
 } else {
 print("Error!")
 }
 
 
 }
 
  */
                
            }
            
        }) { (request, last, error) in
            request.cancel() // stop continous location monitoring on error
            print("Location monitoring failed due to an error \(error)")
        }
        
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    public   func filterListName() { // should probably be called sort and not filter
        let storeListTmp : StoreList? = StoreList()
        storeListTmp?.storeList = Array()
        storeListTmp?.storeList? = (self.storeList?.storeList?.sorted { $0.storeName?.localizedCaseInsensitiveCompare($1.storeName!) == ComparisonResult.orderedAscending })!
        self.storeList? =   (storeListTmp)!
        self.tableView.reloadData(); // notify the table view the data has changed
    }
    
    
    public  func filterListDist() { // should probably be called sort and not filter
        if (self.storeList?.storeList?[0].storeDistance != nil){
            self.storeList?.storeList?.sort() { $0.storeDistance! < $1.storeDistance! }
            self.tableView.reloadData(); // notify the table view the data has changed
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (storeList == nil) {
            return 0}
        if (storeList?.storeList == nil) {
            return 0}
        return (storeList?.storeList!.count)!
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StoreItemTableViewCell
        let row = indexPath.row;  //
        cell.storeName.text = storeList?.storeList![row].storeName
        cell.storeDistance.text = storeList?.storeList![row].storeDistanceS
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row;
        delegate.didSelectItem(rowId: (storeList?.storeList![row].origPos)!, storeName : (storeList?.storeList![row].storeName)! , lat:  (storeList?.getCLocations()[row])!)
    }
    
    
 
    
}
