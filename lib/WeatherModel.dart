
class WeatherModel{
  final temp;
  final pressure;
  final humidity;
  final description;
  final windSpeed;
  final name;
  final icon;

  WeatherModel(this.temp,this.pressure,this.humidity,this.description,this.windSpeed,this.name,this.icon);

  void printModel(){
    print("Temp:$temp\nPressure:$pressure\nHumidity:$humidity\nDescription:$description\nWindSpeed:$windSpeed\nName:$name");
  }

}