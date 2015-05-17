From: dmitry.kalinkin@gmail.com (Dmitry Kalinkin)
Date: Sun, 17 May 2015 19:20:28 +0300
Subject: [Cocci] [PATCH] coccinelle: api: add vma_pages.cocci
In-Reply-To: <alpine.DEB.2.02.1505171526430.2077@localhost6.localdomain6>
References: <1431821187-21648-1-git-send-email-dmitry.kalinkin@gmail.com>
 <alpine.DEB.2.02.1505171526430.2077@localhost6.localdomain6>
Message-ID: <CAM41TOuWHZpnZS8zbDeDnHr1+VZUusCBEiNAx4DHeppoFhT1LQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, May 17, 2015 at 4:39 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> + at r_patch2 depends on !context && patch && !org@
>> +struct vm_area_struct *vma;
>> +@@
>> +
>> +- (vma->vm_end - vma->vm_start) >> PAGE_SHIFT
>> ++ vma_pages(vma)
>
> This rule is not needed.  An isomorphism will allow tha case with ()
> around the whole thing to match the case where those parentheses are
> absent.
So coccinelle is a real semantic tool and sees the difference between
(vma->vm_end - vma->vm_start) >> PAGE_SHIFT + 3
and
(vma->vm_end - vma->vm_start) >> PAGE_SHIFT & 3
Cool. Didn't realize that.

> It may be good to put below the keywords:
>
> // Comments:
> // Options: --all-includes
>
> This rule relies on type information, ie knowing whether something has
> type struct vm_area_struct *, so having more include files available may
> make that more apparent.  On the other hand, if you think the referenced
> thing will always be a local variable (as opposed to a structure field),
> then just using the current C file should be good enough, and it will be
> faster without the --all-includes option.
There probably won't be any benefit in doing that. The statement is long
enough already long enough as it is. So it is unlikely that any code like
(dev->priv->vma->vm_end at p - dev->priv->vma->vm_start) >> PAGE_SHIFT
is to appear.
I also just checked and saw that using --all-includes doesn't produce
additional triggers anywhere on the current code (except for false fire
on mm.h at vma_pages() itself).
>
> I tried the rule replacing struct vm_area_struct *vma; by expression vma
> and got a couple of results on other types.  One could wonder if that code
> could be improved in some way.
Indeed, there are such cases. I checked a couple manually and they turned
out to be some different third party structures having fields called vm_end
and vm_start used for vma-related accounting. These may or may not be a
justifiable uses. We could report them, but not propose an automatic patch

Kind regards,
Dmitry
