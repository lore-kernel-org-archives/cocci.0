From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Sat, 28 Jan 2017 12:10:33 +0530
Subject: [Cocci] position confusion?
In-Reply-To: <1485558606.14579.15.camel@sipsolutions.net>
References: <1485558606.14579.15.camel@sipsolutions.net>
Message-ID: <9d692cfd-f6a0-fef4-bcbb-84564e60beb5@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Saturday 28 January 2017 04:40 AM, Johannes Berg wrote:
> This is nonsense, but I don't see why it shouldn't parse:

Hi,

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

This should be "position p != a.p;".

> @@
> T x at p = { };
>
> @@
> position p != a.p;
> position q != b.p;

And here no need to put constraint for q.

position p != {a.p, b.p};
position q;

> type T;
> identifier x;
> @@
> *T x at q = {};
>
> ->
> 148 149
> Fatal error: exception Failure("meta: parse error: \n = File \"/tmp/test.spatch\", line 17, column 16,  charpos = 148\n    around = 'p', whole content = position q != b.p;\n")
>
>
> if I replace 'p' by 'q' in @b@, it works fine?
>
> johannes
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
