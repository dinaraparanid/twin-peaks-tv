# How to compile and run for WebOS

* Ensure you are on official channel (e.g. stable):
```shell
flutter channel stable
```

* Build Flutter web app:
```shell
flutter build web --release # code will be minfied
flutter build web --profile # code will not be minified (for debug only)
```

* Copy the contents of the `build/web` folder to the `webos` folder.

* Edit href in the index.html file:

```html
<base href="./">
...
```

* Run the `webos` folder in WebOS Simulator.