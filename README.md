# Fake6523-28
This is a replacement for the 28-pin version of the MOS 6523 tri-port interface used in the Commodore 1551 paddle.
There is no datasheet available for the 28-pin version of the 6523. I'm guessing it was a modification that was made exclusively for the 1551 to fit in the paddle. It is quite similar to the 40-pin version but instead of three 8-bit ports it only has one 8-bit port (A) and two 2-bit ports (B and C).

<img src="ref/mos6523-28.svg" alt="pinout" width="300"/>

This replacement is pretty much a scaled down version of the 40-pin [Fake6523](https://github.com/go4retro/Fake6523) created by Jim Brain. 
The verilog code for the CPLD is based on code created by Maciej Witkowiak for the [TCBM2SD](https://github.com/ytmytm/plus4-tcbm2sd).  
It is still using the XC9572XL-10VQ64 but it could possibly be ported to a smaller CPLD.

<img src="rev1/images/mos6523-28_rev1_top_3d.png" alt="render" width="600"/>

The Fake6523-28 has not gone through any long term testing so use at your own risk. 

The Fake6523-28 has briefly been tested as a 1551 paddle TPI together with:
* 1551 CPU: Original 6510T, Monotech 6502
* 1551 TPI: Original 6525A, Fake6523
* Plus/4 CPU: 6510 adapter, dmantione 6502, Monotech 6502
* Plus/4 Kernal: CBM original, 6510 Kernal hack, JiffyDOS
* Plus/4 PLA: Original 251641-02, PLA16V8
* Paddle PLA: Original 251641-03, FlashPLA 55/70ns

I have no original 7501/8501...
