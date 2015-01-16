From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 16 Jan 2015 21:05:43 +0100
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <559AE227-484E-42F1-94ED-DB703D630EE3@gmail.com>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
 <54B95A32.9090600@users.sourceforge.net>
 <559AE227-484E-42F1-94ED-DB703D630EE3@gmail.com>
Message-ID: <54B96F17.8080206@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Rule for function declaration doesn?t (gives parse error too).

Will the semantic filter approach work better if you specify
a return type for the searched functions explicitly?

@find_integer_within_function_declaration@
identifier func, var;
type return_type;
@@
 return_type
 func(...,
*     long var,
      ...);
)

@find_integer_from_function_definition@
identifier func, var;
type return_type;
@@
 return_type
 func(...,
*     long var,
      ...)
 { ... }



> Can I be added to such list, or is it somehow restricted?

Would you like to subscribe to this mailing list?
http://coccinelle.lip6.fr/contact.php

Regards,
Markus
