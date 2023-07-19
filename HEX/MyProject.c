char Display[] = { 63, 6, 91, 79, 102, 109, 125, 7, 127, 111 };
char contagem;
int trava=0,num, flag;  //usado para salvar o estado do botao
char Unidades; //usado para guardar o digito das unidades
char Dezenas; //usado para guardar o digito das dezanas

void interrupt ()
     {

                if(INTCON.TMR0IF==1)
                {
                       if(flag==1)
                       {
                       contagem++;
                       
                        if(contagem==40)
                        {
                         num--;
                         contagem =0;
                        }
                       }
                       TMR0=61;
                       INTCON.TMR0IF=0;
                }
      }

display_dezenas()
      {
       portc.rc4=1;
       Dezenas=(num/10);
       portd=Display[Dezenas];
       delay_ms(5);
       portc.rc4=0;
       portd=0;
      }

display_unidades()
      {
       portc.rc5=1;
       Unidades=(num%10);
       portd=Display[Unidades];
       delay_ms(5);
       portc.rc5=0;
       portd=0;
      }
      fim()
      {
       portd=63;
       portc.rc4=0;
       portc.rc5=0;
       delay_ms(500);
       portc.rc4=1;
       portc.rc5=1;
       delay_ms(500);
      }

void main()
     {

            ADCON1=7;
            TRISD=0;
            PORTD=0;
            TRISB=255;
            PORTB=255;
            TRISA.RA4=1;
            PORTA.RA4=1;
            TRISC=0;
            PORTC=0;
            INTCON.GIE=1;                               //HABILITA INTERRUPÇÃO GLOBAL
            INTCON.PEIE=0;
            INTCON.TMR0IE=1;                             //HABILITA TIMER 0
            TMR0=61;
            INTCON.TMR0IF=0;
            OPTION_REG=0b10000111;                      //HABILITA PRE ESCALER PARA 256
                                                        //TEMPO 0,5 MICRO *(256-6) = 1ms

            while(1)
            {
                 if(portb.rb1==0 || portb.rb2==0)
                       { flag=1;}
                 if(portb.rb2==0 && flag==1)
                       { flag=0; }

                   if(portb.rb0==0)
                   { num++;
                     delay_ms(250);
                   }
                   if(num==100)
                   { num=0; }          
                   if(num>=0)
                   {
                    display_dezenas();
                    display_unidades();
                   }

                   if(num<=0)
                   {
                    flag=0;
                    num=0;
                    fim();
                   }
            }
     }