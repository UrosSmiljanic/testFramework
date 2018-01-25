//
//  StoreViewController.swift
//  genericappios
//
//  Created by DC on 02/04/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import DropDown
import MapKit
import CoreLocation

protocol SelectedStoreDelegate{
    func selectedStore(rowId : Int)
}

protocol SortStoreDelegate{
    func sortStore(rowId : Int)
}



class StoreViewController: BaseViewController, StoreListTableViewControllerDelegate {
    
    var remoteConfig: RemoteConfig!
    var storeList:StoreList!
    
    var delegate:SelectedStoreDelegate! = nil
    
    
    var sortedByDist: Bool = true
    
    @IBOutlet weak var sortButton: UIButton!
    let sortButtonDropDown = DropDown()
    @IBAction func sortBy(_ sender: Any) {
        sortButtonDropDown.show()
        //        if sortedByDist
        //        {
        //            sortedByDist = false
        //            storeListViewController?.filterListName()
        //            sortButton.setTitle( "Sort by distance", for: .normal)
        //        }
        //        else {
        //            sortedByDist = true
        //            storeListViewController?.filterListDist()
        //            sortButton.setTitle("Sort by name", for: .normal)
        //
        //        }
        
    }
    
    
    @IBOutlet var mainView: UIView!
    
    
    @IBOutlet weak var storeListViewTop: NSLayoutConstraint!
    @IBOutlet weak var mapMaybe: UIView!
    
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    
    var coordinates : CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.directionButton.isHidden = true

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        let tapGeasture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        
        swipeRight.direction = UISwipeGestureRecognizerDirection.up
        self.selectStoreView.addGestureRecognizer(swipeRight)
        self.selectStoreView.addGestureRecognizer(tapGeasture)
        
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        
        storeList = StoreList(JSONString: remoteConfig["store_locations"].stringValue!)!
        
        sortButtonDropDown.anchorView = sortButton
        
        
        sortButtonDropDown.bottomOffset = CGPoint(x: 0, y: sortButton.bounds.height)
        
        sortButtonDropDown.dataSource = [
            "Stores near you",
            "Alphabetical Order"
        ]
        
        sortButtonDropDown.selectionAction = { [unowned self] (index, item) in
            self.sortButton.setTitle(item, for: .normal)
            self.sortButtonDropDown.show()
            if item == "Stores near you"
            {
                self.storeListViewController?.filterListDist()
                
            }
            else {   self.storeListViewController?.filterListName()
             
                
                
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var selectedStoreName: UILabel!
    
    @IBOutlet weak var selectStoreHeight: NSLayoutConstraint!
    @IBOutlet weak var selectStoreView: UIView!
    func didSelectItem(rowId : Int, storeName : String, lat : CLLocation)
    {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.storeListViewTop.constant = 520
            self.sortButton.isHidden = true
            self.mapHeight.constant =  self.mainView.frame.height - self.mapMaybe.frame.origin.y - 100
            self.selectStoreHeight.constant = 100
            self.selectedStoreName.text = storeName
            self.view.layoutIfNeeded()
            self.directionButton.isHidden = false

        }, completion: nil)
        coordinates = lat
        containerViewController?.selectedStore(rowId : rowId)
    }
    
    
    
    var containerViewController: MapViewController?
    var storeListViewController: StoreListTableViewController?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storeListTable"{
            
            let vc = segue.destination as! StoreListTableViewController
            storeListViewController = segue.destination as? StoreListTableViewController
            vc.delegate = self
            
        }
        else  if segue.identifier == "map"
            
        {
            
            containerViewController = segue.destination as? MapViewController
            
        } else
        {
            storeListViewController = segue.destination as? StoreListTableViewController
            
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                    //Set x position what ever you want
                    self.storeListViewTop.constant = 15
                    self.mapHeight.constant = 0
                    self.selectStoreHeight.constant = 0
                    self.selectedStoreName.text = ""
                    self.view.layoutIfNeeded()
                    self.sortButton.isHidden = false
                    self.directionButton.isHidden = true

                 }, completion: nil)
                
            default:
                break
            }
        }
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.storeListViewTop.constant = 15
            self.mapHeight.constant = 0
            self.selectStoreHeight.constant = 0
            self.selectedStoreName.text = ""
            self.view.layoutIfNeeded()
            self.sortButton.isHidden = false
            self.directionButton.isHidden = true

            
        }, completion: nil)
    }
    
    @IBOutlet weak var directionButton: UIButton!
    
    @IBAction func directions(_ sender: Any) {
        
        //Defining destination
      
  
        
        let regionDistance:CLLocationDistance = 10000
 
       let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates.coordinate, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.selectedStoreName.text
        mapItem.openInMaps(launchOptions: options)
    }
    
    
}
