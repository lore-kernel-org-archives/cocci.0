From: mcuddie@qnx.com (Mitchell Cuddie)
Date: Thu, 20 Nov 2014 22:04:33 +0000
Subject: [Cocci] Ignore Code in Macro Def
Message-ID: <1416521057.28778.25.camel@QNXWS8653-PC>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I am working on a patch that manipulates null pointer usage. However the
second rule matches code inside macros which causes issues. Is there a
way to have rule 2 skip macros or rule 1 match against them and thereby
deactivate rule 2?

Cheers

Mitchell

@p_null disable is_null, isnt_null1, is_zero, isnt_zero@
expression *E;
type T;
position p;
T *f;
@@
(
    \(E\|f(...)\) == @p NULL
|
    \(E\|f(...)\) != @p NULL
|
    E =@p NULL
)

@np_null depends on !p_null && !ptr_zero disable is_null, isnt_null1,
is_zero, isnt_zero@
position p;
T g;
expression F;
@@
(
    \(F\|g(...)\)  == @p
-   NULL
+   0   
|
    \(F\|g(...)\)  != @p
-   NULL
+   0
|
    F  = @p
-   NULL
+   0
)
