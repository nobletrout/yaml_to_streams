# yaml_to_streams


let's you convert wireshark YAML streams into something useable 

Compresses client or server sent data into blocks of binary data. This is to assist with the fact that TCP gets segemented into YAML blocks, which you probably don't want happening if you are interested in playback of the data in anyway

# advanced usage

If collapsing things together isn't your thing (let's say you are noodling about
with DNS or SIP/RTP or something) then you want to porvide a second option

`./yaml_to_streams $FILE NO`

the second option can be anything as long as it's there.
