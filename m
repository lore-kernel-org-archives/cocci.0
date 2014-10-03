From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 03 Oct 2014 09:55:36 +0200
Subject: [Cocci] minor issue: pretty printing for modified functions as
 arguments
In-Reply-To: <20141001184054.GM14081@wotan.suse.de>
References: <20141001184054.GM14081@wotan.suse.de>
Message-ID: <542E5678.5040804@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Subject: [PATCH] module: add extra argument for parse_params() callback
> 
> This adds an extra argument onto parse_params() to be used
> as a way to make the unused callback a bit more useful and
> generic by allowing the caller to pass on a data structure
> of its choice.

How do you think about to reuse a type definition for such callback functions?
Was such an implementation detail also discussed on a mailing list or forum
already?

Regards,
Markus
