# MapApp

## iOS приложение написано на Swift 5. 
### Използва API на  Apple Maps(MapKit) и неплатената версия на Air Visual API за да може потребителят да избере място на картата и да разбере температурата, влажност и скорост на вятъра, спрямо най-близкия град.

## Документация
* В основата си приложението е изградено чрез клас наследник на UIViewController (ViewController), единственото View в него в предоставеното от MapKit - MKMapView, чиято роля е да репрезентира световната карта.
* Изплозва се Tap Gesture (натискане по екрана) за да се добави MKPointAnnotation. Натискането на определено място по екрана взима предвид точката на натиск по MKMapView спрямо негова координатна му система и чрез член функция на MKMapView - 
> convert(_ point: CGPoint, toCoordinateFrom view: UIView?) -> CLLocationCoordinate2D 
* конвертира тази точка в координатна точка на реалната карта и поставя визиален индикатор (визуалната репрезентация на MKPointAnnotation
* Повторен натиск върху същата точка извиква метод делегат на MKMapView
> mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
* в този метод се из създава заявката към Air Visual API като в символен низ се замества текст заместител с географска широчина и дължина, и API токен, който е константа предоставена от Air Visual API, след което символният низ се подава към конструктора на класа URL и заявката бива изпълнена от URLSession
> URLSession.shared.dataTask(with: url)
*  резулататът то заявката идва в JSON формат, като се парсва към клас APIResponse имплементиращ протокола Codablе
* заявката към Air Visual API се изпълнява към "https://api.airvisual.com/v2/nearest_city?lat={{LATITUDE}}&lon={{LONGITUDE}}&key={{API_KEY}}", и отговорът е във следният формат:
``` 
{
   "status":"success",
   "data":{
      "city":"Stara Zagora",
      "state":"Stara Zagora",
      "country":"Bulgaria",
      "location":{
         "type":"Point",
         "coordinates":[
            25.637389,
            42.432356
         ]
      },
      "current":{
         "weather":{
            "ts":"2019-11-25T16:00:00.000Z",
            "tp":8,
            "pr":1011,
            "hu":87,
            "ws":11.3,
            "wd":60,
            "ic":"04n"
         }
      }
   }
}
```
