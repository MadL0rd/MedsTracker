//
// Auto generated file
//

import UIKit

protocol ModuleGenerator {
    func createModule() -> UIViewController
}

enum UserStoriesModulesDefault: ModuleGenerator {

    case barcodeMedsScaner
    case loading
    case addMedsTypeSelector
    case savedMeds

    func createModule() -> UIViewController {
        switch self {
        case .barcodeMedsScaner: 
            return BarcodeMedsScanerCoordinator.createModule()
        case .loading: 
            return LoadingCoordinator.createModule()
        case .addMedsTypeSelector: 
            return AddMedsTypeSelectorCoordinator.createModule()
        case .savedMeds: 
            return SavedMedsCoordinator.createModule()
        }
    }
}

enum UserStoriesModulesWithOutput: ModuleGenerator {

    case barcodeMedsScaner(output: BarcodeMedsScanerOutput)
    case loading(output: LoadingOutput)
    case addMedsTypeSelector(output: AddMedsTypeSelectorOutput)
    case savedMeds(output: SavedMedsOutput)

    func createModule() -> UIViewController {
        switch self {
        case .barcodeMedsScaner(let output): 
            return BarcodeMedsScanerCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .loading(let output): 
            return LoadingCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .addMedsTypeSelector(let output): 
            return AddMedsTypeSelectorCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        case .savedMeds(let output): 
            return SavedMedsCoordinator.createModule { viewModel in 
                viewModel.output = output
            }
            
        }
    }
}
