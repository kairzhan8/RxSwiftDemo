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
    @IBOutlet weak var applyFilterButton: UIButton!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = photoImageView.image else { return }
        FilterService().applyFilter(to: sourceImage) { (filteredImage) in
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("Segue destination is not found")}
        photosVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        photoImageView.image = image
        applyFilterButton.isHidden = false
    }

}

