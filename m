From: willy@infradead.org (Matthew Wilcox)
Date: Sun, 29 Apr 2018 13:30:23 -0700
Subject: [Cocci] [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <CAGXu5jKLaY2vzeFNaEhZOXbMgDXp4nF4=BnGCFfHFRwL6LXNHA@mail.gmail.com>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
 <alpine.DEB.2.20.1803072212160.2814@hadrien>
 <20180308025812.GA9082@bombadil.infradead.org>
 <alpine.DEB.2.20.1803080722300.3754@hadrien>
 <20180308230512.GD29073@bombadil.infradead.org>
 <alpine.DEB.2.20.1803131818550.3117@hadrien>
 <20180313183220.GA21538@bombadil.infradead.org>
 <CAGXu5jKLaY2vzeFNaEhZOXbMgDXp4nF4=BnGCFfHFRwL6LXNHA@mail.gmail.com>
Message-ID: <20180429203023.GA11891@bombadil.infradead.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Apr 29, 2018 at 09:59:27AM -0700, Kees Cook wrote:
> Did this ever happen?

Not yet.  I brought it up at LSFMM, and I'll repost the patches soon.

> I'd also like to see kmalloc_array_3d() or
> something that takes three size arguments. We have a lot of this
> pattern too:
> 
> kmalloc(sizeof(foo) * A * B, gfp...)
> 
> And we could turn that into:
> 
> kmalloc_array_3d(sizeof(foo), A, B, gfp...)

Are either of A or B constant?  Because if so, we could just use
kmalloc_array.  If not, then kmalloc_array_3d becomes a little more
expensive than kmalloc_array because we have to do a divide at runtime
instead of compile-time.  that's still better than allocating too few
bytes, of course.

I'm wondering how far down the abc + ab + ac + bc + d rabbit-hole we're
going to end up going.  As far as we have to, I guess.
