From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Mon, 6 Oct 2014 22:38:23 +0200
Subject: [Cocci] [PATCH v2 2/7] module: add extra argument
	for	parse_params() callback
In-Reply-To: <542FEE4A.4040401@users.sourceforge.net>
References: <1412372683-2003-1-git-send-email-mcgrof@do-not-panic.com>
 <1412372683-2003-3-git-send-email-mcgrof@do-not-panic.com>
 <542FEE4A.4040401@users.sourceforge.net>
Message-ID: <20141006203823.GB14081@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Oct 04, 2014 at 02:55:38PM +0200, SF Markus Elfring wrote:
> > This adds an extra argument onto parse_params() to be used
> > as a way to make the unused callback a bit more useful and
> > generic by allowing the caller to pass on a data structure
> > of its choice.
> 
> How do you think about to work with more data type definitions for such callback
> functions?

Sorry I don't understand what you mean.

  Luis
