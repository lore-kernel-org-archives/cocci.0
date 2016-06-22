From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 Jun 2016 21:47:21 +0200 (CEST)
Subject: [Cocci] [PATCH v3 3/8] coccicheck: enable parmap support
In-Reply-To: <20160622151024.GR25646@wotan.suse.de>
References: <alpine.DEB.2.02.1606212217060.2040@localhost6.localdomain6>
 <20160621203958.GU25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212241380.2040@localhost6.localdomain6>
 <a8871bc9-866c-4690-0806-6165680cc45d@imag.fr>
 <20160621212839.GZ25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212331160.2040@localhost6.localdomain6>
 <20160621213906.GC25646@wotan.suse.de>
 <alpine.DEB.2.02.1606212342040.2040@localhost6.localdomain6>
 <20160621221454.GF25646@wotan.suse.de>
 <alpine.DEB.2.02.1606220718550.2082@localhost6.localdomain6>
 <20160622151024.GR25646@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1606222146240.2076@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Actually, it would be probably good to raise the default chunksize a bit 
> > for the latter reason.  It would depend on which files get assigned to 
> > which chunks though how much benefit it might have.
> 
> What value do you have in mind? Or should we leave this as a separate future
> change?

It's not urgent.  Experiments would have to be done to find a good 
tradeoff.  If the value is too large, there is the risk of a load 
imbalance at the end.

julia
