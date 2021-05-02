
Product Name: DVX-32xxHD-SP (-T) and DVX-22xxHD-SP (-T)
              Enova Presentation Switcher with power Amp

FG#: FG1906-22 (DVX3256HD-SP)
FG#: FG1906-16 (DVX3255HD-SP)
FG#: FG1906-15 (DVX3250HD-SP)
FG#: FG1906-11 (DVX2250HD-SP)
FG#: FG1906-12 (DVX2255HD-SP)
FG#: FG1906-24 (DVX3256HD-T)
FG#: FG1906-18 (DVX3255HD-T)
FG#: FG1906-17 (DVX3250HD-T)
FG#: FG1906-13 (DVX2250HD-T)
FG#: FG1906-14 (DVX2255HD-T)
FG#: FG1906-07 (DVX2210HD-SP)
FG#: FG1906-09 (DVX2210HD-T)

Current Firmware Version:
Switcher: v1.7.81  SW1906-15_DVX-HD_v1_7_81.kit

Release Date: 2/07/2018

----------------------------------------------------------
Prerequisites
----------------------------------------------------------

NX Device 5001: FW v1.1.28 or later
NX Master FW v1.3.44 or later

----------------------------------------------------------
Programming Information
----------------------------------------------------------
None

----------------------------------------------------------
Changes in this release
----------------------------------------------------------
- Fixed an issue where the VIDOUT_ON-OFF cmd was not 
  always working with a DVX-22xx model
- Fixed an issue where a logo was not showing up when
  hydraport cable is disconneced from the source, when 
  using an hdmi input
- Added support for new SPI Flash devices
- Fixed an issue where dhcp does not get a proper address 
  after a reboot, or firmware download
- Fixed an issue where dxlink input would not get a proper 
  logo setup when no video was detected 
- Fixed an issue where dxlink input would flicker with VGA
  Laptop to MFTX, going from duplicate to extend mode 
- Fixed an issue where switching to same input would cause 
  output to flicker
- Fixed an HDCP failure issue where a red screen would 
  occur instead of video, on an HDMI output
- Fix switching issue that caused wrong outputs to blink 
  for DVX-225x models

----------------------------------------------------------
Known Issues 
----------------------------------------------------------
None
