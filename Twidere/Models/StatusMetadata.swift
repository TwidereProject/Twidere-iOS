
// generated with FlatBuffersSchemaEditor https://github.com/mzaks/FlatBuffersSchemaEditor

import Foundation

import FlatBuffersSwift
		public enum MediaItemType : Int8 {
			case Unknown = 0, Image = 1, Video = 2, AnimatedGif = 3, ExternalPlayer = 4, VariableType = 5
		}
		
		extension MediaItemType {
			func toJSON() -> String {
				switch self {
				case Unknown:
					return "\"Unknown\""
				case Image:
					return "\"Image\""
				case Video:
					return "\"Video\""
				case AnimatedGif:
					return "\"AnimatedGif\""
				case ExternalPlayer:
					return "\"ExternalPlayer\""
				case VariableType:
					return "\"VariableType\""
				}
			}
			static func fromJSON(value : String) -> MediaItemType? {
			switch value {
			case "Unknown":
				return Unknown
			case "Image":
				return Image
			case "Video":
				return Video
			case "AnimatedGif":
				return AnimatedGif
			case "ExternalPlayer":
				return ExternalPlayer
			case "VariableType":
				return VariableType
			default:
				return nil
			}
		}
}
		
public final class StatusMetadata {
	public static var instancePoolMutex : pthread_mutex_t = StatusMetadata.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<StatusMetadata> = []
	public var displayRange : DisplayRange? = nil
	public var links : ContiguousArray<LinkSpanItem?> = []
	public var mentions : ContiguousArray<MentionSpanItem?> = []
	public var hashtags : ContiguousArray<HashtagSpanItem?> = []
	public var media : ContiguousArray<MediaItem?> = []
	public init(){}
	public init(displayRange: DisplayRange?, links: ContiguousArray<LinkSpanItem?>, mentions: ContiguousArray<MentionSpanItem?>, hashtags: ContiguousArray<HashtagSpanItem?>, media: ContiguousArray<MediaItem?>){
		self.displayRange = displayRange
		self.links = links
		self.mentions = mentions
		self.hashtags = hashtags
		self.media = media
	}
}

extension StatusMetadata : PoolableInstances {
	public func reset() { 
		displayRange = nil
		while (links.count > 0) {
			var x = links.removeLast()!
			LinkSpanItem.reuseInstance(&x)
		}
		while (mentions.count > 0) {
			var x = mentions.removeLast()!
			MentionSpanItem.reuseInstance(&x)
		}
		while (hashtags.count > 0) {
			var x = hashtags.removeLast()!
			HashtagSpanItem.reuseInstance(&x)
		}
		while (media.count > 0) {
			var x = media.removeLast()!
			MediaItem.reuseInstance(&x)
		}
	}
}
public extension StatusMetadata {
	static func create(reader : FlatBufferReader, objectOffset : Offset?) -> StatusMetadata? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? StatusMetadata
			}
		}
		let _result = StatusMetadata.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.displayRange = reader.get(objectOffset, propertyIndex: 0)
		let offset_links : Offset? = reader.getOffset(objectOffset, propertyIndex: 1)
		let length_links = reader.getVectorLength(offset_links)
		if(length_links > 0){
			var index = 0
			_result.links.reserveCapacity(length_links)
			while index < length_links {
				_result.links.append(LinkSpanItem.create(reader, objectOffset: reader.getVectorOffsetElement(offset_links!, index: index)))
				index += 1
			}
		}
		let offset_mentions : Offset? = reader.getOffset(objectOffset, propertyIndex: 2)
		let length_mentions = reader.getVectorLength(offset_mentions)
		if(length_mentions > 0){
			var index = 0
			_result.mentions.reserveCapacity(length_mentions)
			while index < length_mentions {
				_result.mentions.append(MentionSpanItem.create(reader, objectOffset: reader.getVectorOffsetElement(offset_mentions!, index: index)))
				index += 1
			}
		}
		let offset_hashtags : Offset? = reader.getOffset(objectOffset, propertyIndex: 3)
		let length_hashtags = reader.getVectorLength(offset_hashtags)
		if(length_hashtags > 0){
			var index = 0
			_result.hashtags.reserveCapacity(length_hashtags)
			while index < length_hashtags {
				_result.hashtags.append(HashtagSpanItem.create(reader, objectOffset: reader.getVectorOffsetElement(offset_hashtags!, index: index)))
				index += 1
			}
		}
		let offset_media : Offset? = reader.getOffset(objectOffset, propertyIndex: 4)
		let length_media = reader.getVectorLength(offset_media)
		if(length_media > 0){
			var index = 0
			_result.media.reserveCapacity(length_media)
			while index < length_media {
				_result.media.append(MediaItem.create(reader, objectOffset: reader.getVectorOffsetElement(offset_media!, index: index)))
				index += 1
			}
		}
		return _result
	}
}
public extension StatusMetadata {
	public static func fromByteArray(data : UnsafeBufferPointer<UInt8>, config : BinaryReadConfig = BinaryReadConfig()) -> StatusMetadata {
		let reader = FlatBufferReader.create(data, config: config)
		let objectOffset = reader.rootObjectOffset
		let result = create(reader, objectOffset : objectOffset)!
		FlatBufferReader.reuse(reader)
		return result
	}
	public static func fromRawMemory(data : UnsafeMutablePointer<UInt8>, count : Int, config : BinaryReadConfig = BinaryReadConfig()) -> StatusMetadata {
		let reader = FlatBufferReader.create(data, count: count, config: config)
		let objectOffset = reader.rootObjectOffset
		let result = create(reader, objectOffset : objectOffset)!
		FlatBufferReader.reuse(reader)
		return result
	}
	public static func fromFlatBufferReader(flatBufferReader : FlatBufferReader) -> StatusMetadata {
		return create(flatBufferReader, objectOffset : flatBufferReader.rootObjectOffset)!
	}
}
public extension StatusMetadata {
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

public extension StatusMetadata {
	public func toFlatBufferBuilder (builder : FlatBufferBuilder) -> Void {
		let offset = addToByteArray(builder)
		performLateBindings(builder)
		try! builder.finish(offset, fileIdentifier: nil)
	}
}

public extension StatusMetadata {
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

		public var displayRange : DisplayRange? { 
			get { return self._reader.get(_objectOffset, propertyIndex: 0)}
			set {
				if let value = newValue{
					try!_reader.set(_objectOffset, propertyIndex: 0, value: value)
				}
			}
		}
		public lazy var links : LazyVector<LinkSpanItem.LazyAccess> = { [self]
			let vectorOffset : Offset? = self._reader.getOffset(self._objectOffset, propertyIndex: 1)
			let vectorLength = self._reader.getVectorLength(vectorOffset)
			let reader = self._reader
			return LazyVector(count: vectorLength){ [reader] in
				LinkSpanItem.LazyAccess(reader: reader, objectOffset : reader.getVectorOffsetElement(vectorOffset!, index: $0))
			}
		}()
		public lazy var mentions : LazyVector<MentionSpanItem.LazyAccess> = { [self]
			let vectorOffset : Offset? = self._reader.getOffset(self._objectOffset, propertyIndex: 2)
			let vectorLength = self._reader.getVectorLength(vectorOffset)
			let reader = self._reader
			return LazyVector(count: vectorLength){ [reader] in
				MentionSpanItem.LazyAccess(reader: reader, objectOffset : reader.getVectorOffsetElement(vectorOffset!, index: $0))
			}
		}()
		public lazy var hashtags : LazyVector<HashtagSpanItem.LazyAccess> = { [self]
			let vectorOffset : Offset? = self._reader.getOffset(self._objectOffset, propertyIndex: 3)
			let vectorLength = self._reader.getVectorLength(vectorOffset)
			let reader = self._reader
			return LazyVector(count: vectorLength){ [reader] in
				HashtagSpanItem.LazyAccess(reader: reader, objectOffset : reader.getVectorOffsetElement(vectorOffset!, index: $0))
			}
		}()
		public lazy var media : LazyVector<MediaItem.LazyAccess> = { [self]
			let vectorOffset : Offset? = self._reader.getOffset(self._objectOffset, propertyIndex: 4)
			let vectorLength = self._reader.getVectorLength(vectorOffset)
			let reader = self._reader
			return LazyVector(count: vectorLength){ [reader] in
				MediaItem.LazyAccess(reader: reader, objectOffset : reader.getVectorOffsetElement(vectorOffset!, index: $0))
			}
		}()

		public var createEagerVersion : StatusMetadata? { return StatusMetadata.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : StatusMetadata.LazyAccess, t2 : StatusMetadata.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension StatusMetadata {
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
	public var displayRange : DisplayRange? { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0)}
		set { 
			if let newValue = newValue {
				try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue)
			}
		}
	}
	public struct LinksVector {
		private var buffer : UnsafePointer<UInt8> = nil
		private var myOffset : Offset = 0
		private let offsetList : Offset?
		private init(buffer b: UnsafePointer<UInt8>, myOffset o: Offset ) {
			buffer = b
			myOffset = o
			offsetList = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 1)
		}
		public var count : Int { get { return FlatBufferReaderFast.getVectorLength(buffer, offsetList) } }
		public subscript (index : Int) -> LinkSpanItem.Fast? {
			get {
				if let ofs = FlatBufferReaderFast.getVectorOffsetElement(buffer, offsetList!, index: index) {
					return LinkSpanItem.Fast(buffer: buffer, myOffset: ofs)
				}
				return nil
			}
		}
	}
	public lazy var links : LinksVector = LinksVector(buffer: self.buffer, myOffset: self.myOffset)
	public struct MentionsVector {
		private var buffer : UnsafePointer<UInt8> = nil
		private var myOffset : Offset = 0
		private let offsetList : Offset?
		private init(buffer b: UnsafePointer<UInt8>, myOffset o: Offset ) {
			buffer = b
			myOffset = o
			offsetList = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 2)
		}
		public var count : Int { get { return FlatBufferReaderFast.getVectorLength(buffer, offsetList) } }
		public subscript (index : Int) -> MentionSpanItem.Fast? {
			get {
				if let ofs = FlatBufferReaderFast.getVectorOffsetElement(buffer, offsetList!, index: index) {
					return MentionSpanItem.Fast(buffer: buffer, myOffset: ofs)
				}
				return nil
			}
		}
	}
	public lazy var mentions : MentionsVector = MentionsVector(buffer: self.buffer, myOffset: self.myOffset)
	public struct HashtagsVector {
		private var buffer : UnsafePointer<UInt8> = nil
		private var myOffset : Offset = 0
		private let offsetList : Offset?
		private init(buffer b: UnsafePointer<UInt8>, myOffset o: Offset ) {
			buffer = b
			myOffset = o
			offsetList = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 3)
		}
		public var count : Int { get { return FlatBufferReaderFast.getVectorLength(buffer, offsetList) } }
		public subscript (index : Int) -> HashtagSpanItem.Fast? {
			get {
				if let ofs = FlatBufferReaderFast.getVectorOffsetElement(buffer, offsetList!, index: index) {
					return HashtagSpanItem.Fast(buffer: buffer, myOffset: ofs)
				}
				return nil
			}
		}
	}
	public lazy var hashtags : HashtagsVector = HashtagsVector(buffer: self.buffer, myOffset: self.myOffset)
	public struct MediaVector {
		private var buffer : UnsafePointer<UInt8> = nil
		private var myOffset : Offset = 0
		private let offsetList : Offset?
		private init(buffer b: UnsafePointer<UInt8>, myOffset o: Offset ) {
			buffer = b
			myOffset = o
			offsetList = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 4)
		}
		public var count : Int { get { return FlatBufferReaderFast.getVectorLength(buffer, offsetList) } }
		public subscript (index : Int) -> MediaItem.Fast? {
			get {
				if let ofs = FlatBufferReaderFast.getVectorOffsetElement(buffer, offsetList!, index: index) {
					return MediaItem.Fast(buffer: buffer, myOffset: ofs)
				}
				return nil
			}
		}
	}
	public lazy var media : MediaVector = MediaVector(buffer: self.buffer, myOffset: self.myOffset)
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : StatusMetadata.Fast, t2 : StatusMetadata.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension StatusMetadata {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		var offset4 = Offset(0)
		if media.count > 0{
			var offsets = [Offset?](count: media.count, repeatedValue: nil)
			var index = media.count - 1
			while(index >= 0){
				offsets[index] = media[index]?.addToByteArray(builder)
				index -= 1
			}
			try! builder.startVector(media.count, elementSize: strideof(Offset))
			index = media.count - 1
			while(index >= 0){
				try! builder.putOffset(offsets[index])
				index -= 1
			}
			offset4 = builder.endVector()
		}
		var offset3 = Offset(0)
		if hashtags.count > 0{
			var offsets = [Offset?](count: hashtags.count, repeatedValue: nil)
			var index = hashtags.count - 1
			while(index >= 0){
				offsets[index] = hashtags[index]?.addToByteArray(builder)
				index -= 1
			}
			try! builder.startVector(hashtags.count, elementSize: strideof(Offset))
			index = hashtags.count - 1
			while(index >= 0){
				try! builder.putOffset(offsets[index])
				index -= 1
			}
			offset3 = builder.endVector()
		}
		var offset2 = Offset(0)
		if mentions.count > 0{
			var offsets = [Offset?](count: mentions.count, repeatedValue: nil)
			var index = mentions.count - 1
			while(index >= 0){
				offsets[index] = mentions[index]?.addToByteArray(builder)
				index -= 1
			}
			try! builder.startVector(mentions.count, elementSize: strideof(Offset))
			index = mentions.count - 1
			while(index >= 0){
				try! builder.putOffset(offsets[index])
				index -= 1
			}
			offset2 = builder.endVector()
		}
		var offset1 = Offset(0)
		if links.count > 0{
			var offsets = [Offset?](count: links.count, repeatedValue: nil)
			var index = links.count - 1
			while(index >= 0){
				offsets[index] = links[index]?.addToByteArray(builder)
				index -= 1
			}
			try! builder.startVector(links.count, elementSize: strideof(Offset))
			index = links.count - 1
			while(index >= 0){
				try! builder.putOffset(offsets[index])
				index -= 1
			}
			offset1 = builder.endVector()
		}
		try! builder.openObject(5)
		if media.count > 0 {
			try! builder.addPropertyOffsetToOpenObject(4, offset: offset4)
		}
		if hashtags.count > 0 {
			try! builder.addPropertyOffsetToOpenObject(3, offset: offset3)
		}
		if mentions.count > 0 {
			try! builder.addPropertyOffsetToOpenObject(2, offset: offset2)
		}
		if links.count > 0 {
			try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
		}
		if let displayRange = displayRange {
			builder.put(displayRange)
			try! builder.addCurrentOffsetAsPropertyToOpenObject(0)
		}
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension StatusMetadata {
	public func toJSON() -> String{
		var properties : [String] = []
		if let displayRange = displayRange{
			properties.append("\"displayRange\":\(displayRange.toJSON())")
		}
		properties.append("\"links\":[\(links.map({$0 == nil ? "null" : $0!.toJSON()}).joinWithSeparator(","))]")
		properties.append("\"mentions\":[\(mentions.map({$0 == nil ? "null" : $0!.toJSON()}).joinWithSeparator(","))]")
		properties.append("\"hashtags\":[\(hashtags.map({$0 == nil ? "null" : $0!.toJSON()}).joinWithSeparator(","))]")
		properties.append("\"media\":[\(media.map({$0 == nil ? "null" : $0!.toJSON()}).joinWithSeparator(","))]")
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> StatusMetadata {
		let result = StatusMetadata()
		if let displayRange = dict["displayRange"] as? NSDictionary {
			result.displayRange = DisplayRange.fromJSON(displayRange)
		}
		if let links = dict["links"] as? NSArray {
			result.links = ContiguousArray(links.map({
				if let entry = $0 as? NSDictionary {
					return LinkSpanItem.fromJSON(entry)
				}
				return nil
			}))
		}
		if let mentions = dict["mentions"] as? NSArray {
			result.mentions = ContiguousArray(mentions.map({
				if let entry = $0 as? NSDictionary {
					return MentionSpanItem.fromJSON(entry)
				}
				return nil
			}))
		}
		if let hashtags = dict["hashtags"] as? NSArray {
			result.hashtags = ContiguousArray(hashtags.map({
				if let entry = $0 as? NSDictionary {
					return HashtagSpanItem.fromJSON(entry)
				}
				return nil
			}))
		}
		if let media = dict["media"] as? NSArray {
			result.media = ContiguousArray(media.map({
				if let entry = $0 as? NSDictionary {
					return MediaItem.fromJSON(entry)
				}
				return nil
			}))
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"StatusMetadata\""
	}
}
public struct DisplayRange : Scalar {
	public let start : Int32
	public let end : Int32
}
public func ==(v1:DisplayRange, v2:DisplayRange) -> Bool {
	return  v1.start==v2.start &&  v1.end==v2.end
}

extension DisplayRange {
	public func toJSON() -> String{
		let startProperty = "\"start\":\(start)"
		let endProperty = "\"end\":\(end)"
		return "{\(startProperty),\(endProperty)}"
	}
	
	public static func fromJSON(dict : NSDictionary) -> DisplayRange {
		return DisplayRange(
		start: (dict["start"] as! NSNumber).intValue,
		end: (dict["end"] as! NSNumber).intValue
		)
	}
}
public final class LinkSpanItem {
	public static var instancePoolMutex : pthread_mutex_t = LinkSpanItem.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<LinkSpanItem> = []
	public var start : Int32 = 0
	public var end : Int32 = 0
	public var origStart : Int32 = 0
	public var origEnd : Int32 = 0
	public var display : String? {
		get {
			if let s = display_s {
				return s
			}
			if let s = display_ss {
				display_s = s.stringValue
			}
			if let s = display_b {
				display_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return display_s
		}
		set {
			display_s = newValue
			display_ss = nil
			display_b = nil
		}
	}
	public func displayStaticString(newValue : StaticString) {
		display_ss = newValue
		display_s = nil
		display_b = nil
	}
	private var display_b : UnsafeBufferPointer<UInt8>? = nil
	public var displayBuffer : UnsafeBufferPointer<UInt8>? {return display_b}
	private var display_s : String? = nil
	private var display_ss : StaticString? = nil
	
	public var link : String? {
		get {
			if let s = link_s {
				return s
			}
			if let s = link_ss {
				link_s = s.stringValue
			}
			if let s = link_b {
				link_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return link_s
		}
		set {
			link_s = newValue
			link_ss = nil
			link_b = nil
		}
	}
	public func linkStaticString(newValue : StaticString) {
		link_ss = newValue
		link_s = nil
		link_b = nil
	}
	private var link_b : UnsafeBufferPointer<UInt8>? = nil
	public var linkBuffer : UnsafeBufferPointer<UInt8>? {return link_b}
	private var link_s : String? = nil
	private var link_ss : StaticString? = nil
	
	public init(){}
	public init(start: Int32, end: Int32, origStart: Int32, origEnd: Int32, display: String?, link: String?){
		self.start = start
		self.end = end
		self.origStart = origStart
		self.origEnd = origEnd
		self.display_s = display
		self.link_s = link
	}
	public init(start: Int32, end: Int32, origStart: Int32, origEnd: Int32, display: StaticString?, link: StaticString?){
		self.start = start
		self.end = end
		self.origStart = origStart
		self.origEnd = origEnd
		self.display_ss = display
		self.link_ss = link
	}
}

extension LinkSpanItem : PoolableInstances {
	public func reset() { 
		start = 0
		end = 0
		origStart = 0
		origEnd = 0
		display = nil
		link = nil
	}
}
public extension LinkSpanItem {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> LinkSpanItem? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? LinkSpanItem
			}
		}
		let _result = LinkSpanItem.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.start = reader.get(objectOffset, propertyIndex: 0, defaultValue: 0)
		_result.end = reader.get(objectOffset, propertyIndex: 1, defaultValue: 0)
		_result.origStart = reader.get(objectOffset, propertyIndex: 2, defaultValue: 0)
		_result.origEnd = reader.get(objectOffset, propertyIndex: 3, defaultValue: 0)
		_result.display_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 4))
		_result.link_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 5))
		return _result
	}
}
public extension LinkSpanItem {
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

		public var start : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public var end : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 1, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 1, value: newValue)}
		}
		public var origStart : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 2, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 2, value: newValue)}
		}
		public var origEnd : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 3, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 3, value: newValue)}
		}
		public lazy var display : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 4))
		public lazy var link : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 5))

		public var createEagerVersion : LinkSpanItem? { return LinkSpanItem.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : LinkSpanItem.LazyAccess, t2 : LinkSpanItem.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension LinkSpanItem {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var start : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public var end : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 1, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 1, value: newValue) }
	}
	public var origStart : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 2, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 2, value: newValue) }
	}
	public var origEnd : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 3, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 3, value: newValue) }
	}
	public var display : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:4)) } }
	public var link : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:5)) } }
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : LinkSpanItem.Fast, t2 : LinkSpanItem.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension LinkSpanItem {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		// let offset5 = try! builder.createString(link)
		var offset5 : Offset
		if let s = link_b {
			offset5 = try! builder.createString(s)
		} else if let s = link_ss {
			offset5 = try! builder.createStaticString(s)
		} else {
			offset5 = try! builder.createString(link)
		}
		// let offset4 = try! builder.createString(display)
		var offset4 : Offset
		if let s = display_b {
			offset4 = try! builder.createString(s)
		} else if let s = display_ss {
			offset4 = try! builder.createStaticString(s)
		} else {
			offset4 = try! builder.createString(display)
		}
		try! builder.openObject(6)
		try! builder.addPropertyOffsetToOpenObject(5, offset: offset5)
		try! builder.addPropertyOffsetToOpenObject(4, offset: offset4)
		try! builder.addPropertyToOpenObject(3, value : origEnd, defaultValue : 0)
		try! builder.addPropertyToOpenObject(2, value : origStart, defaultValue : 0)
		try! builder.addPropertyToOpenObject(1, value : end, defaultValue : 0)
		try! builder.addPropertyToOpenObject(0, value : start, defaultValue : 0)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension LinkSpanItem {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"start\":\(start)")
		properties.append("\"end\":\(end)")
		properties.append("\"origStart\":\(origStart)")
		properties.append("\"origEnd\":\(origEnd)")
		if let display = display{
			properties.append("\"display\":\"\(display)\"")
		}
		if let link = link{
			properties.append("\"link\":\"\(link)\"")
		}
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> LinkSpanItem {
		let result = LinkSpanItem()
		if let start = dict["start"] as? NSNumber {
			result.start = start.intValue
		}
		if let end = dict["end"] as? NSNumber {
			result.end = end.intValue
		}
		if let origStart = dict["origStart"] as? NSNumber {
			result.origStart = origStart.intValue
		}
		if let origEnd = dict["origEnd"] as? NSNumber {
			result.origEnd = origEnd.intValue
		}
		if let display = dict["display"] as? NSString {
			result.display = display as String
		}
		if let link = dict["link"] as? NSString {
			result.link = link as String
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"LinkSpanItem\""
	}
}
public final class MentionSpanItem {
	public static var instancePoolMutex : pthread_mutex_t = MentionSpanItem.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<MentionSpanItem> = []
	public var start : Int32 = 0
	public var end : Int32 = 0
	public var origStart : Int32 = 0
	public var origEnd : Int32 = 0
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
	
	public init(){}
	public init(start: Int32, end: Int32, origStart: Int32, origEnd: Int32, key: UserKey?, name: String?, screenName: String?){
		self.start = start
		self.end = end
		self.origStart = origStart
		self.origEnd = origEnd
		self.key = key
		self.name_s = name
		self.screenName_s = screenName
	}
	public init(start: Int32, end: Int32, origStart: Int32, origEnd: Int32, key: UserKey?, name: StaticString?, screenName: StaticString?){
		self.start = start
		self.end = end
		self.origStart = origStart
		self.origEnd = origEnd
		self.key = key
		self.name_ss = name
		self.screenName_ss = screenName
	}
}

extension MentionSpanItem : PoolableInstances {
	public func reset() { 
		start = 0
		end = 0
		origStart = 0
		origEnd = 0
		if key != nil {
			var x = key!
			key = nil
			UserKey.reuseInstance(&x)
		}
		name = nil
		screenName = nil
	}
}
public extension MentionSpanItem {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> MentionSpanItem? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? MentionSpanItem
			}
		}
		let _result = MentionSpanItem.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.start = reader.get(objectOffset, propertyIndex: 0, defaultValue: 0)
		_result.end = reader.get(objectOffset, propertyIndex: 1, defaultValue: 0)
		_result.origStart = reader.get(objectOffset, propertyIndex: 2, defaultValue: 0)
		_result.origEnd = reader.get(objectOffset, propertyIndex: 3, defaultValue: 0)
		_result.key = UserKey.create(reader, objectOffset: reader.getOffset(objectOffset, propertyIndex: 4))
		_result.name_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 5))
		_result.screenName_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 6))
		return _result
	}
}
public extension MentionSpanItem {
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

		public var start : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public var end : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 1, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 1, value: newValue)}
		}
		public var origStart : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 2, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 2, value: newValue)}
		}
		public var origEnd : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 3, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 3, value: newValue)}
		}
		public lazy var key : UserKey.LazyAccess? = UserKey.LazyAccess(reader: self._reader, objectOffset : self._reader.getOffset(self._objectOffset, propertyIndex: 4))
		public lazy var name : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 5))
		public lazy var screenName : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 6))

		public var createEagerVersion : MentionSpanItem? { return MentionSpanItem.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : MentionSpanItem.LazyAccess, t2 : MentionSpanItem.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension MentionSpanItem {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var start : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public var end : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 1, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 1, value: newValue) }
	}
	public var origStart : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 2, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 2, value: newValue) }
	}
	public var origEnd : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 3, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 3, value: newValue) }
	}
	public var key : UserKey.Fast? { get { 
		if let offset = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 4) {
			return UserKey.Fast(buffer: buffer, myOffset: offset)
		}
		return nil
	} }
	public var name : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:5)) } }
	public var screenName : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:6)) } }
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : MentionSpanItem.Fast, t2 : MentionSpanItem.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension MentionSpanItem {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		// let offset6 = try! builder.createString(screenName)
		var offset6 : Offset
		if let s = screenName_b {
			offset6 = try! builder.createString(s)
		} else if let s = screenName_ss {
			offset6 = try! builder.createStaticString(s)
		} else {
			offset6 = try! builder.createString(screenName)
		}
		// let offset5 = try! builder.createString(name)
		var offset5 : Offset
		if let s = name_b {
			offset5 = try! builder.createString(s)
		} else if let s = name_ss {
			offset5 = try! builder.createStaticString(s)
		} else {
			offset5 = try! builder.createString(name)
		}
		let offset4 = key?.addToByteArray(builder) ?? 0
		try! builder.openObject(7)
		try! builder.addPropertyOffsetToOpenObject(6, offset: offset6)
		try! builder.addPropertyOffsetToOpenObject(5, offset: offset5)
		if key != nil {
			try! builder.addPropertyOffsetToOpenObject(4, offset: offset4)
		}
		try! builder.addPropertyToOpenObject(3, value : origEnd, defaultValue : 0)
		try! builder.addPropertyToOpenObject(2, value : origStart, defaultValue : 0)
		try! builder.addPropertyToOpenObject(1, value : end, defaultValue : 0)
		try! builder.addPropertyToOpenObject(0, value : start, defaultValue : 0)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension MentionSpanItem {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"start\":\(start)")
		properties.append("\"end\":\(end)")
		properties.append("\"origStart\":\(origStart)")
		properties.append("\"origEnd\":\(origEnd)")
		if let key = key{
			properties.append("\"key\":\(key.toJSON())")
		}
		if let name = name{
			properties.append("\"name\":\"\(name)\"")
		}
		if let screenName = screenName{
			properties.append("\"screenName\":\"\(screenName)\"")
		}
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> MentionSpanItem {
		let result = MentionSpanItem()
		if let start = dict["start"] as? NSNumber {
			result.start = start.intValue
		}
		if let end = dict["end"] as? NSNumber {
			result.end = end.intValue
		}
		if let origStart = dict["origStart"] as? NSNumber {
			result.origStart = origStart.intValue
		}
		if let origEnd = dict["origEnd"] as? NSNumber {
			result.origEnd = origEnd.intValue
		}
		if let key = dict["key"] as? NSDictionary {
			result.key = UserKey.fromJSON(key)
		}
		if let name = dict["name"] as? NSString {
			result.name = name as String
		}
		if let screenName = dict["screenName"] as? NSString {
			result.screenName = screenName as String
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"MentionSpanItem\""
	}
}
public final class HashtagSpanItem {
	public static var instancePoolMutex : pthread_mutex_t = HashtagSpanItem.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<HashtagSpanItem> = []
	public var start : Int32 = 0
	public var end : Int32 = 0
	public var origStart : Int32 = 0
	public var origEnd : Int32 = 0
	public var hashtag : String? {
		get {
			if let s = hashtag_s {
				return s
			}
			if let s = hashtag_ss {
				hashtag_s = s.stringValue
			}
			if let s = hashtag_b {
				hashtag_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return hashtag_s
		}
		set {
			hashtag_s = newValue
			hashtag_ss = nil
			hashtag_b = nil
		}
	}
	public func hashtagStaticString(newValue : StaticString) {
		hashtag_ss = newValue
		hashtag_s = nil
		hashtag_b = nil
	}
	private var hashtag_b : UnsafeBufferPointer<UInt8>? = nil
	public var hashtagBuffer : UnsafeBufferPointer<UInt8>? {return hashtag_b}
	private var hashtag_s : String? = nil
	private var hashtag_ss : StaticString? = nil
	
	public init(){}
	public init(start: Int32, end: Int32, origStart: Int32, origEnd: Int32, hashtag: String?){
		self.start = start
		self.end = end
		self.origStart = origStart
		self.origEnd = origEnd
		self.hashtag_s = hashtag
	}
	public init(start: Int32, end: Int32, origStart: Int32, origEnd: Int32, hashtag: StaticString?){
		self.start = start
		self.end = end
		self.origStart = origStart
		self.origEnd = origEnd
		self.hashtag_ss = hashtag
	}
}

extension HashtagSpanItem : PoolableInstances {
	public func reset() { 
		start = 0
		end = 0
		origStart = 0
		origEnd = 0
		hashtag = nil
	}
}
public extension HashtagSpanItem {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> HashtagSpanItem? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? HashtagSpanItem
			}
		}
		let _result = HashtagSpanItem.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.start = reader.get(objectOffset, propertyIndex: 0, defaultValue: 0)
		_result.end = reader.get(objectOffset, propertyIndex: 1, defaultValue: 0)
		_result.origStart = reader.get(objectOffset, propertyIndex: 2, defaultValue: 0)
		_result.origEnd = reader.get(objectOffset, propertyIndex: 3, defaultValue: 0)
		_result.hashtag_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 4))
		return _result
	}
}
public extension HashtagSpanItem {
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

		public var start : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public var end : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 1, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 1, value: newValue)}
		}
		public var origStart : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 2, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 2, value: newValue)}
		}
		public var origEnd : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 3, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 3, value: newValue)}
		}
		public lazy var hashtag : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 4))

		public var createEagerVersion : HashtagSpanItem? { return HashtagSpanItem.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : HashtagSpanItem.LazyAccess, t2 : HashtagSpanItem.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension HashtagSpanItem {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var start : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public var end : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 1, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 1, value: newValue) }
	}
	public var origStart : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 2, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 2, value: newValue) }
	}
	public var origEnd : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 3, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 3, value: newValue) }
	}
	public var hashtag : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:4)) } }
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : HashtagSpanItem.Fast, t2 : HashtagSpanItem.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension HashtagSpanItem {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		// let offset4 = try! builder.createString(hashtag)
		var offset4 : Offset
		if let s = hashtag_b {
			offset4 = try! builder.createString(s)
		} else if let s = hashtag_ss {
			offset4 = try! builder.createStaticString(s)
		} else {
			offset4 = try! builder.createString(hashtag)
		}
		try! builder.openObject(5)
		try! builder.addPropertyOffsetToOpenObject(4, offset: offset4)
		try! builder.addPropertyToOpenObject(3, value : origEnd, defaultValue : 0)
		try! builder.addPropertyToOpenObject(2, value : origStart, defaultValue : 0)
		try! builder.addPropertyToOpenObject(1, value : end, defaultValue : 0)
		try! builder.addPropertyToOpenObject(0, value : start, defaultValue : 0)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension HashtagSpanItem {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"start\":\(start)")
		properties.append("\"end\":\(end)")
		properties.append("\"origStart\":\(origStart)")
		properties.append("\"origEnd\":\(origEnd)")
		if let hashtag = hashtag{
			properties.append("\"hashtag\":\"\(hashtag)\"")
		}
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> HashtagSpanItem {
		let result = HashtagSpanItem()
		if let start = dict["start"] as? NSNumber {
			result.start = start.intValue
		}
		if let end = dict["end"] as? NSNumber {
			result.end = end.intValue
		}
		if let origStart = dict["origStart"] as? NSNumber {
			result.origStart = origStart.intValue
		}
		if let origEnd = dict["origEnd"] as? NSNumber {
			result.origEnd = origEnd.intValue
		}
		if let hashtag = dict["hashtag"] as? NSString {
			result.hashtag = hashtag as String
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"HashtagSpanItem\""
	}
}
public final class MediaItem {
	public static var instancePoolMutex : pthread_mutex_t = MediaItem.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<MediaItem> = []
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
	
	public var mediaUrl : String? {
		get {
			if let s = mediaUrl_s {
				return s
			}
			if let s = mediaUrl_ss {
				mediaUrl_s = s.stringValue
			}
			if let s = mediaUrl_b {
				mediaUrl_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return mediaUrl_s
		}
		set {
			mediaUrl_s = newValue
			mediaUrl_ss = nil
			mediaUrl_b = nil
		}
	}
	public func mediaUrlStaticString(newValue : StaticString) {
		mediaUrl_ss = newValue
		mediaUrl_s = nil
		mediaUrl_b = nil
	}
	private var mediaUrl_b : UnsafeBufferPointer<UInt8>? = nil
	public var mediaUrlBuffer : UnsafeBufferPointer<UInt8>? {return mediaUrl_b}
	private var mediaUrl_s : String? = nil
	private var mediaUrl_ss : StaticString? = nil
	
	public var previewUrl : String? {
		get {
			if let s = previewUrl_s {
				return s
			}
			if let s = previewUrl_ss {
				previewUrl_s = s.stringValue
			}
			if let s = previewUrl_b {
				previewUrl_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return previewUrl_s
		}
		set {
			previewUrl_s = newValue
			previewUrl_ss = nil
			previewUrl_b = nil
		}
	}
	public func previewUrlStaticString(newValue : StaticString) {
		previewUrl_ss = newValue
		previewUrl_s = nil
		previewUrl_b = nil
	}
	private var previewUrl_b : UnsafeBufferPointer<UInt8>? = nil
	public var previewUrlBuffer : UnsafeBufferPointer<UInt8>? {return previewUrl_b}
	private var previewUrl_s : String? = nil
	private var previewUrl_ss : StaticString? = nil
	
	public var type : MediaItemType? = MediaItemType.Unknown
	public var width : Int32 = 0
	public var height : Int32 = 0
	public var videoInfo : VideoMediaItemInfo? = nil
	public var pageUrl : String? {
		get {
			if let s = pageUrl_s {
				return s
			}
			if let s = pageUrl_ss {
				pageUrl_s = s.stringValue
			}
			if let s = pageUrl_b {
				pageUrl_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return pageUrl_s
		}
		set {
			pageUrl_s = newValue
			pageUrl_ss = nil
			pageUrl_b = nil
		}
	}
	public func pageUrlStaticString(newValue : StaticString) {
		pageUrl_ss = newValue
		pageUrl_s = nil
		pageUrl_b = nil
	}
	private var pageUrl_b : UnsafeBufferPointer<UInt8>? = nil
	public var pageUrlBuffer : UnsafeBufferPointer<UInt8>? {return pageUrl_b}
	private var pageUrl_s : String? = nil
	private var pageUrl_ss : StaticString? = nil
	
	public var openBrowser : Bool = false
	public var altText : String? {
		get {
			if let s = altText_s {
				return s
			}
			if let s = altText_ss {
				altText_s = s.stringValue
			}
			if let s = altText_b {
				altText_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return altText_s
		}
		set {
			altText_s = newValue
			altText_ss = nil
			altText_b = nil
		}
	}
	public func altTextStaticString(newValue : StaticString) {
		altText_ss = newValue
		altText_s = nil
		altText_b = nil
	}
	private var altText_b : UnsafeBufferPointer<UInt8>? = nil
	public var altTextBuffer : UnsafeBufferPointer<UInt8>? {return altText_b}
	private var altText_s : String? = nil
	private var altText_ss : StaticString? = nil
	
	public init(){}
	public init(url: String?, mediaUrl: String?, previewUrl: String?, type: MediaItemType?, width: Int32, height: Int32, videoInfo: VideoMediaItemInfo?, pageUrl: String?, openBrowser: Bool, altText: String?){
		self.url_s = url
		self.mediaUrl_s = mediaUrl
		self.previewUrl_s = previewUrl
		self.type = type
		self.width = width
		self.height = height
		self.videoInfo = videoInfo
		self.pageUrl_s = pageUrl
		self.openBrowser = openBrowser
		self.altText_s = altText
	}
	public init(url: StaticString?, mediaUrl: StaticString?, previewUrl: StaticString?, type: MediaItemType?, width: Int32, height: Int32, videoInfo: VideoMediaItemInfo?, pageUrl: StaticString?, openBrowser: Bool, altText: StaticString?){
		self.url_ss = url
		self.mediaUrl_ss = mediaUrl
		self.previewUrl_ss = previewUrl
		self.type = type
		self.width = width
		self.height = height
		self.videoInfo = videoInfo
		self.pageUrl_ss = pageUrl
		self.openBrowser = openBrowser
		self.altText_ss = altText
	}
}

extension MediaItem : PoolableInstances {
	public func reset() { 
		url = nil
		mediaUrl = nil
		previewUrl = nil
		type = MediaItemType.Unknown
		width = 0
		height = 0
		if videoInfo != nil {
			var x = videoInfo!
			videoInfo = nil
			VideoMediaItemInfo.reuseInstance(&x)
		}
		pageUrl = nil
		openBrowser = false
		altText = nil
	}
}
public extension MediaItem {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> MediaItem? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? MediaItem
			}
		}
		let _result = MediaItem.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.url_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 0))
		_result.mediaUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 1))
		_result.previewUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 2))
		_result.type = MediaItemType(rawValue: reader.get(objectOffset, propertyIndex: 3, defaultValue: MediaItemType.Unknown.rawValue))
		_result.width = reader.get(objectOffset, propertyIndex: 4, defaultValue: 0)
		_result.height = reader.get(objectOffset, propertyIndex: 5, defaultValue: 0)
		_result.videoInfo = VideoMediaItemInfo.create(reader, objectOffset: reader.getOffset(objectOffset, propertyIndex: 6))
		_result.pageUrl_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 7))
		_result.openBrowser = reader.get(objectOffset, propertyIndex: 8, defaultValue: false)
		_result.altText_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 9))
		return _result
	}
}
public extension MediaItem {
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

		public lazy var url : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 0))
		public lazy var mediaUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 1))
		public lazy var previewUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 2))
		public var type : MediaItemType? { 
			get { return MediaItemType(rawValue: _reader.get(self._objectOffset, propertyIndex: 3, defaultValue:MediaItemType.Unknown.rawValue))}
			set { 
				if let value = newValue{
					try!_reader.set(_objectOffset, propertyIndex: 3, value: value.rawValue)
				}
			}
		}
		public var width : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 4, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 4, value: newValue)}
		}
		public var height : Int32 { 
			get { return _reader.get(_objectOffset, propertyIndex: 5, defaultValue:0)}
			set { try!_reader.set(_objectOffset, propertyIndex: 5, value: newValue)}
		}
		public lazy var videoInfo : VideoMediaItemInfo.LazyAccess? = VideoMediaItemInfo.LazyAccess(reader: self._reader, objectOffset : self._reader.getOffset(self._objectOffset, propertyIndex: 6))
		public lazy var pageUrl : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 7))
		public var openBrowser : Bool { 
			get { return _reader.get(_objectOffset, propertyIndex: 8, defaultValue:false)}
			set { try!_reader.set(_objectOffset, propertyIndex: 8, value: newValue)}
		}
		public lazy var altText : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 9))

		public var createEagerVersion : MediaItem? { return MediaItem.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : MediaItem.LazyAccess, t2 : MediaItem.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension MediaItem {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var url : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:0)) } }
	public var mediaUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:1)) } }
	public var previewUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:2)) } }
	public var type : MediaItemType? { 
		get { return MediaItemType(rawValue: FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 3, defaultValue: MediaItemType.Unknown.rawValue)) }
		set {
			if let newValue = newValue {
				try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 3, value: newValue.rawValue)
			}
		}
	}
	public var width : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 4, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 4, value: newValue) }
	}
	public var height : Int32 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 5, defaultValue: 0) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 5, value: newValue) }
	}
	public var videoInfo : VideoMediaItemInfo.Fast? { get { 
		if let offset = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 6) {
			return VideoMediaItemInfo.Fast(buffer: buffer, myOffset: offset)
		}
		return nil
	} }
	public var pageUrl : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:7)) } }
	public var openBrowser : Bool { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 8, defaultValue: false) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 8, value: newValue) }
	}
	public var altText : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:9)) } }
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : MediaItem.Fast, t2 : MediaItem.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension MediaItem {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		// let offset9 = try! builder.createString(altText)
		var offset9 : Offset
		if let s = altText_b {
			offset9 = try! builder.createString(s)
		} else if let s = altText_ss {
			offset9 = try! builder.createStaticString(s)
		} else {
			offset9 = try! builder.createString(altText)
		}
		// let offset7 = try! builder.createString(pageUrl)
		var offset7 : Offset
		if let s = pageUrl_b {
			offset7 = try! builder.createString(s)
		} else if let s = pageUrl_ss {
			offset7 = try! builder.createStaticString(s)
		} else {
			offset7 = try! builder.createString(pageUrl)
		}
		let offset6 = videoInfo?.addToByteArray(builder) ?? 0
		// let offset2 = try! builder.createString(previewUrl)
		var offset2 : Offset
		if let s = previewUrl_b {
			offset2 = try! builder.createString(s)
		} else if let s = previewUrl_ss {
			offset2 = try! builder.createStaticString(s)
		} else {
			offset2 = try! builder.createString(previewUrl)
		}
		// let offset1 = try! builder.createString(mediaUrl)
		var offset1 : Offset
		if let s = mediaUrl_b {
			offset1 = try! builder.createString(s)
		} else if let s = mediaUrl_ss {
			offset1 = try! builder.createStaticString(s)
		} else {
			offset1 = try! builder.createString(mediaUrl)
		}
		// let offset0 = try! builder.createString(url)
		var offset0 : Offset
		if let s = url_b {
			offset0 = try! builder.createString(s)
		} else if let s = url_ss {
			offset0 = try! builder.createStaticString(s)
		} else {
			offset0 = try! builder.createString(url)
		}
		try! builder.openObject(10)
		try! builder.addPropertyOffsetToOpenObject(9, offset: offset9)
		try! builder.addPropertyToOpenObject(8, value : openBrowser, defaultValue : false)
		try! builder.addPropertyOffsetToOpenObject(7, offset: offset7)
		if videoInfo != nil {
			try! builder.addPropertyOffsetToOpenObject(6, offset: offset6)
		}
		try! builder.addPropertyToOpenObject(5, value : height, defaultValue : 0)
		try! builder.addPropertyToOpenObject(4, value : width, defaultValue : 0)
		try! builder.addPropertyToOpenObject(3, value : type!.rawValue, defaultValue : 0)
		try! builder.addPropertyOffsetToOpenObject(2, offset: offset2)
		try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
		try! builder.addPropertyOffsetToOpenObject(0, offset: offset0)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension MediaItem {
	public func toJSON() -> String{
		var properties : [String] = []
		if let url = url{
			properties.append("\"url\":\"\(url)\"")
		}
		if let mediaUrl = mediaUrl{
			properties.append("\"mediaUrl\":\"\(mediaUrl)\"")
		}
		if let previewUrl = previewUrl{
			properties.append("\"previewUrl\":\"\(previewUrl)\"")
		}
		if let type = type{
			properties.append("\"type\":\(type.toJSON())")
		}
		properties.append("\"width\":\(width)")
		properties.append("\"height\":\(height)")
		if let videoInfo = videoInfo{
			properties.append("\"videoInfo\":\(videoInfo.toJSON())")
		}
		if let pageUrl = pageUrl{
			properties.append("\"pageUrl\":\"\(pageUrl)\"")
		}
		properties.append("\"openBrowser\":\(openBrowser)")
		if let altText = altText{
			properties.append("\"altText\":\"\(altText)\"")
		}
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> MediaItem {
		let result = MediaItem()
		if let url = dict["url"] as? NSString {
			result.url = url as String
		}
		if let mediaUrl = dict["mediaUrl"] as? NSString {
			result.mediaUrl = mediaUrl as String
		}
		if let previewUrl = dict["previewUrl"] as? NSString {
			result.previewUrl = previewUrl as String
		}
		if let type = dict["type"] as? NSString {
			result.type = MediaItemType.fromJSON(type as String)
		}
		if let width = dict["width"] as? NSNumber {
			result.width = width.intValue
		}
		if let height = dict["height"] as? NSNumber {
			result.height = height.intValue
		}
		if let videoInfo = dict["videoInfo"] as? NSDictionary {
			result.videoInfo = VideoMediaItemInfo.fromJSON(videoInfo)
		}
		if let pageUrl = dict["pageUrl"] as? NSString {
			result.pageUrl = pageUrl as String
		}
		if let openBrowser = dict["openBrowser"] as? NSNumber {
			result.openBrowser = openBrowser.boolValue
		}
		if let altText = dict["altText"] as? NSString {
			result.altText = altText as String
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"MediaItem\""
	}
}
public final class VideoMediaItemInfo {
	public static var instancePoolMutex : pthread_mutex_t = VideoMediaItemInfo.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<VideoMediaItemInfo> = []
	public var duration : Int64 = -1
	public var variants : ContiguousArray<VideoMediaVariant?> = []
	public init(){}
	public init(duration: Int64, variants: ContiguousArray<VideoMediaVariant?>){
		self.duration = duration
		self.variants = variants
	}
}

extension VideoMediaItemInfo : PoolableInstances {
	public func reset() { 
		duration = -1
		while (variants.count > 0) {
			var x = variants.removeLast()!
			VideoMediaVariant.reuseInstance(&x)
		}
	}
}
public extension VideoMediaItemInfo {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> VideoMediaItemInfo? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? VideoMediaItemInfo
			}
		}
		let _result = VideoMediaItemInfo.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.duration = reader.get(objectOffset, propertyIndex: 0, defaultValue: -1)
		let offset_variants : Offset? = reader.getOffset(objectOffset, propertyIndex: 1)
		let length_variants = reader.getVectorLength(offset_variants)
		if(length_variants > 0){
			var index = 0
			_result.variants.reserveCapacity(length_variants)
			while index < length_variants {
				_result.variants.append(VideoMediaVariant.create(reader, objectOffset: reader.getVectorOffsetElement(offset_variants!, index: index)))
				index += 1
			}
		}
		return _result
	}
}
public extension VideoMediaItemInfo {
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

		public var duration : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public lazy var variants : LazyVector<VideoMediaVariant.LazyAccess> = { [self]
			let vectorOffset : Offset? = self._reader.getOffset(self._objectOffset, propertyIndex: 1)
			let vectorLength = self._reader.getVectorLength(vectorOffset)
			let reader = self._reader
			return LazyVector(count: vectorLength){ [reader] in
				VideoMediaVariant.LazyAccess(reader: reader, objectOffset : reader.getVectorOffsetElement(vectorOffset!, index: $0))
			}
		}()

		public var createEagerVersion : VideoMediaItemInfo? { return VideoMediaItemInfo.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : VideoMediaItemInfo.LazyAccess, t2 : VideoMediaItemInfo.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension VideoMediaItemInfo {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var duration : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public struct VariantsVector {
		private var buffer : UnsafePointer<UInt8> = nil
		private var myOffset : Offset = 0
		private let offsetList : Offset?
		private init(buffer b: UnsafePointer<UInt8>, myOffset o: Offset ) {
			buffer = b
			myOffset = o
			offsetList = FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex: 1)
		}
		public var count : Int { get { return FlatBufferReaderFast.getVectorLength(buffer, offsetList) } }
		public subscript (index : Int) -> VideoMediaVariant.Fast? {
			get {
				if let ofs = FlatBufferReaderFast.getVectorOffsetElement(buffer, offsetList!, index: index) {
					return VideoMediaVariant.Fast(buffer: buffer, myOffset: ofs)
				}
				return nil
			}
		}
	}
	public lazy var variants : VariantsVector = VariantsVector(buffer: self.buffer, myOffset: self.myOffset)
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : VideoMediaItemInfo.Fast, t2 : VideoMediaItemInfo.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension VideoMediaItemInfo {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		var offset1 = Offset(0)
		if variants.count > 0{
			var offsets = [Offset?](count: variants.count, repeatedValue: nil)
			var index = variants.count - 1
			while(index >= 0){
				offsets[index] = variants[index]?.addToByteArray(builder)
				index -= 1
			}
			try! builder.startVector(variants.count, elementSize: strideof(Offset))
			index = variants.count - 1
			while(index >= 0){
				try! builder.putOffset(offsets[index])
				index -= 1
			}
			offset1 = builder.endVector()
		}
		try! builder.openObject(2)
		if variants.count > 0 {
			try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
		}
		try! builder.addPropertyToOpenObject(0, value : duration, defaultValue : -1)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension VideoMediaItemInfo {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"duration\":\(duration)")
		properties.append("\"variants\":[\(variants.map({$0 == nil ? "null" : $0!.toJSON()}).joinWithSeparator(","))]")
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> VideoMediaItemInfo {
		let result = VideoMediaItemInfo()
		if let duration = dict["duration"] as? NSNumber {
			result.duration = duration.longLongValue
		}
		if let variants = dict["variants"] as? NSArray {
			result.variants = ContiguousArray(variants.map({
				if let entry = $0 as? NSDictionary {
					return VideoMediaVariant.fromJSON(entry)
				}
				return nil
			}))
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"VideoMediaItemInfo\""
	}
}
public final class VideoMediaVariant {
	public static var instancePoolMutex : pthread_mutex_t = VideoMediaVariant.setupInstancePoolMutex()
	public static var maxInstanceCacheSize : UInt = 0
	public static var instancePool : ContiguousArray<VideoMediaVariant> = []
	public var bitrate : Int64 = -1
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
	
	public var contentType : String? {
		get {
			if let s = contentType_s {
				return s
			}
			if let s = contentType_ss {
				contentType_s = s.stringValue
			}
			if let s = contentType_b {
				contentType_s = String.init(bytesNoCopy: UnsafeMutablePointer<UInt8>(s.baseAddress), length: s.count, encoding: NSUTF8StringEncoding, freeWhenDone: false)
			}
			return contentType_s
		}
		set {
			contentType_s = newValue
			contentType_ss = nil
			contentType_b = nil
		}
	}
	public func contentTypeStaticString(newValue : StaticString) {
		contentType_ss = newValue
		contentType_s = nil
		contentType_b = nil
	}
	private var contentType_b : UnsafeBufferPointer<UInt8>? = nil
	public var contentTypeBuffer : UnsafeBufferPointer<UInt8>? {return contentType_b}
	private var contentType_s : String? = nil
	private var contentType_ss : StaticString? = nil
	
	public init(){}
	public init(bitrate: Int64, url: String?, contentType: String?){
		self.bitrate = bitrate
		self.url_s = url
		self.contentType_s = contentType
	}
	public init(bitrate: Int64, url: StaticString?, contentType: StaticString?){
		self.bitrate = bitrate
		self.url_ss = url
		self.contentType_ss = contentType
	}
}

extension VideoMediaVariant : PoolableInstances {
	public func reset() { 
		bitrate = -1
		url = nil
		contentType = nil
	}
}
public extension VideoMediaVariant {
	private static func create(reader : FlatBufferReader, objectOffset : Offset?) -> VideoMediaVariant? {
		guard let objectOffset = objectOffset else {
			return nil
		}
		if reader.config.uniqueTables {
			if let o = reader.objectPool[objectOffset]{
				return o as? VideoMediaVariant
			}
		}
		let _result = VideoMediaVariant.createInstance()
		if reader.config.uniqueTables {
			reader.objectPool[objectOffset] = _result
		}
		_result.bitrate = reader.get(objectOffset, propertyIndex: 0, defaultValue: -1)
		_result.url_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 1))
		_result.contentType_b = reader.getStringBuffer(reader.getOffset(objectOffset, propertyIndex: 2))
		return _result
	}
}
public extension VideoMediaVariant {
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

		public var bitrate : Int64 { 
			get { return _reader.get(_objectOffset, propertyIndex: 0, defaultValue:-1)}
			set { try!_reader.set(_objectOffset, propertyIndex: 0, value: newValue)}
		}
		public lazy var url : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 1))
		public lazy var contentType : String? = self._reader.getString(self._reader.getOffset(self._objectOffset, propertyIndex: 2))

		public var createEagerVersion : VideoMediaVariant? { return VideoMediaVariant.create(_reader, objectOffset: _objectOffset) }
		
		public var hashValue: Int { return Int(_objectOffset) }
	}
}

public func ==(t1 : VideoMediaVariant.LazyAccess, t2 : VideoMediaVariant.LazyAccess) -> Bool {
	return t1._objectOffset == t2._objectOffset && t1._reader === t2._reader
}

extension VideoMediaVariant {
public struct Fast : Hashable {
	private var buffer : UnsafePointer<UInt8> = nil
	private var myOffset : Offset = 0
	public init(buffer: UnsafePointer<UInt8>, myOffset: Offset){
		self.buffer = buffer
		self.myOffset = myOffset
	}
	public var bitrate : Int64 { 
		get { return FlatBufferReaderFast.get(buffer, myOffset, propertyIndex: 0, defaultValue: -1) }
		set { try!FlatBufferReaderFast.set(UnsafeMutablePointer<UInt8>(buffer), myOffset, propertyIndex: 0, value: newValue) }
	}
	public var url : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:1)) } }
	public var contentType : UnsafeBufferPointer<UInt8>? { get { return FlatBufferReaderFast.getStringBuffer(buffer, FlatBufferReaderFast.getOffset(buffer, myOffset, propertyIndex:2)) } }
	public var hashValue: Int { return Int(myOffset) }
}
}
public func ==(t1 : VideoMediaVariant.Fast, t2 : VideoMediaVariant.Fast) -> Bool {
	return t1.buffer == t2.buffer && t1.myOffset == t2.myOffset
}
public extension VideoMediaVariant {
	func addToByteArray(builder : FlatBufferBuilder) -> Offset {
		if builder.config.uniqueTables {
			if let myOffset = builder.cache[ObjectIdentifier(self)] {
				return myOffset
			}
		}
		// let offset2 = try! builder.createString(contentType)
		var offset2 : Offset
		if let s = contentType_b {
			offset2 = try! builder.createString(s)
		} else if let s = contentType_ss {
			offset2 = try! builder.createStaticString(s)
		} else {
			offset2 = try! builder.createString(contentType)
		}
		// let offset1 = try! builder.createString(url)
		var offset1 : Offset
		if let s = url_b {
			offset1 = try! builder.createString(s)
		} else if let s = url_ss {
			offset1 = try! builder.createStaticString(s)
		} else {
			offset1 = try! builder.createString(url)
		}
		try! builder.openObject(3)
		try! builder.addPropertyOffsetToOpenObject(2, offset: offset2)
		try! builder.addPropertyOffsetToOpenObject(1, offset: offset1)
		try! builder.addPropertyToOpenObject(0, value : bitrate, defaultValue : -1)
		let myOffset =  try! builder.closeObject()
		if builder.config.uniqueTables {
			builder.cache[ObjectIdentifier(self)] = myOffset
		}
		return myOffset
	}
}
extension VideoMediaVariant {
	public func toJSON() -> String{
		var properties : [String] = []
		properties.append("\"bitrate\":\(bitrate)")
		if let url = url{
			properties.append("\"url\":\"\(url)\"")
		}
		if let contentType = contentType{
			properties.append("\"contentType\":\"\(contentType)\"")
		}
		
		return "{\(properties.joinWithSeparator(","))}"
	}

	public static func fromJSON(dict : NSDictionary) -> VideoMediaVariant {
		let result = VideoMediaVariant()
		if let bitrate = dict["bitrate"] as? NSNumber {
			result.bitrate = bitrate.longLongValue
		}
		if let url = dict["url"] as? NSString {
			result.url = url as String
		}
		if let contentType = dict["contentType"] as? NSString {
			result.contentType = contentType as String
		}
		return result
	}
	
	public func jsonTypeName() -> String {
		return "\"VideoMediaVariant\""
	}
}
private func performLateBindings(builder : FlatBufferBuilder) {
	for binding in builder.deferedBindings {
		switch binding.object {
		case let object as StatusMetadata: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as LinkSpanItem: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as MentionSpanItem: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as HashtagSpanItem: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as MediaItem: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as VideoMediaItemInfo: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as VideoMediaVariant: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		case let object as UserKey: try! builder.replaceOffset(object.addToByteArray(builder), atCursor: binding.cursor)
		default: continue
		}
	}
}
