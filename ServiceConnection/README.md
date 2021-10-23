
```Dart
String serviceAddress = 'https://my-json-server.typicode.com/typicode/demo/posts/1';
Uri serviceUri = Uri.parse(serviceAddress);

HttpClientRequest request = await HttpClient().getUrl(serviceUri);
HttpClientResponse response = await request.close();
String stringData = await response.transform(Utf8Decoder()).join();
Map jsonObject = jsonDecode(stringData);

this.post = PostModal.fromJson(jsonObject);
```
