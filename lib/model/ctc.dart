class CommunityTaxCertificate {
  final int id;
  final String ctcNumber;
  final String dateIssue;
  final String placeIssue;
  CommunityTaxCertificate(
      {required this.id,
      required this.ctcNumber,
      required this.dateIssue,
      required this.placeIssue});

  factory CommunityTaxCertificate.fromJson(Map<String, dynamic> json) =>
      CommunityTaxCertificate(
        id: json['id'],
        ctcNumber: json['ctc_number'],
        dateIssue: json['ctc_dateissue'],
        placeIssue: json['ctc_placeissue'],
      );
}
