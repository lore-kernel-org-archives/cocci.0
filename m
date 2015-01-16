From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jan 2015 18:55:50 +0100
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
Message-ID: <54B950A6.1040707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> But I get parse errors no matter what I try.

I guess that I can not really help with parsing difficulties
in your case.


> Where?s my error?

I find that your SmPL disjunction can also be written in
a slightly different way.
Would you like to try out the following semantic filter approach?

@find_big_integers@
identifier func, var;
@@
(
*long var
 ... ;
|
 func(...,
*     long var,
      ...);
|
 func(...,
*     long var,
      ...)
 { ... }
)

Regards,
Markus
