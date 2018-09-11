!------------------------------------------------------------------------------
!- Bonking Barrels Version 0.1 modification 3
!-
!- 25 April 2015 AB Sayuti HM Saman
!- Editing: CBM Prg Studio 2.9.x from ajordison.co.uk
!- Based on Bonking Barrels for Commodore 64
!- (Published in Compute!'s Gazette some time in the 80s)
!------------------------------------------------------------------------------
10 gosub 620: rem Initialisation, instruction, opening
20 do
30     live=3: sc=0
40     do while live>0
50         gosub 930: rem Setup game screen
60         gosub 1030: rem Reset barrels, counters, timers
70         do
80             gosub 200: rem Main game routine
90             if hit=1 then begin
100                 gosub 580: rem lose man
110                 exit
120             bend
130             t=t+1
140             gosub 600: rem update score, time etc
150         loop until t>tmax
160     loop
170     gosub 1140: rem Game over
180  loop
190 end
!------------------------------------------------------------------------------
!-                         Main game routine
200 gosub 320: rem move barrels
210 rem print "{home}";peek(dec("d01e")): rem detect collision flag
220 rem
230 rem
240 rem
250 rem
260 rem
270 rem
280 rem
290 rem
300 rem
310 return
!------------------------------------------------------------------------------
!-                             Move barrels
320 for i=1 to bmax
330     bx(i)=bx(i)+dx(i)
340     if bx(i)>35 then dx(i)=-1
350     if bx(i)<2 then dx(i)=1
360     if peek(sm%+120*by(i)+bx(i))=cs% and peek(sm%+120*by(i)+bx(i)+2)=cs% then begin
370         by(i)=by(i)+1
380         if by(i)>8 then by(i)=1: bx(i)=rnd(0)*36+1: dx(i)=-dx(i)
390     bend
400     movspr i,x0+bx(i)*8, y0+24*by(i)
410 next
420 rem
430 rem
440 rem
450 rem
460 rem
470 return
!------------------------------------------------------------------------------
!-                             Man jumps
480 for j=1 to 100
490   for i=1 to 3
500     sprsav y$(i),8
510     if i=3 then movspr 8,+0,-20
520     sleep 1
530   next
540 next
!------------------------------------------------------------------------------
!-                             Collision subroutine
550 print "{home}";tab(10);bump(1);tab(20);bump(2)
560 rem
570 return
!------------------------------------------------------------------------------
!-                             Lose man
580 rem
590 return
!------------------------------------------------------------------------------
!-                         Update score etc
600 print "{home}time: ";t;tab(8);peek(dec("d01e"));tab(18);sc;tab(35);hs
610 return
!------------------------------------------------------------------------------
!-                            Initilialisation
620 sm%=1024: rem screen memory
630 cs%=32: rem char code for space
640 my=3: rem multiplier for Y
650 graphic 1: graphic 0,1: color 0,1: color 4,1: color 5,2
660 print "please wait..."
670 bmax=4: rem Number of barrels
680 lmax=3: rem Maximum lives
690 rem Setup sprite data for barrel
700 for i=0 to 62
710     read x: poke dec("0e00")+i,x
720 next
730 sprsav 1,x$: rem save the pattern
740 sprsav x$,2: sprsav x$,3: sprsav x$,4
750 rem Setup sprite data for man
760 dim y$(3)
770 for j=1 to 3
780     for i=0 to 62
790         read x: poke dec("0fc0")+i,x
800     next i
810     sprsav 8,y$(j)
820 next j
830 rem Switch on sprites
840 sprite 8,1,8: rem player
850 for i=1 to bmax
860     sprite i,1,8+i,1,0,0,0 : rem barrels
870 next i
880 sleep 1
890 rem
900 rem
910 rem
920 return
!------------------------------------------------------------------------------
!-                           setup game screen
930 scnclr
940 print
950 for j=1 to 7
960     print "{cm +}{space*38}{cm +}";
970     print "{cm +}{space*38}{cm +}";
980     print "{cm +}{cm @*38}{cm +}";
990     x = rnd(0)*36+1
1000     poke sm%+120*j+x,cs%: poke sm%+120*j+x+1,cs%: poke sm%+120*j+x+2,cs%:
1010 next
1020 return
!------------------------------------------------------------------------------
!-                         Init barrels, counters etc
1030 x0=22: y0=36
1040 rem place barrels
1050 for i=1 to bmax
1060     bx(i)=i*4: by(i)=i+3: dx(i)=1
1070     movspr i,x0+bx(i)*8,y0+24*by(i)
1080 next
1090 rem place man
1100 movspr 8,x0+10,y0+24*8
1110 hit=0
1120 t=0: tmax=1000
1130 return
!------------------------------------------------------------------------------
!-                         Game over play again
1140 rem
1150 rem
1160 rem
1170 rem
1180 return
!------------------------------------------------------------------------------
!-                           Sprite data
1190 rem Barrel
1200 data 0,255,0,7,129,224,28,126,48,51,239,216,47,223,236,111
1210 data 255,116,95,126,246,94,255,251,223,251,253,187,247,237,191,255
1220 data 253,175,223,189,191,191,253,223,254,251,94,253,246,109,255,244
1230 data 55,247,236,27,239,216,12,126,48,7,129,224,0,255,0
1240 rem Man - squatting
1250 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1260 data 0,0,0,0,0,0,24,0,0,60,0,0,60,0,0,24
1270 data 0,0,231,0,1,255,128,3,126,192,6,60,96,8,60,16
1280 data 0,60,0,0,126,0,1,195,128,0,36,0,0,102,0
1290 rem Man - Arms up
1300 data 0,129,0,0,0,0,0,153,0,0,189,0,0,189,0,0
1310 data 153,0,0,231,0,0,255,0,0,60,0,0,60,0,0,60
1320 data 0,0,60,0,0,60,0,0,60,0,0,36,0,0,36,0
1330 data 0,36,0,0,36,0,0,36,0,0,0,0,0,102,0
1340 rem Man - standing
1350 data 0,0,0,0,0,0,0,24,0,0,60,0,0,60,0,0
1360 data 24,0,0,231,0,0,255,0,0,255,0,0,189,0,0,189
1370 data 0,0,189,0,0,60,0,0,189,0,0,36,0,0,36,0
1380 data 0,36,0,0,36,0,0,36,0,0,0,0,0,102,0