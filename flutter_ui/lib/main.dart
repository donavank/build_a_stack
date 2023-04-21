import 'package:flutter/material.dart';
import './data/pet_repository.dart';
import './providers/web_service_provider.dart';
import './widgets/build_a_stack.dart';

void main() {
  IWebServiceProvider provider = TestProvider();
  PetRepository petRepository = PetRepository(provider);

  runApp(BuildAStack(petRepository));
}
