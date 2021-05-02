PROGRAM_NAME='Ekrem Imamoglu Otobus'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(********************************************************************
    /* Physical Devices */ 
*********************************************************************)

DV_IO	 		= 5001:22:0

DV_RELAY		= 5001:21:0

DV_IR_TV1	        = 5001:11:0 /*TV LEFT*/
DV_IR_TV2		= 5001:12:0 /*TV RIGHT*/
DV_IR_UYDU1		= 5001:13:0 /*UYDU LEFT*/
DV_IR_UYDU2		= 5001:14:0 /*UYDU RIGHT*/

DV_AUDIO		= 5001:1:0  /*SOUNDBAR RS 232 CONTROL*/

DV_SWITCHER		= 05002:1:0 

(********************************************************************
    /* Panel */ 
*********************************************************************)

DVTP_IO			= 10001:11:0

DVTP_RELAY		= 10001:12:0

DVTP_TVIR1		= 10001:21:0
DVTP_TVIR2		= 10001:22:0
DVTP_UYDUIR1		= 10001:23:0
DVTP_UYDUIR2		= 10001:24:0

DVTP_VIDEO		= 10001:30:0

DVTP_AUDIO		= 10001:40:0

DVTP_GENERAL		= 10001:1:0

(********************************************************************
    /* Virtual Devices */ 
*********************************************************************) 

VDVTP_IO		= 33001:1:0

VDVTP_RELAY		= 33002:1:0

VDVTP_TVIR1		= 33003:1:0
VDVTP_TVIR2		= 33004:1:0
VDVTP_UYDUIR1		= 33005:1:0
VDVTP_UYDUIR2		= 33006:1:0

VDVTP_VIDEO		= 33007:1:0

VDVTP_AUDIO		= 33008:1:0

VDVTP_GENERAL		= 33009:1:0

DEFINE_COMBINE
(VDVTP_IO,DVTP_IO)

(VDVTP_RELAY,DVTP_RELAY)

(VDVTP_TVIR1,DVTP_TVIR1)
(VDVTP_TVIR2,DVTP_TVIR2)
(VDVTP_UYDUIR1,DVTP_UYDUIR1)
(VDVTP_UYDUIR2,DVTP_UYDUIR2)

(VDVTP_VIDEO,DVTP_VIDEO)

(VDVTP_AUDIO,DVTP_AUDIO)

(VDVTP_GENERAL,DVTP_GENERAL)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
/* TV1 mute button variable */ 
integer mute_var_TV1 = 0
/* TV2 mute button variable */
integer mute_var_TV2 = 0

/* SOUNDBAR mute button variable */
integer mute_var_SOUNDBAR = 0

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE
/* Header Popup */
([VDVTP_GENERAL,1]..[VDVTP_GENERAL,4])

/* Sol TV output */
([VDVTP_VIDEO,1]..[VDVTP_VIDEO,3])
/* Sag TV output*/
([VDVTP_VIDEO,4]..[VDVTP_VIDEO,6])

/* Ses switch 1 */
([VDVTP_VIDEO,7]..[VDVTP_VIDEO,8])
/* Ses switch 2 */
([VDVTP_AUDIO,1]..[VDVTP_AUDIO,2])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

/*
* SOUNDBAR RS232 INTERFACE
*/
DATA_EVENT[DV_AUDIO]
{
    ONLINE:
    {
	SEND_COMMAND DV_AUDIO, 'SET BAUD 115200, N, 8, 1'
	SEND_COMMAND DV_AUDIO, 'HSOFF'
	SEND_COMMAND DV_AUDIO, 'XOFF'
    }
}

(********************************************************************
    /* GENERAL STATE CONTROL*/ 
*********************************************************************)

button_event[VDVTP_GENERAL, 0]
{
    push:
    {
	/* Button.input.channel -> ON State*/
	ON[VDVTP_GENERAL, button.input.channel] 
    }
}

(********************************************************************
    /* PERDE SAG I/O CONTROL*/ 
*********************************************************************)

button_event[VDVTP_IO, 0]
{
    push:
    {
	/*
	* Perde Down
	*/
	IF(button.input.channel == 11)
	{
	    ON[DV_IO, 2]
	    
	    wait 3
	    
	    OFF[DV_IO, 1]
	}
	
	/*
	* Perde Up
	*/
	IF(button.input.channel == 12)
	{
	    ON[DV_IO, 1]
	    
	    wait 3
	    
	    OFF[DV_IO, 2]
	}
	
	/*
	* Perde Stop
	*/
	IF(button.input.channel == 13)
	{
	    OFF[DV_IO, 1]
	    OFF[DV_IO, 2]
	}
    }
}

(********************************************************************
    /* PERDE SOL I/O CONTROL*/ 
*********************************************************************)

button_event[VDVTP_IO, 0]
{
    push:
    {
	/*
	* Perde Down
	*/
	IF(button.input.channel == 14)
	{
	    ON[DV_IO, 4]
	    
	    wait 3
	    
	    OFF[DV_IO, 3]
	}
	
	/*
	* Perde Up
	*/
	IF(button.input.channel == 15)
	{
	    ON[DV_IO, 3]
	    
	    wait 3
	    
	    OFF[DV_IO, 4]
	}
	
	/*
	* Perde Stop
	*/
	IF(button.input.channel == 16)
	{
	    OFF[DV_IO, 3]
	    OFF[DV_IO, 4]
	}
    }
}

(********************************************************************
    /* TAIL LIGHT POWER SUPPLY RELAY CONTROL*/ 
*********************************************************************)

button_event[VDVTP_RELAY, 0]
{
    push:
    {
	/*
	* LED on
	* Button state ON
	* 2nd Button state ON
	*/
	IF(button.input.channel == 2)
	{
	    ON[DV_RELAY, 1]
	    
	    WAIT 3
	    
	    ON[VDVTP_RELAY, 2]
	    
	    WAIT 5
	    
	    ON[VDVTP_RELAY, 3]
	}
	
	/*
	* LED off
	* Button state OFF
	* 2nd Button state OFF
	*/
	IF(button.input.channel == 3)
	{
	    OFF[DV_RELAY, 1]
	    
	    WAIT 3
	    
	    OFF[VDVTP_RELAY, 2]
	    
	    WAIT 5
	    
	    OFF[VDVTP_RELAY, 3]
	}
    }
}

(********************************************************************
    /* FRONT LIGHT POWER SUPPLY RELAY CONTROL*/ 
*********************************************************************)

button_event[VDVTP_RELAY, 0]
{
    push:
    {
	/*
	* LED on
	* Button state ON
	* 2nd Button state ON
	*/
	IF(button.input.channel == 4)
	{
	    ON[DV_RELAY, 3]
	    
	    WAIT 3
	    
	    ON[VDVTP_RELAY, 4]
	    
	    WAIT 5
	    
	    ON[VDVTP_RELAY, 5]
	}
	
	/*
	* LED off
	* Button state OFF
	* 2nd Button state OFF
	*/
	IF(button.input.channel == 5)
	{
	    OFF[DV_RELAY, 3]
	    
	    WAIT 3
	    
	    OFF[VDVTP_RELAY, 4]
	    
	    WAIT 5
	    
	    OFF[VDVTP_RELAY, 5]
	}
    }
}

(********************************************************************
    /* STAFF BUTTON RELAY CONTROL*/ 
*********************************************************************)

button_event[VDVTP_RELAY, 0]
{
    push:
    {
	/*
	* Hizmetli LED on
	* Button state on
	* 15 sec -> 
	* + LED off
	* + Button state off
	*/
	IF(button.input.channel == 1)
	{
	    ON[DV_RELAY, 2]
	    
	    WAIT 3
	    
	    ON[VDVTP_RELAY, 1]
	    
	    WAIT 150
	    
	    OFF[DV_RELAY, 2]
	    
	    WAIT 100
	    
	    OFF[VDVTP_RELAY, 1]
	}
    }
}

(********************************************************************
    /* TV SOL UYDU IR CONTROL*/ 
*********************************************************************)

/*
* TV Power ON button -->
* + pulse code
* + button.input.channel == 1 --> state ON
* + button.input.channel == 50 --> state ON
*/
button_event[VDVTP_TVIR1, 1]
{
    push:
    {
	pulse[DV_IR_TV1, 1]
	
	WAIT 3
	
	ON[VDVTP_TVIR1, 1]
	
	WAIT 5
	
	ON[VDVTP_TVIR1, 50]
    }
}

/*
* TV Power OFF button -->
* + pulse code
* + button.input.channel == 1 --> state OFF
* + button.input.channel == 50 --> state OFF
*/
button_event[VDVTP_TVIR1, 50]
{
    push:
    {
	pulse[DV_IR_TV1, 1]
	
	WAIT 3
	
	OFF[VDVTP_TVIR1, 1]
	
	WAIT 5
	
	OFF[VDVTP_TVIR1, 50]
    }
}

/*
* Uydu 1 remaining buttons IR
*/
button_event[VDVTP_UYDUIR1, 0]
{
    push:
    {
	/*
	* IR buttons --> button.input.channel order == file button order
	*/
	IF(button.input.channel <= 28)
	{
	    pulse[DV_IR_UYDU1, button.input.channel]
	}
    }
}

/*
* Uydu Power ON button -->
* + pulse code
* + button.input.channel ==  1 --> state ON
* + button.input.channel ==  50 --> state ON
*/
button_event[VDVTP_UYDUIR1, 1]
{
    push:
    {
	pulse[DV_IR_UYDU1, 1]
	
	WAIT 3
	
	ON[VDVTP_UYDUIR1, 1]
	
	WAIT 5
	
	ON[VDVTP_UYDUIR1, 50]
    }
}

/*
* Uydu Power OFF button -->
* + pulse code
* + button.input.channel ==  1 --> state OFF
* + button.input.channel ==  50 --> state OFF
*/
button_event[VDVTP_UYDUIR1, 50]
{
    push:
    {
	pulse[DV_IR_UYDU1, 1]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR1, 1]
	
	WAIT 5
	
	OFF[VDVTP_UYDUIR1, 50]
    }
}

/*
* Uydu Volume UP -->
* + push --> 
* ++ pulse code
* ++ button.input.channel ==  4 --> state OFF
* ++ mute_var = 0
* + hold -->
* ++ SAME ABOVE
*/
button_event[VDVTP_UYDUIR1, 2]
{
    push:
    {
	pulse[DV_IR_UYDU1, 2]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR1, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
    hold[5, repeat]:
    {
	pulse[DV_IR_UYDU1, 2]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR1, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
}

/*
* Uydu olume DOWN -->
* + push --> 
* ++ pulse code
* ++ button.input.channel ==  4 --> state OFF
* ++ mute_var = 0
* + hold -->
* ++ SAME ABOVE
*/
button_event[VDVTP_UYDUIR1, 3]
{
    push:
    {
	pulse[DV_IR_UYDU1, 3]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR1, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
    hold[5, repeat]:
    {
	pulse[DV_IR_UYDU1, 3]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR1, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
}

/*
* Uydu Mute -->
* + push --> 
* ++ if mute_var == 0 (currently not mute) -->
* +++ pulse code
* +++ button.input.channel ==  4 --> state ON
* +++ mute_var = 1
* ++ else if mute_var == 1 (currently muted) -->
* +++ pulse code
* +++ button.input.channel ==  4 --> state OFF
* +++ mute_var = 0
*/
button_event[VDVTP_UYDUIR1, 4]
{
    push:
    {
	IF(mute_var_TV1 == 0)
	{
	    pulse[DV_IR_UYDU1, 4]
	    
	    WAIT 3
	    
	    ON[VDVTP_UYDUIR1, 4]
	    
	    WAIT 5
	    
	    mute_var_TV1 = 1
	}
	ELSE IF(mute_var_TV1 == 1)
	{
	    pulse[DV_IR_UYDU1, 4]
	    
	    WAIT 3
	    
	    OFF[VDVTP_UYDUIR1, 4]
	    
	    WAIT 5
	    
	    mute_var_TV1 = 0
	}
    }
}

(********************************************************************
    /* TV SAG UYDU IR CONTROL*/ 
*********************************************************************)

/*
* TV Power ON button -->
* + pulse code
* + button.input.channel == 1 --> state ON
* + button.input.channel == 50 --> state ON
*/
button_event[VDVTP_TVIR2, 1]
{
    push:
    {
	pulse[DV_IR_TV2, 1]
	
	WAIT 3
	
	ON[VDVTP_TVIR2, 1]
	
	WAIT 5
	
	ON[VDVTP_TVIR2, 50]
    }
}

/*
* TV Power OFF button -->
* + pulse code
* + button.input.channel == 1 --> state OFF
* + button.input.channel == 50 --> state OFF
*/
button_event[VDVTP_TVIR2, 50]
{
    push:
    {
	pulse[DV_IR_TV2, 1]
	
	WAIT 3
	
	OFF[VDVTP_TVIR2, 1]
	
	WAIT 5
	
	OFF[VDVTP_TVIR2, 50]
    }
}

/*
* Uydu 2 remaining buttons IR
*/
button_event[VDVTP_UYDUIR2, 0]
{
    push:
    {
	/*
	* IR buttons --> button.input.channel order == file button order
	*/
	IF(button.input.channel <= 28)
	{
	    pulse[DV_IR_UYDU2, button.input.channel]
	}
    }
}

/*
* Uydu Power ON button -->
* + pulse code
* + button.input.channel ==  1 --> state ON
* + button.input.channel ==  50 --> state ON
*/
button_event[VDVTP_UYDUIR2, 1]
{
    push:
    {
	pulse[DV_IR_UYDU2, 1]
	
	WAIT 3
	
	ON[VDVTP_UYDUIR2, 1]
	
	WAIT 5
	
	ON[VDVTP_UYDUIR2, 50]
    }
}

/*
* Uydu Power OFF button -->
* + pulse code
* + button.input.channel ==  1 --> state OFF
* + button.input.channel ==  50 --> state OFF
*/
button_event[VDVTP_UYDUIR2, 50]
{
    push:
    {
	pulse[DV_IR_UYDU2, 1]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR2, 1]
	
	WAIT 5
	
	OFF[VDVTP_UYDUIR2, 50]
    }
}

/*
* Uydu Volume UP -->
* + push --> 
* ++ pulse code
* ++ button.input.channel ==  4 --> state OFF
* ++ mute_var = 0
* + hold -->
* ++ SAME ABOVE
*/
button_event[VDVTP_UYDUIR2, 2]
{
    push:
    {
	pulse[DV_IR_UYDU2, 2]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR2, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
    hold[5, repeat]:
    {
	pulse[DV_IR_UYDU2, 2]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR2, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
}

/*
* Uydu olume DOWN -->
* + push --> 
* ++ pulse code
* ++ button.input.channel ==  4 --> state OFF
* ++ mute_var = 0
* + hold -->
* ++ SAME ABOVE
*/
button_event[VDVTP_UYDUIR2, 3]
{
    push:
    {
	pulse[DV_IR_UYDU2, 3]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR2, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
    hold[5, repeat]:
    {
	pulse[DV_IR_UYDU2, 3]
	
	WAIT 3
	
	OFF[VDVTP_UYDUIR2, 4]
	
	WAIT 5
	
	mute_var_TV1 = 0
    }
}

/*
* Uydu Mute -->
* + push --> 
* ++ if mute_var == 0 (currently not mute) -->
* +++ pulse code
* +++ button.input.channel ==  4 --> state ON
* +++ mute_var = 1
* ++ else if mute_var == 1 (currently muted) -->
* +++ pulse code
* +++ button.input.channel ==  4 --> state OFF
* +++ mute_var = 0
*/
button_event[VDVTP_UYDUIR2, 4]
{
    push:
    {
	IF(mute_var_TV1 == 0)
	{
	    pulse[DV_IR_UYDU2, 4]
	    
	    WAIT 3
	    
	    ON[VDVTP_UYDUIR2, 4]
	    
	    WAIT 5
	    
	    mute_var_TV1 = 1
	}
	ELSE IF(mute_var_TV1 == 1)
	{
	    pulse[DV_IR_UYDU2, 4]
	    
	    WAIT 3
	    
	    OFF[VDVTP_UYDUIR2, 4]
	    
	    WAIT 5
	    
	    mute_var_TV1 = 0
	}
    }
}

(********************************************************************
    /* VIDEO MATRIX CONTROL*/ 
*********************************************************************)

button_event[VDVTP_VIDEO, 0]
{
    push:
    {
	/* Button.input.channel -> ON State */
	ON[VDVTP_VIDEO, button.input.channel] 
	
	/*
	* VIDEO AND AUDIO OUT 1 IN 1
	* LEFT TV --> DESK HDMI
	*/
	IF(button.input.channel == 1)
	{
	    send_command DV_SWITCHER,"'VI5O1'"
	    send_command DV_SWITCHER,"'AI5O1'"
	}
	
	/*	
	* VIDEO AND AUDIO OUT 1 IN 2
	* LEFT TV --> NVR CAMERA HDMI
	*/
	IF(button.input.channel == 2)
	{
	    send_command DV_SWITCHER,"'VI4O1'"
	    send_command DV_SWITCHER,"'AI4O1'"
	}
	
	/*	
	* VIDEO AND AUDIO OUT 1 IN 2
	* LEFT TV --> UYDU 1
	*/
	IF(button.input.channel == 3)
	{
	    send_command DV_SWITCHER,"'VI3O1'"
	    send_command DV_SWITCHER,"'AI3O1'"
	}

	/*
	* VIDEO AND AUDIO OUT 2 IN 1
	* RIGHT TV --> DESK HDMI
	*/
	IF(button.input.channel == 4)
	{
	    send_command DV_SWITCHER,"'VI5O2'"
	    send_command DV_SWITCHER,"'AI5O2'"
	}
	
	/*
	* VIDEO AND AUDIO OUT 2 IN 2
	* RIGHT TV --> NVR CAMERA HDMI
	*/
	IF(button.input.channel == 5)
	{
	    send_command DV_SWITCHER,"'VI4O2'"
	    send_command DV_SWITCHER,"'AI4O2'"
	}
	
	/*	
	* VIDEO AND AUDIO OUT 1 IN 2
	* RIGHT TV --> UYDU 2
	*/
	IF(button.input.channel == 6)
	{
	    send_command DV_SWITCHER,"'VI6O2'"
	    send_command DV_SWITCHER,"'AI6O2'"
	}
	
	/*
	* AUDIO OUT 1 IN 1
	* SOUNDBAR --> SOL TV
	* audio out 2 --> audio input 7
	*/
	IF(button.input.channel == 7)
	{
	    send_command DV_SWITCHER,"'AI7O2'"
	}
	
	/*
	* AUDIO OUT 1 IN 2
	* SOUNDBAR --> SAG TV
	* audio output 2 --> audio input 8
	*/
	IF(button.input.channel == 8)
	{
	    send_command DV_SWITCHER,"'AI8O2'"
	}
    }
}

(********************************************************************
    /* AUDIO CONTROL*/ 
*********************************************************************)

button_event[VDVTP_AUDIO, 0]
{
    push:
    {
	/* Button.input.channel -> ON State */
	ON[VDVTP_AUDIO, button.input.channel] 
	
	/*
	* Input source: Bluetooth
	*/
	IF(button.input.channel == 1)
	{
	    send_string DV_AUDIO,"'set',$20,'/audio/source',$20,'aux',13"
	    /*
	    send_string DV_AUDIO,"'set /audio/source aux',$0D"
	    send_string DV_AUDIO,"'set /audio/source aux\r'"
	    
	    send_string DV_AUDIO,"'set /audio/source aux'"
	    
	    send_string DV_AUDIO,"'set /audio/source aux',13"
	    send_string DV_AUDIO,"'set /audio/source aux',13"
	    
	    send_string DV_AUDIO,"'set',$20,'/audio/source',$20,'aux',13"
	    
	    send_string DV_AUDIO,"'set audio/source aux\r\n'"
	    send_string DV_AUDIO,"'set audio/source aux\n'"
	    
	    send_string DV_AUDIO,"'set',$20,'audio/source aux',$0D"*/
	}
	
	/*
	* Input source: USB
	*/
	IF(button.input.channel == 2)
	{
	    send_string DV_AUDIO,"'set',$20,'audio/source usb',13"
	}
    }
}

(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


