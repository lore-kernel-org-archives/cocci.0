From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Dec 2017 10:47:38 +0100 (CET)
Subject: [Cocci] =?utf-8?q?Transformation_challenges_with_SmPL_around_?=
	=?utf-8?b?4oCcTElTVF9GT1JfRUFDSF9FTlRSWeKAnQ==?=
In-Reply-To: <e1ac4060-67e9-973b-e4c7-6faa476af34e@users.sourceforge.net>
References: <alpine.DEB.2.20.1712020913040.2168@hadrien>
 <e1ac4060-67e9-973b-e4c7-6faa476af34e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1712021046000.2168@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @adjustment@
> expression ex;
> statement S;
> @@
> -LIST_FOR_EACH_ENTRY
> +hlist_for_each_entry
>  (..., ...,
> -ex,
>  ...)
>  S

This is not completely a good idea.  The ... in the argument list will
match a sequence of things, not a single thing.  It could be:

-LIST_FOR_EACH_ENTRY
+hlist_for_each_entry
 (e1,e2,
-ex,
 ...)
 S

julia
