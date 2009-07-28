/*
* Copyright 2008 Google Inc. 
* Licensed under the Apache License, Version 2.0:
*  http://www.apache.org/licenses/LICENSE-2.0
*/
package {

import com.google.maps.overlays.Marker;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;

import mx.collections.ArrayCollection;
import mx.containers.Box;
import mx.containers.HBox;
import mx.controls.Alert;
import mx.controls.Button;
import mx.controls.ComboBox;
import mx.controls.Label;
import mx.controls.TextInput;
import mx.core.UIComponent;
import mx.rpc.http.HTTPService;

/**
 * InfoWindowSprite consists of several ellipses arranged in a 'thought bubble'
 * manner, the largest of which contains an embedded image and a circular
 * close button.
 * It can dispatch an Event instance (type: "close"), which the user can listen
 * for and use to call map.closeInfoWindow();
 */
public class InfoWindowTabbedComponent extends UIComponent {
              
  public var textInputName:TextInput;
  public var textInputAddress:TextInput;
  public var comboBoxType:ComboBox;
  public var marker:Marker;
  
  public function InfoWindowTabbedComponent(m:Marker) {    
  	marker = m;
  	
  	var panel:Box = new Box();
  	panel.width = 290;
  	panel.height = 140;
  	panel.setStyle("backgroundColor", "#333333");
  	
  	var hbox:HBox = new HBox();
  	var labelName:Label = new Label();
  	labelName.text = "Name: ";
  	labelName.width = 70;
  	textInputName = new TextInput();
  	textInputName.id = "name";
  	textInputName.percentWidth = 100;
  	textInputName.text = "bla bla";
  	
  	hbox.addChild(labelName);
  	hbox.addChild(textInputName);
  	
  	var hbox3:HBox = new HBox();
  	var labelAddress:Label = new Label();
  	labelAddress.text = "Address: ";
  	labelAddress.width = 70;
  	textInputAddress = new TextInput();
  	textInputAddress.id = "address";
  	textInputAddress.percentWidth = 100;
  	textInputAddress.text = "bli bli";
  
  	hbox3.addChild(labelAddress);
  	hbox3.addChild(textInputAddress);
  	
  	var hbox2:HBox = new HBox();
  	var labelType:Label = new Label();
  	labelType.text = "Type: ";
  	labelType.width = 70;
  	comboBoxType = new ComboBox();
  	comboBoxType.id = "type";
  	comboBoxType.dataProvider = new ArrayCollection(
                [ {label:"Kantor Pemerintah", data:"Kantor Pemerintah"}, 
                  {label:"Rumah Makan", data:"Rumah Makan"},
                  {label:"Universitas", data:"Universitas"},
                  {label:"Bank", data:"Bank"},
                  {label:"Toko/Mall", data:"Toko/Mall"},
                  {label:"Pasar/Market", data:"Pasar/Market"},
                  {label:"Rumah Penduduk", data:"Rumah Penduduk"},
                  {label:"Lain-Lain", data:"Lain-Lain"}]);
  	hbox2.addChild(labelType);
  	hbox2.addChild(comboBoxType);
  	
  	var button:Button = new Button();
  	button.label = "Submit";
  	button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
      saveData();
  	});
  	
  	panel.addChild(hbox);
  	panel.addChild(hbox3);
  	panel.addChild(hbox2);
  	panel.addChild(button);
  	addChild(panel);
  	
  }
 
  public function saveData():void {
    var name:String = textInputName.text;
    var address:String = textInputAddress.text;
    var type:String = comboBoxType.text;
    var lat:Number = marker.getLatLng().lat();
    var lng:Number = marker.getLatLng().lng();
    var urlRequest:URLRequest = new URLRequest("http://localhost/GoogleMaps-debug/add_row.php");
    urlRequest.data = "name=" + name + "&address=" + address + "&type=" + type + "&lat=" + lat + "&lng=" + lng;
    urlRequest.method = URLRequestMethod.POST;
    var urlLoader:URLLoader = new URLLoader(urlRequest);
    urlLoader.addEventListener("complete", function(e:Event):void {
       if (urlLoader.data.length <= 1) {
         Alert.show("Successfully added!");
         marker.closeInfoWindow();
       } else {
       	 Alert.show("There was an error adding the data :(");
       }
    });
  } 
  

}

}
