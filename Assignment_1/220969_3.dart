class Animal {
  String name;
  int age;
  String healthStatus;

  void displayDetails() {
    print('$name ($runtimeType) - Age: $age, Health: $healthStatus');
  }

  Animal({required this.name, required this.age, required this.healthStatus});
}

class FeedingSchedule {
  String animalName;
  String time;
  String foodType;
  var quantity;

  FeedingSchedule(
      {required this.animalName,
      required this.time,
      required this.foodType,
      required this.quantity});
}

class Exhibit {
  String name;
  List<Animal> animals = [];
  List<FeedingSchedule> feedingSchedules = [];

  Exhibit({required this.name});

  void addAnimalToExhibit(Animal animal) {
    animals.add(animal);
  }

  void addFeedingSchedule(FeedingSchedule schedule) {
    feedingSchedules.add(schedule);
  }

  void displayDetails() {
    print('$name: ${animals.map((animal) => animal.name).join(', ')}');
  }
}

class Visitor {
  String name;
  int age;
  List<String> visitedExhibits = [];

  Visitor({required this.name, required this.age});

  void visitExhibit(Zoo zoo, String exhibitName) {
    visitedExhibits.add(exhibitName);
    zoo.Visitors.add(this);
  }
}

class Zoo {
  List<Animal> Animals = [];
  List<Exhibit> Exhibits = [];
  List<FeedingSchedule> feedingSchedules = [];
  List<Visitor> Visitors = [];

  void addAnimal(Animal animal) {
    Animals.add(animal);
  }

  void addExhibit(Exhibit exhibit) {
    Exhibits.add(exhibit);
  }

  // void addFeedingSchedule(FeedingSchedule schedule) {
  //   feedingSchedules.add(schedule);
  // }

  void addFeedingSchedule(String animalName, String time,
      {required String foodType, required String quantity}) {
    feedingSchedules.add(FeedingSchedule(
        animalName: animalName,
        time: time,
        foodType: foodType,
        quantity: quantity));
  }

  // void transferAnimal(Animal animal, Exhibit fromExhibit, Exhibit toExhibit) {
  //   if (Animals.contains(animal)) {
  //     if (fromExhibit.animals.contains(animal)) {
  //       if (Exhibits.contains(fromExhibit) && Exhibits.contains(toExhibit)) {
  //         fromExhibit.animals.remove(animal);
  //         toExhibit.animals.add(animal);
  //       } else
  //         print("Exhibits not found in Zoo.");
  //     } else
  //       print("${animal.name} not in ${fromExhibit.name}.");
  //   } else
  //     print("${animal.name} not in Zoo.");
  // }

 void transferAnimal(String animalName, String fromExhibit, String toExhibit) {
  bool fromExhibitFound = false;
  bool animalFound = false;

  for (var exhibit in Exhibits) {
    if (exhibit.name == fromExhibit) {
      fromExhibitFound = true;

      for (var animal in exhibit.animals) {
        if (animal.name == animalName) {
          animalFound = true;
          exhibit.animals.remove(animal);

          for (var targetExhibit in Exhibits) {
            if (targetExhibit.name == toExhibit) {
              targetExhibit.animals.add(animal);
              break;
            }
          }

          if (!Exhibits.any((exhibit) => exhibit.name == toExhibit)) {
            print("$toExhibit not found.");
          }
          break;
        }
      }

      if (!animalFound) {
        print("$animalName not found.");
      }

      break;
    }
  }

  if (!fromExhibitFound) {
    print("$fromExhibit not found.");
  }
}

  // void moveAnimalToExhibit(Animal animal, Exhibit toExhibit) {
  //   if (Exhibits.contains(toExhibit)) {
  //     toExhibit.animals.add(animal);
  //   } else
  //     print("Exhibit not found in Zoo.");
  // }

  void moveAnimalToExhibit(String animalName, String toExhibit) {
    bool is_animal_ = true;
    bool is_toExhibit_ = true;
    for (var exhibit in Exhibits) {
      if (exhibit.name == toExhibit) {
        is_toExhibit_ = false;
        for (var animal in Animals) {
          if (animal.name == animalName) {
            is_animal_ = false;
            exhibit.animals.add(animal);
          }
        }
        if (is_animal_) {
          print("$animalName not found.");
        }
      }
    }
    if (is_toExhibit_) {
      print("$toExhibit not found.");
    }
  }

  // void updateFeedingSchedule(Animal animal, String time, String foodType, var quantity) {
  //   if (Animals.contains(animal)) {
  //     for (var schedule in feedingSchedules) {
  //       if (schedule.animalName == animal.name) {
  //         schedule.time = time;
  //         schedule.foodType = foodType;
  //         schedule.quantity = quantity;
  //       }
  //     }
  //   } else
  //     print("${animal.name} not in Zoo.");
  // }

  void updateFeedingSchedule(String animalName, String time,
      {required String foodType, required String quantity}) {
    for (var schedule in feedingSchedules) {
      if (schedule.animalName == animalName) {
        schedule.time = time;
        schedule.foodType = foodType;
        schedule.quantity = quantity;
      }
    }
  }

  void displayAllAnimals() {
    print('Details of All Animals:');
    // for (var animal in Animals) {
    //   animal.displayDetails();
    // }
    Animals.forEach((animal) => animal.displayDetails());
    print('\n');
  }

  void displayExhibits() {
    print('Details of All Exhibits:');
    // for (var exhibit in Exhibits) {
    //   exhibit.displayDetails();
    // }
    Exhibits.forEach((exhibit) => exhibit.displayDetails());
    print('\n');
  }

  void displayFeedingSchedule() {
    print('Details of All Feeding Schedules:');
    for (var schedule in feedingSchedules) {
      print(
          '${schedule.animalName} -  ${schedule.time} - ${schedule.foodType} - ${schedule.quantity}');
    }
    print('\n');
  }

  void displayVisitors() {
    print('Details of All Visitors:');
    for (var visitor in Visitors) {
      print(
          '${visitor.name} (Age: ${visitor.age}) - Visited Exhibits: ${visitor.visitedExhibits.join(', ')}');
    }
    print('\n');
  }
}

class Lion extends Animal {
  Lion({required String name, required int age})
      : super(name: name, age: age, healthStatus: "Under Observation");
}

class Giraffe extends Animal {
  Giraffe({required String name, required int age})
      : super(name: name, age: age, healthStatus: "Good");
}

class InteractiveExhibit extends Exhibit {
  InteractiveExhibit({required String name}) : super(name: name);
}

class StaticExhibit extends Exhibit {
  StaticExhibit({required String name}) : super(name: name);
}

void main() {
  Zoo myZoo = Zoo();

  myZoo.addAnimal(Lion(name: 'Simba', age: 5));
  myZoo.addAnimal(Giraffe(name: 'Gerald', age: 3));

  myZoo.addExhibit(InteractiveExhibit(name: 'Savannah Exhibit'));
  myZoo.addExhibit(StaticExhibit(name: 'Rainforest Exhibit'));

  myZoo.addExhibit(InteractiveExhibit(name: 'General Exhibit'));

  myZoo.addFeedingSchedule('Simba', '10:00 AM',
      foodType: 'Meat', quantity: '2 kg');
  myZoo.addFeedingSchedule('Gerald', '12:30 PM',
      foodType: 'Leaves', quantity: '5 kg');

  myZoo.moveAnimalToExhibit('Simba', 'General Exhibit');

  myZoo.transferAnimal('Simba', 'General Exhibit', 'Savannah Exhibit');

  myZoo.moveAnimalToExhibit('Gerald', 'Rainforest Exhibit');

  myZoo.updateFeedingSchedule('Simba', '10:00 AM',
      foodType: 'Meat', quantity: '3 kg');

  Visitor johnDoe = Visitor(name: 'John Doe', age: 25);
  johnDoe.visitExhibit(myZoo, 'Savannah Exhibit');

  myZoo.displayAllAnimals();
  myZoo.displayExhibits();
  myZoo.displayFeedingSchedule();
  myZoo.displayVisitors();

}
