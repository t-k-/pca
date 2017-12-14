## Source code description
To run our code, you need to
* unzip train-images-idx3-ubyte.gz and train-labels-idx1-ubyte.gz
* unzip AT&T image data into `att_faces/`
* unzip non-face-data-20171214T041035Z-001.zip into non-face-data/

## How to run code
For each task, run the corresponding .m main file as shown below.

### 1. Face detection (test if it is face or not)
Using PCA + Linear regression: `face_detection.m`
Using CNN: `face_detection_cnn.m`

### 2. Face recognition (test if it is a known face or not)
Using PCA + Linear regression: `att_faces_recognition.m`
Using CNN: `face_recognition_cnn.m`

### 3. Face identification (to guess who he/she is)
Using PCA + Linear regression: `att_faces.m`
Using BP Neural Network: `bpnn.m`
Using CNN: `cnn.m`

### Reproducibility
Since CNN may initialize different weight each time, you may not get the stated accuracy.
To reproduce our result, you can use the saved net weight using load function and comment trainNetwork function like below:
```
% net = trainNetwork(train_data, train_label, layers, options);
load('best_recognition_net')
```
