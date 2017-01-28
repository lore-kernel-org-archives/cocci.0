From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 28 Jan 2017 07:37:37 +0100 (CET)
Subject: [Cocci] position confusion?
In-Reply-To: <1485558606.14579.15.camel@sipsolutions.net>
References: <1485558606.14579.15.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701280736450.2822@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 28 Jan 2017, Johannes Berg wrote:

> This is nonsense, but I don't see why it shouldn't parse:
>
> @a@
> type T;
> identifier x;
> position p;
> @@
> T x at p = { };
>
> @b@
> type T;
> identifier x;
> position p;
> @@
> T x at p = { };
>
> @@
> position p != a.p;
> position q != b.p;
> type T;
> identifier x;
> @@
> *T x at q = {};
>
> ->
> 148 149
> Fatal error: exception Failure("meta: parse error: \n = File \"/tmp/test.spatch\", line 17, column 16,??charpos = 148\n????around = 'p', whole content = position q != b.p;\n")
>
>
> if I replace 'p' by 'q' in @b@, it works fine?

Yes.  It's stupid, but the declaration of p on the line position p != a.p;
somehow takes over the name p.  To fix someday.

julia

>
> johannes
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
