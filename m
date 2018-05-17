From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 17 May 2018 17:00:02 -0400
Subject: [Cocci] exists do not work if file group is too big
In-Reply-To: <alpine.DEB.2.20.1805172241400.2273@hadrien>
References: <20180516191634.GB2994@redhat.com>
 <128b6146-5368-12bb-ae42-236982ff3494@users.sourceforge.net>
 <20180517144527.GA5048@redhat.com>
 <alpine.DEB.2.20.1805172241400.2273@hadrien>
Message-ID: <20180517210001.GB15887@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 17, 2018 at 10:45:29PM +0200, Julia Lawall wrote:
> In terms of the running time, I get a running time of 11 seconds with the
> command line of 48 files and I get a running time of 22 seconds if I just
> run spatch on the entire kernel.  That seems slower, but if I use the
> command line of 48 files, I get changes in 27 files, while if I run it on
> the entire kernel, I get changes in 75 files.  If I run it on the entire
> kernel using 40 cores (-j 40), I get changes in 75 files in 1.7 seconds.

In this simple test case this would work but in my real spatch i have to
change one function at a time as otherwise there is conflict on header
update. Moreover i also have to use --recursive-headers if i don't do the
git grep to provide file list which is also one of the reasons why it
was much slower.

Ideally if header files could be updated --in-place even when there is
conflict i might first add proper #include as a first step to avoid the
recursive flag.


As an example if i want to add a new argument to both:

int set_page_dirty(struct page *page);
int set_page_dirty_lock(struct page *page);

then because inside include/linux/mm.h they are declare one after the
other --in-place will fails. This case is not the worse, i can split
this in 2 spatches and it would work. I can't do that when updating
callback which have same pattern ie 2 callback prototype declare one
after the other.

Cheers,
J?r?me
