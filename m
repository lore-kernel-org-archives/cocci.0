From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 27 Apr 2014 11:36:22 +0200 (CEST)
Subject: [Cocci] [PATCH 1/1] scripts/coccinelle: use BIT() macro if
 possible
In-Reply-To: <CABxcv==8F2CghQKVDp==5Mx8-OBJnc+yZWEBqi7OFGij8OHaeg@mail.gmail.com>
References: <1398558586-28931-1-git-send-email-javier@dowhile0.org>
 <20140427051428.GA2671@katana>
 <CABxcv==8F2CghQKVDp==5Mx8-OBJnc+yZWEBqi7OFGij8OHaeg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1404271135590.2006@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 27 Apr 2014, Javier Martinez Canillas wrote:

> Hello Wolfram,
> 
> Thanks a lot for your feedback.
> 
> On Sun, Apr 27, 2014 at 7:14 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Sun, Apr 27, 2014 at 02:29:46AM +0200, Javier Martinez Canillas wrote:
> >> Using the BIT() macro instead of manually shifting bits
> >> makes the code less error prone and also more readable.
> >
> > Does it? It is a taste thing, yet I don't think it makes the code that
> > much more readable that it is worth changing the whole tree.
> >
> 
> I believe there is a reason for that macro but yes I agree with you
> that is a matter of taste and the it shouldn't be enforced.
> 
> I'm doing a big refactoring for the GPIO subsystem and was told to use
> coccinelle so this patch was part of my learning. I posted it because
> I thought that it could be useful but I don't mind the patch to be
> dropped if that is not the case.

Perhaps it could be useful in files that already use BIT somewhere?

julia
