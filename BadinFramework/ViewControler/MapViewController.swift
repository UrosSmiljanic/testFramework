//
//  MapViewController.swift
//  genericappios
//
//  Created by DC on 07/05/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import MapKit

class MapViewController: UIViewController  {

    
    var remoteConfig: RemoteConfig!
    var storeList:StoreList!

   
    
     var mapView: GMSMapView!
    var markers  : [GMSMarker]! = Array()
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: 41.887,
                                              longitude:-87.622,
                                              zoom:15)
          mapView = GMSMapView.map(withFrame: .zero, camera:camera)
        
   
        
        
        
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        
        storeList = StoreList(JSONString: remoteConfig["store_locations"].stringValue!)!
        
        
        for store in storeList.storeList! {
            let store_marker = GMSMarker()
            markers.append(store_marker)
            store_marker.position = CLLocationCoordinate2D(latitude: store.getLat(), longitude: store.getLong())
            store_marker.title = store.storeName
            //store_marker.snippet = "Hey, this is \(store.storeName ?? "")"
            store_marker.map = mapView
            store_marker.icon =     self.imageWithImage(image: UIImage(named: "icon")!, scaledToSize: CGSize(width: 20.0, height: 20.0))

        }
        
        view = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func selectedStore(rowId : Int){
        let storee = GMSCameraPosition.camera(withLatitude:storeList.storeList![rowId].getLat(),
                                              longitude: storeList.storeList![rowId].getLong(),
                                              zoom: 14)
       self.mapView.camera = storee
           self.mapView.selectedMarker = markers[rowId]
        view = mapView

    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        //image.draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
  
    
}
