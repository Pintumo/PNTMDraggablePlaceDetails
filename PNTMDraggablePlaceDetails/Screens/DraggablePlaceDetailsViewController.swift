import Kingfisher
import UIKit

public class DraggablePlaceDetailsViewController: UIViewController {
    
    // MARK: - Public
    
    public init(_ model: DraggablePlaceDetailsPlaceModel) {
        self.dataStore = DraggablePlaceDetailsStore(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: - Private
    
    private lazy var contentView = DraggablePlaceDetailsView(delegate: self)
    private let dataStore: DraggablePlaceDetailsStore
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        self.view = contentView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.cancelButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        self.contentView.cancelGesture.delegate = self
    }
}

extension DraggablePlaceDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.contentView.numberOfImages = self.dataStore.numberOfPhotos()
        return self.dataStore.numberOfPhotos()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  self.contentView.dequeCellForImageIndexPath(indexPath)
        guard let url = self.dataStore.photoAtIndexPath(indexPath) else { return UICollectionViewCell() }
        
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            self.contentView.setCurrentPage(Int(scrollView.contentOffset.x) / Int(scrollView.frame.width))
        }
    }
}

extension DraggablePlaceDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.contentView.backgroundColor = .white
        header.textLabel?.textColor = Constants.mainColor
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : "Bewertungen"
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataStore.heightAtIndexPath(indexPath)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStore.numbersOfRowsInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataStore.tableView(tableView, cellForRowAt:indexPath, target: self, shareAction:  #selector(sharePlacesURL), routeAction: #selector(routeToLocation))
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dataStore.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is TableView {
            self.contentView.scrollViewDidScroll(scrollView)
        }
    }
}

extension DraggablePlaceDetailsViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = gestureRecognizer as? UIPanGestureRecognizer else { return true }
        let velocity = pan.velocity(in: pan.view)
        if abs(velocity.y) > abs(velocity.x) && velocity.y > 0  {
            self.dismiss(animated: true, completion: nil)
            return false
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DraggablePlaceDetailsViewController {
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissPanGesture(_ sender: UIPanGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sharePlacesURL(_ sender: UIButton) {
        guard let url = self.dataStore.model.sharingURL() else { return }
        UIActivityViewController.sharePlacesURL(url, presenter: self)
    }
    
    @objc func routeToLocation(_ sender: UIButton) {
        guard let location = self.dataStore.model.location else { return }
        UIAlertController.routeToLocation(location, presenter: self)
    }
}
