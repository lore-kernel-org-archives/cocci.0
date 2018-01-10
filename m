From: rob@hoelz.ro (Rob Hoelz)
Date: Tue, 9 Jan 2018 20:22:47 -0600
Subject: [Cocci] Patching const char * constants
Message-ID: <20180109202248.7a1e4e1c@eridanus>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Coccinelle community,

I just discovered Coccinelle a few days ago, and already my mind is reeling with the possibilities.
I'm doing some work porting the Claws Mail mail client to GTK3, and I think Coccinelle would be a
great tool to use to accomplish this task.

One of the thing I'm trying to use Coccinelle to do is to detect and patch string concatenation via
string literal juxtaposition; for example:

> ...
>  GTK_STOCK_NO, "+" GTK_STOCK_YES, NULL);

I would like to write a spatch that does something like the following:

> @@
> constant char *stock_constant =~ "^GTK_STOCK";
> @@
>
> -"+" stock_constant
> +stock_constant

For starters, Coccinelle doesn't seem to recognize string juxtaposition (spatch gives me an error when
I try this); secondly, I can't seem to get "constant char *p" to match *any* string literals.  For example,
take this simple test program:

> int
> main(void)
> {
>    const char *p = "bar";
>    return 0;
> }

If I just use "constant p", it'll match the 0 literal in the return statement.  I can use "constant int p" to
make only that 0 match, but I'd like to match the "bar" string literal, and "constant char *p" doesn't seem to
work.  Is there some way I can get Coccinelle to match only string literals to a metavariable?

Another quick question: is there a way to tell Coccinelle to dump its AST so I can see which type an expression
has been assigned?  Having such a tool might help me get more familiar with the tool!

Thanks,
Rob
