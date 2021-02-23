//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by kairzhan on 2/22/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Segue destination is not found")}
        photosVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            self?.photoImageView.image = photo
        }).disposed(by: disposeBag)
    }

}

