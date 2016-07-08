From: Frederic.LEROY@b-com.com (=?iso-8859-1?Q?Fr=E9d=E9ric_LEROY_=28ext=29?=)
Date: Fri, 8 Jul 2016 10:50:50 +0000
Subject: [Cocci] Add a parameter to function
Message-ID: <f2e0fa46cc354563ae8bfd52fc5f35fa@vprd-opci0018.b-com.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I made a test case, I try to add a parameter S to a function :
--------8<----------------8<----------------8<--------
void a();                                          
void z(void);                                      
void b(int i);                                     
void c(int i, char c);                             
                                                   
                                                   
void a() {                                         
    int b=5;                                       
}                                                  
                                                   
void z(void) {                                     
    int b=5;                                       
}                                                  
                                                   
                                                   
void b(int i) {                                    
    int b = 5 + i;                                 
}                                                  
                                                   
void c(int i, char c) {                            
    int b = i + c;                                 
}       
--------8<----------------8<----------------8<--------

The problem I have is when I have a void or empty declaration.
The only way I found is to rely rule dependencies :

--------8<----------------8<----------------8<--------
@ rule1 @
identifier fn;
parameter list pl;
@@

- fn(void)
+ fn(int s)
{ ... }

@ rule2 @
identifier fn;
parameter list pl;
@@

- fn()
+ fn(int s)
{ ... }

@ depends on !(rule1 || rule2) @
identifier fn;
parameter list pl;
@@

- fn(pl)
+ fn(int s, pl)
{ ... }
--------8<----------------8<----------------8<--------

Is there a better way to achieve this ?

Kind regards,

Fr?d?ric
