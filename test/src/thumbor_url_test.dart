import 'package:test/test.dart';
import 'package:thumbor/src/thumbor_url.dart';

void main() {
  test('creates an instance of ThumborUrl with just the hostname', () {
    var thumborUrl = new ThumborUrl(
        host: "hostname",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg");

    expect(thumborUrl.host, "hostname");
    expect(thumborUrl.key, isNull);
    expect(
      thumborUrl.imageUrl,
      "http://images.google.com/im-feeling-lucky.jpg",
    );
  });

  test('creates an unsafe instance of ThumborUrl and gets the url', () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg");

    expect(thumborUrl.toUrl(),
        "http://thumbor.example.com/unsafe/http://images.google.com/im-feeling-lucky.jpg");
  });

  test('creates an unsafe instance of ThumborUrl and gets the unsafe url', () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg");

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/http://images.google.com/im-feeling-lucky.jpg");
  });

  test('creates a safe instance of ThumborUrl and gets the url', () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        key: "1234567890",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg");

    expect(thumborUrl.toUrl(),
        "http://thumbor.example.com/qZKaZJPvUX-spYpawhsBv320rmA=/http://images.google.com/im-feeling-lucky.jpg");
  });

  test('creates a safe instance of ThumborUrl then gets the safe url', () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        key: "1234567890",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg");

    expect(thumborUrl.toSafeUrl(),
        "http://thumbor.example.com/qZKaZJPvUX-spYpawhsBv320rmA=/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with trim and gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..trim();

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/trim/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with trim and orientation and gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..trim(orientation: TrimOrientation.bottomRight);
    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/trim:bottom-right/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with trim, orientation and tolerance then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..trim(orientation: TrimOrientation.bottomRight, tolerance: 155);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/trim:bottom-right:155/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a crop then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..crop(1, 2, 3, 4);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/2x1:4x3/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300x200/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a resize and an original height then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: ThumborUrl.ORIGINAL_SIZE, width: 300);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300xorig/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a resize and an original width then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: ThumborUrl.ORIGINAL_SIZE);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/origx200/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a resize horizontal flip then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..flipHorizontally();

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/-300x200/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a resize vertical flip then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..flipVertically();

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300x-200/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a smart resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..smart();

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300x200/smart/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a horizontal align resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..horizontalAlign(HorizontalAlignment.right);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300x200/right/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a vertical align resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..verticalAlign(VerticalAlignment.middle);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300x200/middle/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a vertical and horizontal align resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..horizontalAlign(HorizontalAlignment.right)
      ..verticalAlign(VerticalAlignment.middle);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/300x200/right/middle/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a vertical and horizontal align resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..fitIn(FitInStyle.adaptive);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/adaptive-fit-in/300x200/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a vertical and horizontal align resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..fitIn(FitInStyle.normal);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/fit-in/300x200/http://images.google.com/im-feeling-lucky.jpg");
  });

  test(
      'creates an unsafe instance of ThumborUrl with a vertical and horizontal align resize then gets the unsafe url',
      () {
    var thumborUrl = new ThumborUrl(
        host: "http://thumbor.example.com/",
        imageUrl: "http://images.google.com/im-feeling-lucky.jpg")
      ..resize(height: 200, width: 300)
      ..fitIn(FitInStyle.full);

    expect(thumborUrl.toUnsafeUrl(),
        "http://thumbor.example.com/unsafe/full-fit-in/300x200/http://images.google.com/im-feeling-lucky.jpg");
  });
}
