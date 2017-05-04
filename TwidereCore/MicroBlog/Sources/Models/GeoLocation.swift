public struct GeoLocation {
    public var latitude: Double = Double.nan
    public var longitude: Double = Double.nan
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
