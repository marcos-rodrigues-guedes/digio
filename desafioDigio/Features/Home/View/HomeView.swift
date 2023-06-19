import UIKit
import SnapKit
import Kingfisher
import SkeletonView

class HomeView: UIView, HomeViewProtocol {
    
    private var viewObject: HomeViewModel?
    
    private let errorView = ErrorView()
    
    private let scrollView = UIScrollView()
    
    public var onItemTapped: ((ItemHomeViewModel) -> Void)?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .midnightBlue
        return activityIndicator
    }()
    
    private let headerStackViewView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 0)
        return stackView
    }()
    
    private let cashStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25)
        return stackView
    }()
    
    private let productStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let spotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Olá, Maria"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let headerIconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let firstCarouselCollectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 10)
        carouselLayout.minimumLineSpacing = 12
        let collection = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let cardTitleLabel: UILabel = {
        let label = UILabel()
        let text = "digio Cash"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: "digioBlue")
        let words = text.components(separatedBy: " ")
        guard let lastWord = words.last else {
            return label
        }
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: lastWord)
        attributedString.addAttribute(.foregroundColor, value:
                                        UIColor(named: "digioGray") ?? UIColor.gray, range: range)
        label.attributedText = attributedString
        return label
    }()
    
    private let cardCashView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        return view
    }()
    
    private let secondCarouselTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Produtos"
        label.textColor = UIColor(named: "digioBlue")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let secondCarouselCollectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 30)
        carouselLayout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        firstCarouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardCashView.translatesAutoresizingMaskIntoConstraints = false
        secondCarouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        
        addSubview(activityIndicator)
        
        scrollView.addSubview(headerStackViewView)
        
        headerStackViewView.addArrangedSubview(headerIconImageView)
        
        headerIconImageView.image = Utils.createTwoCirclesImage(size: CGSize(width: 50, height: 50),
                                                                firstCircleRadius: 13,
                                                                secondCircleRadius: 5,
                                                                ringWidth: 7,
                                                                openingRatio: 0.84)
        
        headerStackViewView.addArrangedSubview(headerTitleLabel)
        
        scrollView.addSubview(contentStackView)
        
        cardCashView.isSkeletonable = true
        cardCashView.showAnimatedGradientSkeleton()
        
        spotStackView.addArrangedSubview(firstCarouselCollectionView)
        
        contentStackView.addArrangedSubview(spotStackView)
        
        cashStackView.addArrangedSubview(cardTitleLabel)
        cashStackView.addArrangedSubview(cardCashView)
        
        contentStackView.addArrangedSubview(cashStackView)
        
        productStackView.addArrangedSubview(secondCarouselTitleLabel)
        productStackView.addArrangedSubview(secondCarouselCollectionView)
        
        contentStackView.addArrangedSubview(productStackView)
        
        firstCarouselCollectionView.register(SpotLightItemViewCell.self,
                                             forCellWithReuseIdentifier: "FirstCarouselItemCell")
        firstCarouselCollectionView.dataSource = self
        firstCarouselCollectionView.delegate = self
        
        secondCarouselCollectionView.register(ProductItemViewCell.self,
                                              forCellWithReuseIdentifier: "SecondCarouselItemCell")
        secondCarouselCollectionView.dataSource = self
        secondCarouselCollectionView.delegate = self
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerStackViewView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-40)
            make.left.equalToSuperview().inset(20)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview()
        }
        
        firstCarouselCollectionView.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        cardCashView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        secondCarouselCollectionView.snp.makeConstraints { make in
            make.height.equalTo(130)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        cashStackView.isUserInteractionEnabled = true
        cashStackView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageTapped() {
        if let item = viewObject?.cash {
            onItemTapped?(item)
        }
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCarouselCollectionView {
            return viewObject?.spotlight.count ?? 0
        } else {
            return viewObject?.products.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCarouselCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCarouselItemCell",
                                                             for: indexPath)
                as? SpotLightItemViewCell {
                cell.configure(with: viewObject?.spotlight[indexPath.row].imageUrl ?? "")
                return cell
            } else {
                fatalError("Unable to dequeue SpotLightItemViewCell")
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCarouselItemCell",
                                                             for: indexPath)
                as? ProductItemViewCell {
                cell.configure(with: viewObject?.products[indexPath.row].imageUrl ?? "")
                return cell
            } else {
                fatalError("Unable to dequeue ProductItemViewCell")
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == firstCarouselCollectionView {
            return CGSize(width: UIScreen.main.bounds.width * 0.87, height: 150)
        } else {
            return CGSize(width: UIScreen.main.bounds.width * 0.3, height: 110)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCarouselCollectionView {
            if let item = viewObject?.spotlight[indexPath.row] {
                onItemTapped?(item)
            }
        } else {
            if let item = viewObject?.products[indexPath.row] {
                onItemTapped?(item)
            }
        }
    }
}

extension HomeView {
    func show(homeViewModel: HomeViewModelProtocol) {
        
        contentStackView.isHidden = homeViewModel.isLoading || homeViewModel.isError
        headerStackViewView.isHidden = homeViewModel.isLoading || homeViewModel.isError
        
        guard !homeViewModel.isLoading else {
            activityIndicator.startAnimating()
            return
        }
        guard !homeViewModel.isError else {
            activityIndicator.stopAnimating()
            errorView.showErrorInView(self, title: homeViewModel.errorDescription)
            return
        }
        
        errorView.hide()
        activityIndicator.stopAnimating()
        
        viewObject = homeViewModel.homeModel
        loadCashCardView(url: homeViewModel.homeModel?.cash.imageUrl)
        firstCarouselCollectionView.reloadData()
        secondCarouselCollectionView.reloadData()
        
    }
}

private extension HomeView {
    func loadCashCardView(url: String?) {
        guard let cashUrl = url else { return }
        cardCashView.kf.setImage(with: URL(string: cashUrl),
                                 placeholder: UIImage(named: "placeholder")) { [weak self] result in
            switch result {
            case .success(let value):
                self?.cardCashView.hideSkeleton()
                self?.cardCashView.image = value.image
            case .failure(let error):
                print("Erro ao baixar a imagem: \(error)")
            }
        }
    }
}
