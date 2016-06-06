From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 6 Jun 2016 22:04:26 +0200 (CEST)
Subject: [Cocci] Further software updates after Coccinelle v1.0.5?
In-Reply-To: <a48e21fa-cde3-2e85-ee7f-3c8af8de1572@users.sourceforge.net>
References: <alpine.DEB.2.10.1606061112180.2909@hadrien>
 <a48e21fa-cde3-2e85-ee7f-3c8af8de1572@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1606062203090.2060@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 6 Jun 2016, SF Markus Elfring wrote:

> > Coccinelle v1.0.5 is now available.
> 
> Thanks for this software development progress.
> 
> 
> * I would appreciate that corresponding changes will become viewable
> also by the GitHub interface shortly.

I have no idea what you are asking for.  The file changes.txt is availabl 
in github all the time.

> * Would you like to add any comments to open issues like the following?
> 
> 
> > * Coccinelle is compatible with the latest release of OCaml, version 4.03.0
> 
> Software development challenges around OCaml-SmPL scripting interface
> with OCaml (>= 4.02.1 ?)
> https://github.com/coccinelle/coccinelle/issues/48
> 
> 
> > * Include files are now parse before the .c files that include them (quite
> > strangely, they were previously parsed afterwards).  This makes more
> > typedef information available when parsing the .c file, and can reduce
> > parse errors.
> 
> * Was another test case added for this implementation detail?
> * Is such header file inclusion still affected by command line parameters?

Yes.

> 
> > * Various improvements in the pretty printing of C code.
> 
> Will further considerations evolve around the topic "Make change
> influence configurable for coding style rules"?
> https://github.com/coccinelle/coccinelle/issues/37

No idea.

julia

> 
> > A more complete list of changes, including to the pycocci wrapper,
> > is available here: http://coccinelle.lip6.fr/distrib/changes.html
> 
> How do you think about to take another look here?
> 
> * Improve application programming interface design around match
> management functions
>   https://github.com/coccinelle/coccinelle/issues/64
> 
> * Fixed: PCRE bundle
>  
> https://github.com/coccinelle/coccinelle/commit/4ab8c0f230fe5b88c4fda55fba8137fc2e7d3f5d#diff-330c4cdb11d3a4bcb8e1446ed8022389R48
> 
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
