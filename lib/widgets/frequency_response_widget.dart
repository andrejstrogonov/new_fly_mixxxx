import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import '../providers/audio_provider.dart';

class FrequencyResponseWidget extends StatelessWidget {
  const FrequencyResponseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        // Generate frequency points for visualization (logarithmic scale)
        List<int> frequencies = _generateFrequencies();
        List<double> magnitudes = audioProvider.calculateFrequencyResponse(frequencies);
        List<double> phases = audioProvider.calculatePhaseResponse(frequencies);

        return DefaultTabController(
          length: 3,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Frequency Response (АЧХ & ФЧХ & Диаграмма Боде)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                TabBar(
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.deepPurple,
                  tabs: const [
                    Tab(text: 'АЧХ (Амплитуда)'),
                    Tab(text: 'ФЧХ (Фаза)'),
                    Tab(text: 'Диаграмма Боде'),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      // АЧХ
                      _buildAchxChart(frequencies, magnitudes),
                      // ФЧХ
                      _buildPhchxChart(frequencies, phases),
                      // Диаграмма Боде
                      _buildBodeChart(frequencies, magnitudes, phases),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<int> _generateFrequencies() {
    // Generate logarithmically spaced frequencies from 20Hz to 20kHz
    List<int> frequencies = [];
    double logMin = log(20.0) / log(10.0);  // log10(20)
    double logMax = log(20000.0) / log(10.0);  // log10(20000)
    int points = 50;

    for (int i = 0; i < points; i++) {
      double logFreq = logMin + (logMax - logMin) * (i / (points - 1));
      double freq = pow(10.0, logFreq).toDouble();
      frequencies.add(freq.toInt());
    }

    return frequencies;
  }

  Widget _buildAchxChart(List<int> frequencies, List<double> magnitudes) {
    // Normalize frequencies to 0-100 scale for chart
    List<FlSpot> spots = [];
    for (int i = 0; i < frequencies.length; i++) {
      double x = i.toDouble();
      double y = magnitudes[i].clamp(-12.0, 12.0);
      spots.add(FlSpot(x, y));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amplitude Frequency Response (АЧХ)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 4,
                  verticalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const labels = ['20Hz', '100Hz', '1kHz', '10kHz', '20kHz'];
                        int index = value ~/ 10;
                        if (index >= 0 && index < labels.length) {
                          return Text(
                            labels[index],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}dB',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.deepPurple.withOpacity(0.3),
                  ),
                ),
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: -12,
                maxY: 12,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.deepPurple,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.deepPurple.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhchxChart(List<int> frequencies, List<double> phases) {
    // Normalize phases to chart scale
    List<FlSpot> spots = [];
    for (int i = 0; i < frequencies.length; i++) {
      double x = i.toDouble();
      double y = phases[i].clamp(-180.0, 180.0);
      spots.add(FlSpot(x, y));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phase Frequency Response (ФЧХ)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 60,
                  verticalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const labels = ['20Hz', '100Hz', '1kHz', '10kHz', '20kHz'];
                        int index = value ~/ 10;
                        if (index >= 0 && index < labels.length) {
                          return Text(
                            labels[index],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}°',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.cyan.withOpacity(0.3),
                  ),
                ),
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: -180,
                maxY: 180,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.cyan,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.cyan.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodeChart(List<int> frequencies, List<double> magnitudes, List<double> phases) {
    // Create Bode diagram data points
    List<FlSpot> magnitudeSpots = [];
    List<FlSpot> phaseSpots = [];

    for (int i = 0; i < frequencies.length; i++) {
      double freqLog = log(frequencies[i].toDouble()) / log(10.0);  // log10(frequency)
      double magnitude = magnitudes[i].clamp(-12.0, 12.0);
      double phase = phases[i].clamp(-180.0, 180.0);

      magnitudeSpots.add(FlSpot(freqLog, magnitude));
      phaseSpots.add(FlSpot(freqLog, phase));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Диаграмма Боде (ЛФЧХ) - Логарифмическая частотная характеристика',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              children: [
                // Амплитудная характеристика Боде
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurple.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 4,
                          verticalInterval: 0.5,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.2),
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            if (value == 1.3 || value == 2.0 || value == 3.0 || value == 4.3) {
                              return FlLine(
                                color: Colors.grey.withOpacity(0.3),
                                strokeWidth: 1,
                              );
                            }
                            return FlLine(
                              color: Colors.grey.withOpacity(0.15),
                              strokeWidth: 0.5,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                final logLabels = {
                                  '1.3': '20Hz',
                                  '2.0': '100Hz',
                                  '3.0': '1kHz',
                                  '4.0': '10kHz',
                                  '4.3': '20kHz',
                                };
                                final key = value.toStringAsFixed(1);
                                if (logLabels.containsKey(key)) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      logLabels[key] ?? '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}dB',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.deepPurple.withOpacity(0.3),
                          ),
                        ),
                        minX: 1.0,
                        maxX: 4.5,
                        minY: -12,
                        maxY: 12,
                        lineBarsData: [
                          LineChartBarData(
                            spots: magnitudeSpots,
                            isCurved: true,
                            color: Colors.deepPurple,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.deepPurple.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Фазовая характеристика Боде
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 60,
                          verticalInterval: 0.5,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.2),
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            if (value == 1.3 || value == 2.0 || value == 3.0 || value == 4.3) {
                              return FlLine(
                                color: Colors.grey.withOpacity(0.3),
                                strokeWidth: 1,
                              );
                            }
                            return FlLine(
                              color: Colors.grey.withOpacity(0.15),
                              strokeWidth: 0.5,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                final logLabels = {
                                  '1.3': '20Hz',
                                  '2.0': '100Hz',
                                  '3.0': '1kHz',
                                  '4.0': '10kHz',
                                  '4.3': '20kHz',
                                };
                                final key = value.toStringAsFixed(1);
                                if (logLabels.containsKey(key)) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      logLabels[key] ?? '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}°',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors.cyan.withOpacity(0.3),
                          ),
                        ),
                        minX: 1.0,
                        maxX: 4.5,
                        minY: -180,
                        maxY: 180,
                        lineBarsData: [
                          LineChartBarData(
                            spots: phaseSpots,
                            isCurved: true,
                            color: Colors.cyan,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.cyan.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

