From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 2 Nov 2017 15:21:02 +0100
Subject: [Cocci] Setting the section for a function with SmPL
Message-ID: <dae0fefb-6920-8e6a-76c6-b02b5fb0d4df@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Implementations of various functions will be changed on demand. It can happen
then that you would like to know if the applied changes will result also in
differences for the generated code.

Development tools like ?size? can display some information for such a comparison.
The total size display might be occasionally not so useful. I imagine that it
can help to split a default section configuration into smaller parts.
https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gcc/Common-Function-Attributes.html#index-section-function-attribute

I would like to append a corresponding attribute to a function signature by the
means of the semantic patch language.

@section_specification@
type T;
@@
T rcar_pcie_enable_msi(...)
+ __attribute__((section ("my_update")))
 {
 ...
 }


Unfortunately, the software ?Coccinelle 1.0.6-00345-g2ca0befa? does not like
such an approach so far.

elfring at Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/set_section1.cocci drivers/pci/host/pcie-rcar.c
?
plus: parse error: 
  File "/home/elfring/Projekte/Coccinelle/janitor/set_section1.cocci", line 6, column 1, charpos = 105
  around = '{',
  whole content =  {


Can the software situation be improved anyhow for this use case?

Regards,
Markus
