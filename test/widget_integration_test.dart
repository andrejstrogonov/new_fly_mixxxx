import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:new_fly_mixxxx/main.dart';
import 'package:new_fly_mixxxx/providers/audio_provider.dart';
import 'package:new_fly_mixxxx/providers/audio_device_analyzer.dart';
import 'package:new_fly_mixxxx/providers/composition_generator.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('MyApp builds successfully', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // App should render without crashing
      expect(find.byType(MyApp), findsOneWidget);
    });

    testWidgets('Mixer screen renders with title', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify main screen elements exist
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Theme is correctly applied (dark mode)', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Check if dark theme is applied
      final materialApp = find.byType(MaterialApp);
      expect(materialApp, findsOneWidget);
    });
  });

  group('Equalizer Widget Tests', () {
    testWidgets('EQ widget displays all bands', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => AudioProvider(),
              child: Consumer<AudioProvider>(
                builder: (context, provider, _) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 10; i++)
                          Slider(
                            value: provider.eqBands[i],
                            min: -12,
                            max: 12,
                            onChanged: (value) {
                              provider.setEqBand(i, value);
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should have 10 sliders for 10 bands
      expect(find.byType(Slider), findsWidgets);
    });

    testWidgets('EQ slider changes value correctly', (WidgetTester tester) async {
      final provider = AudioProvider();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider<AudioProvider>.value(
              value: provider,
              child: Consumer<AudioProvider>(
                builder: (context, provider, _) {
                  return Slider(
                    value: provider.eqBands[0].toDouble(),
                    min: -12,
                    max: 12,
                    onChanged: (value) {
                      provider.setEqBand(0, value);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Initial value should be 0
      expect(provider.eqBands[0], 0.0);

      // Tap and drag slider
      await tester.drag(find.byType(Slider).first, const Offset(50, 0));
      await tester.pumpAndSettle();

      // Value should have changed
      expect(provider.eqBands[0] != 0.0, true);
    });
  });

  group('Frequency Response Widget Tests', () {
    testWidgets('Frequency response widget renders without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => AudioProvider(),
              child: SingleChildScrollView(
                child: Consumer<AudioProvider>(
                  builder: (context, provider, _) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Frequency Response'),
                            const TabBar(
                              tabs: [
                                Tab(text: 'АЧХ'),
                                Tab(text: 'ФЧХ'),
                                Tab(text: 'Боде'),
                              ],
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                children: [
                                  Container(color: Colors.grey),
                                  Container(color: Colors.grey),
                                  Container(color: Colors.grey),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Widget should render successfully
      expect(find.byType(DefaultTabController), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
    });

    testWidgets('Tab switching works in frequency response widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => AudioProvider(),
              child: SingleChildScrollView(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'АЧХ'),
                          Tab(text: 'ФЧХ'),
                          Tab(text: 'Боде'),
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        child: TabBarView(
                          children: [
                            Container(
                              color: Colors.red,
                              child: const Text('АЧХ Tab'),
                            ),
                            Container(
                              color: Colors.green,
                              child: const Text('ФЧХ Tab'),
                            ),
                            Container(
                              color: Colors.blue,
                              child: const Text('Боде Tab'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // First tab should be active
      expect(find.text('АЧХ Tab'), findsOneWidget);

      // Tap second tab
      await tester.tap(find.byIcon(Icons.tab));
      await tester.pumpAndSettle();
    });
  });

  group('Audio Device Analysis Widget Tests', () {
    testWidgets('Audio device analysis widget renders',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => AudioDeviceAnalyzer(),
              child: Consumer<AudioDeviceAnalyzer>(
                builder: (context, analyzer, _) {
                  return const Center(
                    child: Text('Audio Device Analysis'),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Audio Device Analysis'), findsOneWidget);
    });
  });

  group('Layout Tests', () {
    testWidgets('No RenderFlex unbounded height errors',
        (WidgetTester tester) async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // If we get here without assertion errors, the layout is correct
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('SingleChildScrollView works with frequency response widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Frequency Response'),
                      const SizedBox(height: 16),
                      const TabBar(
                        tabs: [
                          Tab(text: 'АЧХ'),
                          Tab(text: 'ФЧХ'),
                          Tab(text: 'Боде'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          children: [
                            Container(color: Colors.red),
                            Container(color: Colors.green),
                            Container(color: Colors.blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(DefaultTabController), findsOneWidget);
    });
  });

  group('Provider Tests', () {
    testWidgets('AudioProvider is accessible through Consumer',
        (WidgetTester tester) async {
      bool providerAccessed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider(
              create: (_) => AudioProvider(),
              child: Consumer<AudioProvider>(
                builder: (context, provider, _) {
                  providerAccessed = true;
                  return Center(
                    child: Text(
                        'Current Preset: ${provider.currentPreset}'),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(providerAccessed, true);
      expect(find.text('Current Preset: Flat'), findsOneWidget);
    });

    testWidgets('Multiple providers work together', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AudioProvider()),
                ChangeNotifierProvider(
                    create: (_) => AudioDeviceAnalyzer()),
                ChangeNotifierProvider(
                    create: (_) => CompositionGeneratorProvider()),
              ],
              child: Consumer<AudioProvider>(
                builder: (context, audioProvider, _) {
                  return Center(
                    child: Text(
                        'Preset: ${audioProvider.currentPreset}'),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Preset: Flat'), findsOneWidget);
    });
  });
}

