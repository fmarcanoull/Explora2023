# This scenario assumes there is a file "Explora", 
# in the default stimuli directory
scenario = "Explora DWI - MANO IZQUIERDA"; 
scenario_type = fMRI;
#scenario_type = fMRI_emulation;

# no_logfile = true;
default_delta_time = 1;   
default_font_size = 1;

$TR = 6000;
scan_period = $TR;   
pulses_per_scan = 1; # slices(no se hara sino con volumenes no con slices)
pulse_code = 30; 


#$DummyTime = 10000;			# 5 TR de dummies 

$ImageWidth = 800;
$ImageHeight = 600;

$TOTAL_VOLS = 58;
$TOTAL_SECS_EXP = '$TOTAL_VOLS * $TR'; 
$TIEMPO_T2 = 3000;		
$DummyTime = $TIEMPO_T2;			   # Para J12 ya tiene dummies (10). 

$EsperandoFMRITime = 0;

$CrossColor = "64,64,64";
$CrossSize = 36;

$TextColor = "255,255,255";
$TextSize = 32;

############## NOMBRES DE CODIGOS Y FICHEROS
$DUMMY 		= "DUMMY";
$ACTIVIDAD 	= "ACTIVIDAD_MANO_IZQUIERDA";
$INTRO 		= "INTRO";
$BEEP			= "REPOSO";
$BEEP2		= "ACTIVIDAD_MANO_IZQUIERDA";
$FIN			= "FIN";

$ACTIVIDADB 	= 	"pPrepareseParaActividad";
$INTROB 			= 	"pIntro";
$BEEPB			=  "pBeep";
$BEEP2B			=  "pBeep2";
$FINB				= 	"pMantengaseEnReposo";

$ACTIVIDADP 	= 	"PrepareseParaActividad.bmp";
$INTROP 			= 	"Intro.bmp";
$BEEPP			=  "Beep_IZQ.bmp";
$BEEP2P			=  "Beep2_IZQ.bmp";
$FINP				= 	"MantengaseEnReposo.bmp";

$ACTIVIDADF 	= 	"PrepareseParaActividad.wav";
$INTROF 			= 	"Intro_IZQ.wav";
$BEEPF			=  "Beep.wav";
$BEEP2F			=  "Beep2.wav";
$FINF				= 	"MantengaseEnReposo.wav";


# A cada inicio de onset, se le resta la duracion del sonido, el cual se suma en el momento que se presenta este durante el estimulo.
#
$DuracionFicheroACTIVIDAD	= 3705; 		# msg
$LapsoACTIVIDAD				= 0;		# msg (5" + 30")
$InicioACTIVIDAD 				= 0;

$DuracionFicheroINTRO		= 8219; 		# msg
$LapsoINTRO						= 0;	# msg (7" + 4'00")
$InicioINTRO 					= 0;

$DuracionFicheroFIN			= 1903; 		# msg
$LapsoFIN						= 0;		# msg (6" )
$InicioFIN	 					= 10000;

$DuracionFicheroBEEP			= 185; 		# msg
$LapsoBEEP						= 24000; # '24000 - $DuracionFicheroBEEP';			# msg (6" )
$InicioBEEP	 					= 0;

$DuracionFicheroBEEP2		= 470; 		# msg
$LapsoBEEP2						= '$TOTAL_SECS_EXP - $LapsoBEEP';			# msg (6" )
$InicioBEEP2	 				= 0;

begin;

picture {} default;
picture {} Pantalla_Oscura;

TEMPLATE "Bitmaps.tem" {
	fileName					bName;
	$ACTIVIDADP				$ACTIVIDADB;
	$BEEPP					$BEEPB;
	$BEEP2P					$BEEP2B;
	$INTROP					$INTROB;
	$FINP						$FINB;
};

trial{
	picture{
		background_color=0,0,0;
		text{
			caption="ESPERANDO PRIMER PULSO fMRI";
			font_size=40;
		};
		x=0;y=0;
	};
	time=0;
	code = "EsperandoPulsoFMRI";
}esperando_fmri_texto;

trial{
	trial_mri_pulse = 1;
}esperando_fmri_pulso;


################################ PROGRAMA ########################################### 

TEMPLATE "Explora.tem" {
	# nombreFichero	   etiquetaEvento		 activarEnInstante 
   audioName			   picName							label		 					start;
   $INTROF					$INTROB 						$INTRO 						$InicioINTRO;	
};


trial esperando_fmri_texto;
trial esperando_fmri_pulso;

trial{
		picture Pantalla_Oscura;
		delta_time =  0;
		code = $DUMMY;
};

TEMPLATE "ExploraDWI.tem" {
	# nombreFichero	   etiquetaEvento		 activarEnInstante 
   audioName			   picName						label		 					start;
   $BEEPF					$BEEPB 						$BEEP 						$DummyTime;	
   $BEEP2F					$BEEP2B 						$BEEP2 						$LapsoBEEP;	
	$FINF						$FINB							$FIN							$LapsoBEEP2;	
};
