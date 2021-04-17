PROGRAM_NAME='proje'
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
DV_Samsung	=	5001:5:0
DV_Video	=	5001:2:0
DV_TV		=	5001:1:0
DV_TCP		=	0:3:0
DV_RELAY	=	5001:4:0

(*			Panel				*)
DVTP_Samsung	=	10001:1:0
DVTP_Video	=	10001:2:0
DVTP_TV		=	10001:3:0
DVTP_TCP	=	10001:4:0
DVTP_RELAY	=	10001:5:0

(* 			Virtual Device			*)

VDV_Samsung	=	33001:1:0
VDV_TV		=	33002:1:0
VDV_Video	=	33003:1:0
VDV_TCP		=	33004:1:0
VDV_RELAY	=	33005:1:0

DEFINE_COMBINE

(DVTP_Samsung, VDV_Samsung)
(DVTP_Video, VDV_Video)
(DVTP_TV, VDV_TV)
(DVTP_TCP, VDV_TCP)	
(DVTP_RELAY, VDV_RELAY)

DEFINE_CONSTANT
(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
char avr_ip = '192.168.1.34'
	
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

integer ses = 1

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
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
    
    //RS232
    DATA_EVENT[DV_TV]
    {
	ONLINE:
	{
	    SEND_COMMAND DV_TV, 'SET BAUD 9600, N, 8, 1, 485 DISABLE'
	    SEND_COMMAND DV_TV, 'HSOFF'
	    SEND_COMMAND DV_TV, 'XOFF'
	}
    
}
    DATA_EVENT[DV_Video]
    {
	ONLINE:
	{
	    SEND_COMMAND DV_Video, 'SET BAUD 9600, N, 8, 1, 485 DISABLE'
	    SEND_COMMAND DV_Video, 'HSOFF'
	    SEND_COMMAND DV_Video, 'XOFF'
	}
    
}
    (* TV Power on *)
    button_event[VDV_TV, 1]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$41,$30,$43,$02,$43,$32,$30,$33,$44,$36,$30,$30,$30,$31,$03,$73,$0d"

	}
    }
    
    (* TV Power off  *)
    button_event[VDV_TV, 2]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$41,$30,$43,$02,$43,$32,$30,$33,$44,$36,$30,$30,$30,$34,$03,$76,$0d"
	}
    }
    (* TV Volume up   *)
    button_event[VDV_TV, 3]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$31,$30,$45,$30,$41,$02,$31,$30,$41,$44,$30,$30,$30,$31,$03,$01,$0d"
	}
    }
    
    (*  TV Volume down  *)
    button_event[VDV_TV, 4]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$31,$30,$45,$30,$41,$02,$31,$30,$41,$44,$30,$30,$30,$32,$03,$02,$0d"
	}
    }
    
    (*  TV Mute ON   *)
    button_event[VDV_TV, 5]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$38,$44,$30,$30,$30,$31,$03,$09,$0d"
	}
    }
    
    (*  TV Mute OFF    *)
    button_event[VDV_TV, 6]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$38,$44,$30,$30,$30,$32,$03,$0A,$0d"
	}
    }
    
    (*  TV Channel Up  *)
    button_event[VDV_TV, 7]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$38,$42,$30,$30,$30,$31,$03,$0F,$0d"
	}
    }
    
    (*  TV Channel Down  *)
    button_event[VDV_TV, 8]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$38,$42,$30,$30,$30,$32,$03,$0C,$0d"
	}
    }

    (*  TV VGA  *)
    button_event[VDV_TV, 9]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$30,$31,$03,$73,$0d"
	}
    }

    (*  TV Input Switch HDMI1 *)
    button_event[VDV_TV, 10]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$31,$31,$03,$72,$0d"
	}
    }
    
    (*  TV Input Switch HDMI2 *)
    button_event[VDV_TV, 11]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$31,$32,$03,$71,$0d"
	}
    }
    
    (*  TV Input Switch HDMI3 *)
    button_event[VDV_TV, 12]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$31,$33,$03,$70,$0d"
	}
    } 

    (*  TV  Input Switch Video (Composite)*)
    button_event[VDV_TV, 13]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$30,$35,$03,$77,$0d"
	}
    } 
    
    (*  TV Input Switch TV*)
    button_event[VDV_TV, 14]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$30,$41,$03,$73,$0d"
	}
    } 

    (*  TV Input Switch Video (Component)*)
    button_event[VDV_TV, 15]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$41,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$30,$43,$03,$01,$0d"
	}
    } 
    
    (*  TV Input Switch USB*)
    button_event[VDV_TV, 16]
    {
	push:
	{
	    send_string DV_TV, "$01,$30,$31,$30,$45,$30,$41,$02,$30,$30,$36,$30,$30,$30,$31,$34,$03,$07,$0d"
	}
    } 
    
    (* Audio Power ON  *)
    button_event[VDV_Video, 1]
    {
	push:
	{
	    send_string DV_Video, "'PowerON.'"
	}
    }

    (* Audio Power OFF  *)
    button_event[VDV_Video, 2]
    {
	push:
	{
	    send_string DV_Video, "'PowerOFF.'"
	}
    }

    (* Audio Matrix   *)
    button_event[VDV_Video, 3]
    {
	push:
	{
	    send_string DV_Video, "'OUT[01][01]'"
	}
    }

    button_event[VDV_Video, 4]
    {
	push:
	{
	    send_string DV_Video, "'OUT[02][01]'"
	}
    }
    button_event[VDV_Video, 5]
    {
	push:
	{
	    send_string DV_Video, "'OUT[01][02]'"
	}
    }
    button_event[VDV_Video, 6]
    {
	push:
	{
	    send_string DV_Video, "'OUT[02][02]'"
	}
    }
    
    (* IR  *)
    button_event[VDV_Samsung, 0]
    {
    push:
    {
	IF((button.input.channel <35) and (button.input.channel >0))
	    {
	    pulse[DV_Samsung, button.input.channel]
	    }
	}
    }
    (* IR Power Off 		*)
    button_event[VDV_Samsung, 14]
    {
    push:
    {
	pulse[DV_Samsung, 14]
    }
    }
    (* IR Power On      *)
    button_event[VDV_Samsung, 13]
    {
    push:
    {
	pulse[DV_Samsung, 13]
    }
    }
    
    (*    TCP POWER ON   *)
    button_event[VDV_TCP, 1]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'PWON',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }
    
    (*    TCP POWER OFF  *)
    button_event[VDV_TCP, 2]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'PWSTANDBY',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }
    
        (*    TCP Volume Up  *)
    button_event[VDV_TCP, 3]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'MVUP',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }
    
    (*    TCP Volume Dwon  *)
    button_event[VDV_TCP, 4]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'MVDOWN',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }

    (*    TCP MUTE ON   *)
    button_event[VDV_TCP, 5]
    {
    push:
    {	
	IF(ses == 1)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'MUON',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	
	wait 3
	
	ses = 0
	}
	ELSE IF(ses == 0)
	{
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'MUOFF',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
	
	wait 3
	
	ses = 1
    }
    }
    }

    (*    TCP DVD SWITCH  *)
    button_event[VDV_TCP, 6]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'SIDVD',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }

    (*    TCP CD SWITCH  *)
    button_event[VDV_TCP, 7]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'SICD',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }

    (*    TCP GAME SWITCH  *)
    button_event[VDV_TCP, 8]
    {
    push:
    {
	IP_CLIENT_OPEN(DV_TCP.PORT,avr_ip,23,1)
	    send_string DV_TCP,"'SIGAME',$0d"
	IP_CLIENT_CLOSE(DV_TCP.PORT)
    }
    }
    
    (*   Perde indir *)
    button_event[VDV_RELAY,1]
    {
    push:
    {
	ON[DV_RELAY, 1]
	OFF[DV_RELAY, 2]
    }
    }
    
    (* perde kaldýr *)
    button_event[VDV_RELAY,2]
    {
    push:
    {
	OFF[DV_RELAY, 1]
	ON[DV_RELAY, 2]
    }
    }
    
    (* perde stop *)
    button_event[VDV_RELAY,3]
    {
    push:
    {
	OFF[DV_RELAY, 1]
	OFF[DV_RELAY, 2]
    }
    }
DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


