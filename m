From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 7 Mar 2017 17:31:17 +0100 (CET)
Subject: [Cocci] How to execute coccicheck outside linux source tree?
In-Reply-To: <CAAJ24apcC3TYyMwR0g=aBavk9JC9mb8+v=63LTK6eGDeD8WDDg@mail.gmail.com>
References: <CAAJ24apcC3TYyMwR0g=aBavk9JC9mb8+v=63LTK6eGDeD8WDDg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703071730170.3150@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 5 Mar 2017, Jeremy wrote:

> Hi all,
>
> I'd like to scan some driver by coccicheck, but don't know how to execute it.
> I know that we could scan driver in linux source tree by
> `make coccicheck MODE=report -M=drivers/'
>
> btw, it will print a lot of errors as follow:
>
> Fatal error: exception Failure("meta: parse error:
>  = File "./scripts/coccinelle/misc/boolconv.cocci", line 47, column 7,
>  charpos = 773
>     around = 'true', whole content = symbol true, false;
> ")
> 773 777
> Fatal error: exception Failure("meta: parse error:
>  = File "./scripts/coccinelle/misc/boolconv.cocci", line 47, column 7,
>  charpos = 773
>     around = 'true', whole content = symbol true, false;
> ")

I think that you need to update your Coccinelle.  You can get the latest
version from github:

https://github.com/coccinelle/coccinelle

Perhaps this will solve all of your problems :)

julia


>
> Jeremy
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
