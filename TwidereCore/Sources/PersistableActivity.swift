//
//  PersistableActivity.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

//sourcery: jsonParse
class PersistableActivity: PersistableStatus {
    
    // sourcery: jsonField=action
    //@CursorField(value = Activities.ACTION)
    var action: String? = nil
    
    // sourcery: jsonField=max_position
    //@CursorField(value = Activities.MAX_SORT_POSITION)
    var max_sort_position: Int64 = 0
    // sourcery: jsonField=min_position
    //@CursorField(value = Activities.MIN_SORT_POSITION)
    var min_sort_position: Int64 = 0
    
    // sourcery: jsonField=max_request_position
    //@CursorField(value = Activities.MAX_REQUEST_POSITION)
    var max_position: String? = nil
    
    // sourcery: jsonField=min_request_position
    //@CursorField(value = Activities.MIN_REQUEST_POSITION)
    var min_position: String? = nil
    
    
    // sourcery: jsonField=source_keys
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    //@CursorField(value = Activities.SOURCE_KEYS, converter = UserKeysCursorFieldConverter::class)
    var source_keys: [UserKey]!
    
    // sourcery: jsonField=sources
    //@CursorField(value = Activities.SOURCES, converter = LoganSquareCursorFieldConverter::class)
    var sources: [PersistableUser]!
    
    // sourcery: jsonField=targets
    //@CursorField(value = Activities.TARGETS, converter = LoganSquareCursorFieldConverter::class)
    var targets: RelatedObject!
    
    // sourcery: jsonField=target_objects
    //@CursorField(value = Activities.TARGET_OBJECTS, converter = LoganSquareCursorFieldConverter::class)
    var target_objects: RelatedObject!
    
    // sourcery: jsonField=sources_lite
    //@CursorField(value = Activities.SOURCES_LITE, converter = LoganSquareCursorFieldConverter::class)
    var sources_lite: [PersistableLiteUser]!
    
    // sourcery: jsonField=summary_line
    //@CursorField(value = Activities.SUMMARY_LINE, converter = LoganSquareCursorFieldConverter::class)
    var summary_line: [SummaryLine]? = nil
    
    //@CursorField(Activities.HAS_FOLLOWING_SOURCE)
    // sourcery: jsonField=has_following_source
    var has_following_source: Bool = true
    
    //transient
    var after_filtered_sources: [PersistableLiteUser]? = nil
    
    required init() {
        
    }
    
    
    //sourcery: jsonParse
    class RelatedObject {
        
        required init() {
            
        }
        
    }
    
    //sourcery: jsonParse
    class SummaryLine {
        
        required init() {
            
        }
        
    }
    
}
