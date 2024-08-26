//
//  File.swift
//  
//
//  Created by John Knowles on 8/12/24.
//

import Foundation
import AsyncDisplayKit
import UIKit

#if os(iOS)
public class SceneNavigation: ASNavigationController, UINavigationControllerDelegate {
    public init(rootController: UIViewController) {
        super.init(rootViewController: rootController)
        self.delegate = self
    }
    
    private var popRecognizer: InteractivePopRecognizer?

    var initialInteractivePopGestureRecognizerDelegate: UIGestureRecognizerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                               willShow viewController: UIViewController,
                               animated: Bool) {
        navigationController.setNavigationBarHidden(true, animated: animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        popRecognizer = InteractivePopRecognizer(controller: self)
//        initialInteractivePopGestureRecognizerDelegate = self.interactivePopGestureRecognizer?.delegate
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        self.interactivePopGestureRecognizer?.delegate = initialInteractivePopGestureRecognizerDelegate
    }
}

class InteractivePopRecognizer: NSObject {

    // MARK: - Properties

    fileprivate weak var navigationController: UINavigationController?

    // MARK: - Init

    init(controller: UINavigationController) {
        self.navigationController = controller

        super.init()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension InteractivePopRecognizer: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }

    // This is necessary because without it, subviews of your top controller can cancel out your gesture recognizer on the edge.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
#endif


import DifferenceKit
public extension ASCollectionNode {
    public func reload<T: Collection>(changeset stagedChangeset: StagedChangeset<T>,
                               setData: @escaping (T) -> ()) {
        for changeset in stagedChangeset {
            performBatchUpdates({
                setData(changeset.data)
                
                if !changeset.sectionDeleted.isEmpty {
                    deleteSections(IndexSet(changeset.sectionDeleted))
                }
                
                if !changeset.sectionInserted.isEmpty {
                    insertSections(IndexSet(changeset.sectionInserted))
                }
                
                if !changeset.sectionUpdated.isEmpty {
                    reloadSections(IndexSet(changeset.sectionUpdated))
                }
                
                for (source, target) in changeset.sectionMoved {
                    moveSection(source, toSection: target)
                }
                
                if !changeset.elementDeleted.isEmpty {
                    deleteItems(at: changeset.elementDeleted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementInserted.isEmpty {
                    insertItems(at: changeset.elementInserted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementUpdated.isEmpty {
                    reloadItems(at: changeset.elementUpdated.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                for (source, target) in changeset.elementMoved {
                    moveItem(at: IndexPath(item: source.element, section: source.section), to: IndexPath(item: target.element, section: target.section))
                }
            })
        }
            
    }
}
