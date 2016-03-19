From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 19 Mar 2016 18:47:56 +0100 (CET)
Subject: [Cocci] [PATCH] scripts: coccinelle: remove check to move
 constants to right
In-Reply-To: <20160319174625.GA3981@tetsubishi>
References: <1458409079-4669-1-git-send-email-wsa@the-dreams.de>
 <alpine.DEB.2.02.1603191840121.2259@localhost6.localdomain6>
 <20160319174625.GA3981@tetsubishi>
Message-ID: <alpine.DEB.2.02.1603191847460.2259@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 19 Mar 2016, Wolfram Sang wrote:

> On Sat, Mar 19, 2016 at 06:43:08PM +0100, Julia Lawall wrote:
> > On Sat, 19 Mar 2016, Wolfram Sang wrote:
> > 
> > > The header mentions this check depends on personal taste. I agree.
> > > Running coccicheck on patches before I apply them, this SmPL produced
> > > enough false positives for me that I'd rather see it removed.
> > 
> > An improvement is coming up, that should be more acceptable.  However, 
> > it's being held up by the need for some bug fixes in Coccinelle.  A 
> > release of Coccinelle is planned for the beginning of April.  Perhaps 
> > it is just as well to just remove this version for now.
> > 
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> Thanks, Julia. If you put me on CC of the new version, I'll be happy to
> test.

Thanks :)

julia
