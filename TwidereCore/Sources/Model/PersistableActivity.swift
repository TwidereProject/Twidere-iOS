//
//  PersistableActivity.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

//sourcery: jsonParse
public class PersistableActivity: PersistableStatus {
    
    // sourcery: jsonField=action
    //@CursorField(value = Activities.ACTION)
    public var action: String? = nil
    
    // sourcery: jsonField=max_position
    //@CursorField(value = Activities.MAX_SORT_POSITION)
    public var max_sort_position: Int64 = 0
    // sourcery: jsonField=min_position
    //@CursorField(value = Activities.MIN_SORT_POSITION)
    public var min_sort_position: Int64 = 0
    
    // sourcery: jsonField=max_request_position
    //@CursorField(value = Activities.MAX_REQUEST_POSITION)
    public var max_position: String? = nil
    
    // sourcery: jsonField=min_request_position
    //@CursorField(value = Activities.MIN_REQUEST_POSITION)
    public var min_position: String? = nil
    
    
    // sourcery: jsonField=source_keys
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    //@CursorField(value = Activities.SOURCE_KEYS, converter = UserKeysCursorFieldConverter::class)
    public var source_keys: [UserKey]!
    
    // sourcery: jsonField=sources
    //@CursorField(value = Activities.SOURCES, converter = LoganSquareCursorFieldConverter::class)
    public var sources: [PersistableUser]!
    
    // sourcery: jsonField=targets
    //@CursorField(value = Activities.TARGETS, converter = LoganSquareCursorFieldConverter::class)
    public var targets: RelatedObject!
    
    // sourcery: jsonField=target_objects
    //@CursorField(value = Activities.TARGET_OBJECTS, converter = LoganSquareCursorFieldConverter::class)
    public var target_objects: RelatedObject!
    
    // sourcery: jsonField=sources_lite
    //@CursorField(value = Activities.SOURCES_LITE, converter = LoganSquareCursorFieldConverter::class)
    public var sources_lite: [PersistableLiteUser]!
    
    // sourcery: jsonField=summary_line
    //@CursorField(value = Activities.SUMMARY_LINE, converter = LoganSquareCursorFieldConverter::class)
    public var summary_line: [SummaryLine]? = nil
    
    //@CursorField(Activities.HAS_FOLLOWING_SOURCE)
    // sourcery: jsonField=has_following_source
    public var has_following_source: Bool = true
    
    //transient
    public var after_filtered_sources: [PersistableLiteUser]? = nil
    
    required public init() {
        
    }
    
    
    //sourcery: jsonParse
    public class RelatedObject {
        
        required public init() {
            
        }
        
    }
    
    //sourcery: jsonParse
    public class SummaryLine {
        
        // sourcery: jsonField=key
        // sourcery: jsonFieldConverter=UserKeyFieldConverter
        public var key: UserKey!
        
        // sourcery: jsonField=name
        public var name: String!
        
        // sourcery: jsonField=screen_name
        public var screen_name: String!
        
        // sourcery: jsonField=content
        public var content: String!
        
        required public init() {
            
        }
        
    }
    
}
