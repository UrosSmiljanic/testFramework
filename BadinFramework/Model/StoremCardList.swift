//
//  StoremCard.swift
//  genericappios
//
//  Created by DC on 13/09/2017.
//  Copyright © 2017 Dusan. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

open class StoremCardList: Mappable {
    
    
    
    open var list:[StoremCard]?
    
    
    public init() {
        
    }
    
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        list <- map["groups"]
        
    }
    
    
    open func getStores() -> [StoremCard]{
        /*self.storeList?.storeList? = (self.storeList?.storeList?.sorted { $0.storeName?.localizedCaseInsensitiveCompare($1.storeName!) == ComparisonResult.orderedAscending })!*/
        
        list?.sort() { $0.groupName! < $1.groupName! }
        
        return list!
    }
    
    
    open func getRegionsFilter(parentId: String) -> [String]{
        var result: [String] = Array()
        
        for s in list! {
            if (s.parentId == parentId){
            if (!result.contains(s.groupName!)){
                
                
                    result.append(s.groupName!)
               
            }
            }
        }
        return result
    }
    open func getRegionIdFilter(parentId: String) -> [String]{
        var result: [String] = Array()
        
        for s in list! {
            if (s.parentId == parentId){
                if (!result.contains(s.groupId!)){
                    
                    
                        result.append(s.groupId!)
                    
                }
            }
        }
        return result
    }
    
    open func getStoresFilter(groupId: String) -> [String]{
        var result: [String] = Array()
        
        for s in list! {
            if s.groupId == groupId
            {
                result.append(s.memberName!)
            }
        }
        return result
    }
    
    open func getStoresIdFilter(groupId: String) -> [String]{
        var result: [String] = Array()
        
        for s in list! {
            if s.groupId == groupId
            {
                result.append(s.memberId!)
            }
        }
        return result
    }
    
    open func getStoresAll() -> [String]{
        var result: [String] = Array()
        
        for s in list! {
                result.append(s.memberName!)
        }
        
        result.sort() { $0 < $1 }
      
        return result
    }
    open func getStoresName(id : String) -> String{
        let result: String = ""
        
        for s in list! {
            if s.memberId == id
            {
                return s.memberName!
            }
        }
        return result
        
    }
    
    open func getStoresId(name : String) -> String{
        let result: String = ""
        
        for s in list! {
            if s.memberName == name
            {
                return s.memberId!
            }
        }
        return result
        
    }
    
    /*public List<Store> getStores() {
     
     Collections.sort(stores, new Comparator<Store>()
     {
     @Override
     public int compare(Store text1, Store text2)
     {
     return text1.getMemberName().compareToIgnoreCase(text2.getMemberName());
     }
     });
     
     return stores;
     }
     
     public List<Store> getStoresFilter(String parentId) {
     List<Store> a = new ArrayList<>();
     
     for (Store s : stores) {
     if (s.getGroupId().equals(parentId))
     a.add(s);
     }
     return a;
     }*/
    
    
    
    
}
