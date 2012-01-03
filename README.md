#Controlled Damage

Controlled Damage is a Ruby script that lets you introduce intentional damage
to files.  Why would you want to do this?  Two reasons:

##Parser Tolerance

If you have a program that is meant to parse data as input, feeding it
intentionally damaged data could help you find parser bugs, buffer 
problems, and a variety of issues you would never find if you always
fed your program pristine data.  For instance, if your program was meant
to accept mpeg transport stream files as input, you could simulate a
bad network connection by slightly damaging the transport stream file.

##Artistic [De-]Generation

Lossy graphics file formats (such as jpg) can sometimes to some 
interesting and artistic things if you introduce small amounts of 
damage.  The more highly-compressed the input file is, the more drastic
the output file changes will appear.

#Usage

This app takes three parameters, with an optional fourth:

 - Input filename.  This is the source file (typically a jpg or transport stream).
 - Output filename.  This is the destination file.
 - Distortion.  For each byte in the file, there is a one-in-this-many chance of
   introducing a singe bit of damage.  A value of 1000 would give each byte a 1:1000
   chance of being damaged or, on average, 1 in 1000 bytes will have a damaged
   bit.
 - Seed.  The seed for the random number generator.  If you run the program twice
   with the same seed, you will get the same results.  If left out, one will
   be generated for you (and displayed when complete).

