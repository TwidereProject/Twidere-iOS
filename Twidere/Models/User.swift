
// generated with FlatBuffersSchemaEditor https://github.com/mzaks/FlatBuffersSchemaEditor

import Foundation

import FlatBuffersSwift
public final class User {
    public static var instancePoolMutex : pthread_mutex_t = User.setupInstancePoolMutex()
    public static var maxInstanceCacheSize : UInt = 0
    public static var instancePool : ContiguousArray<User> = []
    public var key : UserKey? = nil
    public var name : String? {
        get {
            if let s = name_s {
                return s
            }
            if let s = name_ss {
                name_s = s.stringValue
            }
            if let s = name_b {
                name_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
            }
            return name_s
        }
        set {
            name_s = newValue
            name_ss = nil
            name_b = nil
        }
    }
    public func nameStaticString(newValue : StaticString) {
        name_ss = newValue
        name_s = nil
        name_b = nil
    }
    private var name_b : UnsafeBufferPointer<UInt8>? = nil
    public var nameBuffer : UnsafeBufferPointer<UInt8>? {return name_b}
    private var name_s : String? = nil
    private var name_ss : StaticString? = nil
    
    public var screenName : String? {
        get {
            if let s = screenName_s {
                return s
            }
            if let s = screenName_ss {
                screenName_s = s.stringValue
            }
            if let s = screenName_b {
                screenName_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
            }
            return screenName_s
        }
        set {
            screenName_s = newValue
            screenName_ss = nil
            screenName_b = nil
        }
    }
    public func screenNameStaticString(newValue : StaticString) {
        screenName_ss = newValue
        screenName_s = nil
        screenName_b = nil
    }
    private var screenName_b : UnsafeBufferPointer<UInt8>? = nil
    public var screenNameBuffer : UnsafeBufferPointer<UInt8>? {return screenName_b}
    private var screenName_s : String? = nil
    private var screenName_ss : StaticString? = nil
    
    public var profileImageUrl : String? {
        get {
            if let s = profileImageUrl_s {
                return s
            }
            if let s = profileImageUrl_ss {
                profileImageUrl_s = s.stringValue
            }
            if let s = profileImageUrl_b {
                profileImageUrl_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
            }
            return profileImageUrl_s
        }
        set {
            profileImageUrl_s = newValue
            profileImageUrl_ss = nil
            profileImageUrl_b = nil
        }
    }
    public func profileImageUrlStaticString(newValue : StaticString) {
        profileImageUrl_ss = newValue
        profileImageUrl_s = nil
        profileImageUrl_b = nil
    }
    private var profileImageUrl_b : UnsafeBufferPointer<UInt8>? = nil
    public var profileImageUrlBuffer : UnsafeBufferPointer<UInt8>? {return profileImageUrl_b}
    private var profileImageUrl_s : String? = nil
    private var profileImageUrl_ss : StaticString? = nil
    
    public var profileBannerUrl : String? {
        get {
            if let s = profileBannerUrl_s {
                return s
            }
            if let s = profileBannerUrl_ss {
                profileBannerUrl_s = s.stringValue
            }
            if let s = profileBannerUrl_b {
                profileBannerUrl_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
            }
            return profileBannerUrl_s
        }
        set {
            profileBannerUrl_s = newValue
            profileBannerUrl_ss = nil
            profileBannerUrl_b = nil
        }
    }
    public func profileBannerUrlStaticString(newValue : StaticString) {
        profileBannerUrl_ss = newValue
        profileBannerUrl_s = nil
        profileBannerUrl_b = nil
    }
    private var profileBannerUrl_b : UnsafeBufferPointer<UInt8>? = nil
    public var profileBannerUrlBuffer : UnsafeBufferPointer<UInt8>? {return profileBannerUrl_b}
    private var profileBannerUrl_s : String? = nil
    private var profileBannerUrl_ss : StaticString? = nil
    
    public init(){}
    public init(key: UserKey?, name: String?, screenName: String?, profileImageUrl: String?, profileBannerUrl: String?){
        self.key = key
        self.name_s = name
        self.screenName_s = screenName
        self.profileImageUrl_s = profileImageUrl
        self.profileBannerUrl_s = profileBannerUrl
    }
    public init(key: UserKey?, name: StaticString?, screenName: StaticString?, profileImageUrl: StaticString?, profileBannerUrl: StaticString?){
        self.key = key
        self.name_ss = name
        self.screenName_ss = screenName
        self.profileImageUrl_ss = profileImageUrl
        self.profileBannerUrl_ss = profileBannerUrl
    }
}

extension User : PoolableInstances {
    public func reset() {
        if key != nil {
            var x = key!
            key = nil
            UserKey.reuseInstance(&x)
        }
        name = nil
        screenName = nil
        profileImageUrl = nil
        profileBannerUrl = nil
    }
}
public extension User {
    private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> User? {
        guard let objectOffset = objectOffset else {
            return nil
        }
        if reader.config.uniqueTables {
            if let o = reader.objectPool[objectOffset]{
                return o as? User
            }
        }
        let _result = User.createInstance()
        if reader.config.uniqueTables {
            reader.objectPool[objectOffset] = _result
        }
        _result.key = UserKey.create(reader, objectOffset: reader.getOffset(objectOffset, propertyIndex: 0))
        _result.name_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 1))
        _result.screenName_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 2))
        _result.profileImageUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 3))
        _result.profileBannerUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 4))
        return _result
    }
}
public extension User {
    public static func fromByteArray(data : UnsafeBufferPointer<UInt8>, config : BinaryReadConfig = BinaryReadConfig()) -> User {
        let reader = FlatBufferReader.create(data, config: config)
        let objectOffset = reader.rootObjectOffset
        let result = create(reader, objectOffset : objectOffset)!
        FlatBufferReader.reuse(reader)
        return result
    }
    public static func fromRawMemory(data : UnsafeMutablePointer<UInt8>, count : Int, config : BinaryReadConfig = BinaryReadConfig()) -> User {
        let reader = FlatBufferReader.create(data, count: count, config: config)
        let objectOffset = reader.rootObjectOffset
        let result = create(reader, objectOffset : objectOffset)!
        FlatBufferReader.reuse(reader)
        return result
    }
    public static func fromFlatBufferReader(flatBufferReader : FlatBufferReader) -> User {
        return create(flatBufferReader, objectOffset : flatBufferReader.rootObjectOffset)!
    }
}
public extension User {
    public func toByteArray (config : BinaryBuildConfig = BinaryBuildConfig()) -> [UInt8] {
        let builder = FlatBufferBuilder.create(config)
        let offset = addToByteArray(builder)
        performLateBindings(builder)
        try! builder.finish(offset, fileIdentifier: nil)
        let result = builder.data
        FlatBufferBuilder.reuse(builder)
        return result
    }
}

public extension User {
    public func toFlatBufferBuilder (builder : FlatBufferBuilder) -> Void {
        let offset = addToByteArray(builder)
        performLateBindings(builder)
        try! builder.finish(offset, fileIdentifier: nil)
    }
}

public extension User {
    public final class LazyAccess : Hashable {
        private let _reader : FlatBufferReader!
        private let _objectOffset : Offset!
        public init(data : UnsafeBufferPointer<UInt8>, config : BinaryReadConfig = BinaryReadConfig()){
            _reader = FlatBufferReader.create(data, config: config)
            _objectOffset = _reader.rootObjectOffset
        }
        deinit{
            FlatBufferReader.reuse(_reader)
        }
        public var data : [UInt8] {
            return _reader.data
        }
        private init?(reader : FlatBufferReader, objectOffset : Offset?){
            guard let objectOffset = objectOffset else {
                _reader = nil
                _objectOffset = nil
                return nil
            }
            _reader = reader
            _objectOffset = objectOffset
        }
        
        public lazy var key : UserKey.LazyAccess? = UserKey.LazyAccess(reader: self._reader, objectOffset : self._reader.getOffset(self._objectOffset, propertyIndex: 0))
        public lazy var name : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 1))
        public lazy var screenName : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 2))
        public lazy var profileImageUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 3))
        public lazy var profileBannerUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 4))
        
        public var createEagerVersion : User? { return User.create(_reader, objectOffset: _objectOffset) }
        
        public var hashValue: Int { return Int(_objectOffset) }
    }
}

public func ==(t1 : User.LazyAccess, t2 : User.LazyAccess) -> Bool {
    return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension User {
    public struct Fast : Hashable {
        private var buffer : UnsafePointer<UInt8> = nil
        private var myOffset : Offset = 0
        public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
            self.buffer = buffer
            self.myOffset = myOffset
        }
        public init(_ data : UnsafePointer<UInt8>) {
            self.buffer = data
            self.myOffset = UnsafePointer<Offset>(buffer.advancedBy(0)).memory
        }
        public func getData() -> UnsafePointer<UInt8> {
            return buffer
        }
        public var key : UserKey.Fast? { get {
            if let offset = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 0) {
                return UserKey.Fast(buffer: buffer, myOffset: offset)
            }
            return nil
            } }
        public var name : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:1)) } }
        public var screenName : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:2)) } }
        public var profileImageUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:3)) } }
        public var profileBannerUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:4)) } }
        public var hashValue: Int { return Int(myOffset) }
    }
}
public func ==(t1 : User.Fast, t2 : User.Fast) -> Bool {
    return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension User {
    private func addToByteArray(builder : FlatBufferBuilder) -> Offset {
        if builder.config.uniqueTables {
            if let myOffset = builder.cache[ObjectIdentifier(self)] {
                return myOffset
            }
        }
        // let offset4 = try! builder.createString(profileBannerUrl)
        var offset4 : Offset
        if let s = profileBannerUrl_b {
            offset4 = try! builder.createString(s)
        } else if let s = profileBannerUrl_ss {
            offset4 = try! builder.createStaticString(s)
        } else {
            offset4 = try! builder.createString(profileBannerUrl)
        }
        // let offset3 = try! builder.createString(profileImageUrl)
        var offset3 : Offset
        if let s = profileImageUrl_b {
            offset3 = try! builder.createString(s)
        } else if let s = profileImageUrl_ss {
            offset3 = try! builder.createStaticString(s)
        } else {
            offset3 = try! builder.createString(profileImageUrl)
        }
        // let offset2 = try! builder.createString(screenName)
        var offset2 : Offset
        if let s = screenName_b {
            offset2 = try! builder.createString(s)
        } else if let s = screenName_ss {
            offset2 = try! builder.createStaticString(s)
        } else {
            offset2 = try! builder.createString(screenName)
        }
        // let offset1 = try! builder.createString(name)
        var offset1 : Offset
        if let s = name_b {
            offset1 = try! builder.createString(s)
        } else if let s = name_ss {
            offset1 = try! builder.createStaticString(s)
        } else {
            offset1 = try! builder.createString(name)
        }
        let offset0 = key?.addToByteArray(builder) ?? 0
        try! builder.openObject(5)
        try! builder.addPropertyOffsetToOpenObject(4, offset: offset4)
        try! builder.addPropertyOffsetToOpenObject(3, offset: offset3)
        try! builder.addPropertyOffsetToOpenObject(2, offset: offset2)
        try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
        if key != nil {
            try! builder.addPropertyOffsetToOpenObject(0, offset: offset0)
        }
        let myOffset =  try! builder.closeObject()
        if builder.config.uniqueTables {
            builder.cache[ObjectIdentifier(self)] = myOffset
        }
        return myOffset
    }
}
extension User {
    public func toJSON() -> String{
        var properties : [String] = []
        if let key = key{
            properties.append("\"key\":\(key.toJSON())")
        }
        if let name = name{
            properties.append("\"name\":\"\(name)\"")
        }
        if let screenName = screenName{
            properties.append("\"screenName\":\"\(screenName)\"")
        }
        if let profileImageUrl = profileImageUrl{
            properties.append("\"profileImageUrl\":\"\(profileImageUrl)\"")
        }
        if let profileBannerUrl = profileBannerUrl{
            properties.append("\"profileBannerUrl\":\"\(profileBannerUrl)\"")
        }
        
        return "{\(properties.joinWithSeparator(","))}"
    }
    
    public static func fromJSON(dict : NSDictionary) -> User {
        let result = User()
        if let key = dict["key"] as? NSDictionary {
            result.key = UserKey.fromJSON(key)
        }
        if let name = dict["name"] as? NSString {
            result.name = name as String
        }
        if let screenName = dict["screenName"] as? NSString {
            result.screenName = screenName as String
        }
        if let profileImageUrl = dict["profileImageUrl"] as? NSString {
            result.profileImageUrl = profileImageUrl as String
        }
        if let profileBannerUrl = dict["profileBannerUrl"] as? NSString {
            result.profileBannerUrl = profileBannerUrl as String
        }
        return result
    }
    
    public func jsonTypeName() -> String {
        return "\"User\""
    }
}
private func performLateBindings(builder : FlatBufferBuilder) {
    for binding in builder.deferedBindings {
        switch binding.object {
        case let object as UserKey: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
        default: continue
        }
    }
}