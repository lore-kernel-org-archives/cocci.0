From: rob@hoelz.ro (Rob Hoelz)
Date: Mon, 15 Jan 2018 10:59:35 -0600
Subject: [Cocci] Patching string literal juxtaposition
In-Reply-To: <58ff3bae-29c1-19cf-99f1-5b96e7855101@users.sourceforge.net>
References: <20180109202248.7a1e4e1c@eridanus>
 <58ff3bae-29c1-19cf-99f1-5b96e7855101@users.sourceforge.net>
Message-ID: <20180115105935.430cae15@eridanus>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Jan 2018 14:30:16 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> > @@
> > constant char *stock_constant =~ "^GTK_STOCK";
> > @@
> >
> > -"+" stock_constant
> > +stock_constant
> >
> > For starters, Coccinelle doesn't seem to recognize string
> > juxtaposition (spatch gives me an error when I try this);  
> 
> It would be nice if this small source code adjustment could be
> specified also for the semantic patch language in such a convenient
> and succinct way. But the Coccinelle software provides a specific
> behaviour for string literals so far. I imagine then that you could
> achieve the desired transformation with an other approach.
> 
> * How do you think about to choose any of the supported programming
> languages for the construction of corresponding SmPL script rules?
>   http://coccinelle.lip6.fr/docs/main_grammar003.html
> 
> * A ?constant? could be stored in a script variable by this
> metavariable type. http://coccinelle.lip6.fr/docs/main_grammar002.html
> 
>   The received input string can be adjusted in ways you like by
> additional function calls from the available programming interfaces.
>   Would you like to propagate the constructed value back to another
> script rule by calling the SmPL method ?make_expr??
> 
> Regards,
> Markus
> 

I'm *very* much new to Coccinelle, so I think I'll have to trying the scripting
interface as per Julia's suggestion.  I think I need to experiment with Coccinelle
a bit (or a lot!) more to get the hang of it.

-Rob
