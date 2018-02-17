From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Feb 2018 23:43:08 +0100 (CET)
Subject: [Cocci] might be bug report, breaking up of a comment
In-Reply-To: <kky3jrgtjg.fsf@bora.foobar.de>
References: <kkd113ibim.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1802172243470.12418@hadrien> <kky3jrgtjg.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1802172341300.12418@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 17 Feb 2018, Robert Larice wrote:

> Julia Lawall <julia.lawall@lip6.fr> writes:
>
> > On Sat, 17 Feb 2018, Robert Larice wrote:
> >
> >> Hello,
> >>
> >>   attached is a small example which seems to
> >>     break up a comment line,
> >>     thus commenting out following lines.
> >>
> >>   Please look at the "long reuse" line
> >>     which will have an open comment when spatch is run,
> >>     thus commenting out the following "struct line *options"
> >
> > I also see this undesriable behavior.  Thanks for the report.
> >
> > julia
>
> grepping a bit in the source code I found this:
>   cpp_eat_until_nl
> perhaps in the vicinity of the issue.
>
> and there is this comment somewhere:
>
> (* cpp recognize C comments, so when #define xx (yy) /* comment \n ... */
>  * then he has already erased the /* comment. So:
>  * - dont eat the start of the comment otherwise afterwards we are in the middle
>  *   of a comment and so will problably get a parse error somewhere.
>  * - have to recognize comments in cpp_eat_until_nl.
>  *)

Thanks for the help, but that's not it at all.  The problem is in the
function get_indent in the file parsing_c/unparse_c.ml.  I'll try to fix
it tomorrow.

julia
