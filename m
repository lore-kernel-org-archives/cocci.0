From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 04 Oct 2014 14:55:38 +0200
Subject: [Cocci] [PATCH v2 2/7] module: add extra argument for
 parse_params() callback
In-Reply-To: <1412372683-2003-3-git-send-email-mcgrof@do-not-panic.com>
References: <1412372683-2003-1-git-send-email-mcgrof@do-not-panic.com>
 <1412372683-2003-3-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <542FEE4A.4040401@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> This adds an extra argument onto parse_params() to be used
> as a way to make the unused callback a bit more useful and
> generic by allowing the caller to pass on a data structure
> of its choice.

How do you think about to work with more data type definitions for such callback
functions?

Regards,
Markus
