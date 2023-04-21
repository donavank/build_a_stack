import '../data/pet.dart';

abstract class IWebServiceProvider {
  Future<List<String>> getNames();
  Future<Pet?> getPet(String name);
}

class WebServiceProvider implements IWebServiceProvider {
  String petsUrl = "https://localhost:8080/pets";
  late Uri serviceUri;

  WebServiceProvider() {
    serviceUri = Uri.parse( petsUrl );
  }

  @override
  Future<List<String>> getNames() {
    // TODO: implement getNames
    throw UnimplementedError();
  }

  @override
  Future<Pet?> getPet(String name) {
    // TODO: implement getPet
    throw UnimplementedError();
  }
}

class TestProvider implements IWebServiceProvider {
  List<String> namesList = ["Merlin"]; //"Mia", "Finnley", "Gaea", "Kisses", "Tye"];
  Map<String, Pet> petsMap = {"Merlin": Pet("Merlin", "Dog", "Mixed Bread")}; //"Mia": Pet(), "Finnley": Pet(), "Gaea": Pet(), "Kisses": Pet(), "Tye": Pet() };

  @override
  Future<List<String>> getNames() {
    return Future.delayed(const Duration(milliseconds: 500), () => namesList);
  }

  @override
  Future<Pet?> getPet(String name) {
    return Future.delayed(const Duration(milliseconds: 500), () => petsMap[name] );
  }

}