From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jan 2018 11:28:28 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
 <alpine.DEB.2.20.1801141056190.7902@hadrien>
 <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801141126290.7902@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 14 Jan 2018, SF Markus Elfring wrote:

> > Well, you didn't keep the semantic patch in the message.
>
> You can take another look in other information systems (if desired).
> https://systeme.lip6.fr/pipermail/cocci/2018-January/004848.html
>
>
> >> How do you think about to avoid the extra initialisation
> >> when only the operation mode ?context? or ?patch? would be active?
> >
> > context and patch use the regular expression too.
>
> Where?

Look at the script code just under the comment "For context mode" and just
under the comment "For patch mode".  Both of them use m.  m is declared in
the initialize.

>
>
> > All forms of the rule need it, to keep the casts that contain sparse annotations.
>
> How do ?annotations? matter here?
>
>
> Is a specific variable used only by two SmPL rules?
>
> ?
> > +m = re.compile(pattern)
> ?
> > @script:python depends on report@
> ?
> > +if m.search(t) != None:
> ?
>
>
> Why are two underscores used as a search pattern in this use case?

How about just removing the script code and looking your self at what
happens in eg the patch case if it is not there.

__ are typically used in sparse annotations.

julia
