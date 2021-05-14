//
//  SavedMedsViewModel.swift
//  MedsTracker
//
//  Created by Антон Текутов on 14.05.2021.
//

final class SavedMedsViewModel {
	var output: SavedMedsOutput?
}

// MARK: - Configuration
extension SavedMedsViewModel: CustomizableSavedMedsViewModel {

}

// MARK: - Interface for view
extension SavedMedsViewModel: SavedMedsViewModelProtocol {

}

