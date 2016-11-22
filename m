From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 22 Nov 2016 14:33:06 +0100 (CET)
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
Message-ID: <alpine.DEB.2.10.1611221430450.31331@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Nov 2016, Michael Stefaniuc wrote:

> Hello,
>
> I have to have 3 rules to remove a cast. The rules are basically
> identical, they just differ by the type of an expression. That type is
> inherited from different rules that aren't matching at the same time.
>
> Now I wanted to use positions to eliminate false positives rather than
> duplicating that code, but that doesn't work. Using the position in the
> second rule will generate an error:
> meta: semantic error: position cannot be inherited over modifications: p
>
> Though that doesn't makes sense, as the position is never modified, only
> all the other positions not matching are modified.
> Here are the relevant chunks:
>
> @ disable drop_cast @
> type find.To;
> type T;
> To *obj;
> position p != cast_good.p;
> @@
> - (T)
>        (obj at p)
>
>
> @ disable drop_cast @
> type find2.To;
> type T;
> To *obj;
> position p != cast_good.p;
> @@
> - (T)
>        (obj at p)

What gets modified is the file, or at least the function, so you can't
rely on the positions being meaningful once the code has been changed.

I think you could use a disjunction to make just one rule, to avoid the
problem.

You can also put a set of possible types for obj ({type1, type2, ...}) and
put the whole thing into one line.

julia
