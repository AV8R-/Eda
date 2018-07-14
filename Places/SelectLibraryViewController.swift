import UIKit
import class Alamofire.SessionManager

final class SelectLibraryViewController: UITableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let places = segue.destination as? PlacesViewController else {
            return
        }
        
        // Naïve DI
        
        places.placesService = PlacesService(sessionManager: SessionManager())
        
        switch segue.identifier {
        case "SDWebImage":
            places.picturesService = SDWebImageAdapter()
        case "Kingfisher":
            places.picturesService = KingfisherAdapter()
        case "Nuke":
            places.picturesService = NukeAdapter()
        default: ()
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .default, title: "Clear cache", handler: { (action, indexPath) in
            switch indexPath.row {
            case 0:
                SDWebImageAdapter().dropCache()
            case 1:
                KingfisherAdapter().dropCache()
            case 2:
                NukeAdapter().dropCache()
            default: ()
            }
        })]
    }
    
}
