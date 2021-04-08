# Hellow Worlds of superhenrikkes worlds


### Intrests
Brains, yoga, also together. I do experimental research on humans even thought I'm a mechanical engineer. The humans tend to somewhat interact with machines, important to mention. I also like books and semi-heavy weights. I like experimenting with wearable physiology sensors, that be ECG, GSR and neuroimaging modalities fNIRS and EEG. In stu studies. 

````

import argparse
import time
import numpy as np

import brainflow
from brainflow.board_shim import BoardShim, BrainFlowInputParams, LogLevels, BoardIds
from brainflow.data_filter import DataFilter, FilterTypes, AggOperations

from pylsl import StreamInfo, StreamOutlet

BoardShim.enable_dev_board_logger()

params = BrainFlowInputParams()
params.serial_port = 'COM3'

board = BoardShim(BoardIds.CYTON_BOARD.value, params) # added cyton board id here
board.prepare_session()

board.start_stream()
board.config_board('/2')  # enable analog mode only for Cyton Based Boards!    # added from example in docs
BoardShim.log_message(LogLevels.LEVEL_INFO.value, 'start sleeping in the main thread') # is this needed? 

# define lsl streams
# Scaling factor for conversion between raw data (counts) and voltage potentials:
SCALE_FACTOR_EEG = (4500000)/24/(2**23-1) #uV/count
SCALE_FACTOR_AUX = 0.002 / (2**4) 
# Defining stream info:
name = 'OpenBCIEEG'
ID = 'OpenBCIEEG'
channels = 8
sample_rate = 250
datatype = 'float32'
streamType = 'EEG'
print(f"Creating LSL stream for EEG. \nName: {name}\nID: {ID}\n")

info_eeg = StreamInfo(name, streamType, channels, sample_rate, datatype, ID)
chns = info_eeg.desc().append_child("channels")
for label in ["AFp1", "AFp2", "C3", "C4", "P7", "P8", "O1", "O2"]:
    ch = chns.append_child("channel")
    ch.append_child_value("label", label)

info_aux = StreamInfo('OpenBCIAUX', 'AUX', 3, 250, 'float32', 'OpenBCItestAUX')
chns = info_aux.desc().append_child("channels")
for label in ["X", "Y", "Z"]:
    ch = chns.append_child("channel")
    ch.append_child_value("label", label)

outlet_aux = StreamOutlet(info_aux)
outlet_eeg = StreamOutlet(info_eeg)

# construct a numpy array that contains only eeg channels and aux channels with correct scaling
# this streams to lsl
while True:
    print('get continiuous Data From the Board')
    data = board.get_current_board_data(1) # this gets data continiously

    # create scaled data
    scaled_eeg_data = data[1:9]*SCALE_FACTOR_EEG
    scaled_aux_data = data[10:13]*SCALE_FACTOR_AUX
    print(scaled_eeg_data)
    print(scaled_aux_data)
    print('------------------------------------------------------------------------------------------')

    outlet_eeg.push_sample(scaled_eeg_data)
    outlet_aux.push_sample(scaled_aux_data)


#When using the Python / LSL sending program, you must put the Cyton into either 'digital' or 'analog' (Aux mode), via a serial port SDK command:
#https://docs.openbci.com/docs/02Cyton/CytonSDK#board-mode
#The default "board mode", is to send the Accelerometer data at reduced rate.

````


## Quotes
> (...) Cultivate a habit of impatience about the things you most want to do. (...)" from [Life is to Short](http://www.paulgraham.com/vb.html) by Paul Graham. 

The following quotes are stolen from the very same, Paul Graham.

> "The best writing is rewriting."
> E. B. White

> "However little television you watch, watch less." 
> David McCullough


🦄
