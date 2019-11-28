/* PaperRound
 * Author: ayoobm
 * Creation date: 11/13/19
 */
MACHINE  PaperRound
  
  
  VARIABLES 
    houseset , delivered
   
  
  SETS ANSWER = { yes, no } ; PaperOrMag = { paper, magazine}

  INVARIANT 
    houseset <: NAT1 & delivered <: NAT1 & houseset > 10

  INITIALISATION 
    houseset , delivered := {} , {}

  OPERATIONS

    add(new) =
      PRE  new : NAT1  &  new /: houseset
      THEN houseset := houseset \/ { new }
    END;

    ans <-- numberOfHouses =
        BEGIN
          ans := card( houseset )
        END;
    ans <-- firsthouse =
      PRE  card(houseset) > 1
      THEN ans := min(houseset)
    END;
    
    ans <-- lasthouse =
      PRE  card(houseset) > 1
      THEN ans := max(houseset)
    END;
    
    ans <-- haspaper(number) =
      PRE  card(houseset) > 1 & number : NAT1
      THEN 
          IF (number : houseset)
          THEN
              ans := yes
          ELSE
              ans := no
          END
    END;
    
    stopdelivery (number) = 
    PRE number : NAT1 & number : houseset
    THEN 
        houseset := houseset - {number}
        /* did not implement the message functionality*/
    END;
    
    deliverMagazine(number) =
    PRE number : NAT1 & number : houseset & number /: delivered
    THEN 
        delivered := delivered \/ { number }
    END;
    
    stopMagazine(number) =
    PRE number : NAT1 & number : houseset & number : delivered
    THEN 
        delivered := delivered - { number }
    END;
    
    ans <-- deliveries(number) =
      PRE number : NAT1
      THEN 
          IF (number: houseset)
          THEN
              ans := paper
          ELSE
              ans := magazine
          END
          
    END;
    
    stopalldeliverys(number) = 
    PRE number : houseset & number : delivered
    THEN
        houseset , delivered := houseset - {number} , delivered - {number}
    END
    
END