//
//  String-ext.swift
//  NBA-Stats
//
//  Created by Alberto Dominguez on 10/11/21.
//

import Foundation
import SwiftUI

extension String {
    func load() -> UIImage {
        // try catch block
        do{
            // convert string to URL
            guard let url = URL(string: self) else {
                // return empty image if url is invalid
                return UIImage()
            }
            
            // convert url to data
            let data: Data = try Data(contentsOf: url )
            
            // create UIImage object from Data
            // and optional value if image in URL does not exist
            return UIImage(data: data) ?? UIImage()
            
        } catch {
            
        }
        
        return UIImage()
    }
}
