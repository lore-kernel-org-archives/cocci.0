From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 1 Dec 2014 11:24:58 +0100 (CET)
Subject: [Cocci] How to use coccinelle as a kind of grep -l ?
In-Reply-To: <547C3F10.4000307@inria.fr>
References: <547C3F10.4000307@inria.fr>
Message-ID: <alpine.DEB.2.02.1412011122160.2036@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 1 Dec 2014, Francois Berenger wrote:

> Hello,
> 
> Inside of applying any patch, I need to use coccinelle
> in order to detect certain C files that match a given pattern
> in a source code tree.
> 
> Is it possible to use coccinelle for that, how?

Yes.  One way is to put * on the lines of interest, in place of - or +.  
Then you will get a diff in which the matched lines of interest are marked 
with -.  With emacs diff mode, you can jump from the diff to the context 
in the source file.

Another way is to use position variables and use ocaml or python to print 
a message indicating wher you found whatever is of interest.

You can find many examples of both uses in the examples in the Linux 
kernel source tree, in the scripts/coccinelle subdirectory.

julia

> 
> -- 
> Regards,
> Francois.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
