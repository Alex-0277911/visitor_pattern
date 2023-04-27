// Паттерн Visitor може бути корисним для обробки різних типів погодних даних
// в погодному застосунку.

// Наприклад, ми можемо мати різні типи погодних даних, такі як температура,
// вологість, швидкість вітру тощо, і ми можемо мати різні способи обробки цих
// даних, наприклад, можна обчислити середнє значення, максимальне значення,
// мінімальне значення тощо.

// Для реалізації паттерну Visitor у погодному застосунку, спочатку створимо
// базовий клас WeatherData, який представляє погодні дані:

abstract class WeatherData {
  void accept(visitor);
}

// Клас WeatherData містить метод accept(), який приймає об'єкт WeatherVisitor.
// Цей метод буде викликаний для кожного об'єкта погодних даних, коли ми
// застосовуємо відвідувача до нього.

// Далі, створимо декілька класів, які реалізують базовий клас WeatherData.
// Наприклад, створимо клас TemperatureData, який представляє температуру:

// Клас TemperatureData містить одне поле - температуру, і перевизначає метод
// accept(), щоб передати відвідувачу об'єкт this за допомогою методу
// visitor.visitTemperature(this).

// Подібним чином, ми можемо створити інші класи для різних типів погодних даних,
// наприклад, клас HumidityData для вологості, клас WindSpeedData для швидкості
// вітру тощо.

class TemperatureData extends WeatherData {
  final double temperature;

  TemperatureData(this.temperature);

  @override
  void accept(visitor) {
    visitor.visitTemperature(this);
  }
}

class HumidityData extends WeatherData {
  final double humidity;

  HumidityData(this.humidity);

  @override
  void accept(visitor) {
    visitor.visitHumidity(this);
  }
}

class WindSpeedData extends WeatherData {
  final double windSpeed;

  WindSpeedData(this.windSpeed);

  @override
  void accept(visitor) {
    visitor.visitWindSpeed(this);
  }
}

// Нарешті, ми створимо клас WeatherVisitor, який буде відвідувати різні
// об'єкти погодних даних та проводити обробку:

abstract class WeatherVisitor {
  void visitTemperature(TemperatureData temperatureData);
  void visitHumidity(HumidityData humidityData);
  void visitWindSpeed(WindSpeedData windSpeedData);
}

// Клас WeatherVisitor містить методи visitTemperature(), visitHumidity() та
// visitWindSpeed(), які будуть викликані для кожного об'єкту погодних даних з
// відповідним типом. Наприклад, якщо ми хочемо обчислити середню температуру,
// ми можемо створити клас AverageTemperatureVisitor, який реалізує інтерфейс
// WeatherVisitor:

// Клас AverageTemperatureVisitor містить два поля - count та totalTemperature,
// які використовуються для обчислення середньої температури. Клас також
// реалізує методи visitTemperature(), visitHumidity() та visitWindSpeed(),
// проте, оскільки нам потрібно обчислити середню температуру, ми реалізуємо
// тільки метод visitTemperature(), а методи visitHumidity() та visitWindSpeed()
// будуть порожніми. Метод getAverageTemperature() повертає середню температуру,
// обчислену зі значень, які зберігаються у полях count та totalTemperature.

class AverageTemperatureVisitor implements WeatherVisitor {
  int count = 0;
  double totalTemperature = 0;

  @override
  void visitTemperature(TemperatureData temperatureData) {
    totalTemperature += temperatureData.temperature;
    count++;
  }

  @override
  void visitHumidity(HumidityData humidityData) {
    // Нічого не робимо
  }

  @override
  void visitWindSpeed(WindSpeedData windSpeedData) {
    // Нічого не робимо
  }

  double getAverageTemperature() {
    return totalTemperature / count;
  }
}

// Нарешті, ми можемо створити об'єкти погодних даних та відвідувачів та
// викликати метод accept() для кожного об'єкту погодних даних, передаючи
// відвідувача в якості аргументу. Наприклад, для обчислення середньої
// температури, ми можемо створити об'єкти TemperatureData та
// AverageTemperatureVisitor і викликати метод accept() для кожного об'єкту
// TemperatureData, передаючи об'єкт AverageTemperatureVisitor в якості аргументу:

void main() {
  final temperatureData1 = TemperatureData(20.0);
  final temperatureData2 = TemperatureData(22.5);
  final temperatureData3 = TemperatureData(18.7);

  final averageTemperatureVisitor = AverageTemperatureVisitor();

  temperatureData1.accept(averageTemperatureVisitor);
  temperatureData2.accept(averageTemperatureVisitor);
  temperatureData3.accept(averageTemperatureVisitor);

  final averageTemperature = averageTemperatureVisitor.getAverageTemperature();
  print('Середня температура: $averageTemperature градусів Цельсія');
}

// У цьому прикладі ми створили три об'єкти `TemperatureData` з різними
// значеннями температури, створили об'єкт `AverageTemperatureVisitor`,
// викликали метод `accept()` для кожного об'єкту `TemperatureData`, передаючи
// `AverageTemperatureVisitor` в якості аргументу, та обчислили середню
// температуру за допомогою методу `getAverageTemperature()`.
