From: jklee@nosuchfail.org (Jonathan Klee)
Date: Thu, 06 Nov 2014 18:12:50 +0100
Subject: [Cocci] matching "..." va_list args
Message-ID: <545BAC12.90402@nosuchfail.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear all,

Since "..." basically means anything, I was wondering if we can match 
"..." va_list kind of arguments in a function prototype.
I would like to do something like :

@@
identifier f, a;
type T, A;
@@
-T f(A a, ...);
+T f(A a, ...) { va_list args; va_start(args, a); va_stop(args); }

Regards,
jklee
