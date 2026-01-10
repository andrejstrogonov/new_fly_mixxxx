import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/audio_provider.dart';
import 'dart:math' as math;

class FrequencyResponseWidget extends StatefulWidget {
  const FrequencyResponseWidget({super.key});

  @override
  State<FrequencyResponseWidget> createState() => _FrequencyResponseWidgetState();
}

class _FrequencyResponseWidgetState extends State<FrequencyResponseWidget> {
  int _selectedTab = 0;
  final List<String> _tabs = ['АЧХ', 'ФЧХ', 'ЛАЧХ', 'ЛФЧХ'];

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Frequency Response Analysis',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton<int>(
                    value: _selectedTab,
                    dropdownColor: const Color(0xFF2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    items: _tabs.asMap().entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTab = value ?? 0;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: _buildChart(audioProvider),
              ),
              const SizedBox(height: 16),
              _buildLegend(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChart(AudioProvider audioProvider) {
    final frequencies = [20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000];
    
    switch (_selectedTab) {
      case 0: // АЧХ (Amplitude-Frequency Response)
        return _buildAmplitudeChart(audioProvider, frequencies);
      case 1: // ФЧХ (Phase-Frequency Response)
        return _buildPhaseChart(audioProvider, frequencies);
      case 2: // ЛАЧХ (Logarithmic Amplitude-Frequency Response)
        return _buildLogAmplitudeChart(audioProvider, frequencies);
      case 3: // ЛФЧХ (Logarithmic Phase-Frequency Response)
        return _buildLogPhaseChart(audioProvider, frequencies);
      default:
        return _buildAmplitudeChart(audioProvider, frequencies);
    }
  }

  Widget _buildAmplitudeChart(AudioProvider audioProvider, List<int> frequencies) {
    final magnitudes = audioProvider.calculateFrequencyResponse(frequencies);
    final spots = frequencies.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), magnitudes[entry.key]);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < frequencies.length) {
                  return Text(
                    '${frequencies[value.toInt()]}Hz',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(1)}dB',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.deepPurple,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.deepPurple,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
        minY: -15,
        maxY: 15,
      ),
    );
  }

  Widget _buildPhaseChart(AudioProvider audioProvider, List<int> frequencies) {
    final phases = audioProvider.calculatePhaseResponse(frequencies);
    final spots = frequencies.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), phases[entry.key]);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < frequencies.length) {
                  return Text(
                    '${frequencies[value.toInt()]}Hz',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(0)}°',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
        minY: -180,
        maxY: 180,
      ),
    );
  }

  Widget _buildLogAmplitudeChart(AudioProvider audioProvider, List<int> frequencies) {
    final magnitudes = audioProvider.calculateFrequencyResponse(frequencies);
    final spots = frequencies.asMap().entries.map((entry) {
      final logFreq = math.log(frequencies[entry.key]) / math.ln10;
      return FlSpot(logFreq, magnitudes[entry.key]);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final freq = math.pow(10, value).round();
                return Text(
                  '${freq}Hz',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(1)}dB',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
        minY: -15,
        maxY: 15,
      ),
    );
  }

  Widget _buildLogPhaseChart(AudioProvider audioProvider, List<int> frequencies) {
    final phases = audioProvider.calculatePhaseResponse(frequencies);
    final spots = frequencies.asMap().entries.map((entry) {
      final logFreq = math.log(frequencies[entry.key]) / math.ln10;
      return FlSpot(logFreq, phases[entry.key]);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final freq = math.pow(10, value).round();
                return Text(
                  '${freq}Hz',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(0)}°',
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
        minY: -180,
        maxY: 180,
      ),
    );
  }

  Widget _buildLegend() {
    final legends = [
      {'color': Colors.deepPurple, 'label': 'АЧХ - Amplitude Response'},
      {'color': Colors.orange, 'label': 'ФЧХ - Phase Response'},
      {'color': Colors.green, 'label': 'ЛАЧХ - Log Amplitude'},
      {'color': Colors.red, 'label': 'ЛФЧХ - Log Phase'},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: legends.map((legend) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: legend['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              legend['label'] as String,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}