From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 7 Oct 2016 08:27:21 +0200 (CEST)
Subject: [Cocci] scripts/coccicheck: Update for a comment?
In-Reply-To: <8d36952c-1dbb-bb26-ee57-3e1540c042c0@users.sourceforge.net>
References: <ea62a1ea-c566-65a0-e2fd-2ee96839cf48@users.sourceforge.net>
 <alpine.DEB.2.10.1610070749420.3074@hadrien>
 <76a6d8fa-03b9-5589-2885-fa62933dd391@users.sourceforge.net>
 <alpine.DEB.2.10.1610070803550.3074@hadrien>
 <8d36952c-1dbb-bb26-ee57-3e1540c042c0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1610070824490.3074@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 7 Oct 2016, SF Markus Elfring wrote:

> >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/scripts/coccicheck?id=c802e87fbe2d4dd58982d01b3c39bc5a781223aa#n4
> >>>
> >>> How about submitting a patch to fix the problem?
> >>
> >> I would appreciate to become a bit more sure about the current storage location
> >> which should be referenced in this file.
> >
> > In the Documentation directory find . -name "*cocci*"
> >
> > gives
> >
> > ./dev-tools/coccinelle.rst
> >
> > I think you could have done that yourself.
>
> Does the usage of the format "reStructuredText" trigger further considerations
> like the following?
>
> * Does your feedback suggest that the path from this source file should be put
>   in related places?
>
> * Would it make sense to store such a file name in a special variable?
>
> * When would you refer to generated file formats (like PDF) for this use case?

Either you send the patch, or I will send the patch, when I have time,
with no credit to you.  I'm not an expert on all of the future plans for
the documentation,  The only think I know is where the file is now, and
that the file is perfectly readable in its rst format, and thus it seems
quite all right to reference it.  If the situation change in the future,
we can have another patch in the future.

julia
