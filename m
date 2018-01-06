From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 6 Jan 2018 18:26:17 +0100 (CET)
Subject: [Cocci] Automatic generation of SmPL rules by a script rule
In-Reply-To: <5fb3bd3a-d78d-7d2c-050f-146887838d95@users.sourceforge.net>
References: <c1e3f44c-63ca-3306-840b-77d677e7e91f@users.sourceforge.net>
 <alpine.DEB.2.20.1801061800370.2579@hadrien>
 <5fb3bd3a-d78d-7d2c-050f-146887838d95@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801061822290.2579@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 6 Jan 2018, SF Markus Elfring wrote:

> > The simplest thing would be to just print the rule you want in a
> > python/ocaml script rule.
>
> I would like to adjust a SmPL execution environment for special use cases somehow.
> How would ?printing? be useful here?

Well, I was thinking that you could eg make a script like:

@script:ocaml@
e << r.e;
@@

Printf.printf "@@\n";
Printf.printf "expression f;\n";
Printf.printf "@@\n\n";
Printf.printf "-f(%s);\n" e

But I'm not sure that the parser of script code would be happy with a @ in
the script code, so you would have to do some trick to get around that.

>
>
> > Some support was added at one point for generating rules based on matches
> > from other rules,
>
> Such information sounds promising.
>
>
> > but that code has not been maintained, and I don't think it is likely
> > to be updated in the future.
>
> I am curious if there are still any chances to revive corresponding
> approaches.

I'm not interested in spending time on it in the foreseeable future.  If
anyone else wants to, the code is there...  Maybe you put something like
generated in the header of the semantic patch rule, like you might put
script:ocaml.

julia

>
>
> Is it safer therefore to generate advanced SmPL script files by external
> software tools (at the moment)?
>
> Regards,
> Markus
>
