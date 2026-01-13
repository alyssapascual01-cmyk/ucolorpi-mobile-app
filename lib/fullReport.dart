import 'package:flutter/material.dart';
import 'mockData.dart';

class FullReportPage extends StatelessWidget {
  final UrinalysisRecord record;
  const FullReportPage({Key? key, required this.record}) : super(key: key);

  String _formatDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    // simple evaluation for display
    String status() {
      int outOfRange = 0;
      final ph = double.tryParse(record.ph) ?? 0.0;
      if (ph != 7.0) outOfRange++;
      final sg = double.tryParse(record.specificGravity) ?? 0.0;
      if (!(sg >= 1.005 && sg <= 1.030)) outOfRange++;
      final chemicals = [record.glucose, record.blood, record.ketone, record.protein, record.urobilinogen, record.bilirubin, record.leukocyte, record.nitrite];
      for (var v in chemicals) if (v.toLowerCase() != 'negative') outOfRange++;
      if (outOfRange == 0) return 'Normal';
      if (outOfRange <= 2) return 'Attention';
      return 'Abnormal';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          // small back row above the gradient (matches mock with light top area)
          SafeArea(
            child: Container(
              color: const Color(0xFFF2F2F7),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.chevron_left, color: Color(0xFF33E4DB)),
                      SizedBox(width: 6),
                      Text('Back', style: TextStyle(color: Color(0xFF33E4DB), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Gradient header
          Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)]),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('FULL REPORT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('DATE: ${_formatDate(record.date)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(generateRecordId(record, mockUrinalysisRecords), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),

          // Content (card overlaps header)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: const [
                                  Expanded(child: Text('Component', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))),
                                  Expanded(child: Text('Result', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))),
                                  Expanded(child: Text('Reference', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 6),
                              _row('Ph', record.ph, '5.0-8.0'),
                              const SizedBox(height: 8),
                              _row('Specific Gravity', record.specificGravity, '1.005-1.030'),
                              const SizedBox(height: 8),
                              _row('Glucose', record.glucose, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Blood', record.blood, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Ketone', record.ketone, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Protein', record.protein, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Urobilinogen', record.urobilinogen, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Bilirubin', record.bilirubin, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Leukocyte', record.leukocyte, 'Negative'),
                              const SizedBox(height: 8),
                              _row('Nitrite', record.nitrite, 'Negative'),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Remarks:', style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 6),
                          Text(status() == 'Normal' ? 'Overall Result Is Within Normal Range.' : 'Please consult a healthcare professional for abnormal results.'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // NOTE block
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Container(width: 6, height: 50, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8))),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: 'NOTE: ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                                  TextSpan(text: 'The Reference Column Indicates The Normal Or Expected Range For Each Urine Test Parameter.', style: TextStyle(color: Colors.black54, fontSize: 12)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    Center(
                      child: GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Download PDF not implemented'))),
                        child: Container(
                          height: 44,
                          width: 220,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF33E4DB), Color(0xFF00BBD3)]),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(color: const Color(0xFF00BBD3).withOpacity(0.18), blurRadius: 8, offset: Offset(0, 4))],
                          ),
                          child: const Center(child: Text('Download PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],      
        ),
    );
  }

  Widget _row(String label, String value, String reference) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(color: Colors.black54))),
        Expanded(child: Text(value, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(child: Text(reference, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)))
      ],
    );
  }
}
