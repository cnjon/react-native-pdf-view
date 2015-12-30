# react-native-pdf-view
React Native PDF View (Android Only)


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
    Component,
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
                         onLoadComplete = {()=>{
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

| Property      | Type        	| Default 		 				| Description |
| ------------- |:-------------:|:------------:				| ----------- |
| src        | string 			| null 			 				| pdf absolute path
| pageNumber    		  | number  	    |	1 		 				| page index
| zoom 		  | number  	    |	1.0 	| zoom scale
| onLoadComplete 			| function     	  | null	 			| page load complete
