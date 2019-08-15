# yaml_to_streams


let's you convert wireshark YAML streams into something useable 

Compresses client or server sent data into blocks of binary data. This is to assist with the fact that TCP gets segemented into YAML blocks, which you probably don't want happening if you are interested in playback of the data in anyway
