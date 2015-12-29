# react-native-pdf-view
React Native PDF View

### Installation
```bash
npm i react-native-pdf-view --save
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
