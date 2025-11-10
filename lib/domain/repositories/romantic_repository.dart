import '../entities/romantic_step.dart';

// Repository, dış veri kaynaklarıyla (Data Source) etkileşimi soyutlar.
abstract class RomanticRepository {
  // UseCase, bu metodu kullanarak bir sonraki adımı isteyecektir.
  Future<RomanticStep> getNextStep(int currentStepIndex);
}
