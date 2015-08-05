#!/bin/bash

   #Onomatopeia campanes en Catala es:
   #ning-nang, ning-ning, ning nong, bim bom
   #Campanes hores : BOM  
   #Campanes quarts: Bim Bom


   ###
   ## Vars:
   #
   BELLS=""		#Max length 4x12 = 48 characters
   TWEET=""		#Max length 140 characters
   BASIC_HASHTAG=""	#Max length 12+1+11 = 24
   EXTRA_TAG=""		#For special days
   MSG=""		#140-48-24 = 68 characters left!!!
   MINUTE=`date "+%M"`
   HOUR=`date "+%I"`
   DAY=`date "+%d"`
   MONTH=`date "+%m"`
   YEAR=`date "+%Y"`

   #Two Basic hashtags lists. Some repeated to appear more
   HASHTG1=( \#Arenys \#ArenysdeMar \#Sinera \#GaiaVila \#AdM
             \#ViscArenys \#SomDArenys \#SomDeMar \#Setciències
             \#Sardinetes \#Arenyencs \#SomVERDS
             \#Arenys \#ArenysdeMar \#SomDeMar \#GaiaVila )
   HASHTG2=( \#Campanar \#Campanes \#Campanades )
   NUM_LIST1=$(( $RANDOM%${#HASHTG1[*]} ))
   NUM_LIST2=$(( $RANDOM%${#HASHTG2[*]} ))

   BASIC_HASHTAG="${HASHTG1[$NUM_LIST1]} ${HASHTG2[$NUM_LIST2]}"


   ###
   ## Generating the number of bells. 
   #
	       # 10# to indicate base 10, not octal!
   for (( i=0; i<10#`date "+%I"` ; i++ ))
   do
      BELLS="BOM $BELLS"
   done


   ###
   ## EXTRA TAG! For special days :D 
   #

   if [ $DAY == 01 -a $MONTH == 01 -a `date "+%H"` == 00 ]; then
      #Campanades
      for (( i=1; i<=12; i++ ))
      do  
         NUM_LIST1=$(( $RANDOM%${#HASHTG1[*]} ))
         TWEET="BOM - ${i}a Campanada - Campanar Arenys de Mar ${YEAR} ${HASHTG1[$NUM_LIST1]}"
         echo "$TWEET" | twitter tweet
         sleep 2 
      done
      BELLS=""
      MSG="Feliç ${YEAR}. Aquest any seguirem tuitejant les campanes "
       
   elif [ $DAY == 01 -a $MONTH == 01 ]; then
      MSG="- Bon Cap d'Any $YEAR " 
      EXTRA_TAG=" #$YEAR" 

   elif [ $DAY == 05 -a $MONTH == 01 ]; then
      EXTRA_TAG=" #Naps #Cols" 

   elif [ $DAY == 29 -a $MONTH == 02 ]; then
      MSG="- $YEAR any de traspàs " 
      EXTRA_TAG=" #Bixest" 

   elif [ $DAY == 21 -a $MONTH == 03 ]; then
      MSG="- Comença l'equinocci de primavera " 
      EXTRA_TAG=" #Primavera "

   elif [ $DAY == 23 -a $MONTH == 04 ]; then
      EXTRA_TAG=" #SantJordi #rosa #llibre"
  
   elif [ $DAY == 01 -a $MONTH == 05 ]; then
      EXTRA_TAG=" #1rDeMaig #treballador"
  
   elif [ $DAY == 21 -a $MONTH == 06 ]; then
      MSG="- Comença el solstici d'estiu " 
      EXTRA_TAG=" #Estiu "

   elif [ $DAY == 23 -a $MONTH == 06 ]; then
      EXTRA_TAG=" #Revetlla #SantJoan #Foguera"

   elif [ $DAY == 29 -a $MONTH == 06 ]; then
      MSG="- Crema de la Bota " 
      EXTRA_TAG=" #SantPere #Crema #LaBota"

   elif [ $DAY == 09 -a $MONTH == 07 ]; then
      MSG="- Honor y Glòria al patró d'Arenys de Mar " 
      EXTRA_TAG=" #SantZenon #FestaMajor"

   elif [ $DAY == 16 -a $MONTH == 08 ]; then
      MSG="- Visca Sant Roc gloriós " 
      EXTRA_TAG=" #SantRoc #Macips #almorratxa #FestaMajor"

   elif [ $DAY == 11 -a $MONTH == 09 ]; then
      MSG="- Diada Nacional de Catalunya " 
      EXTRA_TAG=" #Diada #Catalunya #11S "

   elif [ $DAY == 23 -a $MONTH == 09 ]; then
      MSG="- Comença l'equinocci de tardor " 
      EXTRA_TAG=" #Tardor "

   elif [ $DAY == 31 -a $MONTH == 10 ]; then
      EXTRA_TAG=" #Castanyada #panellets #moniatos #castanyes"

   elif [ $DAY == 21 -a $MONTH == 12 ]; then
      MSG="- Comença el solstici d'hivern " 
      EXTRA_TAG=" #Hivern "

   elif [ $DAY == 28 -a $MONTH == 12 ]; then
      MSG="- Aquest Cap d'Any, el raïm amb el campanar d'Arenys de Mar "  

   elif [ $DAY == 29 -a $MONTH == 12 ]; then
      MSG="- Per Cap d'Any, pren el raïm amb el campanar d'Arenys de Mar "  

   elif [ $DAY == 30 -a $MONTH == 12 ]; then
      MSG="- Demà tuitejarem les campanades, el raïm amb el campanar d'Arenys "  

   elif [ $DAY == 31 -a $MONTH == 12 -a `date "+%H"` == 23 ]; then
      MSG="- 1 hora pel canvi d'any. Tuitejarem les campanades! "  
      EXTRA_TAG=" #raïm "
      TWEET="$BELLS$MSG$BASIC_HASHTAG$EXTRA_TAG"
      echo "$TWEET" | twitter tweet
      #Els Quarts!
      sleep 59m 
      sleep 51 
      for (( i=1; i<=4; i++ ))
      do  
         NUM_LIST1=$(( $RANDOM%${#HASHTG1[*]} ))
         TWEET="Bim Bom - ${i}r Quart - Campanar Arenys de Mar ${HASHTG1[$NUM_LIST1]}"
         echo "$TWEET" | twitter tweet
         sleep 2 
      done
      BELLS=""
      MSG=""
      BASIC_HASHTAG=""
      EXTRA_TAG=""

   elif [ $DAY == 31 -a $MONTH == 12 ]; then
      MSG="- El raïm amb el campanar d'Arenys, despedim el $YEAR com cal "  
      EXTRA_TAG=" #raïm "

   fi


   ###
   ## Compacting the tweet
   #
   TWEET="$BELLS$MSG$BASIC_HASHTAG$EXTRA_TAG"


   ###
   ## Checking length of the tweet! if more than 140, only bells!
   #
   if [ ${#TWEET} -gt 140 ]; then
      TWEET="$BELLS"
   fi


   ###
   ## Sending Tweet!
   #
   echo "$TWEET" | twitter tweet


