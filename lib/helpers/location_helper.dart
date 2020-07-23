const API_KEY = 'pk.eyJ1Ijoia2Jvd2U5OSIsImEiOiJja2Jmam0zM3QwdzhyMnNud2hpM3I2aDlsIn0.EvD9S3-w8GPE4RfY5ko-uw';

class LocationHelper {
  static String generateLocationImage({double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/dark-v10/static/pin-s+FFC107($longitude,$latitude)/$longitude,$latitude,12,0/300x200?access_token=$API_KEY';
  }
  static String generateLocationImageLarge({double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/dark-v10/static/pin-s+FFC107($longitude,$latitude)/$longitude,$latitude,12,0/600x600?access_token=$API_KEY';
  }
}
