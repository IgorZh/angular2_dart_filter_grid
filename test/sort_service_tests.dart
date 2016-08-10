import "package:test/test.dart";

import 'package:angular2_dart_filter_grid/sort_service.dart';
import 'package:angular2_dart_filter_grid/sort_request.dart';

void main() {
  group("String", ()
  {
    var sortService = new SortService<SortModel>();
    var rows = <SortModel>[
      new SortModel('Darth Vader'),
      new SortModel('Luke Skywalker'),
      new SortModel('Han Solo'),
      new SortModel(null)
    ];

    test("SortService.Sort() null values asc", () async {

      var request = <SortRequest<SortModel, String>>[
        new SortRequest((r) => r.name, 1)];

      sortService.sort(request, rows);

      expect(rows.first.name, equals(null));
    });

    test("SortService.Sort() null values desc", () async {

      var request = <SortRequest<SortModel, String>>[
        new SortRequest((r) => r.name, -1)];

      sortService.sort(request, rows);

      expect(rows.last.name, equals(null));
    });
  });
}

class SortModel {
  String name;

  SortModel(this.name);
}