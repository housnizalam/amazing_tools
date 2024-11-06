// class Mensch {
//   String name;
//   String geschlecht;
//   int alter;
//   Mensch._(
//     this.name,
//     this.geschlecht,
//     this.alter,
//   );
//   factory Mensch.mann(
//     String name,
//     int alter,
//   ) {
//     return Mensch._(name, 'Mänlich', alter);
//   }
//   factory Mensch.frau(
//     String name,
//     int alter,
//   ) {
//     return Mensch._(name, 'Weiblich', alter);
//   }
// }

// final m = Mensch._('Max', 'Mänlich', 30);

// abstract class Mensch {
//   String name;
//   String geschlecht;
//   int alter;
//   Mensch({required this.name, required this.geschlecht, required this.alter});
// }

// class Mann extends Mensch {
//   Mann(String name, int alter) : super(name: name, geschlecht: 'Mänlich', alter: alter);
// }

// class Frau extends Mensch {
//   Frau(String name, int alter) : super(name: name, geschlecht: 'Weiblich', alter: alter);
// }

class Mensch {
  String name;
  String geschlecht;
  int alter;
  Mensch._(
    this.name,
    this.geschlecht,
    this.alter,
  );
  factory Mensch.mann(String name, int alter) {
    return Mensch._(name, 'Mänlich', alter);
  }
  factory Mensch.frau(String name, int alter) {
    {
      return Mensch._(name, 'Weiblich', alter);
    }
  }
  
}
