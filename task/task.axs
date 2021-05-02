PROGRAM_NAME='task'
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

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DV_Projection		=	5001:1:0
DV_Audio		=	5001:2:0
DV_IO	 		= 	5001:22:0
DV_Led			=	5001:11:0

DV_TCP			=	0:3:0

(*		PANEL			*)
DVTP_Projection		=	10001:1:0
DVTP_Audio		=	10001:2:0
DVTP_IO			= 	10001:11:0
DVTP_Led		=	10001:4:0
DVTP_TCP		=	10001:5:0
DVTP_General		=	10001:6:0

(*		Virtual Device		*)
VDVTP_Projection	=	33001:1:0
VDVTP_Audio		=	33002:1:0
VDVTP_IO		= 	33004:1:0
VDVTP_Led		=	33003:1:0
VDVTP_TCP		=	33005:1:0
VDVTP_General		=	33006:1:0

DEFINE_COMBINE

(DVTP_Projection, VDVTP_Projection)
(DVTP_Audio, VDVTP_Audio)
(VDVTP_IO,DVTP_IO)
(DVTP_Led, VDVTP_Led)
(DVTP_TCP, VDVTP_TCP)
(DVTP_General, VDVTP_General)

DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
char pro_ip = '192.168.1.12'

DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
integer button_up = 1 //


DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

/*     */
([VDVTP_General,1] .. [VDVTP_General,4])


DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

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

/*      RS232			*/
    DATA_EVENT[DV_Audio]
    {
	ONLINE:
	{
	    SEND_COMMAND DV_Audio, 'SET BAUD 9600, N, 8, 1, 485 DISABLE'
	    SEND_COMMAND DV_Audio, 'HSOFF'
	    SEND_COMMAND DV_Audio, 'XOFF'
	}
	
}

/* 	GENERAL STATE CONTROL	*/ 

button_event[VDVTP_GENERAL, 0]
{
    push:
    {
	ON[VDVTP_GENERAL, button.input.channel] 
    }
}

(*****************************************************************)
(*			Perde kontrolü				 *)
(*****************************************************************)

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
(*****************************************************************)
(*			LED Kontrolü				 *)
(*****************************************************************)
button_event[VDVTP_Led, 0]
{
    push:
    {
	// LED Açma
	IF(button.input.channel == 3)
	{
	pulse[DV_Led, 3]
	WAIT 3
	ON[VDVTP_Led,3]
	WAIT 5
	ON[VDVTP_Led, 4]
	}
	
	// LED Kapama
	IF(button.input.channel == 4)
	{
	pulse[DV_Led, 4]
	WAIT 3
	OFF[VDVTP_Led,3]
	WAIT 5
	OFF[VDVTP_Led, 4]
	}
	
	//White
	IF(button.input.channel == 2)
	{
	pulse[DV_Led, 2]
	}
	
	//Red
	IF(button.input.channel == 5)
	{
	pulse[DV_Led, 5]
	}
	
	//Green
	IF(button.input.channel == 6)
	{
	pulse[DV_Led, 6]
	}
	
	//Blue
	IF(button.input.channel == 7)
	{
	pulse[DV_Led, 7]
	}
	
	//Medium Red
	IF(button.input.channel == 8)
	{
	pulse[DV_Led, 8]
	}
	
	//Medium Green
	IF(button.input.channel == 9)
	{
	pulse[DV_Led, 9]
	}
	
	//Medium Blue
	IF(button.input.channel == 10)
	{
	pulse[DV_Led, 10]
	}
	
	//VeryLightRed
	IF(button.input.channel == 11)
	{
	pulse[DV_Led, 11]
	}
	
	//VeryLightCyan
	IF(button.input.channel == 12)
	{
	pulse[DV_Led, 12]
	}
	
	//Purple
	IF(button.input.channel == 13)
	{
	pulse[DV_Led, 13]
	}
	
	//VeryLightOrange
	IF(button.input.channel == 14)
	{
	pulse[DV_Led, 14]
	}
	
	//LightBlue
	IF(button.input.channel == 15)
	{
	pulse[DV_Led, 15]
	}
	
	//Magenta
	IF(button.input.channel == 16)
	{
	pulse[DV_Led, 16]
	}
	
	//VeryLightYellow
	IF(button.input.channel == 17)
	{
	pulse[DV_Led, 17]
	}
	
	//DarkBlue
	IF(button.input.channel == 18)
	{
	pulse[DV_Led, 18]
	}
	
	//Light UP
	IF(button.input.channel == 20)
	{
	pulse[DV_Led, 20]
	}
	
	//Light DOWN
	IF(button.input.channel == 21)
	{
	pulse[DV_Led, 21]
	}
}
}

(*****************************************************************)
(*			Projeksiyon Kontrolü 			 *)
(*****************************************************************)

(*	Projeksiyon Açma	*)
button_event[VDVTP_TCP, 1]
{
    push:
    {	
    IF(button.input.channel ==1)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT, pro_ip, 23,1)
	send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$50,$4F,$4E,$03"	
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	Projeksiyon Kapama	*)
button_event[VDVTP_TCP, 2]
{
    push:
    {
    	IF(button.input.channel ==2)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$50,$4F,$46,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	MENU		*)
button_event[VDVTP_TCP, 3]
{
    push:
    {
	IF(button.input.channel ==7)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$4D,$4E,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	UP	*)
button_event[VDVTP_TCP, 4]
{
    push:
    {
	IF(button.input.channel ==23)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$43,$55,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	Down	*)
button_event[VDVTP_TCP, 5]
{
    push:
    {
	IF(button.input.channel ==24)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$43,$44,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	Left	*)
button_event[VDVTP_TCP, 6]
{
    push:
    {
	IF(button.input.channel ==25)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$43,$4C,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	Right	*)
button_event[VDVTP_TCP, 7]
{
    push:
    {
	IF(button.input.channel ==26)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$43,$52,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	OK	*)
button_event[VDVTP_TCP, 8]
{
    push:
    {
	IF(button.input.channel ==27)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$45,$4E,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	INPUT	*)
button_event[VDVTP_TCP, 9]
{
    push:
    {
	IF(button.input.channel ==9)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$49,$49,$53,$3A"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	SETUP	*)
button_event[VDVTP_TCP, 10]
{
    push:
    {
	IF(button.input.channel ==10)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$02,$41,$44,$5A,$5A,$3B,$4F,$41,$4D,$3A"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*	HDM1	*)
button_event[VDVTP_TCP, 11]
{
    push:
    {
	IF(button.input.channel ==10)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,pro_ip,23,1)
	    send_string DV_TCP,"$44,$4C,$31,$3A,$48,$44,$31,$03"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	}
    }
}

(*****************************************************************)
(*			AVR Kontrolü				 *)
(*****************************************************************)

(*	AVR Power ON	*)
button_event[VDVTP_Audio,1]
{
    push:
    {
	IF(button.input.channel ==1)
	{
	send_string DVTP_Audio, "'PWON',$0d"
	}
    }
}

(*	AVR Power OFF	*)
button_event[VDVTP_Audio,2]
{
    push:
    {
	IF(button.input.channel ==50)
	{
	send_string DVTP_Audio, "'PWSTANDBY', $0d"
	}
    }
}

(*	AVR VOLUME UP	*)
button_event[VDVTP_Audio,3]
{
    push:
    {
	IF(button.input.channel ==2)
	{
	send_string DVTP_Audio, "'MVUP', $0d"
	}
    }
}

(*	AVR VOLUME DOWN	*)
button_event[VDVTP_Audio,4]
{
    push:
    {
	IF(button.input.channel ==3)
	{
	send_string DVTP_Audio, "'MVDOWN', $0d"
	}
    }
}

(*	AVR MUTE ON	*)
button_event[VDVTP_Audio,5]
{
    push:
    {
	IF(button.input.channel ==4)
	{
	send_string DVTP_Audio, "'MUON', $0d"
	}
    }
}

(*	AVR PHONO INPUT	*)
button_event[VDVTP_Audio,6]
{
    push:
    {
	IF(button.input.channel ==20)
	{
	send_string DVTP_Audio, "'SIPHONO', $0d"
	}
    }
}

(*	AVR DVD INPUT	*)
button_event[VDVTP_Audio,7]
{
    push:
    {
	IF(button.input.channel ==12)
	{
	send_string DVTP_Audio, "'SIDVD', $0d"
	}
    }
}

(*	AVR BLUERAY INPUT	*)
button_event[VDVTP_Audio,8]
{
    push:
    {
	IF(button.input.channel ==13)
	{
	send_string DVTP_Audio, "'SIBD', $0d"
	}
    }
}

(*	AVR TV INPUT	*)
button_event[VDVTP_Audio,9]
{
    push:
    {
	IF(button.input.channel ==17)
	{
	send_string DVTP_Audio, "'SITV', $0d"
	}
    }
}

(*	AVR CBL INPUT	*)
button_event[VDVTP_Audio,10]
{
    push:
    {
	IF(button.input.channel ==11)
	{
	send_string DVTP_Audio, "'SISAT/CBL', $0d"
	}
    }
}

(*	AVR MEDIA INPUT	*)
button_event[VDVTP_Audio,11]
{
    push:
    {
	IF(button.input.channel ==16)
	{
	send_string DVTP_Audio, "'SIMPLAY', $0d"
	}
    }
}

(*	AVR GAME INPUT	*)
button_event[VDVTP_Audio,12]
{
    push:
    {
	IF(button.input.channel ==14)
	{
	send_string DVTP_Audio, "'SIGAME', $0d"
	}
    }
}

(*	AVR AUX INPUT	*)
button_event[VDVTP_Audio,13]
{
    push:
    {
	IF(button.input.channel ==15)
	{
	send_string DVTP_Audio, "'SIAUX1', $0d"
	}
    }
}

(*	AVR 8K INPUT	*)
button_event[VDVTP_Audio,14]
{
    push:
    {
	IF(button.input.channel ==18)
	{
	send_string DVTP_Audio, "'SI8K', $0d"
	}
    }
}

(*	AVR BLUETOOTH INPUT	*)
button_event[VDVTP_Audio,15]
{
    push:
    {
	IF(button.input.channel ==19)
	{
	send_string DVTP_Audio, "'SIBT', $0d"
	}
    }
}

(*	AVR UP	*)
button_event[VDVTP_Audio,16]
{
    push:
    {
	IF(button.input.channel ==23)
	{
	send_string DVTP_Audio, "'MNCUP', $0d"
	}
    }
}

(*	AVR DOWN	*)
button_event[VDVTP_Audio,17]
{
    push:
    {
	IF(button.input.channel ==24)
	{
	send_string DVTP_Audio, "'MNCNDN', $0d"
	}
    }
}

(*	AVR Right	*)
button_event[VDVTP_Audio,18]
{
    push:
    {
	IF(button.input.channel ==26)
	{
	send_string DVTP_Audio, "'MNCRT', $0d"
	}
    }
}

(*	AVR Left	*)
button_event[VDVTP_Audio,19]
{
    push:
    {
	IF(button.input.channel ==25)
	{
	send_string DVTP_Audio, "'MNCLT', $0d"
	}
    }
}

(*	AVR ENTER	*)
button_event[VDVTP_Audio,20]
{
    push:
    {
	IF(button.input.channel ==27)
	{
	send_string DVTP_Audio, "'MNENT', $0d"
	}
    }
}

(*	AVR Option	*)
button_event[VDVTP_Audio,21]
{
    push:
    {
	IF(button.input.channel ==9)
	{
	send_string DVTP_Audio, "'MNOPT', $0d"
	}
    }
}

(*	AVR Info	*)
button_event[VDVTP_Audio,22]
{
    push:
    {
	IF(button.input.channel ==8)
	{
	send_string DVTP_Audio, "'MNRTN', $0d"
	}
    }
}

(*	AVR Setup	*)
button_event[VDVTP_Audio,23]
{
    push:
    {	
	IF(button.input.channel ==10)
	{
	IF(button_up == 1)
	{
	send_string DVTP_Audio, "'MNMEN ON', $0d"
	button_up = 0
	}
	ELSE IF(button_up == 0)
	{
	    send_string DV_TCP,"'MNMEN OFF',$0d"
	button_up = 1
    }
    }
}
}

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


