//
//  PhotoCaptureView.swift
//  ActivityPlanner
//
//  Created by Kyle Eichlin on 12/9/20.
//

import Foundation
import SwiftUI
 
struct PhotoCaptureView: View {
   
    @Binding var showImagePicker: Bool
    @Binding var photoImageData: Data?
   
    let cameraOrLibrary: String
   
    var body: some View {
       
        ImagePicker(imagePickerShown: $showImagePicker,
                    photoImageData: $photoImageData,
                    cameraOrLibrary: cameraOrLibrary)
    }
}
 
