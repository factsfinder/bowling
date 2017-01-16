#!/usr/bin/ksh

function enterName {
  trap "print 'You can't escape without entering your name..!'" INT EXIT
  read Name?"Please Enter you name: "
  while [ 1 ]
  do
   if [ "$Name" -eq "" 2> /dev/null ]
   then
      echo "You should enter your name to play the game..!"
      read Name?"Please enter your name..!";
   else
      banner "Welcome " $Name;
      break
   fi
  done
}

startBowling(){
   typeset score=0
   integer i=1
   #Collecting Frames 1 to 9  scores
   while [ i -lt 10 ]
   do
    let maxPoints=10
    echo "Frame $i"
    read ballOne?"First Ball No of pins down "

    while [[ $ballOne -gt $maxPoints || $ballOne -lt 0 ]]
    do
       echo "Please enter only intergers in range of 0 to 10..! Thank you."
       echo "Frame $i"
       read ballOne?"First Ball No of pins down "
    done

    if [ $ballOne -eq $maxPoints ]
    then
        echo "That's a Strike ==> 'X'"
        echo "You've got 10 points..! Let's wait for the Bonus"
        let ballTwo=0
        ((score=score+ballOne+ballTwo))
        scoreNine[i]="x"
        frameBallA[i]=$ballOne
        frameBallB[i]=$ballTwo
        echo "Onto the Next Frame..!\n"
      elif [[ $ballOne -lt $maxPoints  &&  $ballOne -gt -1 ]]
    then
        if [ $ballOne -eq 0 ]
        then
          echo "That's a Gutter Ball, means you get no points."
          echo "Now let's move onto ball two\n"
        fi

        let tempBallTwo=$(($maxPoints-$ballOne))
        read ballTwo?"Second ball No of pins down "

        while [[ $ballTwo -gt tempBallTwo || $ballTwo -lt 0 ]]
        do
          echo "Wrong Input. This is not possible in actual bowling..! Try again\n"
          read ballTwo?"Second ball No of pins down "
        done

        if [ $ballTwo -le $tempBallTwo ]
        then
          if [ $ballTwo -eq 0 ]
          then
              echo "That's a Gutter Ball, means you get no points.\n"
          fi

          ((score=score+ballOne+ballTwo))
          scoreNine[i]=$((ballOne+ballTwo))
          frameBallA[i]=$ballOne
          frameBallB[i]=$ballTwo

          if [ $((ballOne+ballTwo)) -eq 10 ]
          then
              echo "That's a spare ==> '/'"
              echo "Your total score now is $score"
              echo "You will get bonus of next frame's ball one\n"
          else
              echo "This frame score is $((ballOne+ballTwo))"
              echo "Your total score now is $score. Onto the next frame \n"
          fi
        else
         echo "Please enter only numbers"
        fi

    else
       echo "Please enter only numbers in the range of 1 to 10..!"
       continue
    fi
   ((i=i+1))
    done

   # implementing 10th frame
   integer j=1
   integer score10=0
   echo "This is your 10th and the last frame..!"
   echo "Here you can bowl a maximum of upto 3 balls..!\n"

   while [ j -lt 4 ]
   do
    echo "Frame 10"
    read ballOne?"First Ball No of pins down "
    while [[ $ballOne -gt maxPoints && $ballOne -lt 0 ]]
    do
      echo "That's not actually a possible number for this game. Use your brain bummer..!"
      echo "Once again please enter numbers only from 0 to 10"
      read ballOne?"First ball No of pins down "
    done

    if [ $ballOne -eq $maxPoints ]
    then
      echo "That's a Strike => "X"\n You've got 10 points"
      echo "Frame 10"
      read ballTwo?"Second Ball No of pins down "
      while [[ $ballTwo -gt maxPoints || $ballTwo -lt 0 ]]
      do
       echo "That's not actually a possible number for this game. Use your brain bummer..!"
       echo "Once again please enter numbers only from 0 to 10"
       read ballTwo?"Second ball No of pins down "
      done

      if [ $ballTwo -eq $maxPoints ]
      then
       echo "That's a Strike => "X"\n You've got 10 points"
       echo "Frame 10"
       read ballThree?"Third and Last Ball No of pins down "
       while [[ $ballThree -gt maxPoints || $ballThree -lt 0 ]]
       do
         echo "That's not actually a possible number for this game. Use your brain bummer..!"
         echo "Once again please enter numbers only from 0 to 10"
         read ballThree?"Third ball No of pins down "
       done
       if [ $ballThree -eq $maxPoints ]
       then
           read ballThree?"Third and Last Ball No of pins down "
         while [[ $ballThree -gt maxPoints || $ballTwo -lt 0 ]]
         do
           echo "That's not actually a possible number for this game. Use your brain bummer..!"
           echo "Once again please enter numbers only from 0 to 10"
           read ballThree?"Third ball No of pins down "
         done
         if [ $ballThree -eq $maxPoints ]; then
           echo "A strike => "X" 10 points for this.!\nAnd that's the end of your game"
           frame10Balls[1]=$ballOne
           frame10Balls[2]=$ballTwo
           frame10Balls[3]=$ballThree
           break

         elif [ $ballThree -eq 0 ]; then
           echo "A gutter ball again..! No luck for you today..!Game over..!"
           frame10Balls[1]=$ballOne
           frame10Balls[2]=$ballTwo
           frame10Balls[3]=$ballThree
           break

         else
           frame10Balls[1]=$ballOne
            frame10Balls[2]=$ballTwo
           frame10Balls[3]=$ballThree
            break
         fi
       fi
       read ballThree?"Third Ball No of pins down "
       while [[ $ballThree -gt $maxPoints || $ballThree -lt 0 ]]
       do
          echo "That's not actually a possible number for this game. Use your brain bummer..!"
          read ballThree?"Third ball No of pins down "
       done
       if [ $((ballTwo+ballThree)) -eq $maxPoints ]; then
          frame10Balls[1]=$ballOne
          frame10Balls[2]=$ballTwo
          frame10Balls[3]=$ballThree
          break
       else
          frame10Balls[1]=$ballOne
          frame10Balls[2]=$ballTwo
          frame10Balls[3]=$ballThree
          break
       fi #ballTwoeq10 when ballOneeq10
     fi
    elif [[ $ballOne -lt $maxPoints && $ballOne -gt -1 ]]
    then
      if [ $ballOne -eq 0 ]
      then
        echo "Gutter Ball means Zero Points..!"
        read ballTwo?"Second Ball No of balls down "
        while [[ $ballTwo -gt maxPoints || $ballTwo -lt 0 ]]
        do
          echo "That's not actually a possible number for this game. Use your brain bummer..!"
          echo "Once again please enter numbers only from 0 to 10"
          read ballTwo?"Second ball No of pins down "
        done

        if [ $ballTwo -eq 0 ]
        then
           echo "That's a gutter ball again..! You need more practice. Game over"
           frame10Balls[1]=$ballOne
           frame10Balls[2]=$ballTwo
           frame10Balls[3]=0
           break
        elif [ $ballTwo -eq $maxPoints ]
        then
            echo "That's a strike => "X" "
            read ballThree?"Third Ball No of balls down "
            while [[ $ballThree -gt maxPoints || $ballThree -lt 0 ]]
            do
              echo "That's not actually a possible number for this game. Use your brain bummer..!"
              echo "Once again please enter numbers only from 0 to 10"
              read ballThree?"Second ball No of pins down "
            done
            if [ $ballThree -eq 0 ]; then
               echo "A gutter ball. Zero Points. Game over"
               frame10Balls[1]=$ballOne
               frame10Balls[2]=$ballTwo
               frame10Balls[3]=$ballThree
               break
            elif [ $ballThree -eq $maxPoints ]; then
               echo "Good job..! Game over anyway..!"
               frame10Balls[1]=$ballOne
               frame10Balls[2]=$ballTwo
               frame10Balls[3]=$ballThree
               break
            else
               frame10Balls[1]=$ballOne
               frame10Balls[2]=$ballTwo
               frame10Balls[3]=$ballThree
               break
             fi #when ballThree is 0
        fi #when ballTwo is 0
       fi #when ballOne is 0

     echo "Try to make a spare here"
     read ballTwo?"Second Ball No of balls down "
     while [[ $ballTwo -gt maxPoints || $ballTwo -lt 0 || $ballTwo -gt $((maxPoints-ballOne))  ]]
     do
       echo "That's not actually a possible number for this game. Use your brain bummer..!"
       echo "Once again please enter numbers only from 0 to 10"
       read ballTwo?"Second ball No of pins down "
     done
     if [ $ballTwo -eq 0 ]
     then
        echo "A gutter ball => Zero Points and Game over..!"
        frame10Balls[1]=$ballOne
        frame10Balls[2]=$ballTwo
        frame10Balls[3]=0
        break

     elif [ $((ballOne+ballTwo)) -eq $maxPoints ]
     then
        echo "A Spare = > 10 points..!"
        read ballThree?"Third Ball No of balls down "
        while [[ $ballThree -gt maxPoints || $ballThree -lt 0 ]]
        do
          echo "That's not actually a possible number for this game. Use your brain bummer..!"
          echo "Once again please enter numbers only from 0 to 10"
          read ballThree?"Third ball No of pins down "
        done
        if [ $ballThree -eq 0 ]; then
           echo "A gutter ball. Zero Points. Game over"
           frame10Balls[1]=$ballOne
           frame10Balls[2]=$ballTwo
           frame10Balls[3]=$ballThree
           break
        elif [ $ballThree -eq $maxPoints ]; then
           echo "Two strikes in a row. Good job..! Game over anyway..!"
           frame10Balls[1]=$ballOne
           frame10Balls[2]=$ballTwo
           frame10Balls[3]=$ballThree
           break
        else
           echo "Game Over..!"
           frame10Balls[1]=$ballOne
           frame10Balls[2]=$ballTwo
           frame10Balls[3]=$ballThree
           break
        fi #when ballThree is 0
     else
         echo "Well Game Over for you...!"
         frame10Balls[1]=$ballOne
         frame10Balls[2]=$ballTwo
         frame10Balls[3]=0
         break
     fi #when ballOne is not zero or X and when ballTwo is zero
    else
     echo "Please enter only numericals and within the range of 0 to 10"
     continue
    fi #ballOne-eq10
   ((j=j+1))
   done
   
   #Printing Nine Frames Scores
   integer j=1
   integer nineframeScore=0
   while [ $j -le ${#scoreNine[*]} ]
   do
    echo "\t Frame $j Ball One Score is: ${frameBallA[$j]}"
    echo "\t Frame $j Ball Two Score is: ${frameBallB[$j]}"
    echo "Frame $j Score is: ${scoreNine[$j]}\n"
    ((nineframeScore=nineframeScore+${frameBallA[$j]}+${frameBallB[$j]}))
    ((j=j+1))
   done;

   echo "Your Nine Frames Score without Bonus is: $nineframeScore\n"

   #Printing Tenth Frame Scores
   integer y=1
   integer frame10Score=0
   while [ $y -le ${#frame10Balls[*]} ]
   do
    echo "Frame 10 Ball $y Score is: ${frame10Balls[$y]}"
    ((frame10Score=frame10Score+${frame10Balls[$y]}))
    ((y=y+1))
   done

   echo "Your Tenth Frame score total is : $frame10Score\n"
   
    let scoreWithoutBonus=$((nineframeScore+frame10Score))
   echo "Your total 10 frames score without bonus is: $scoreWithoutBonus";



      #calculate scores with bonus
   integer x=1
   integer bonusScore=0
   while [ x -lt 10 ]
   do
      if [[ ${frameBallA[$x]} -eq $maxPoints && ${frameBallB[$j]} -eq 0 ]]
      then
          let temp1=${scoreNine[x+1]}
          ((bonusScore=bonusScore+temp1))
      elif [[ ${frameBallA[$x]} -lt $maxPoints && ${scoreNine[$x]} -eq $maxPoints ]]
      then
          let temp2=${frameBallA[x+1]}
          ((bonusScore=bonusScore+temp2))
      else
          ((x=x+1))
          continue
      ((x=x+1))
      fi
   done



   #Total Score calculation
   let TotalScore = 0
   ((TotalScore=bonusScore+scoreWithoutBonus))
   echo "Your Complete Score: $TotalScore\n"


} #end of startBowling fucntion

#Save bowlers scores inside a file
saveScore(){
  integer n=1
  integer r=1
  printf "%s\t%d", $Name, date  > bowlers.txt
  while [ n -lt 10 ]
  do
     printf "\t%d\t%d\t", ${frameBallA[$n]}, ${frameBallB[$n]}  >> bowlers.txt
     ((n=n+1))
  done
  while [ r -lt 4 ]
  do
     printf "%d", ${frame10Balls[$r]} >> bowlers.txt
  done
}


#Creating an interactive menu with select command
banner "Welcome..!"
echo "Please check the options below and choose one..! Thank you..!"
while [ 1 ]
do
  PS3="Choose an Option ";
  select CHOICE in EnterName PlayGame SaveScore Quit
  do
    case $CHOICE in
      EnterName) enterName;;
       PlayGame) startBowling;;
      SaveScore) saveScore;;
           Quit) exit;;
              *) echo "\nInvalid Choice\nEnter 3 to Save your Scores\nEnter 4 to quit game\nEnter 1 to enter a new Player name\nEnter 2 to play the game";;
    esac
  done
done

           

