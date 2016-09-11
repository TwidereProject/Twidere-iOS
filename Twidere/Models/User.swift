
// generated with FlatBuffersSchemaEditor https://github.com/mzaks/FlatBuffersSchemaEditor

import Foundation

import FlatBuffersSwift
public final class User {
	public static var instancePoolMutex : pthread_mutex_t = User.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<User> = []
	public var _id : Int64 = 0
	public var accountKey : UserKey? = nil
	public var key : UserKey? = nil
	public var createdAt : Float64 = 0
	public var position : Int64 = -1
	public var isProtected : Bool = false
	public var isVerified : Bool = false
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
	
	public var profileBackgroundUrl : String? {
		get {
			if let s = profileBackgroundUrl_s {
				return s
			}
			if let s = profileBackgroundUrl_ss {
				profileBackgroundUrl_s = s.stringValue
			}
			if let s = profileBackgroundUrl_b {
				profileBackgroundUrl_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return profileBackgroundUrl_s
		}
		set {
			profileBackgroundUrl_s = newValue
			profileBackgroundUrl_ss = nil
			profileBackgroundUrl_b = nil
		}
	}
	public func profileBackgroundUrlStaticString(newValue : StaticString) {
		profileBackgroundUrl_ss = newValue
		profileBackgroundUrl_s = nil
		profileBackgroundUrl_b = nil
	}
	private var profileBackgroundUrl_b : UnsafeBufferPointer<UInt8>? = nil
	public var profileBackgroundUrlBuffer : UnsafeBufferPointer<UInt8>? {return profileBackgroundUrl_b}
	private var profileBackgroundUrl_s : String? = nil
	private var profileBackgroundUrl_ss : StaticString? = nil
	
	public var descriptionPlain : String? {
		get {
			if let s = descriptionPlain_s {
				return s
			}
			if let s = descriptionPlain_ss {
				descriptionPlain_s = s.stringValue
			}
			if let s = descriptionPlain_b {
				descriptionPlain_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return descriptionPlain_s
		}
		set {
			descriptionPlain_s = newValue
			descriptionPlain_ss = nil
			descriptionPlain_b = nil
		}
	}
	public func descriptionPlainStaticString(newValue : StaticString) {
		descriptionPlain_ss = newValue
		descriptionPlain_s = nil
		descriptionPlain_b = nil
	}
	private var descriptionPlain_b : UnsafeBufferPointer<UInt8>? = nil
	public var descriptionPlainBuffer : UnsafeBufferPointer<UInt8>? {return descriptionPlain_b}
	private var descriptionPlain_s : String? = nil
	private var descriptionPlain_ss : StaticString? = nil
	
	public var descriptionDisplay : String? {
		get {
			if let s = descriptionDisplay_s {
				return s
			}
			if let s = descriptionDisplay_ss {
				descriptionDisplay_s = s.stringValue
			}
			if let s = descriptionDisplay_b {
				descriptionDisplay_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return descriptionDisplay_s
		}
		set {
			descriptionDisplay_s = newValue
			descriptionDisplay_ss = nil
			descriptionDisplay_b = nil
		}
	}
	public func descriptionDisplayStaticString(newValue : StaticString) {
		descriptionDisplay_ss = newValue
		descriptionDisplay_s = nil
		descriptionDisplay_b = nil
	}
	private var descriptionDisplay_b : UnsafeBufferPointer<UInt8>? = nil
	public var descriptionDisplayBuffer : UnsafeBufferPointer<UInt8>? {return descriptionDisplay_b}
	private var descriptionDisplay_s : String? = nil
	private var descriptionDisplay_ss : StaticString? = nil
	
	public var url : String? {
		get {
			if let s = url_s {
				return s
			}
			if let s = url_ss {
				url_s = s.stringValue
			}
			if let s = url_b {
				url_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return url_s
		}
		set {
			url_s = newValue
			url_ss = nil
			url_b = nil
		}
	}
	public func urlStaticString(newValue : StaticString) {
		url_ss = newValue
		url_s = nil
		url_b = nil
	}
	private var url_b : UnsafeBufferPointer<UInt8>? = nil
	public var urlBuffer : UnsafeBufferPointer<UInt8>? {return url_b}
	private var url_s : String? = nil
	private var url_ss : StaticString? = nil
	
	public var urlExpanded : String? {
		get {
			if let s = urlExpanded_s {
				return s
			}
			if let s = urlExpanded_ss {
				urlExpanded_s = s.stringValue
			}
			if let s = urlExpanded_b {
				urlExpanded_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return urlExpanded_s
		}
		set {
			urlExpanded_s = newValue
			urlExpanded_ss = nil
			urlExpanded_b = nil
		}
	}
	public func urlExpandedStaticString(newValue : StaticString) {
		urlExpanded_ss = newValue
		urlExpanded_s = nil
		urlExpanded_b = nil
	}
	private var urlExpanded_b : UnsafeBufferPointer<UInt8>? = nil
	public var urlExpandedBuffer : UnsafeBufferPointer<UInt8>? {return urlExpanded_b}
	private var urlExpanded_s : String? = nil
	private var urlExpanded_ss : StaticString? = nil
	
	public var location : String? {
		get {
			if let s = location_s {
				return s
			}
			if let s = location_ss {
				location_s = s.stringValue
			}
			if let s = location_b {
				location_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return location_s
		}
		set {
			location_s = newValue
			location_ss = nil
			location_b = nil
		}
	}
	public func locationStaticString(newValue : StaticString) {
		location_ss = newValue
		location_s = nil
		location_b = nil
	}
	private var location_b : UnsafeBufferPointer<UInt8>? = nil
	public var locationBuffer : UnsafeBufferPointer<UInt8>? {return location_b}
	private var location_s : String? = nil
	private var location_ss : StaticString? = nil
	
	public var metadata : UserMetadata? = nil
	public init(){}
	public init(_id: Int64, accountKey: UserKey?, key: UserKey?, createdAt: Float64, position: Int64, isProtected: Bool, isVerified: Bool, name: String?, screenName: String?, profileImageUrl: String?, profileBannerUrl: String?, profileBackgroundUrl: String?, descriptionPlain: String?, descriptionDisplay: String?, url: String?, urlExpanded: String?, location: String?, metadata: UserMetadata?){
		self._id = _id
		self.accountKey = accountKey
		self.key = key
		self.createdAt = createdAt
		self.position = position
		self.isProtected = isProtected
		self.isVerified = isVerified
		self.name_s = name
		self.screenName_s = screenName
		self.profileImageUrl_s = profileImageUrl
		self.profileBannerUrl_s = profileBannerUrl
		self.profileBackgroundUrl_s = profileBackgroundUrl
		self.descriptionPlain_s = descriptionPlain
		self.descriptionDisplay_s = descriptionDisplay
		self.url_s = url
		self.urlExpanded_s = urlExpanded
		self.location_s = location
		self.metadata = metadata
	}
	public init(_id: Int64, accountKey: UserKey?, key: UserKey?, createdAt: Float64, position: Int64, isProtected: Bool, isVerified: Bool, name: StaticString?, screenName: StaticString?, profileImageUrl: StaticString?, profileBannerUrl: StaticString?, profileBackgroundUrl: StaticString?, descriptionPlain: StaticString?, descriptionDisplay: StaticString?, url: StaticString?, urlExpanded: StaticString?, location: StaticString?, metadata: UserMetadata?){
		self._id = _id
		self.accountKey = accountKey
		self.key = key
		self.createdAt = createdAt
		self.position = position
		self.isProtected = isProtected
		self.isVerified = isVerified
		self.name_ss = name
		self.screenName_ss = screenName
		self.profileImageUrl_ss = profileImageUrl
		self.profileBannerUrl_ss = profileBannerUrl
		self.profileBackgroundUrl_ss = profileBackgroundUrl
		self.descriptionPlain_ss = descriptionPlain
		self.descriptionDisplay_ss = descriptionDisplay
		self.url_ss = url
		self.urlExpanded_ss = urlExpanded
		self.location_ss = location
		self.metadata = metadata
	}
}

extension User : PoolableInstances {
	public func reset() { 
		_id = 0
		if accountKey != nil {
			var x = accountKey!
			accountKey = nil
			UserKey.reuseInstance(&x)
		}
		if key != nil {
			var x = key!
			key = nil
			UserKey.reuseInstance(&x)
		}
		createdAt = 0
		position = -1
		isProtected = false
		isVerified = false
		name = nil
		screenName = nil
		profileImageUrl = nil
		profileBannerUrl = nil
		profileBackgroundUrl = nil
		descriptionPlain = nil
		descriptionDisplay = nil
		url = nil
		urlExpanded = nil
		location = nil
		if metadata != nil {
			var x = metadata!
			metadata = nil
			UserMetadata.reuseInstance(&x)
		}
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
		_result._id = reader.get(objectOffset, propertyIndex: 0, defaultValue: 0)
		_result.accountKey = UserKey.create(reader, objectOffset: reader.getOffset(objectOffset, propertyIndex: 1))
		_result.key = UserKey.create(reader, objectOffset: reader.getOffset(objectOffset, propertyIndex: 2))
		_result.createdAt = reader.get(objectOffset, propertyIndex: 3, defaultValue: 0)
		_result.position = reader.get(objectOffset, propertyIndex: 4, defaultValue: -1)
		_result.isProtected = reader.get(objectOffset, propertyIndex: 5, defaultValue: false)
		_result.isVerified = reader.get(objectOffset, propertyIndex: 6, defaultValue: false)
		_result.name_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 7))
		_result.screenName_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 8))
		_result.profileImageUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 9))
		_result.profileBannerUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 10))
		_result.profileBackgroundUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 11))
		_result.descriptionPlain_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 12))
		_result.descriptionDisplay_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 13))
		_result.url_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 14))
		_result.urlExpanded_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 15))
		_result.location_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 16))
		_result.metadata = UserMetadata.create(reader, objectOffset: reader.getOffset(objectOffset, propertyIndex: 17))
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

		public var _id : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public lazy var accountKey : UserKey.LazyAccess? = UserKey.LazyAccess(reader: self._reader, objectOffset : self._reader.getOffset(self._objectOffset, propertyIndex: 1))
		public lazy var key : UserKey.LazyAccess? = UserKey.LazyAccess(reader: self._reader, objectOffset : self._reader.getOffset(self._objectOffset, propertyIndex: 2))
		public var createdAt : Float64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 3, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 3, value: newValue)}
		}
		public var position : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 4, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 4, value: newValue)}
		}
		public var isProtected : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 5, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 5, value: newValue)}
		}
		public var isVerified : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 6, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 6, value: newValue)}
		}
		public lazy var name : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 7))
		public lazy var screenName : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 8))
		public lazy var profileImageUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 9))
		public lazy var profileBannerUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 10))
		public lazy var profileBackgroundUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 11))
		public lazy var descriptionPlain : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 12))
		public lazy var descriptionDisplay : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 13))
		public lazy var url : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 14))
		public lazy var urlExpanded : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 15))
		public lazy var location : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 16))
		public lazy var metadata : UserMetadata.LazyAccess? = UserMetadata.LazyAccess(reader: self._reader, objectOffset : self._reader.getOffset(self._objectOffset, propertyIndex: 17))

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
	public var _id : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public var accountKey : UserKey.Fast? { get { 
		if let offset = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 1) {
			return UserKey.Fast(buffer: buffer, myOffset: offset)
		}
		return nil
	} }
	public var key : UserKey.Fast? { get { 
		if let offset = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 2) {
			return UserKey.Fast(buffer: buffer, myOffset: offset)
		}
		return nil
	} }
	public var createdAt : Float64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 3, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 3, value: newValue) }
	}
	public var position : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 4, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 4, value: newValue) }
	}
	public var isProtected : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 5, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 5, value: newValue) }
	}
	public var isVerified : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 6, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 6, value: newValue) }
	}
	public var name : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:7)) } }
	public var screenName : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:8)) } }
	public var profileImageUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:9)) } }
	public var profileBannerUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:10)) } }
	public var profileBackgroundUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:11)) } }
	public var descriptionPlain : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:12)) } }
	public var descriptionDisplay : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:13)) } }
	public var url : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:14)) } }
	public var urlExpanded : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:15)) } }
	public var location : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:16)) } }
	public var metadata : UserMetadata.Fast? { get { 
		if let offset = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 17) {
			return UserMetadata.Fast(buffer: buffer, myOffset: offset)
		}
		return nil
	} }
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
		if builder.inProgress.contains(ObjectIdentifier(self)){
			return 0
		}
		builder.inProgress.insert(ObjectIdentifier(self))
		let offset17 = metadata?.addToByteArray(builder) ?? 0
		// let offset16 = try! builder.createString(location)
		var offset16 : Offset
		if let s = location_b {
			offset16 = try! builder.createString(s)
		} else if let s = location_ss {
			offset16 = try! builder.createStaticString(s)
		} else {
			offset16 = try! builder.createString(location)
		}
		// let offset15 = try! builder.createString(urlExpanded)
		var offset15 : Offset
		if let s = urlExpanded_b {
			offset15 = try! builder.createString(s)
		} else if let s = urlExpanded_ss {
			offset15 = try! builder.createStaticString(s)
		} else {
			offset15 = try! builder.createString(urlExpanded)
		}
		// let offset14 = try! builder.createString(url)
		var offset14 : Offset
		if let s = url_b {
			offset14 = try! builder.createString(s)
		} else if let s = url_ss {
			offset14 = try! builder.createStaticString(s)
		} else {
			offset14 = try! builder.createString(url)
		}
		// let offset13 = try! builder.createString(descriptionDisplay)
		var offset13 : Offset
		if let s = descriptionDisplay_b {
			offset13 = try! builder.createString(s)
		} else if let s = descriptionDisplay_ss {
			offset13 = try! builder.createStaticString(s)
		} else {
			offset13 = try! builder.createString(descriptionDisplay)
		}
		// let offset12 = try! builder.createString(descriptionPlain)
		var offset12 : Offset
		if let s = descriptionPlain_b {
			offset12 = try! builder.createString(s)
		} else if let s = descriptionPlain_ss {
			offset12 = try! builder.createStaticString(s)
		} else {
			offset12 = try! builder.createString(descriptionPlain)
		}
		// let offset11 = try! builder.createString(profileBackgroundUrl)
		var offset11 : Offset
		if let s = profileBackgroundUrl_b {
			offset11 = try! builder.createString(s)
		} else if let s = profileBackgroundUrl_ss {
			offset11 = try! builder.createStaticString(s)
		} else {
			offset11 = try! builder.createString(profileBackgroundUrl)
		}
		// let offset10 = try! builder.createString(profileBannerUrl)
		var offset10 : Offset
		if let s = profileBannerUrl_b {
			offset10 = try! builder.createString(s)
		} else if let s = profileBannerUrl_ss {
			offset10 = try! builder.createStaticString(s)
		} else {
			offset10 = try! builder.createString(profileBannerUrl)
		}
		// let offset9 = try! builder.createString(profileImageUrl)
		var offset9 : Offset
		if let s = profileImageUrl_b {
			offset9 = try! builder.createString(s)
		} else if let s = profileImageUrl_ss {
			offset9 = try! builder.createStaticString(s)
		} else {
			offset9 = try! builder.createString(profileImageUrl)
		}
		// let offset8 = try! builder.createString(screenName)
		var offset8 : Offset
		if let s = screenName_b {
			offset8 = try! builder.createString(s)
		} else if let s = screenName_ss {
			offset8 = try! builder.createStaticString(s)
		} else {
			offset8 = try! builder.createString(screenName)
		}
		// let offset7 = try! builder.createString(name)
		var offset7 : Offset
		if let s = name_b {
			offset7 = try! builder.createString(s)
		} else if let s = name_ss {
			offset7 = try! builder.createStaticString(s)
		} else {
			offset7 = try! builder.createString(name)
		}
		let offset2 = key?.addToByteArray(builder) ?? 0
		let offset1 = accountKey?.addToByteArray(builder) ?? 0
		try! builder.openObject(18)
		if metadata != nil {
			try! builder.addPropertyOffsetToOpenObject(17, offset: offset17)
		}
		try! builder.addPropertyOffsetToOpenObject(16, offset: offset16)
		try! builder.addPropertyOffsetToOpenObject(15, offset: offset15)
		try! builder.addPropertyOffsetToOpenObject(14, offset: offset14)
		try! builder.addPropertyOffsetToOpenObject(13, offset: offset13)
		try! builder.addPropertyOffsetToOpenObject(12, offset: offset12)
		try! builder.addPropertyOffsetToOpenObject(11, offset: offset11)
		try! builder.addPropertyOffsetToOpenObject(10, offset: offset10)
		try! builder.addPropertyOffsetToOpenObject(9, offset: offset9)
		try! builder.addPropertyOffsetToOpenObject(8, offset: offset8)
		try! builder.addPropertyOffsetToOpenObject(7, offset: offset7)
		try! builder.addPropertyToOpenObject(6, value : isVerified, defaultValue : false)
		try! builder.addPropertyToOpenObject(5, value : isProtected, defaultValue : false)
		try! builder.addPropertyToOpenObject(4, value : position, defaultValue : -1)
		try! builder.addPropertyToOpenObject(3, value : createdAt, defaultValue : 0)
		if key != nil {
			try! builder.addPropertyOffsetToOpenObject(2, offset: offset2)
		}
		if accountKey != nil {
			try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
		}
		try! builder.addPropertyToOpenObject(0, value : _id, defaultValue : 0)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		builder.inProgress.remove(ObjectIdentifier(self))
		return myOffset
	}
}
extension User {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"_id\":\(_id)")
		if let accountKey = accountKey{
			properties.append("\"accountKey\":\(accountKey.toJSON())")
		}
		if let key = key{
			properties.append("\"key\":\(key.toJSON())")
		}
		properties.append("\"createdAt\":\(createdAt)")
		properties.append("\"position\":\(position)")
		properties.append("\"isProtected\":\(isProtected)")
		properties.append("\"isVerified\":\(isVerified)")
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
		if let profileBackgroundUrl = profileBackgroundUrl{
			properties.append("\"profileBackgroundUrl\":\"\(profileBackgroundUrl)\"")
		}
		if let descriptionPlain = descriptionPlain{
			properties.append("\"descriptionPlain\":\"\(descriptionPlain)\"")
		}
		if let descriptionDisplay = descriptionDisplay{
			properties.append("\"descriptionDisplay\":\"\(descriptionDisplay)\"")
		}
		if let url = url{
			properties.append("\"url\":\"\(url)\"")
		}
		if let urlExpanded = urlExpanded{
			properties.append("\"urlExpanded\":\"\(urlExpanded)\"")
		}
		if let location = location{
			properties.append("\"location\":\"\(location)\"")
		}
		if let metadata = metadata{
			properties.append("\"metadata\":\(metadata.toJSON())")
		}
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> User {
		let result = User()
		if let _id = dict["_id"] as? NSNumber {
			result._id = _id.longLongValue
		}
		if let accountKey = dict["accountKey"] as? NSDictionary {
			result.accountKey = UserKey.fromJSON(accountKey)
		}
		if let key = dict["key"] as? NSDictionary {
			result.key = UserKey.fromJSON(key)
		}
		if let createdAt = dict["createdAt"] as? NSNumber {
			result.createdAt = createdAt.doubleValue
		}
		if let position = dict["position"] as? NSNumber {
			result.position = position.longLongValue
		}
		if let isProtected = dict["isProtected"] as? NSNumber {
			result.isProtected = isProtected.boolValue
		}
		if let isVerified = dict["isVerified"] as? NSNumber {
			result.isVerified = isVerified.boolValue
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
		if let profileBackgroundUrl = dict["profileBackgroundUrl"] as? NSString {
			result.profileBackgroundUrl = profileBackgroundUrl as String
		}
		if let descriptionPlain = dict["descriptionPlain"] as? NSString {
			result.descriptionPlain = descriptionPlain as String
		}
		if let descriptionDisplay = dict["descriptionDisplay"] as? NSString {
			result.descriptionDisplay = descriptionDisplay as String
		}
		if let url = dict["url"] as? NSString {
			result.url = url as String
		}
		if let urlExpanded = dict["urlExpanded"] as? NSString {
			result.urlExpanded = urlExpanded as String
		}
		if let location = dict["location"] as? NSString {
			result.location = location as String
		}
		if let metadata = dict["metadata"] as? NSDictionary {
			result.metadata = UserMetadata.fromJSON(metadata)
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"User\""
	}
}
public final class UserMetadata {
	public static var instancePoolMutex : pthread_mutex_t = UserMetadata.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<UserMetadata> = []
	public var following : Bool = false
	public var followedBy : Bool = false
	public var blocking : Bool = false
	public var blockedBy : Bool = false
	public var muting : Bool = false
	public var followRequestSent : Bool = false
	public var statusesCount : Int64 = -1
	public var followersCount : Int64 = -1
	public var friendsCount : Int64 = -1
	public var favoritesCount : Int64 = -1
	public var mediaCount : Int64 = -1
	public var listsCount : Int64 = -1
	public var listedCount : Int64 = -1
	public var groupsCount : Int64 = -1
	public init(){}
	public init(following: Bool, followedBy: Bool, blocking: Bool, blockedBy: Bool, muting: Bool, followRequestSent: Bool, statusesCount: Int64, followersCount: Int64, friendsCount: Int64, favoritesCount: Int64, mediaCount: Int64, listsCount: Int64, listedCount: Int64, groupsCount: Int64){
		self.following = following
		self.followedBy = followedBy
		self.blocking = blocking
		self.blockedBy = blockedBy
		self.muting = muting
		self.followRequestSent = followRequestSent
		self.statusesCount = statusesCount
		self.followersCount = followersCount
		self.friendsCount = friendsCount
		self.favoritesCount = favoritesCount
		self.mediaCount = mediaCount
		self.listsCount = listsCount
		self.listedCount = listedCount
		self.groupsCount = groupsCount
	}
}

extension UserMetadata : PoolableInstances {
	public func reset() { 
		following = false
		followedBy = false
		blocking = false
		blockedBy = false
		muting = false
		followRequestSent = false
		statusesCount = -1
		followersCount = -1
		friendsCount = -1
		favoritesCount = -1
		mediaCount = -1
		listsCount = -1
		listedCount = -1
		groupsCount = -1
	}
}
public extension UserMetadata {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> UserMetadata? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? UserMetadata
			}
		}
		let _result = UserMetadata.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.following = reader.get(objectOffset, propertyIndex: 0, defaultValue: false)
		_result.followedBy = reader.get(objectOffset, propertyIndex: 1, defaultValue: false)
		_result.blocking = reader.get(objectOffset, propertyIndex: 2, defaultValue: false)
		_result.blockedBy = reader.get(objectOffset, propertyIndex: 3, defaultValue: false)
		_result.muting = reader.get(objectOffset, propertyIndex: 4, defaultValue: false)
		_result.followRequestSent = reader.get(objectOffset, propertyIndex: 5, defaultValue: false)
		_result.statusesCount = reader.get(objectOffset, propertyIndex: 6, defaultValue: -1)
		_result.followersCount = reader.get(objectOffset, propertyIndex: 7, defaultValue: -1)
		_result.friendsCount = reader.get(objectOffset, propertyIndex: 8, defaultValue: -1)
		_result.favoritesCount = reader.get(objectOffset, propertyIndex: 9, defaultValue: -1)
		_result.mediaCount = reader.get(objectOffset, propertyIndex: 10, defaultValue: -1)
		_result.listsCount = reader.get(objectOffset, propertyIndex: 11, defaultValue: -1)
		_result.listedCount = reader.get(objectOffset, propertyIndex: 12, defaultValue: -1)
		_result.groupsCount = reader.get(objectOffset, propertyIndex: 13, defaultValue: -1)
		return _result
	}
}
public extension UserMetadata {
	public final class LazyAccess : Hashable {
		private let _reader : FlatBufferReader!
		private let _objectOffset : Offset!
		private init?(reader : FlatBufferReader, objectOffset : Offset?){
			guard let objectOffset = objectOffset else {
				_reader = nil
				_objectOffset = nil
				return nil
			}
			_reader = reader
			_objectOffset = objectOffset
		}

		public var following : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public var followedBy : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 1, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 1, value: newValue)}
		}
		public var blocking : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 2, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 2, value: newValue)}
		}
		public var blockedBy : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 3, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 3, value: newValue)}
		}
		public var muting : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 4, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 4, value: newValue)}
		}
		public var followRequestSent : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 5, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 5, value: newValue)}
		}
		public var statusesCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 6, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 6, value: newValue)}
		}
		public var followersCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 7, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 7, value: newValue)}
		}
		public var friendsCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 8, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 8, value: newValue)}
		}
		public var favoritesCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 9, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 9, value: newValue)}
		}
		public var mediaCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 10, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 10, value: newValue)}
		}
		public var listsCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 11, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 11, value: newValue)}
		}
		public var listedCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 12, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 12, value: newValue)}
		}
		public var groupsCount : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 13, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 13, value: newValue)}
		}

		public var createEagerVersion : UserMetadata? { return UserMetadata.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : UserMetadata.LazyAccess, t2 : UserMetadata.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension UserMetadata {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var following : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public var followedBy : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 1, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 1, value: newValue) }
	}
	public var blocking : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 2, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 2, value: newValue) }
	}
	public var blockedBy : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 3, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 3, value: newValue) }
	}
	public var muting : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 4, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 4, value: newValue) }
	}
	public var followRequestSent : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 5, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 5, value: newValue) }
	}
	public var statusesCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 6, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 6, value: newValue) }
	}
	public var followersCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 7, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 7, value: newValue) }
	}
	public var friendsCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 8, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 8, value: newValue) }
	}
	public var favoritesCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 9, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 9, value: newValue) }
	}
	public var mediaCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 10, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 10, value: newValue) }
	}
	public var listsCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 11, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 11, value: newValue) }
	}
	public var listedCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 12, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 12, value: newValue) }
	}
	public var groupsCount : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 13, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 13, value: newValue) }
	}
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : UserMetadata.Fast, t2 : UserMetadata.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension UserMetadata {
	private func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		try! builder.openObject(14)
		try! builder.addPropertyToOpenObject(13, value : groupsCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(12, value : listedCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(11, value : listsCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(10, value : mediaCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(9, value : favoritesCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(8, value : friendsCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(7, value : followersCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(6, value : statusesCount, defaultValue : -1)
		try! builder.addPropertyToOpenObject(5, value : followRequestSent, defaultValue : false)
		try! builder.addPropertyToOpenObject(4, value : muting, defaultValue : false)
		try! builder.addPropertyToOpenObject(3, value : blockedBy, defaultValue : false)
		try! builder.addPropertyToOpenObject(2, value : blocking, defaultValue : false)
		try! builder.addPropertyToOpenObject(1, value : followedBy, defaultValue : false)
		try! builder.addPropertyToOpenObject(0, value : following, defaultValue : false)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension UserMetadata {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"following\":\(following)")
		properties.append("\"followedBy\":\(followedBy)")
		properties.append("\"blocking\":\(blocking)")
		properties.append("\"blockedBy\":\(blockedBy)")
		properties.append("\"muting\":\(muting)")
		properties.append("\"followRequestSent\":\(followRequestSent)")
		properties.append("\"statusesCount\":\(statusesCount)")
		properties.append("\"followersCount\":\(followersCount)")
		properties.append("\"friendsCount\":\(friendsCount)")
		properties.append("\"favoritesCount\":\(favoritesCount)")
		properties.append("\"mediaCount\":\(mediaCount)")
		properties.append("\"listsCount\":\(listsCount)")
		properties.append("\"listedCount\":\(listedCount)")
		properties.append("\"groupsCount\":\(groupsCount)")
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> UserMetadata {
		let result = UserMetadata()
		if let following = dict["following"] as? NSNumber {
			result.following = following.boolValue
		}
		if let followedBy = dict["followedBy"] as? NSNumber {
			result.followedBy = followedBy.boolValue
		}
		if let blocking = dict["blocking"] as? NSNumber {
			result.blocking = blocking.boolValue
		}
		if let blockedBy = dict["blockedBy"] as? NSNumber {
			result.blockedBy = blockedBy.boolValue
		}
		if let muting = dict["muting"] as? NSNumber {
			result.muting = muting.boolValue
		}
		if let followRequestSent = dict["followRequestSent"] as? NSNumber {
			result.followRequestSent = followRequestSent.boolValue
		}
		if let statusesCount = dict["statusesCount"] as? NSNumber {
			result.statusesCount = statusesCount.longLongValue
		}
		if let followersCount = dict["followersCount"] as? NSNumber {
			result.followersCount = followersCount.longLongValue
		}
		if let friendsCount = dict["friendsCount"] as? NSNumber {
			result.friendsCount = friendsCount.longLongValue
		}
		if let favoritesCount = dict["favoritesCount"] as? NSNumber {
			result.favoritesCount = favoritesCount.longLongValue
		}
		if let mediaCount = dict["mediaCount"] as? NSNumber {
			result.mediaCount = mediaCount.longLongValue
		}
		if let listsCount = dict["listsCount"] as? NSNumber {
			result.listsCount = listsCount.longLongValue
		}
		if let listedCount = dict["listedCount"] as? NSNumber {
			result.listedCount = listedCount.longLongValue
		}
		if let groupsCount = dict["groupsCount"] as? NSNumber {
			result.groupsCount = groupsCount.longLongValue
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"UserMetadata\""
	}
}
private func performLateBindings(builder : FlatBufferBuilder) {
	for binding in builder.deferedBindings {
		switch binding.object {
		case let object as User: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as UserMetadata: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as UserKey: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		default: continue
		}
	}
}
