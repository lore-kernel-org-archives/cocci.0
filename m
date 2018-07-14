From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Jul 2018 16:36:09 -0400 (EDT)
Subject: [Cocci] [PATCH v2] coccinelle: strncpy+truncation by strscpy
In-Reply-To: <20180714130800.GA15334@nautica>
References: <20180714130800.GA15334@nautica>
Message-ID: <alpine.DEB.2.20.1807141633010.3283@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 14 Jul 2018, Dominique Martinet wrote:

> Julia Lawall wrote on Sat, Jul 14, 2018:
> > Not a big deal, but actually the v2 goes below the ---
>
> I've seen both being done (if you look at the git log of the linux
> kernel and search for 'v2' you will have some matches)

I guess.  Normally I would conseider that since the v1 is not in the git
history, no one care about the delta between the v1 and v2. If there is
important information it should just be in the commit message.

> The list was a bit long in this case, but I think it's worth at least
> mentioning that the previous version used strlcpy and why I changed in
> the commit message.

I guess, but you could say that strlcpy was not used for a certain reason,
without making it historical information.

>
> > > +msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> > > +coccilib.report.print_report(p[0], msg)
> >
> > This is the first SUGGESTION.  I don't know if anyone out there is relying
> > on it always being WARNING or ERROR.
>
> Eh, I must have been really unlucky with the scripts I looked at, one
> just happened to have SUGGESTION used like this (misc/warn.cocci), but
> now you said that I can see it's the only one!
>
> I'm not sure on what to do here, if you think there could be scripts
> relying on that then I'll change this to WARNING, but the wording feels
> a bit strong and "suggestion" leaves more room for interpretation.

I guess that if there is already one, then another won't hurt.

>
>
> > Copyright stuff in the other sub-thread
>
> Replying here instead to limit the number of mails sent,
> I think people would look at git blame/log if there is no name in the
> file, but I can understand it is simpler if a name is present.

One less command to type.

>
> Just a nitpick on format, all copyright comments on cocci scripts end
> with the license; since that will be added as an SPDX tag instead do you
> mind if I do not list it again there?

I know nothing about SPDX tags.  If something is added, I don't know how
it is done.

julia

>
>
> Also just a head's up, I'll be AFK for the next ~48 hours; I'll post a
> v3 of the patch with license/copyright added, possibly suggestion
> changed, and whatever else comes up by then :)
>
> Thanks,
> --
> Dominique Martinet
>
