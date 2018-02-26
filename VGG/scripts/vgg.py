# -*- coding: utf-8 -*-



import tflearn
from tflearn.layers.core import input_data, dropout, fully_connected
from tflearn.layers.conv import conv_2d, max_pool_2d
from tflearn.layers.normalization import local_response_normalization
from tflearn.layers.estimator import regression

# Load path/class_id image file train:
dataset_file = '/home/marco/Desktop/tp4_mb/data/train.txt'

# Load path/class_id image file validate:
dataset_file_validate = '/home/marco/Desktop/tp4_mb/data/validate.txt'

# Load path/class_id image file test:
dataset_file_test = '/home/marco/Desktop/tp4_mb/data/test.txt'

# Build the preloader array, resize images to 64x64
from tflearn.data_utils import image_preloader
X, Y = image_preloader(dataset_file, image_shape=(64, 64),   mode='file', categorical_labels=True,   normalize=True, files_extension= ['jpg', 'png'])

# Build the preloader array, resize images to 64x64

X_validate, Y_validate = image_preloader(dataset_file_validate, image_shape=(64, 64),   mode='file', categorical_labels=True,   normalize=True)

# Build the preloader array, resize images to 64x64

X_test, Y_test = image_preloader(dataset_file_test, image_shape=(64, 64),   mode='file', categorical_labels=True,   normalize=True)

# Building 'VGG Network'
network = input_data(shape=[None, 64, 64, 3])

network = conv_2d(network, 64, 3, activation='relu')
network = conv_2d(network, 64, 3, activation='relu')
network = max_pool_2d(network, 2, strides=2)

network = conv_2d(network, 128, 3, activation='relu')
network = conv_2d(network, 128, 3, activation='relu')
network = max_pool_2d(network, 2, strides=2)

network = conv_2d(network, 256, 3, activation='relu')
network = conv_2d(network, 256, 3, activation='relu')
network = conv_2d(network, 256, 3, activation='relu')
network = max_pool_2d(network, 2, strides=2)

network = conv_2d(network, 512, 3, activation='relu')
network = conv_2d(network, 512, 3, activation='relu')
network = conv_2d(network, 512, 3, activation='relu')
network = max_pool_2d(network, 2, strides=2)

network = conv_2d(network, 512, 3, activation='relu')
network = conv_2d(network, 512, 3, activation='relu')
network = conv_2d(network, 512, 3, activation='relu')
network = max_pool_2d(network, 2, strides=2)

network = fully_connected(network, 4096, activation='relu')
network = dropout(network, 0.5)
network = fully_connected(network, 4096, activation='relu')
network = dropout(network, 0.5)
network = fully_connected(network, 4, activation='softmax')

network = regression(network, optimizer='rmsprop',
                     loss='categorical_crossentropy',
                     learning_rate=0.0001)

# Training
model = tflearn.DNN(network, checkpoint_path='/tmp/tflearn_logs/model_vgg',
                    max_checkpoints=1, tensorboard_verbose=3, tensorboard_dir='/tmp/tflearn_logs')
model.fit(X, Y, n_epoch=10, validation_set=(X_validate, Y_validate), shuffle=True,
          show_metric=True, batch_size=32, snapshot_step=10,
          snapshot_epoch=False, run_id='vgg_face10')

fw = open('predictionTestepoch20.txt', 'w')

model.save('model1.tfl')

# Evaluate model
score = model.evaluate(X_test, Y_test)
print('Test accuarcy of score: %0.4f%%' % (score[0] * 100))

# # Run the model on one example
prediction = model.predict(X_test)
print("Prediction of image of test: %s" % str(prediction))

fw.write("%s\n" % prediction)

longueur = len(prediction)
print("length of test: %f" % longueur)
