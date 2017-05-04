// sourcery: jsonParse
public class GeoPoint {
    // sourcery: jsonField=coordinates
    public var coordinates: [Double]!
    
    // sourcery: jsonField=type
    public var type: String!
    
    public var geoLocation: GeoLocation! {
        guard let coords = coordinates, coords.count == 2 else {
            return nil
        }
        return GeoLocation(latitude: coords[0], longitude: coords[1])
    }
    
    required public init() {
        
    }
}
