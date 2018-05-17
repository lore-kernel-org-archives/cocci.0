From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 May 2018 23:11:12 +0200 (CEST)
Subject: [Cocci] exists do not work if file group is too big
In-Reply-To: <20180517210001.GB15887@redhat.com>
References: <20180516191634.GB2994@redhat.com>
 <128b6146-5368-12bb-ae42-236982ff3494@users.sourceforge.net>
 <20180517144527.GA5048@redhat.com>
 <alpine.DEB.2.20.1805172241400.2273@hadrien>
 <20180517210001.GB15887@redhat.com>
Message-ID: <alpine.DEB.2.20.1805172304150.2273@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 17 May 2018, Jerome Glisse wrote:

> On Thu, May 17, 2018 at 10:45:29PM +0200, Julia Lawall wrote:
> > In terms of the running time, I get a running time of 11 seconds with the
> > command line of 48 files and I get a running time of 22 seconds if I just
> > run spatch on the entire kernel.  That seems slower, but if I use the
> > command line of 48 files, I get changes in 27 files, while if I run it on
> > the entire kernel, I get changes in 75 files.  If I run it on the entire
> > kernel using 40 cores (-j 40), I get changes in 75 files in 1.7 seconds.
>
> In this simple test case this would work but in my real spatch i have to
> change one function at a time as otherwise there is conflict on header
> update. Moreover i also have to use --recursive-headers if i don't do the
> git grep to provide file list which is also one of the reasons why it
> was much slower.
>
> Ideally if header files could be updated --in-place even when there is
> conflict i might first add proper #include as a first step to avoid the
> recursive flag.

I'm not sure to understand any of the above.  At the moment you have
--no-includes, so no headers are consulted.  What do you need from header
files?  Do you need type information?  Do you need to change the files?
Do the changes in the header files interact with the changes in the .c
file?

If it just happens that there are also calls to set_page_dirty in the
header files that you want to update, then you can give the options
--no-includes --include-headers.

If the only thing you want from the header files is type information, then
you can say eg --recursive-includes --include-headers-for-types.  That
would be much faster, because the transformation rules wouldn't be applied
over and over to the header files.

If you want to do both, the above options can be combined.

>
>
> As an example if i want to add a new argument to both:
>
> int set_page_dirty(struct page *page);
> int set_page_dirty_lock(struct page *page);
>
> then because inside include/linux/mm.h they are declare one after the
> other --in-place will fails. This case is not the worse, i can split
> this in 2 spatches and it would work. I can't do that when updating
> callback which have same pattern ie 2 callback prototype declare one
> after the other.

Do you actually need to automate this part?

I think I could be more helpful if I had an example that more competely
shows what you want to do.

julia
