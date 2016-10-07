From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 7 Oct 2016 08:06:46 +0200 (CEST)
Subject: [Cocci] scripts/coccicheck: Update for a comment?
In-Reply-To: <76a6d8fa-03b9-5589-2885-fa62933dd391@users.sourceforge.net>
References: <ea62a1ea-c566-65a0-e2fd-2ee96839cf48@users.sourceforge.net>
 <alpine.DEB.2.10.1610070749420.3074@hadrien>
 <76a6d8fa-03b9-5589-2885-fa62933dd391@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1610070803550.3074@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 7 Oct 2016, SF Markus Elfring wrote:

> >> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccicheck?id=c802e87fbe2d4dd58982d01b3c39bc5a781223aa#n4
> >
> > How about submitting a patch to fix the problem?
>
> I would appreciate to become a bit more sure about the current storage location
> which should be referenced in this file.

In the Documentation directory find . -name "*cocci*"

gives

./dev-tools/coccinelle.rst

I think you could have done that yourself.

julia

>
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
