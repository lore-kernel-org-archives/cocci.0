From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 14 Feb 2014 20:56:16 +0100
Subject: [Cocci] Patch macros
In-Reply-To: <alpine.DEB.2.10.1402141649210.2118@hadrien>
References: <87eh35emhk.fsf@tassilo.jf.intel.com>
 <alpine.DEB.2.10.1402141649210.2118@hadrien>
Message-ID: <20140214195616.GA32005@two.firstfloor.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Feb 14, 2014 at 04:51:18PM +0100, Julia Lawall wrote:
> On Fri, 14 Feb 2014, Andi Kleen wrote:
> 
> >
> > Hi,
> >
> > I was trying to replace static asmlinkage with static. However
> > it always gives a cocci parsing error. I assume the problem is that
> > asmlinkage is really a macro (for __attribute__((visible)) in
> > my case). How to handle this in cocci?
> 
> Unfortunately, I don't think it is possible.  The Coccinelle C parser
> doesn't have any notion of asmlinkage, and so it skips over it.

I was hoping there was a way to tell cocci about the macros.

Ok, back to sed then for this.

Thanks Julia.

-Andi
