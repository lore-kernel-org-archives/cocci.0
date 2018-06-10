From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 10 Jun 2018 08:34:01 +0200
Subject: [Cocci] High level restriction of function calls with SmPL
Message-ID: <8f24e468-34d5-7cce-9543-7833fc8e76f7@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I would like to try another source code transformation out with the help of
the semantic patch language.
The following approach can express a bit of information I became interested in.

 {
 ... when any
     when != action(..., input, ...)
 }


Now I am looking for ways to restrict (or filter) such function calls further.
The passed parameter should correspond to a specific data type property.
Can it be determined here together with a scripted constraint?

Regards,
Markus
