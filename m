From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 9 Apr 2013 07:19:07 +0200 (CEST)
Subject: [Cocci] Handling of omitted data type specification?
In-Reply-To: <51633345.6060103@users.sourceforge.net>
References: <mailman.1.1364983201.25969.cocci@systeme.lip6.fr>
 <1365431375.3314.42.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1304081655220.1963@hadrien>
 <51633345.6060103@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1304090715590.2019@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 8 Apr 2013, SF Markus Elfring wrote:

> > In the previous fix that I made, I just caused the missing type,
> > which was hidden under a macro, to make the match fail.
>
> How do you think about to make this detail configurable?

On this case, there is nothing to configure.  If there is no known type,
then matching a type variable cannot succeed.

> > In this case, though perhaps you would prefer T to be bound to int?
>
> Does the C programming language specify that integers are used as the default
> data type (or if modifiers are used)?
> http://stackoverflow.com/questions/2099830/unsigned-keyword-in-c#2099873
> https://www.cs50.net/resources/cppreference.com/data_types.html
> http://en.cppreference.com/w/cpp/language/types

Coccibelle already takes case of eg signed x;  It should do the same for
register, for consistency.

> > That might cause some problemes, though, because it is not a real "int"
> > in the source code...
>
> Does the semantic patch language support to filter for omitted data types?
>
> Would you like to distinguish the use case if this item was just forgotten or
> intentionally omitted?

Perhaps it is useful.  There may be an isomorphism for deciding whether or
not int is assumed in the signed etc case.

julia
