From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 9 Mar 2014 14:06:09 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <531C63B8.6090403@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
 <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
 <531C1FAD.6030009@users.sourceforge.net>
 <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
 <531C63B8.6090403@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403091404230.2101@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 9 Mar 2014, SF Markus Elfring wrote:

> > Have a special rule for such functions and use position variables to
> > prevent the rule that matches interesting parameter lists from matching
> > functions that have satisfied this case:
>
> I have adjusted your suggestion a little bit here.
>
> @no_input@
> identifier fun;
> position pos;
> @@
>  fun at pos(void) { ... }
>
> @input depends on no_input@
> identifier fun;
> parameter list [count] pl;
> position pos != no_input.pos;
> @@
>  fun at pos(pl) { ... }
>
> @script:python collection depends on input@

No need for depends on input.  For a python rule, all metavariables have
to be bound before anything happens.

> fun << input.fun;
> count << input.count;
> places << input.pos;
> @@
> store_positions(fun, count, places)
>
>
> This pattern variant works as expected for a source code example that was
> already mentioned before.
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --sp-file
> list_function_parameters2.cocci ../Probe/f-ptr-test1.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: ../Probe/f-ptr-test1.c
> function|"parameter count"|"source file"|line|column
> my_log|1|"../Probe/f-ptr-test1.c"|1|6
> my_safe_log|1|"../Probe/f-ptr-test1.c"|6|5
> my_addition|2|"../Probe/f-ptr-test1.c"|25|5
>
>
> But I wonder about the processing for the following small source file.
>
> void my_log(char const * format, ...)
> {
>   /* Write something ... */
> }
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt --sp-file
> list_function_parameters2.cocci ../Probe/ellipsis-test1.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: ../Probe/ellipsis-test1.c
> No result for this analysis!
>
>
> I would appreciate your advices.

I have no idea.  I would have sort of expected that it would return a
length of 2, but I guess it is reasonable, and even desirable, that it
does not.  What answer would you like?

julia
