From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 13:37:37 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>	<554DB33D.2000000@users.sourceforge.net>	<CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>	<554DE908.5060009@users.sourceforge.net>
 <CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>
Message-ID: <554DF181.5070707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> void main () {
>     (int) *s = &1;

I find the parentheses unnecessary for the data type specification.


>     *s =2;
>     p = malloc( sizeof (int)) ;

Is a single integer allocated for demonstration here?

Did you miss the data type specification for this variable?


> concerning *x at p1->y
> 
> it allows to detect the dereference of a pointer (x->y)

I would expect that the asterisk should not be placed
in the first text column of your SmPL script then.


How would you like to handle corresponding function calls?

https://cwe.mitre.org/data/definitions/690.html

Regards,
Markus
