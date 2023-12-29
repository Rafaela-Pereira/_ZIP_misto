Data dados_trat;

set dados;

   if (tratamento= 1) then do;

      t1 = 1;

      t2 = 0;

       t3 = 0;

       t4 = 0;

       t5=  0;

       t6=  0;

   end;

   else if (tratamento= 2) then do;

   t1 = 0;

   t2 = 1;

   t3 = 0;

   t4 = 0;

   t5=  0;

   t6=  0;

   end;

    else if (tratamento= 3) then do;

   t1 = 0;

   t2 = 0;

   t3 = 1;

   t4 = 0;

   t5=  0;

   t6=  0;

   end;

      else if (tratamento= 4) then do;

   t1 = 0;

   t2 = 0;

   t3 = 0;

   t4 = 1;

   t5=  0;

   t6=  0;

   end;

         else if (tratamento= 5) then do;

   t1 = 0;

   t2 = 0;

   t3 = 0;

   t4 = 0;

   t5=  1;

   t6=  0;

   end;

    else  do;

   t1 = 0;

   t2 = 0;

   t3 = 0;

   t4 = 0;

   t5=  0;

   t6=  1;

   end;

 

run;

 

 

proc nlmixed data= dados_trat;

   parameters beta0=-30

              beta1=0.05

              gamma2= 25

              gamma3 = 25

              gamma4= 25

              gamma5= 25

              gamma6= 25

              alpha0=-11

              sigma= 5 ;

   /*modelo do parâmetro p*/

   p = 1/(1+exp(-alpha0));

   /* Modelo do paraâmetro lambda */

   lambda   = exp(beta0 + beta1*dia + t2*gamma2+ t3*gamma3+t4*gamma4+

              t5*gamma5+ t6*gamma6 + log(total)+ b);

   /* Log-verossimilhança da ZIP */

   if incidencia=0 then

        ll = log(p + (1-p)*exp(-lambda));

   else ll = log((1-p)) - lambda  + incidencia*log(lambda) - lgamma(incidencia + 1);

   model incidencia ~ general(ll);

   random b ~ normal(0,sigma) subject= ramo;

   estimate 'gamma2-gamma3' gamma2-gamma3;

   estimate 'gamma3-gamma4' gamma3-gamma4;

   estimate 'gamma4-gamma5' gamma4-gamma5;

   estimate 'gamma5-gamma6' gamma5-gamma6;

   predict incidencia out=predito;

run;

 
