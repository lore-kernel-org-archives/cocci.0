From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 29 Oct 2014 10:45:29 +0100
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <544FED2B.2030305@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
Message-ID: <5450B739.8050109@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> However, I fail to assemble those two patches in a single concise one.

How do you think about the following approach?

@Add_before_declaration@
identifier func;
type t;
@@
(
 #define func BAR(func)
 t func(...);
|
+#define func BAR(func)
 t func(...);
)

@Add_before_implementation@
identifier func;
type t;
@@
(
 #define func BAR(func)
 t func(...)
 { ... }
|
+#define func BAR(func)
 t func(...)
 { ... }
)


Do you need to express a detailed adjustment precondition for a safer semantic
patch?

Regards,
Markus
