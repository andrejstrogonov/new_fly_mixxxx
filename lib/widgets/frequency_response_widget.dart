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

        return Container(
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
                'Frequency Response (АЧХ & ФЧХ)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Amplitude Frequency Response (АЧХ)
              _buildAchxChart(frequencies, magnitudes),
              const SizedBox(height: 24),
              // Phase Frequency Response (ФЧХ)
              _buildPhchxChart(frequencies, phases),
            ],
          ),
        );
      },
    );
  }

  List<int> _generateFrequencies() {
    // Generate logarithmically spaced frequencies from 20Hz to 20kHz
    List<int> frequencies = [];
    double logMin = 20.0;
    double logMax = 20000.0;
    int points = 50;

    for (int i = 0; i < points; i++) {
      double logFreq = logMin + (logMax - logMin) * (i / (points - 1));
      double exponent = log(logFreq) / log(10.0);
      double freq = pow(10.0, exponent).toDouble();
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
}
