//
//  JSONDecoderExtension.swift
//  Cinematic
//
//  Created by Gurpreet Kaur on 2022-12-15.
//

import Foundation
extension JSONDecoder {
    
    func setCustomDateDecodingStrategy() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateDecodingStrategy = .formatted(formatter)
    }
}
// decoding data 
