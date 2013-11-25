From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Mon, 25 Nov 2013 17:05:11 +0100
Subject: [Cocci] purely syntactic transformations
Message-ID: <1385395511.3195.64.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi list,

I was thinking that it would be nice to have a Coccinelle option for
doing purely syntactic transformations, i.e. with no relation to the
control flow.

Indeed, while handling control-flow-sensitive transformations  is a so
powerful feature of Coccinelle (no doubt the most powerful one), there
are a number of simple, local syntactic transformations that become
artificially difficult because of the control flow handling. Typically,
there was a long discussion earlier this month about dropping "return;"
statements at the end of a void function.
https://systeme.lip6.fr/pipermail/cocci/2013-November/000492.html

Josh Triplett josh at joshtriplett.org wrote:
> I wanted to write a semantic patch that matched (and removed) "return;"
> at the end of a void function.  I've attached the full .cocci file
> written for coccicheck, but the key bit looks like this:
> 
> @@
> identifier fn;
> @@
> void fn ( ... )
> {
> ...
> - return;
> }
> 
> However, that patch also produces results like this:
> [...]

In summary, in order to take control flow features into account
(which are irrelevant here), the patch becomes much more complex.

There are other examples of simple syntactic transformations that
become artificially complicated, such as instrumenting the code
with traces, in presence of some return statements. 

So I was wandering if it would be difficult to have a command-line
option such as --no-control-flow to totally disable the construction
of the control flow graph and apply the rules simply on the AST.

Any thoughts on that?

Cheers,
Nic.
