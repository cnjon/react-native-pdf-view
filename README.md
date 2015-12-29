# react-native-pdf-view
React Native PDF View

![react-native-action-button demo](http://i.giphy.com/26BkMir9IcAhqe4EM.gif)

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
| src        | boolean 			| false 			 				| action buttons visible or not
| type    		  | string  	    |	"float" 		 				| either `float` (bigger btns) or `tab` (smaller btns) + position changes
| position 		  | string  	    |	"right" / "center" 	| one of: `left` `center` and `right`
| bgColor 			| string     	  | "transparent"	 			| background color when ActionButtons are visible
| buttonColor		| string     	  | "rgba(0,0,0,1)"			| background color of the +Button **(must be rgba value!)**
| spacing				| number 	   	  | 20									| spacing between the `ActionButton.Item`s
| offsetX				| number 	   	  | 10 / 30							| offset to the sides of the screen
| offsetY       | number        | 4 / 30              | offset to the bottom of the screen
| btnOutRange   | string        | props.buttonColor   | button background color to animate to
| outRangeScale | number 	   	  | 1	                	| changes size of button during animation
