# react-native-pdf-view
React Native PDF View (cross-platform support)

### Breaking change

React native 0.19 changed the ReactProps class which led to problems with updating native view properties (see https://github.com/facebook/react-native/issues/5649). These errors are corrected in react-native-pdf-view version 0.2.0. Use version 0.2.* for react native >=0.19 and for earlier react native versions use version 0.1.3.

### Installation
```bash
npm i react-native-pdf-view --save
```
* In `android/setting.gradle`

```gradle
...
include ':PDFView'
project(':PDFView').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-pdf-view/android')
```

* In `android/app/build.gradle`

```gradle
...
dependencies {
    ...
    compile project(':PDFView')
}
```

* register module (in MainActivity.java)

On newer versions of React Native (0.18+):
```java
import com.keyee.pdfview.PDFView;  // <--- import

public class MainActivity extends ReactActivity {
  ......
    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
        new PDFView(), // <------ add here
        new MainReactPackage());
    }
}
```

On older versions of React Native:
```java
import com.keyee.pdfview.PDFView;  // <--- import

public class MainActivity extends Activity implements DefaultHardwareBackBtnHandler {
  ......

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    mReactRootView = new ReactRootView(this);

    mReactInstanceManager = ReactInstanceManager.builder()
      .setApplication(getApplication())
      .setBundleAssetName("index.android.bundle")
      .setJSMainModuleName("index.android")
      .addPackage(new MainReactPackage())
      .addPackage(new PDFView())              // <------ add here
      .setUseDeveloperSupport(BuildConfig.DEBUG)
      .setInitialLifecycleState(LifecycleState.RESUMED)
      .build();

    mReactRootView.startReactApplication(mReactInstanceManager, "ExampleRN", null);

    setContentView(mReactRootView);
  }

  ......

}
```

### Usage

First, require it from your app's JavaScript files with:
```bash
import PDFView from 'react-native-pdf-view';
```


### Example

```js
'use strict';

import React,{
    Component
} from 'react';

import {
    StyleSheet,
    View
} from 'react-native';

import PDFView from 'react-native-pdf-view';

export default class PDF extends Component {
    constructor(props) {
        super(props);
    }

    render(){
      <PDFView ref={(pdf)=>{this.pdfView = pdf;}}
                         src={"sdcard/pdffile.pdf"}
                         onLoadComplete = {(pageCount)=>{
                            this.pdfView.setNativeProps({
                                zoom: 1.5
                            });
                         }}
                         style={styles.pdf}/>
    }
}
var styles = StyleSheet.create({
    pdf: {
        flex:1
    }
});
```


### Configuration

| Property      | Type        	| Default 		 				| Description | iOS | Android |
| ------------- |:-------------:|:------------:				| ----------- | --- | ------- |
| path        | string 			| null 			 				| pdf absolute path| ✔   | ✔ |
| src        | string 			| null 			 				| pdf absolute path(`Deprecated`) | ✔   | ✔ |
| asset        | string 			| null 			 				| the name of a PDF file in the asset folder |   | ✔ |
| pageNumber    		  | number  	    |	1 		 				| page index | ✔   | ✔ |
| zoom 		  | number  	    |	1.0 	| zoom scale | ✔   | ✔ |
| onLoadComplete 			| function     	  | null	 			| page load complete,return page count | ✔   | ✔ |
