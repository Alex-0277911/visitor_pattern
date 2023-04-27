// Клас WeatherData з методом accept, який використовується для прийому відвідувачів
abstract class WeatherData {
  void accept(WeatherVisitor visitor);
}

// Клас WeatherVisitor, який містить методи visit для кожного типу погодних даних
abstract class WeatherVisitor {
  void visitTemperature(Temperature temperature);
  void visitWind(Wind wind);
  void visitPrecipitation(Precipitation precipitation);
}

// Клас Temperature, що містить значення температури та реалізує метод accept
class Temperature implements WeatherData {
  final double value;

  Temperature(this.value);

  @override
  void accept(WeatherVisitor visitor) {
    visitor.visitTemperature(this);
  }
}

// Клас Wind, що містить значення швидкості вітру та реалізує метод accept
class Wind implements WeatherData {
  final double speed;

  Wind(this.speed);

  @override
  void accept(WeatherVisitor visitor) {
    visitor.visitWind(this);
  }
}

// Клас Precipitation, що містить значення опадів та реалізує метод accept
class Precipitation implements WeatherData {
  final double amount;

  Precipitation(this.amount);

  @override
  void accept(WeatherVisitor visitor) {
    visitor.visitPrecipitation(this);
  }
}

// Клас WeatherForecast, що містить список погодних даних та метод accept для їх передачі відвідувачу
class WeatherForecast {
  final List<WeatherData> data;

  WeatherForecast(this.data);

  void accept(WeatherVisitor visitor) {
    for (final d in data) {
      d.accept(visitor);
    }
  }
}

// Клас WeatherSummaryVisitor, що реалізує методи visit для кожного типу погодних даних та зберігає результат у вигляді рядка
class WeatherSummaryVisitor implements WeatherVisitor {
  final StringBuffer summary = StringBuffer();

  @override
  void visitTemperature(Temperature temperature) {
    summary.write('Температура: ${temperature.value.toStringAsFixed(1)}°C\n');
  }

  @override
  void visitWind(Wind wind) {
    summary.write('Швидкість вітру: ${wind.speed.toStringAsFixed(1)} км/год\n');
  }

  @override
  void visitPrecipitation(Precipitation precipitation) {
    summary.write(
        'Кількість опадів: ${precipitation.amount.toStringAsFixed(1)} мм\n');
  }
}

// Приклад використання
void main() {
  // Створюємо список погодних даних
  final data = <WeatherData>[
    Temperature(20.5),
    Wind(10.0),
    Precipitation(5.5),
  ];
// Створюємо екземпляр відвідувача, який буде відображати дані в консолі
  final visitor = WeatherSummaryVisitor();

// Відвідуємо кожен елемент списку даних за допомогою методу accept()
  for (final weatherData in data) {
    weatherData.accept(visitor);
  }

  final averageSummary = visitor.summary;
  print(averageSummary);
}
