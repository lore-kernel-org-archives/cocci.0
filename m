From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 24 Feb 2014 17:14:26 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530B5FB6.6010207@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1402241710370.2074@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 24 Feb 2014, SF Markus Elfring wrote:

> > There is no need to put the ? else es.
>
> I get the following result for the adjusted search pattern.
>
>  void work at pos(...,data_type input,...)
>  {
>   ...
> ( if (!input) return;
> | if (input) is else es
> )
>   ...
>  }
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --sp-file
> list_input_parameter_validation2.cocci /usr/src/linux-stable/arch/um/kernel/sysrq.c
> ...
> function|"data type"|"parameter"|"source file"|line|column
> show_stack|"unsigned long
> *"|stack|"/usr/src/linux-stable/arch/um/kernel/sysrq.c"|67|6
>
>
> This example does not fit to my expectation because it seems that the function
> implementation does not refer to the passed values.
> Do you get any idea for this potential mismatch?

Sorry, I had been looking at the wrong function when I wrote my previous
response.

Indeed, there are some uses of isomorphisms at work here.  First the

if (input) is else es

is changed to

if (!input) es else is

and then that is changed to

if (!input) es

which matches the code at line 83.

I'm not sure what is the point of the if (input) is else es pattern.  I
would think you only want to find cases where the function does nothing
until it tests input and aborts the function is the value is 0.  So you
only want the return case.  Before it, you would want

... when != S

where S is a statement typed metavariable.  That way the ... will only
match declarations.

julia
