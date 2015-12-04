From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Dec 2015 15:44:20 +0100 (CET)
Subject: [Cocci] Searching with SmPL for missing clean-up settings in
 designated initialisers
In-Reply-To: <56619B56.7040508@users.sourceforge.net>
References: <56603DC3.8040609@hurleysoftware.com>
 <56608E06.9060003@metafoo.de> <alpine.DEB.2.10.1512032310280.2777@hadrien>
 <20151203234832.GB20409@wotan.suse.de>
 <56619B56.7040508@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1512041543520.2764@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 4 Dec 2015, SF Markus Elfring wrote:

> > virtual context
> >
> > @ is_tty @
> > identifier fops;
> > @@
> > struct tty_operations fops = {
> > };
> >
> > @ tty_has_cleanup depends on is_tty @
> > identifier is_tty.fops;
> > identifier fn;
> > @@
> > struct tty_operations fops = {
> >         .cleanup = fn,
> > };
> >
> > @ depends on is_tty && !tty_has_cleanup && context @
> > identifier is_tty.fops;
> > @@
> > * struct tty_operations fops = {
> > };
>
> How do you think about a SmPL approach like the following?
>
>
> virtual show_context_diff
>
> @contains_member_functions@
> identifier var;
> struct operations =~ "^(?x)
> (?:
>    \w+_operations
> |
>    (?:
> # Alternation placeholder
>    )
> )$";
> @@
>  operations var = { ... };
>
> @contains_cleanup_function
>  contains_member_functions@
> expression assign;
> identifier release =~ "^(?x)
> (?:
>    cleanup
> |
>    (?:
> # Another alternation placeholder
>    )
> )$",
>            contains_member_functions.var;
> type contains_member_functions.operations;
> @@
>  operations var = { ...,
>                     .cleanup = (assign),
>                     ...
>                   };
>
> @show_member_functions
>  depends on show_context_diff
>             && contains_member_functions
>             && !contains_cleanup_function@
> identifier contains_member_functions.var;
> struct contains_member_functions.operations;
> @@
> *operations var = { ... };
>
>
> Would this SmPL script variant need any further fine-tuning
> (or other software extensions)?

I have no idea what the above does.  The previous proposed variants were
completely fine.

julia
