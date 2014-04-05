From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 5 Apr 2014 19:47:23 +0200 (CEST)
Subject: [Cocci] Trivial question about renaming prototypes in .h files
In-Reply-To: <20140405155421.GA20098@harvey.netwinder.org>
References: <20140405155421.GA20098@harvey.netwinder.org>
Message-ID: <alpine.DEB.2.02.1404051944510.2029@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 5 Apr 2014, Ralph Siemsen wrote:

> Hi all,
> 
> Is it possible to apply sematic patches to prototypes in header files?
> I've experimented with the various -include options, and have tried several
> different versions of spatch, but I can't seem to make this work.
> I'm using the basic example 13.1 from the main_grammar.pdf document:
> 
> @@
> @@
> -foo()
> +bar()
> 
> This works fine when applied to .c files, but it does not seem to want to
> rename prototypes in header files. Renaming the .h to a .c does not seem
> to work either.
> 
> Am I missing something obvious?

I'm not sure to understand what you are trying to do.  This replaces one 
expression by another.  There are no expressions in a function prototype.

If you want to rename the function foo to bar, then you would write:

@@
@@

- foo
+ bar
    () { ... }

This should update any prototype of the function as well.

You may want to try the options --include-headers --no-includes

julia
