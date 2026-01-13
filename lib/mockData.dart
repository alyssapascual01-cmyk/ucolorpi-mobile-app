
class UrinalysisRecord {
  final String id;
  final DateTime date;

  final String ph;
  final String specificGravity;
  final String glucose;
  final String blood;
  final String ketone;
  final String protein;
  final String urobilinogen;
  final String bilirubin;
  final String leukocyte;
  final String nitrite;

  UrinalysisRecord({
    required this.id,
    required this.date,
    required this.ph,
    required this.specificGravity,
    required this.glucose,
    required this.blood,
    required this.ketone,
    required this.protein,
    required this.urobilinogen,
    required this.bilirubin,
    required this.leukocyte,
    required this.nitrite,
  });
}

// ---------------- MOCK RECORDS LIST ----------------

final List<UrinalysisRecord> mockUrinalysisRecords = [
  // 🔹 Record 1 (Normal)
  UrinalysisRecord(
    id: "UCP-2026-0001",
    date: DateTime(2025, 10, 28),

    ph: "7.0",
    specificGravity: "1.010",
    glucose: "Negative",
    blood: "Negative",
    ketone: "Negative",
    protein: "Negative",
    urobilinogen: "Negative",
    bilirubin: "Negative",
    leukocyte: "Negative",
    nitrite: "Negative",
  ),

  // 🔹 Record 2 (With abnormalities – sample)
  UrinalysisRecord(
    id: "UCP-2026-0002",
    date: DateTime(2025, 11, 05),

    ph: "7.5",
    specificGravity: "1.030",
    glucose: "Positive",
    blood: "Trace",
    ketone: "Negative",
    protein: "Negative",
    urobilinogen: "Negative",
    bilirubin: "Negative",
    leukocyte: "Negative",
    nitrite: "Negative",
  ),

  UrinalysisRecord(
    id: "UCP-2026-0003",
    date: DateTime(2025, 12, 05),

    ph: "7.2",
    specificGravity: "1.030",
    glucose: "Positive",
    blood: "Trace",
    ketone: "Negative",
    protein: "Negative",
    urobilinogen: "Negative",
    bilirubin: "Negative",
    leukocyte: "Negative",
    nitrite: "Negative",
  ),
];

// Generates a UCP ID based on the record's year and its sequence number
// within allRecords for that year. Format: UCP-<YYYY>-<NNNN> (zero-padded).
String generateRecordId(UrinalysisRecord record, List<UrinalysisRecord> allRecords) {
  final year = record.date.year;
  // Filter records with the same year and sort by date ascending
  final sameYear = allRecords.where((r) => r.date.year == year).toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  // Find the index of this record among same-year records
  final idx = sameYear.indexWhere((r) => identical(r, record) || (r.date == record.date && r.id == record.id));
  final seq = (idx >= 0) ? (idx + 1) : 1;
  final seqStr = seq.toString().padLeft(4, '0');
  return 'UCP-$year-$seqStr';
}
