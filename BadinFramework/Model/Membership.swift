import UIKit
import ObjectMapper

open class Membership: Mappable {
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var memberships:EmbeddedMembershipGroup?
    
    
    public func mapping(map: Map) {
        memberships <- map["_embedded"]
    }
    
    public required init?() {
        
    }
    
    
}
