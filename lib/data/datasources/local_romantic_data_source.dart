import '../../domain/entities/romantic_step.dart';

// Bu, uygulamanızın tüm statik (yerel) içeriğidir.
final List<Map<String, dynamic>> _appData = [
  {
    'index': 0,
    'path': 'assets/images/Giris.jpg',
    'button': 'hoşgeldin güzelim <3',
    'header': 'hayatıma...',
  },
  {
    'index': 1,
    'path': 'assets/images/cafe.jpg',
    'button': 'her ana bayılıyorum <3',
    'header': 'seninle geçirdiğim...',
  },
  {
    'index': 2,
    'path': 'assets/images/3.jpg',
    'button': 'çok şanslıyım <3',
    'header': 'benimle olduğun için...',
  },
  {
    'index': 3,
    'path': 'assets/images/2.jpg',
    'button': 'seni tanıyabilmişim <3',
    'header': 'iyi ki...',
  },
  {
    'index': 4,
    'path': 'assets/images/4.jpg',
    'button': 'mutlu oluruz umarım <3',
    'header': 'hep böyle...',
  },
  {
    'index': 5,
    'path': 'assets/images/hediye.jpg',
    'button': 'bana en güzel hediye <3',
    'header': 'yanımda olman...',
  },
  {
    'index': 6,
    'path': 'assets/images/birlikte.jpg',
    'button': 'güzel günlere <3',
    'header': 'birlikte daha nice...',
  },
];

class LocalRomanticDataSource {
  Future<RomanticStep> getStep(int index) async {
    // 1 saniyelik gecikme ekleyerek ağdan geliyormuş hissi verelim
    //await Future.delayed(const Duration(milliseconds: 500));

    try {
      final data = _appData.firstWhere((e) => e['index'] == index);
      // Data Model'i Domain Entity'e dönüştür.
      return RomanticStep(
        stepIndex: data['index'] as int,
        assetImagePath: data['path'] as String,
        buttonText: data['button'] as String,
        headerText: data['header'] as String,
      );
    } catch (e) {
      // Hata (liste sonuna gelindiğinde)
      return const RomanticStep(
        stepIndex: 999, // Son adım
        assetImagePath: 'assets/images/end_screen.jpg',
        buttonText: 'seni seviyorum güzelim',
        headerText: 'iyi ki varsın :*',
      );
    }
  }
}
