//
//  UITableViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 SwifterSwift
//

import UIKit

#if !os(watchOS)
// MARK: - Properties
public extension UITableView {

	/// SwifterSwift: Index path of last row in tableView.
    var indexPathForLastRow: IndexPath? {
		return indexPathForLastRow(inSection: lastSection)
	}

	/// SwifterSwift: Index of last section in tableView.
    var lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
    
    func dequeue<Cell: UITableViewCell>(indexPath: IndexPath) -> Cell
    {
        guard let cell = dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell
        else { fatalError("Error in cell") }
        return cell
    }
    
    func register<T>(cell: T.Type) where T: UITableViewCell
    {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }

}
extension UIView
{
    static var nib: UINib
    {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static var identifier: String
    {
        return "\(self)"
    }
     
    
    func applyGradient(colours: [UIColor] = [R.color.mainColor() ?? .clear,R.color.secondColor() ?? .clear]) {
        DispatchQueue.main.async { [weak self] in
            self?.applyGradient(colours: colours, gradient: .horizontal)
            self?.layoutSubviews()
        }
        
        
    }
    
    func applyGradient(colours: [UIColor], gradient orientation: GradientOrientation) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.layer.bounds
        gradient.cornerRadius = 8
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        gradient.colors = colours.map { $0.cgColor }
//        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
}


typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical

    var startPoint : CGPoint {
        return points.startPoint
    }

    var endPoint : CGPoint {
        return points.endPoint
    }

    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}

// MARK: - Methods
public extension UITableView {

	/// SwifterSwift: Number of all rows in all sections of tableView.
	///
	/// - Returns: The count of all rows in the tableView.
    func numberOfRows() -> Int {
		var section = 0
		var rowCount = 0
		while section < numberOfSections {
			rowCount += numberOfRows(inSection: section)
			section += 1
		}
		return rowCount
	}

	/// SwifterSwift: IndexPath for last row in section.
	///
	/// - Parameter section: section to get last row in.
	/// - Returns: optional last indexPath for last row in section (if applicable).
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
		guard section >= 0 else { return nil }
		guard numberOfRows(inSection: section) > 0  else {
			return IndexPath(row: 0, section: section)
		}
		return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
	}

	/// Reload data with a completion handler.
	///
	/// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			self.reloadData()
		}, completion: { _ in
			completion()
		})
	}

	/// SwifterSwift: Remove TableFooterView.
    func removeTableFooterView() {
		tableFooterView = nil
	}

	/// SwifterSwift: Remove TableHeaderView.
    func removeTableHeaderView() {
		tableHeaderView = nil
	}

	/// SwifterSwift: Scroll to bottom of TableView.
	///
	/// - Parameter animated: set true to animate scroll (default is true).
    func scrollToBottom(animated: Bool = true) {
		let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
		setContentOffset(bottomOffset, animated: animated)
	}

	/// SwifterSwift: Scroll to top of TableView.
	///
	/// - Parameter animated: set true to animate scroll (default is true).
    func scrollToTop(animated: Bool = true) {
		setContentOffset(CGPoint.zero, animated: animated)
	}

	/// SwifterSwift: Dequeue reusable UITableViewCell using class name
	///
	/// - Parameter name: UITableViewCell type
	/// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

	/// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
	///
	/// - Parameters:
	///   - name: UITableViewCell type.
	///   - indexPath: location of cell in tableView.
	/// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }

	/// SwiferSwift: Dequeue reusable UITableViewHeaderFooterView using class name
	///
	/// - Parameter name: UITableViewHeaderFooterView type
	/// - Returns: UITableViewHeaderFooterView object with associated class name.
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name))")
        }
        return headerFooterView
    }
    
    func registerHeader<T>(header: T.Type) where T: UITableViewHeaderFooterView
    {
        register(header.nib, forHeaderFooterViewReuseIdentifier: header.identifier)
    }

	/// SwifterSwift: Register UITableViewHeaderFooterView using class name
	///
	/// - Parameters:
	///   - nib: Nib file used to create the header or footer view.
	///   - name: UITableViewHeaderFooterView type.
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
		register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
	}

	/// SwifterSwift: Register UITableViewHeaderFooterView using class name
	///
	/// - Parameter name: UITableViewHeaderFooterView type
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
		register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
	}

	/// SwifterSwift: Register UITableViewCell using class name
	///
	/// - Parameter name: UITableViewCell type
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
		register(T.self, forCellReuseIdentifier: String(describing: name))
	}

	/// SwifterSwift: Register UITableViewCell using class name
	///
	/// - Parameters:
	///   - nib: Nib file used to create the tableView cell.
	///   - name: UITableViewCell type.
    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
		register(nib, forCellReuseIdentifier: String(describing: name))
	}

    /// SwifterSwift: Register UITableViewCell with .xib file using only its corresponding class.
    ///               Assumes that the .xib filename and cell class has the same name.
    ///
    /// - Parameters:
    ///   - name: UITableViewCell type.
    ///   - bundleClass: Class in which the Bundle instance will be based on.
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    /// SwifterSwift: Check whether IndexPath is valid within the tableView
    ///
    /// - Parameter indexPath: An IndexPath to check
    /// - Returns: Boolean value for valid or invalid IndexPath
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

}
#endif
