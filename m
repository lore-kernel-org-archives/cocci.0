From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 7 Oct 2014 00:15:21 +0200
Subject: [Cocci] [PATCH v2 2/7] module: add extra argument
	for	parse_params() callback
In-Reply-To: <5433045A.9000108@users.sourceforge.net>
References: <1412372683-2003-1-git-send-email-mcgrof@do-not-panic.com>
 <1412372683-2003-3-git-send-email-mcgrof@do-not-panic.com>
 <542FEE4A.4040401@users.sourceforge.net>
 <20141006203823.GB14081@wotan.suse.de>
 <5433045A.9000108@users.sourceforge.net>
Message-ID: <20141006221521.GC14081@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Oct 06, 2014 at 11:06:34PM +0200, SF Markus Elfring wrote:
> >> How do you think about to work with more data type definitions for such
> >> callback functions?
> > 
> > Sorry I don't understand what you mean.
> 
> Can a specific "typedef" help in corresponding software maintenance?
> 
> Do you find descriptions from an other software application useful for such an
> use case here?
> http://www.fltk.org/doc-1.3/group__callback__functions.html

Thanks I've reviewed this but I prefer to avoid typedefs.

  Luis
