
// generated with FlatBuffersSchemaEditor https://github.com/mzaks/FlatBuffersSchemaEditor

import Foundation

import FlatBuffersSwift
public final class UserKey {
    public static var instancePoolMutex : pthread_mutex_t = UserKey.setupInstancePoolMutex()
    public static var maxInstanceCacheSize : UInt = 0
    public static var instancePool : ContiguousArray<UserKey> = []
    public var id : String? {
        get {
            if let s = id_s {
                return s
            }
            if let s = id_ss {
                id_s = s.stringValue
            }
            if let s = id_b {
                id_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
            }
            return id_s
        }
        set {
            id_s = newValue
            id_ss = nil
            id_b = nil
        }
    }
    public func idStaticString(newValue : StaticString) {
        id_ss = newValue
        id_s = nil
        id_b = nil
    }
    private var id_b : UnsafeBufferPointer<UInt8>? = nil
    public var idBuffer : UnsafeBufferPointer<UInt8>? {return id_b}
    private var id_s : String? = nil
    private var id_ss : StaticString? = nil
    
    public var host : String? {
        get {
            if let s = host_s {
                return s
            }
            if let s = host_ss {
                host_s = s.stringValue
            }
            if let s = host_b {
                host_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
            }
            return host_s
        }
        set {
            host_s = newValue
            host_ss = nil
            host_b = nil
        }
    }
    public func hostStaticString(newValue : StaticString) {
        host_ss = newValue
        host_s = nil
        host_b = nil
    }
    private var host_b : UnsafeBufferPointer<UInt8>? = nil
    public var hostBuffer : UnsafeBufferPointer<UInt8>? {return host_b}
    private var host_s : String? = nil
    private var host_ss : StaticString? = nil
    
    public init(){}
    public init(id: String?, host: String?){
        self.id_s = id
        self.host_s = host
    }
    public init(id: StaticString?, host: StaticString?){
        self.id_ss = id
        self.host_ss = host
    }
}

extension UserKey : PoolableInstances {
    public func reset() {
        id = nil
        host = nil
    }
}
public extension UserKey {
    static func create(reader : FlatBufferReader, objectOffset : Offset?) -> UserKey? {
        guard let objectOffset = objectOffset else {
            return nil
        }
        if reader.config.uniqueTables {
            if let o = reader.objectPool[objectOffset]{
                return o as? UserKey
            }
        }
        let _result = UserKey.createInstance()
        if reader.config.uniqueTables {
            reader.objectPool[objectOffset] = _result
        }
        _result.id_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 0))
        _result.host_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 1))
        return _result
    }
}
public extension UserKey {
    public static func fromByteArray(data : UnsafeBufferPointer<UInt8>, config : BinaryReadConfig = BinaryReadConfig()) -> UserKey {
        let reader = FlatBufferReader.create(data, config: config)
        let objectOffset = reader.rootObjectOffset
        let result = create(reader, objectOffset : objectOffset)!
        FlatBufferReader.reuse(reader)
        return result
    }
    public static func fromRawMemory(data : UnsafeMutablePointer<UInt8>, count : Int, config : BinaryReadConfig = BinaryReadConfig()) -> UserKey {
        let reader = FlatBufferReader.create(data, count: count, config: config)
        let objectOffset = reader.rootObjectOffset
        let result = create(reader, objectOffset : objectOffset)!
        FlatBufferReader.reuse(reader)
        return result
    }
    public static func fromFlatBufferReader(flatBufferReader : FlatBufferReader) -> UserKey {
        return create(flatBufferReader, objectOffset : flatBufferReader.rootObjectOffset)!
    }
}
public extension UserKey {
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

public extension UserKey {
    public func toFlatBufferBuilder (builder : FlatBufferBuilder) -> Void {
        let offset = addToByteArray(builder)
        performLateBindings(builder)
        try! builder.finish(offset, fileIdentifier: nil)
    }
}

public extension UserKey {
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
        init?(reader : FlatBufferReader, objectOffset : Offset?){
            guard let objectOffset = objectOffset else {
                _reader = nil
                _objectOffset = nil
                return nil
            }
            _reader = reader
            _objectOffset = objectOffset
        }
        
        public lazy var id : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 0))
        public lazy var host : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 1))
        
        public var createEagerVersion : UserKey? { return UserKey.create(_reader, objectOffset: _objectOffset) }
        
        public var hashValue: Int { return Int(_objectOffset) }
    }
}

public func ==(t1 : UserKey.LazyAccess, t2 : UserKey.LazyAccess) -> Bool {
    return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension UserKey {
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
        public var id : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:0)) } }
        public var host : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:1)) } }
        public var hashValue: Int { return Int(myOffset) }
    }
}
public func ==(t1 : UserKey.Fast, t2 : UserKey.Fast) -> Bool {
    return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension UserKey {
    func addToByteArray(builder : FlatBufferBuilder) -> Offset {
        if builder.config.uniqueTables {
            if let myOffset = builder.cache[ObjectIdentifier(self)] {
                return myOffset
            }
        }
        // let offset1 = try! builder.createString(host)
        var offset1 : Offset
        if let s = host_b {
            offset1 = try! builder.createString(s)
        } else if let s = host_ss {
            offset1 = try! builder.createStaticString(s)
        } else {
            offset1 = try! builder.createString(host)
        }
        // let offset0 = try! builder.createString(id)
        var offset0 : Offset
        if let s = id_b {
            offset0 = try! builder.createString(s)
        } else if let s = id_ss {
            offset0 = try! builder.createStaticString(s)
        } else {
            offset0 = try! builder.createString(id)
        }
        try! builder.openObject(2)
        try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
        try! builder.addPropertyOffsetToOpenObject(0, offset: offset0)
        let myOffset =  try! builder.closeObject()
        if builder.config.uniqueTables {
            builder.cache[ObjectIdentifier(self)] = myOffset
        }
        return myOffset
    }
}
extension UserKey {
    public func toJSON() -> String{
        var properties : [String] = []
        if let id = id{
            properties.append("\"id\":\"\(id)\"")
        }
        if let host = host{
            properties.append("\"host\":\"\(host)\"")
        }
        
        return "{\(properties.joinWithSeparator(","))}"
    }
    
    public static func fromJSON(dict : NSDictionary) -> UserKey {
        let result = UserKey()
        if let id = dict["id"] as? NSString {
            result.id = id as String
        }
        if let host = dict["host"] as? NSString {
            result.host = host as String
        }
        return result
    }
    
    public func jsonTypeName() -> String {
        return "\"UserKey\""
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

