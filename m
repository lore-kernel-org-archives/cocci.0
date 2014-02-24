From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 24 Feb 2014 16:05:26 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
Message-ID: <530B5FB6.6010207@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> There is no need to put the ? else es.

I get the following result for the adjusted search pattern.

 void work at pos(...,data_type input,...)
 {
  ...
( if (!input) return;
| if (input) is else es
)
  ...
 }


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --sp-file
list_input_parameter_validation2.cocci /usr/src/linux-stable/arch/um/kernel/sysrq.c
...
function|"data type"|"parameter"|"source file"|line|column
show_stack|"unsigned long
*"|stack|"/usr/src/linux-stable/arch/um/kernel/sysrq.c"|67|6


This example does not fit to my expectation because it seems that the function
implementation does not refer to the passed values.
Do you get any idea for this potential mismatch?

Regards,
Markus
