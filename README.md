# VideoGames
Uygulama MVVM mimarisi ile geliştirildi.
Arayüz tamamen Swift ile UIKit kütüphanesi kullanılarak oluşturuldu. Lokal veritabanı için CoreData kütüphanesi kullanıldı.

## Uygulamayı Geliştirirken Kullandığım 3rd party Kütüphaneler(CocoaPods)

### Alamofire - KingFisher - Firebase(Analytics,Crashlytics)

![](https://raw.githubusercontent.com/caner07/VideoGames/main/Screenshots/home.png) 

Anasayfada API üzerinden çekilen oyunlar gösterilir. Arama barındaki arama işlemi lokalde indirilmiş liste üzerinden yapılır.

![](https://raw.githubusercontent.com/caner07/VideoGames/main/Screenshots/details.png)

Oyun Detayları sayfasında oyun hakkında kısa bir açıklama yazısı bulunuyor. Oyun resminin alt tarafındaki yıldız ikonuna dokunarak kullanıcı
oyunu favorilere ekleyip lokal veritabanına kaydedilmesini sağlayabilir. Halihazırda favorilere eklediği bir oyunun detay sayfasına girdiğinde
yıldız ikonu içi dolu olarak gösterilir. Bu sayfada ek olarak Firebase Analyticse event gönderilir. Kulllanıcı sayfaya girdiğinde o oyunun incelendiğine dair
event gönderilir,favorilere eklerse ayrıca favorilere eklendiğine dair event gönderilir.

![](https://raw.githubusercontent.com/caner07/VideoGames/main/Screenshots/favorites.png)

Favoriler ekranında CoreData veritabanına kaydedilmiş oyunların listesi gösterilir. Bu sayfadaki arama barındaki arama işlemi doğrudan CoreData veritabanına
sorgu yollanarak yapılır.
