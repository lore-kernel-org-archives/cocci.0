From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 23 Feb 2013 17:07:58 +0100 (CET)
Subject: [Cocci] [PATCH] scripts/coccinelle: find constant additions
 that could be bit ors
In-Reply-To: <20130223150521.GK9138@mwanda>
References: <1359821995-27910-1-git-send-email-Julia.Lawall@lip6.fr>
 <20130222104431.GF12402@pobox.suse.cz> <20130223150521.GK9138@mwanda>
Message-ID: <alpine.DEB.2.02.1302231706060.2085@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 23 Feb 2013, Dan Carpenter wrote:

> On Fri, Feb 22, 2013 at 11:44:31AM +0100, Michal Marek wrote:
> > On Sat, Feb 02, 2013 at 05:19:55PM +0100, Julia Lawall wrote:
> > > From: Julia Lawall <Julia.Lawall@lip6.fr>
> > > 
> > > Semantic patch (http://coccinelle.lip6.fr/) to check for constants that are
> > > added but are used elsewhere as bitmasks.
> > > 
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > Applied to kbuild.git#misc.
> > 
> 
> I'm not sure we want to do this.  The one patch which was sent with
> this script wasn't applied.

I think that the view on it was that if it isn't broken, don't fix it.  
But if the rules that are being added to the kernel are primarily being 
used for new code, then it could be reasonable for developers to consider 
whether they would really rather use | rather than the confusing +.

julia
