# How to compile and run for WebOS

* Build Flutter web app in release mode:
```shell
flutter build web --release
```

* Copy the contents of the `build/web` folder to the `webos` folder.

* Edit href in the index.html file:

```html
<base href="./">
...
```

* Run the `webos` folder in WebOS Simulator.