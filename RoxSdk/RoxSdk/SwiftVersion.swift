//
//  SwiftVersion.swift
//  RoxSdk
//
//  Created by Andrew Anisimov on 17.06.2021.
//  Copyright © 2021 rollout.io. All rights reserved.
//

import Foundation

class SwiftVersion {
    
    public static func getLanguageCompatibilityVersion() -> String {
        // FIXME: see no other way of getting Swift language version
        // see https://stackoverflow.com/questions/30790188/how-do-i-see-which-version-of-swift-im-using
        
        #if swift(>=5.4)
        return "5.4"
        
        #elseif swift(>=5.3)
        return "5.3"

        #elseif swift(>=5.2)
        return "5.2"

        #elseif swift(>=5.1)
        return "5.1"

        #elseif swift(>=5.0)
        return "5.0"

        #elseif swift(>=4.2)
        return "4.2"

        #elseif swift(>=4.1)
        return "4.1"

        #elseif swift(>=4.0)
        return "4.0"

        #elseif swift(>=3.2)
        return "3.2"

        #elseif swift(>=3.0)
        return "3.0"

        #elseif swift(>=2.2)
        return "2.2"

        #elseif swift(>=2.1)
        return "2.1"

        #elseif swift(>=2.0)
        return "2.0"

        #elseif swift(>=1.2)
        return "1.2"

        #elseif swift(>=1.1)
        return "1.1"

        #elseif swift(>=1.0)
        return "1.0"
        
        #else
        return "0.0"

        #endif
    }
}
