import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    let localInicial = CLLocation(latitude: 42.434719, longitude: -83.985001)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        
        mapa.mapType = .standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0275, longitudeDelta: 0.0275) //para mostrar o zoom ao redoor da localizacao setada
        let regiao = MKCoordinateRegion(center: localInicial.coordinate, span: span)
        mapa.setRegion(regiao, animated: true)
        
        let anotacao = MKPointAnnotation() // Criar anotacao
        anotacao.coordinate = localInicial.coordinate
        anotacao.title = "AQUI"
        anotacao.subtitle = "AQUI MESMO"
        mapa.addAnnotation(anotacao) //Colocar anotacao em um mapa
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let local = locations[locations.count-1]
        
        if local.horizontalAccuracy > 0.0 {
            lm.stopUpdatingLocation()
            print("\(local.coordinate.latitude), \(local.coordinate.latitude)")
            ViewController.geocoder.reverseGeocodeLocation(local) { (placemarks, _) in
                if let marca = placemarks?.first{
                    print(marca)
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }

}

