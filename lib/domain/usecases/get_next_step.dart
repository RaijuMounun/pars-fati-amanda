import '../entities/romantic_step.dart';
import '../repositories/romantic_repository.dart';

// UseCase, tek bir iş kuralını uygular (SRP).
class GetNextStep {
  final RomanticRepository repository; // Bağımlılık Enjeksiyonu

  GetNextStep(this.repository);

  // 'call' metodu UseCase'i bir fonksiyon gibi çağırmamızı sağlar.
  Future<RomanticStep> call(int currentStepIndex) async {
    // İş mantığı (bu örnekte sadece veriyi çekiyoruz)
    return repository.getNextStep(currentStepIndex);
  }
}
