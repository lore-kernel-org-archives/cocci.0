From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 24 Feb 2014 11:55:22 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
Message-ID: <530B251A.4020307@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There is no need to put the ? else es.

Thanks for your explanation.

I get a "surprise" if I try out the following SmPL variant.

@safety_check@
identifier function, input;
type data_type;
position pos;
statement is, es;
@@
 void function at pos(...,data_type input,...)
 {
  ...
( if (!input) return;
| if (input) is else es
)
  ...
 }

@script:python collection depends on safety_check@
typ << safety_check.data_type;
fun << safety_check.function;
point << safety_check.input;
places << safety_check.pos;
@@
store_positions(fun, typ, point, places)


Response:
875 883
Fatal error: exception Failure("scriptmeta: parse error:
 = File "list_input_parameter_validation3.cocci", line 43, column 20,  charpos = 875
    around = 'function', whole content = fun << safety_check.function;


Can such names be reused which are key words@other places?

Regards,
Markus
