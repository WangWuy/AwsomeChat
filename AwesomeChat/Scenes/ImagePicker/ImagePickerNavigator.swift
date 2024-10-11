//
//  ImagePickerNavigator.swift
//  AwesomeChat
//
//  Created by đào sơn on 12/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

protocol ImagePickerNavigatorType {
    func makeViewController() -> ImagePickerViewController
    var input: ReplaySubject<ImagePickerInput> { get }
    var output: ReplaySubject<ImagePickerOutput> { get }
}

extension ImagePickerNavigator {
    func makeViewController() -> ImagePickerViewController {
        let imagePickerViewModel = ImagePickerViewModel(navigator: self,
                                                        selectedPHassets: .init(value: []))
        return ImagePickerViewController(viewModel: imagePickerViewModel, isShowingImagePicker: .just(true))
    }
}

struct ImagePickerInput {
    let mediaType: Observable<MediaType>
}

struct ImagePickerOutput {
    let selectedAsset: Observable<[PHAsset]>
}

public struct ImagePickerNavigator: ImagePickerNavigatorType {
    var input = ReplaySubject<ImagePickerInput>.create(bufferSize: 1)
    var output = ReplaySubject<ImagePickerOutput>.create(bufferSize: 1)
}
