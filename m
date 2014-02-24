From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 24 Feb 2014 16:19:22 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530B5FB6.6010207@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1402241616500.2074@hadrien>
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

I'm not sure, but I think it has to do with the fact that the entire
function is an if where both branches leave the function.  It seems to be
considering that to be error-handling code.  It does not require to find
the complete pattern on execution paths that correspond to error-handling
code.  So it doesn't require to find the pattern at all.

In your case, I think you want to be completely sure that regardless of
the execution path chosen, the test is performed.  So you should put when
string after the first ... (ie the one after the first { ).

julia
