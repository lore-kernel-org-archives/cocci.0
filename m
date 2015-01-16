From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jan 2015 19:36:34 +0100
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
Message-ID: <54B95A32.9090600@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I?m trying to write a semantic patch to be able to find
> all `long` variables/function parameters in my code.

Can the desired semantic filter approach be also written
without a SmPL disjunction?

Would you like to try the following variant out?

@find_integer_variable@
identifier var;
@@
*long var
 ... ;
)

@find_integer_within_function_declaration@
identifier func, var;
@@
 func(...,
*     long var,
      ...);
)

@find_integer_from_function_definition@
identifier func, var;
@@
 func(...,
*     long var,
      ...)
 { ... }


Are you looking for more special cases in your source code?

Regards,
Markus
