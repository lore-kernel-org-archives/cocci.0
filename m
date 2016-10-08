From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Oct 2016 23:23:47 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87shs6y3hq.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610060750180.3179@hadrien>
 <878ttzjzss.fsf@vostro.rath.org> <alpine.DEB.2.10.1610080743040.3176@hadrien>
 <87shs6y3hq.fsf@vostro.rath.org>
Message-ID: <alpine.DEB.2.10.1610082321270.3373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > The name is illustrated in Advanced SmPL:
> > http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf
>
> Call me stupid, but I just went through it again and I still don't see
> it. There are lots of examples with "@ ..stuff..@" (the first on slide
> 4), but as far as I can tell it never explains what this means.

OK, perhaps it is mentioned in the video:
http://faultlinux.lip6.fr/videos/workshop_videos_2011/Julia_Lawall_introduction_part2.f4v

>
> Actually, the frequent occurence of @script:python@ makes me think that
> this actually has semantic signficance and is much more than a label
> that I can choose for my own convenience...?

script:python indicates that the rule has python code rather than pattern
matching.  The name of a rule that you can choose freely should not
contain :

>
>
> > A variety of metavariable types are listed in slide 11 of the Linux
> > oriented tutorial: http://coccinelle.lip6.fr/papers/tutorial.pdf
>
> Yes, I saw that. But I deliberately wrote "explained" rather than just
> "listed" :-).

In the video, perhaps...

The following paper is quite old, but may also be helpful:

Tutorial paper: Semantic Patches, Documenting and Automating Collateral
Evolutions in Linux Device Drivers
Yoann Padioleau, Julia L. Lawall, and Gilles Muller
Ottawa Linux Symposium (OLS 2007), June 2007.

julia
