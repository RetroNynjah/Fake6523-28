# Fake6523-28
This is a replacement for the 28-pin version of the MOS 6523 tri-port interface used in the Commodore 1551 paddle.

This replacement is pretty much a scaled down version of the 40-pin [Fake6523](https://github.com/go4retro/Fake6523) created by Jim Brain. 
The verilog code for the CPLD is based on code created by Maciej Witkowiak for the [TCBM2SD](https://github.com/ytmytm/plus4-tcbm2sd).  

## About the 6523
<img src="ref/mos6523-28.svg" alt="pinout" width="300"/>

There is no datasheet available for the 28-pin version of the 6523. I'm guessing it was a modification that was made exclusively for the 1551 to fit in the paddle. They seem to be branded either 6523T or 6523A. 
It is quite similar to the 40-pin version but instead of three 8-bit ports it only has one 8-bit port (A) and two 2-bit ports (B and C). Some [old instructions](ref/1551-tia.gif) were available that let you replace a 28-pin 6523 with a 40-pin 6523 or 6525 using an adapter. I based my PCB design on those instructions.

I've tested a real 6523T to find out how it behaves in various conditions and this is what I found. Some of it is obvious and some of it is my best guesses.  
The two 2-bit ports and their corresponding DDR registers are all 8-bit registers internally. The other six bits in a 2-bit port (let's call them extra bits) are most likely all there. They are just not connected to any external pins.
Eight bits can be written to them and wile the bits are configured as outputs (1) in the DDR registers, the same eight bits can be read back from the port register.  
When the extra bits are switched to inputs (0) in the DDR register, they most likely start to float. At first, they retain the data that was last written to the port register but after a second or so, the extra bits start to toggle. The behaviour may seem conistent but it only is until it isn't :)

## Design
I chose to replicate the output funtionality in this design. The extra bits are normally not used by the 1551 and the drive works fine without that functionality.
If some third party software like a highly optimized loader would use the extra bits for anything, it feels good to have them for compatibility.

<img src="rev1/images/mos6523-28_rev1_top_3d.png" alt="render" width="600"/>

This simple design is using the XC9572XL-10VQ64 but it could possibly be ported to a smaller CPLD by limiting the port A and port B internal registers to two bits each.  

## Compatibility
The Fake6523-28 has not gone through any long term testing so **use at your own risk**.  
It has briefly been tested as a 1551 paddle TPI together with:
* 1551 CPU
    * MOS 6510T
    * Monotech 6502
* 1551 TPI
    * MOS 6525A
    * Fake6523
* Plus/4 CPU adapters (I have no original 7501/8501)
    * 6510 adapter
    * dmantione 6502
    * Monotech 6502
* Plus/4 Kernal
    * CBM original
    * 6510 Kernal hack
    * JiffyDOS
* Plus/4 PLA
    * MOS 251641-02
    * PLA16V8
* Paddle PLA
    * Original 251641-03
    * FlashPLA 55/70ns

## Future
A future enhancement could be to switch to an active product as the XC9672L has been discontinued and will be harder to source in the future. An active product will most likely complicate things as level shifters will be needed for 26 signals.
