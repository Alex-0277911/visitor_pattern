// Visitor (відвідувач) використовується для розділення алгоритмів від об'єктів,
// на яких вони працюють. Це дозволяє додавати нові алгоритми без зміни класів
// об'єктів, до яких вони застосовуються.

// В контексті спортивного застосунку, де ми можемо мати різні види спорту, цей
// паттерн можна використовувати для розділення алгоритмів, які працюють з
// різними типами спорту.

// Для прикладу, розглянемо додавання можливості обчислення середнього рейтингу
// команди в спортивному застосунку. Ми можемо визначити загальний інтерфейс для
// відвідувача TeamVisitor, який містить метод visit для обробки команди.

abstract class TeamVisitor {
  void visit(Team team);
}

// Цей клас представляє гравця в команді, має два поля: ім'я гравця та його рейтинг.

class Player {
  final String name;
  final int rating;

  Player(this.name, this.rating);
}

// Кожен вид спорту може мати свій власний клас команди, який буде реалізувати
// інтерфейс Team та приймати відвідувачів

abstract class Team {
  String name;
  List<Player> players;
  Team(this.name, this.players);
  void accept(TeamVisitor visitor);
}

class FootballTeam implements Team {
  String name;
  List<Player> players;
  FootballTeam(this.name, this.players);
  void accept(TeamVisitor visitor) {
    visitor.visit(this);
  }
}

class BasketballTeam implements Team {
  String name;
  List<Player> players;
  BasketballTeam(this.name, this.players);
  void accept(TeamVisitor visitor) {
    visitor.visit(this);
  }
}

// Тепер ми можемо створити клас AverageRatingVisitor, який реалізує інтерфейс
// TeamVisitor та обчислює середній рейтинг команди.

class AverageRatingVisitor implements TeamVisitor {
  double rating = 0;
  int count = 0;
  void visit(Team team) {
    team.players.forEach((player) {
      rating += player.rating;
      count++;
    });
    rating /= count;
    print('${team.name} average rating: $rating');
  }
}

// За допомогою паттерну Visitor ми можемо додати нові алгоритми для роботи з
// командами, не змінюючи класів команд та гарантуючи, що ці алгоритми будуть
// застосовуватися тільки до підходящих типів команд.

// Тепер ми можемо створити декілька команд різних видів спорту та обчислити
// їх середній рейтинг за допомогою класу AverageRatingVisitor.

void main() {
  var footballTeam = FootballTeam('Real Madrid', [
    Player('Cristiano Ronaldo', 98),
    Player('Sergio Ramos', 95),
    Player('Karim Benzema', 89),
  ]);
  var basketballTeam = BasketballTeam('Los Angeles Lakers', [
    Player('LeBron James', 97),
    Player('Anthony Davis', 92),
    Player('Russell Westbrook', 88),
  ]);

  var averageRatingVisitor = AverageRatingVisitor();
  footballTeam.accept(
      averageRatingVisitor); // виведе "Real Madrid average rating: 94.0"
  basketballTeam.accept(
      averageRatingVisitor); // виведе "Los Angeles Lakers average rating: 92.33333333333333"
}
