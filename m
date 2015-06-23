From: skunk@iSKUNK.ORG (Daniel Richard G.)
Date: Tue, 23 Jun 2015 18:33:33 -0400
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <alpine.DEB.2.10.1506231430140.2554@hadrien>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
Message-ID: <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

On Tue, 2015 Jun 23 14:46+0200, Julia Lawall wrote:
> >
> > Bug 1: The patch adds a new "ctx" argument to calls to foo() and
> > qux(). If qux() is in the argument list of a call to foo(), however,
> > then the foo() call is not modified.
>
> Coccinelle picks one branch of the disjunction for matching against
> each "statement" (loop header, etc).  It also tried to enforce the
> prioritization of things early in a disjunction over things later.
> This means that in your example it can't match both something with
> arguments and something without.
> 
> On the other hand, the following works fine:
> 
> @expression@
> identifier F =~ "^(bar|qux)$";
> @@
>  F(
> +ctx,
>  ...)

Ohh, so Coccinelle knows to drop the comma if the matched function has
no arguments. That is helpful!

But I see that the original semantic patch will do

    -  x += bar(1, 0) + qux();
    +  x += bar(ctx, 1, 0) + qux(ctx);

The argument is added to qux() as before, but bar() now gets it too,
within the same expression/statement. I'm not understanding the "one
branch" limitation in view of this...

> > Bug 4: Coccinelle can't handle an expression whose content is
> > affected by a cpp conditional. (In my scenario, I would like it to
> > ignore the WIN32 side.) Can this be addressed with an appropriate
> > macro-file definition?
>
> The problem is that the #ifdef is being ignored.  It sees x +=
> _timezone timezone / 3600;  Unless you know the names of all the
> variables you want to ignore, I don't see an easy solution.

Coccinelle already does some preprocessor handling; there isn't a way to
tell it to look at only one side of a particular conditional? The
example I gave is a trivial one---the expression could be written out
twice---but there are others less amenable to such a rewrite.

> > There were also a couple of issues that appeared to be parse errors,
> > but were actually due to Coccinelle not recognizing C99 integer
> > types (e.g. "int32_t"). Would these not be reasonable to add to the
> > program's default initializations?
>
> Just add #define int32_t int to standard.h.

Right; I used --macro-file so not to depend on site-specific changes.
But aren't these types ubiquitous enough (if not in the Linux kernel
tree) that they would merit inclusion in the upstream standard.h? With
all the other definitions in that file, it would seem a bit odd to leave
out something as basic as this.

(Is there any advantage in writing "typedef int int32_t;" rather than
a #define?)

> Sorry not to have responded sooner.  Messages from nonmembers are
> moderated, and since most such messages are spam, I don't pay a lot of
> attention to them...

I suspected as much; thank you for pulling this needle from the haystack
:]


--Daniel


-- 
Daniel Richard G. || skunk at iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
