import Foundation
import ObjectMapper

open class EmbeddedMembershipGroup : Mappable {
    
    open var membership:[MembershipGroup]?
    
    
    
    public init( ) {
    }
    
    public required init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        membership <- map["memberships"]
    }
}
