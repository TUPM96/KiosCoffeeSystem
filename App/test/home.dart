// num a = 11;
// num b = 4.5;

// int a = 10;
// int b = 2;

import 'dart:async';

class Car {
  final String name;
  final String type;

  Car({required this.name, required this.type});

  void makeSound() {
    print('Miaw');
  }
}

class Muscle implements Car {
  Muscle(name, type);
  void makeSound() {
    print('whoosh');
  }

  @override
  String get name => name;

  @override
  String get type => type;
}

class FormulaOneCar extends Car {
  FormulaOneCar({required super.name, required super.type});

  int ersLevel = 100;

  void useERS() {
    Timer.periodic(Duration(seconds: 15), (Timer t) {
      ersLevel -= 1;
      print('$name is using ERS, current ERS level: $ersLevel');
    });
  }
}

final Car fordMustang = Muscle('Ford', 'Muscle');
final Car americanCar = Car(name: 'American Car', type: 'Car Car');
final FormulaOneCar scuderiaFerrari =
    FormulaOneCar(name: 'Ferrari', type: 'Open Wheel Racing');

String name = 'Rizal';

//function
String getInitialName(String value) {
  return value.substring(0, 1);
}

// void loopExample() {
//   final countUntil = 5;
//   var i = 0;

//   while (i < countUntil) {
//     i++;
//     print(i);
//   }
// }

// void loopExample2() {
//   final countUntil = 5;
//   var i = 0;

//   do {
//     i++;
//     print(i);
//   } while (i < countUntil);
// }

void loopExample3() {
  final countUntil = 5;
  var i = 0;

  for (i; i < countUntil; i++,) {
    print(i + 1);
  }
}

void loopExample4() {
  final countUntil = List.generate(5, (index) => index);
  var i = 0;

  for (i in countUntil) {
    i++;
    print(i);
  }
}

void loopExample5() {
  var daftarAngka = [1, 2, 3, 4, 5];
  daftarAngka.forEach((var num) => print(num));
}

void main() {
  // loopExample3(); //1,2,3,4,5
  // loopExample4(); //1,2,3,4,5
  // loopExample5(); //1,2,3,4,5

  fordMustang.makeSound();
  print(americanCar.name);
  scuderiaFerrari.useERS();
}
