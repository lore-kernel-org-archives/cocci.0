From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Sun, 8 Oct 2017 23:26:10 +0200
Subject: [Cocci] [PATCH 0/2] detect identical chip data arrays
In-Reply-To: <alpine.DEB.2.20.1710082243140.2160@hadrien>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <20171008203258.y7kqx7ipondxlsix@earth>
 <alpine.DEB.2.20.1710082243140.2160@hadrien>
Message-ID: <20171008212610.kdnsr7bcuitvmedc@earth>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Sun, Oct 08, 2017 at 10:44:50PM +0200, Julia Lawall wrote:
> On Sun, 8 Oct 2017, Sebastian Reichel wrote:
> > Hi,
> >
> > On Sun, Oct 08, 2017 at 09:18:39PM +0200, Julia Lawall wrote:
> > > Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warning
> > > messages to indicate that some structures are the same, in response to
> > > feedback from Liam Breck.
> > >
> > > Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, which
> > > is not yet released, it actually works with the version currently available
> > > on Github, eg from Coccinelle commit 3ba77b3a0f91.
> >
> > I think the rename makes sense, but I would expect the move to
> > happen in one go with "git send-email -M", so that it detects the
> > rename.
> 
> I'm not actually sure what is the status of the previous version.
> Masahiro said applied, but I downloaded his tree and it was not there.  So
> I thought this way would be easier.
> 
> julia

Ok. In that case it makes sense to just apply the one with better
name of course :) Thanks for the script!

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20171008/3074de0f/attachment.asc>
