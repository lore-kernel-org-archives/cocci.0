From: mstefani@redhat.com (Michael Stefaniuc)
Date: Mon, 25 Mar 2013 17:09:08 +0100
Subject: [Cocci] parameter list to expression list?
Message-ID: <515076A4.1030701@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

is there an intrinsic way to get from a parameter list to an expression
list? That would come in handy when forwarding from one function to
another one. At the moment I help myself with a python rule that
transforms the parameter list to an identifier but that feels clumsy.
E.g. in SmPL pseudo code something like this would be nice:

@@
type T;
parameter list P;
expression list E = P;
expression ret;
@@
 T foo(P)
 {
     return
-           ret
+           bar(E)
     ;
 }



thanks
bye
	michael
