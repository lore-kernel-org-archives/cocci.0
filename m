From: asmadeus@codewreck.org (Dominique Martinet)
Date: Sat, 14 Jul 2018 11:16:15 +0200
Subject: [Cocci] [01/18] coccinelle: change strncpy+truncation to strlcpy
In-Reply-To: <a35ae0ee-13d2-7ac8-99a4-488069983154@users.sourceforge.net>
References: <20180713080023.GB9638@nautica>
 <a35ae0ee-13d2-7ac8-99a4-488069983154@users.sourceforge.net>
Message-ID: <20180714091615.GA14258@nautica>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SF Markus Elfring wrote on Sat, Jul 14, 2018:
> How do you think about to adjust the initial meta-data a bit more?
> 
> * SPDX identifier

Oh, right, 7/55 of the cocci scripts have one... I'll add one in a v3 of
the patch on Tuesday, I want to give a bit more time for other comments
if any come.

> * Copyright information

I left that one out on purpose, as I do not want to give the copyright
to anyone and do not particularily care for myself.
I'm doing that on my free time and this is not related to my work (as
opposed to e.g. the work I'm doing on 9P where I use my work e-mail;
which is also on my free time but relies on knowledge I owe to my work),
and I mostly see people attribute themselves copyright when related to
their work establishment.

Now I'm looking a bit closer I see this is not necessarily the case, but
I'd still rather leave this out unless there's a reason to add it.


> > the only exceptions would be if someone relied on strncpy to fill the end
> > of the buffer with zero to not leak data somewhere but that is not easy
> > to judge by itself (although I hope rare enough)
> 
> Would you dare to develop a corresponding source code search as another
> safety check?

Hmm, good question. It would be handy but will limit the matches more
than required I think.

Taking an example at random in the reports of the current patch,
cpumask in tools/accounting/getdelays.c is not zeroed out before the
strncpy so would be ruled out -- but when it's actually used, it only
sends to the network 'strlen(cpumask)+1' bytes of cpumask so the usage
made is perfectly safe.

My second argument here is a bad one (I just have to learn ;)) but while
I could easily check if dest has been memset'd/allocated with kzalloc,
I'm not sure how to express 'dest is a member of struct s, s was
allocted with kzalloc' which is probably much more common.

I'm also not sure how far back coccinelle would be able to check that?
For example in drivers/gpu/drm/i915/intel_tv.c we have 'mode_ptr =
drm_mode_create(...)' followed by 'strncpy(mode_ptr->name...), and
'drm_mode_create' did allocate with kzalloc; would coccinelle look that
far?

Thanks,
-- 
Dominique Martinet
