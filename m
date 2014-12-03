From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Dec 2014 13:52:53 +0100 (CET)
Subject: [Cocci] [patch] CodingStyle: add some more error handling
	guidelines
In-Reply-To: <20141203124511.GR5048@mwanda>
References: <20141202085950.GA13434@mwanda>
 <547F0297.6030202@users.sourceforge.net> <20141203124511.GR5048@mwanda>
Message-ID: <alpine.DEB.2.10.1412031352120.2373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 3 Dec 2014, Dan Carpenter wrote:

> On Wed, Dec 03, 2014 at 01:31:19PM +0100, SF Markus Elfring wrote:
> >
> > * To which source code place should the word "location" refer to?
> >   - jump source
> >   - jump target
>
> jump target.

I think you mean source?  Or it really is ambiguous.  The example was
err_kmalloc_failed, which seems source-related.

julia
