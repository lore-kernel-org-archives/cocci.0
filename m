From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 19:50:00 +0200 (CEST)
Subject: [Cocci] coccinelle problems with kernel code
In-Reply-To: <20150909164026.GA19823@Sligo.logfs.org>
References: <20150908180759.GA27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509082316550.2050@localhost6.localdomain6>
 <20150908214536.GC27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509090717080.2047@localhost6.localdomain6>
 <20150909055721.GD27133@Sligo.logfs.org>
 <alpine.DEB.2.10.1509091206380.3224@hadrien>
 <20150909164026.GA19823@Sligo.logfs.org>
Message-ID: <alpine.DEB.2.10.1509091949220.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 9 Sep 2015, J?rn Engel wrote:

> On Wed, Sep 09, 2015 at 12:08:02PM +0200, Julia Lawall wrote:
> >
> > This is available is you have Coccinelle version 1.0.2.  Just give -j X
> > where X is the number of cores that you want to use.
>
> Debian is still at 1.0.0.  I suspect I will wait for them to upgrade
> rather than package a newer version myself.  Laziness wins the day.

There is a scrit that provides an alternative soluiton to parallelism
here:

http://article.gmane.org/gmane.comp.version-control.coccinelle/684/match=kees+cook

julia
