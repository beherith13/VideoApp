//
//  ViewController.swift
//  VideoApp
//
//  Created by Beherith on 06.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class VideoGalleryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    public var viewModelFactory: VideoGalleryViewModelFactory!
    private var viewModel: VideoGalleryViewModel!
    
    private let disposeBag = DisposeBag()
    private let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<(), VideoGalleryItemViewModel>>(configureCell: { _, collectionView, indexPath, item in
        let cell: VideoGalleryItemCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(model: item)
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer()
        collectionView.addGestureRecognizer(gestureRecognizer)
        
        let visible = rx.visible.asSignal()
        let focus = collectionView.rx
            .didUpdateFocusInContextWithAnimationCoordinator
            .asSignal()
            .map { $0.context.nextFocusedIndexPath?.row }        
        let select = gestureRecognizer.rx.event.asSignal().map { _ in () }
        let retry = retryButton.rx.controlEvent(.primaryActionTriggered).asSignal()
        
        let input = VideoGallery.Input(
            enable: visible,
            focus: focus,
            select: select,
            retry: retry
        )
        viewModel = viewModelFactory.create(input: input)
        
        setup()
    }
    
    private func setup() {
        viewModel.items
            .map { [SectionModel(model: (), items: $0)] }
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
       
        viewModel.isLoading
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.error
            .drive(errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.error
            .map { $0 != nil }
            .drive(collectionView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.error
            .map { $0 == nil }
            .drive(errorView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
