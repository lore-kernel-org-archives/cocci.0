From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 10 Feb 2018 16:15:20 +0100 (CET)
Subject: [Cocci] please help me with a failing match
In-Reply-To: <87wozkkhsg.fsf@t-online.de>
References: <kkk1vlt55g.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1802101422060.3317@hadrien> <87wozkkhsg.fsf@t-online.de>
Message-ID: <alpine.DEB.2.20.1802101613320.3317@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 10 Feb 2018, Robert Larice wrote:

> Julia Lawall <julia.lawall@lip6.fr> writes:
>
> > On Sat, 10 Feb 2018, Robert Larice wrote:
> >
> >> Dear People,
> >>
> >>   I'm completely new here.
> >>
> >>   Attached is a small piece of .c and a .cocci file.
> >>   There is a "return 41;" in both files, commented out.
> >>   If I uncomment this "return 41;" in both files then
> >>     spatch will not match the pieces any more.
> >>
> >>   Could you please help me to undertand and circumvent this issue ?
> >
> > I have not noticed this problem before, but I suspect that it is due to
> > the fact that Coccinelle is matching the control-flow path and not the
> > abstract syntax tree. In a control-flow graph, nothing follows a return.
> >
> > julia
>
> Thank You,
> I tried to sneak around the problem with a second "rule" which
>   translates "return 42" to "auxiliary(42)".
> My intention was to first change the source in such a way
>   that the "control-flow" graph does not end at the "return",
> and then hope that the second (accordingly modified) rule would
>   match.
> This didn't work, I assume I would have to express the idea of
>   first applying the first rule
>     then to rebuild the control-flow graph
>   then try the second rule.
>   (and finally undo the changes of the first rule in a third rule)
> I can not force "rebuild" without invoking spatch myself a second time.

If you change all the returns to something else and then match your
pattern, and then change them it should work.

>
> ---
> I'm a bit of a maintainer for the "ngspice" project, which has a vast
>   amount of very old files, and lots of semi duplicated stuff often crying
>   for a thourough hair wash,
> stumbled over this intresting tool, and am tying it for a certain
>   rewrite I'm currently busy with.

OK,feel free to ask more questions if you run into further issues.

julia
