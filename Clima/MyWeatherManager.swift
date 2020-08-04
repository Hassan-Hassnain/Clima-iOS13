
import Foundation
import CoreLocation

protocol WeatherManagerDelegat {
    func didUpdateWeather(_ WeatherManager: MyWeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct MyWeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c6e3da79601c742282d5967c913b0f72&units=metric"
    var delegate: WeatherManagerDelegat?
    
    func  fetchWeater(cityName: String) {
        let  urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(With: urlString)
    }
    ///================================================================================================================================
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(With: urlString)
    }
    ///================================================================================================================================
    
    func performRequest(With urlString: String){
        if let url = URL(string: urlString)  {                          //2
            let session = URLSession(configuration: .default)           //3
            let task = session.dataTask(with: url){                     //4
                (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData,encoding: .utf8)//5
                    //print(dataString)
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()                                                   //6
        }
    }
    ///==========================================================================================================================================
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: cityId, cityName: cityName, temperature: temp)
            
            print(weather.conditionName)
            //printWeatherContent(decodedData)
            return weather
            
        } catch {
            //print(error)
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}
/*
 1. First of all create a url string and save it in String type variable
 2. Create url
 3. Create URLSession in default configuration
 4. Create session data task
 5. TypeCast data in Stirng
 6. Resume task
 
 */
