import UIKit

class DraggablePlaceDetailsView: UIView {
    
    var numberOfImages: Int = 1 { didSet { self.pageControl.numberOfPages = numberOfImages }}
    let cancelButton = UIButton(type: .custom)
    let cancelGesture = UIPanGestureRecognizer()
    
    private let collectionView: UICollectionView
    private let pageControl = UIPageControl()
    private let tableView = TableView()
    
    private let maxHeaderHeight: CGFloat = 260.0
    private let minHeaderHeight: CGFloat = 66.0
    private var headerHeightConstraint: NSLayoutConstraint!

    init(delegate: UITableViewDelegate & UITableViewDataSource & UICollectionViewDelegate & UICollectionViewDataSource) {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: maxHeaderHeight)
        collectionView = UICollectionView(frame: CGRect.null, collectionViewLayout: flowLayout)

        super.init(frame: CGRect.null)

        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.isPagingEnabled = true
        self.collectionView.register(ImageCell.self, forCellWithReuseIdentifier: Constants.DPDImageReuseIdentifier)
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = delegate
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        self.headerHeightConstraint = self.collectionView.heightAnchor.constraint(equalToConstant: maxHeaderHeight)
        self.headerHeightConstraint.isActive = true
        
        self.pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = 1
        self.pageControl.currentPage = 0
        self.addSubview(self.pageControl)
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.leftAnchor.constraint(equalTo: self.collectionView.leftAnchor).isActive = true
        self.pageControl.rightAnchor.constraint(equalTo: self.collectionView.rightAnchor).isActive = true
        self.pageControl.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        let cancelButtonImage = Assets.close_arrow.image()?.withRenderingMode(.alwaysTemplate)
        self.cancelButton.setImage(cancelButtonImage, for: .normal)
        self.cancelButton.imageView?.tintColor = .white
        self.addSubview(self.cancelButton)
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.centerYAnchor.constraint(equalTo: self.pageControl.centerYAnchor).isActive = true
        self.cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        self.collectionView.addGestureRecognizer(self.cancelGesture)
        
        self.tableView.register(ReviewCell.self, forCellReuseIdentifier: Constants.DPDReviewReuseIdentifier)
        self.tableView.delegate = delegate
        self.tableView.dataSource = delegate
        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Public Methods

extension DraggablePlaceDetailsView {
    func dequeCellForImageIndexPath(_ indexPath: IndexPath) -> ImageCell {
        return self.collectionView
            .dequeueReusableCell(withReuseIdentifier: Constants.DPDImageReuseIdentifier, for: indexPath)
            as! ImageCell
    }
    
    func setCurrentPage(_ currentPage: Int) {
        self.pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newHeight = maxHeaderHeight - scrollView.contentOffset.y
        if newHeight < minHeaderHeight {
            newHeight = minHeaderHeight
        } else if newHeight > maxHeaderHeight {
            newHeight = maxHeaderHeight
        }
        
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        self.headerHeightConstraint.constant = newHeight
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: newHeight)
        self.collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
}
