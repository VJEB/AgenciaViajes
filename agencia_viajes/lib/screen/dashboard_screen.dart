// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Dashboards extends StatelessWidget {
  const Dashboards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Grafico")
                // child: LineChart(
                //   LineChartData(
                //       // Data for the line chart
                //       ),
                // ),
                ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Grafico")
                // child: BarChart(
                //   BarChartData(
                //       // Data for the bar chart
                //       ),
                // ),
                ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Grafico")

                // child: PieChart(
                //   PieChartData(
                //       // Data for the pie chart
                //       ),
                // ),
                ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Grafico")
                // child: ScatterChart(
                //   ScatterChartData(
                //       // Data for the scatter chart
                //       ),
                // ),
                ),
          ),
        ],
      ),
    );
  }
}
