/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades.multimedia 1.0
import bb.cascades 1.2

Page{
    onCreationCompleted: {
        camera.open();        
    }
    Container {
        //Todo: fill me with QML
        Label {
            // Localized text with the dynamic translation and locale updates support
            id: m_label
            text: "Please toggle camera ON in ScriptMode"
            multiline: true
            objectName: "m_label"
        }
        Camera {
            id: camera            
            objectName: "m_camera"
            visible: false
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            attachedObjects: [
                BarcodeDetector {
                    id: barcodeDetector    
                    formats: BarcodeFormat.Any
                    camera: camera
                    onDetected: {
                        m_label.text = "Your barcode returned: \n\n" + data + "\n\nYou can restart another request with ScriptMode";
                        _app.sendToWatch(data, format);
                        camera.stopViewfinder();
                        camera.close();
                        camera.visible = false;
                    }
                }
            ]            
        }
    }
}
