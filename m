From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 20 Jul 2018 08:03:35 +0200 (CEST)
Subject: [Cocci] [PATCH v3] coccinelle: suggest replacing
 strncpy+truncation by strscpy
In-Reply-To: <20180720055705.GA2810@nautica>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
 <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
 <alpine.DEB.2.20.1807200731240.2349@hadrien> <20180720054050.GA32233@nautica>
 <alpine.DEB.2.20.1807200745400.2349@hadrien>
 <20180720055705.GA2810@nautica>
Message-ID: <alpine.DEB.2.20.1807200759230.2349@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 20 Jul 2018, Dominique Martinet wrote:

> Julia Lawall wrote on Fri, Jul 20, 2018:
> > On Fri, 20 Jul 2018, Dominique Martinet wrote:
> > > I guess there is no value in the script landing first by itself, I'll
> > > just remove the script path from the commit messages and resend the
> > > first few this weekend.
> >
> > It's not that there is no value to the script.  The problem is that I
> > don't know if the script is correct - I'm not familiar with these string
> > functions.  Once the script is in the kernel, it stays there beyond your
> > patches, so I would prefer to know that it is correct up front, rather
> > than having to remove it afterwards.
>
> I understand, I didn't say there is no value in the script ("landing
> first by itself" doesn't mean it should/can not be taken later)
>
> I'll bump this thread again in a couple of weeks after having resent
> most of the other patches

Thanks.

The rule is also not so efficient in the patch case, because you have the
rule r that matches the pattern, and then the ok rule at the end that
matches the same pattern.  It would be better to put depends on org ||
report in the rule r, and let the patch rule be freestanding, ie just
declare dest, src, and sz, not r.dest, etc.

If you like, you can also add the context case by just putting a * in
front of the strncpy call in the r rule.  That highlights the change in
diff-like output, which can in general be useful to see the context in
which the issue occurs.

julia
