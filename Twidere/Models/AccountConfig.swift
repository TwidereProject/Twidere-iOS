
// generated with FlatBuffersSchemaEditor https://github.com/mzaks/FlatBuffersSchemaEditor

import Foundation
import FlatBuffersSwift

public final class AccountConfig {
    public static var instancePoolMutex : pthread_mutex_t = AccountConfig.setupInstancePoolMutex()
    public static var maxInstanceCacheSize : UInt = 0
    public static var instancePool : ContiguousArray<AccountConfig> = []
    public var characterLimit : Int32 = 140
    public init(){}
    public init(characterLimit: Int32){
        self.characterLimit = characterLimit
    }
}

extension AccountConfig : PoolableInstances {
    public func reset() {
        characterLimit = 140
    }
}
public extension AccountConfig {
    private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> AccountConfig? {
        guard let objectOffset = objectOffset else {
            return nil
        }
        if reader.config.uniqueTables {
            if let o = reader.objectPool[objectOffset]{
                return o as? AccountConfig
            }
        }
        let _result = AccountConfig.createInstance()
        if reader.config.uniqueTables {
            reader.objectPool[objectOffset] = _result
        }
        _result.characterLimit = reader.get(objectOffset, propertyIndex: 0, defaultValue: 140)
        return _result
    }
}
public extension AccountConfig {
    public static func fromByteArray(data : UnsafeBufferPointer<UInt8>, config : BinaryReadConfig = BinaryReadConfig()) -> AccountConfig {
        let reader = FlatBufferReader.create(data, config: config)
        let objectOffset = reader.rootObjectOffset
        let result = create(reader, objectOffset : objectOffset)!
        FlatBufferReader.reuse(reader)
        return result
    }
    public static func fromRawMemory(data : UnsafeMutablePointer<UInt8>, count : Int, config : BinaryReadConfig = BinaryReadConfig()) -> AccountConfig {
        let reader = FlatBufferReader.create(data, count: count, config: config)
        let objectOffset = reader.rootObjectOffset
        let result = create(reader, objectOffset : objectOffset)!
        FlatBufferReader.reuse(reader)
        return result
    }
    public static func fromFlatBufferReader(flatBufferReader : FlatBufferReader) -> AccountConfig {
        return create(flatBufferReader, objectOffset : flatBufferReader.rootObjectOffset)!
    }
}
public extension AccountConfig {
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

public extension AccountConfig {
    public func toFlatBufferBuilder (builder : FlatBufferBuilder) -> Void {
        let offset = addToByteArray(builder)
        performLateBindings(builder)
        try! builder.finish(offset, fileIdentifier: nil)
    }
}

public extension AccountConfig {
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
        
        public var characterLimit : Int32 {
            get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:140)}
            set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
        }
        
        public var createEagerVersion : AccountConfig? { return AccountConfig.create(_reader, objectOffset: _objectOffset) }
        
        public var hashValue: Int { return Int(_objectOffset) }
    }
}

public func ==(t1 : AccountConfig.LazyAccess, t2 : AccountConfig.LazyAccess) -> Bool {
    return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension AccountConfig {
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
        public var characterLimit : Int32 {
            get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: 140) }
            set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
        }
        public var hashValue: Int { return Int(myOffset) }
    }
}
public func ==(t1 : AccountConfig.Fast, t2 : AccountConfig.Fast) -> Bool {
    return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension AccountConfig {
    private func addToByteArray(builder : FlatBufferBuilder) -> Offset {
        if builder.config.uniqueTables {
            if let myOffset = builder.cache[ObjectIdentifier(self)] {
                return myOffset
            }
        }
        try! builder.openObject(1)
        try! builder.addPropertyToOpenObject(0, value : characterLimit, defaultValue : 140)
        let myOffset =  try! builder.closeObject()
        if builder.config.uniqueTables {
            builder.cache[ObjectIdentifier(self)] = myOffset
        }
        return myOffset
    }
}
extension AccountConfig {
    public func toJSON() -> String{
        var properties : [String] = []
        properties.append("\"characterLimit\":\(characterLimit)")
        
        return "{\(properties.joinWithSeparator(","))}"
    }
    
    public static func fromJSON(dict : NSDictionary) -> AccountConfig {
        let result = AccountConfig()
        if let characterLimit = dict["characterLimit"] as? NSNumber {
            result.characterLimit = characterLimit.intValue
        }
        return result
    }
    
    public func jsonTypeName() -> String {
        return "\"AccountConfig\""
    }
}
private func performLateBindings(builder : FlatBufferBuilder) {
    for binding in builder.deferedBindings {
        switch binding.object {
        case let object as AccountConfig: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
        default: continue
        }
    }
}
