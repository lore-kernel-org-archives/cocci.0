From: neleai@seznam.cz (=?utf-8?B?T25kxZllaiBCw61sa2E=?=)
Date: Thu, 30 May 2013 00:09:23 +0200
Subject: [Cocci] Converting old-style function definitions.
In-Reply-To: <alpine.DEB.2.02.1305291835300.2246@hadrien>
References: <20130529162209.GA30955@domone.kolej.mff.cuni.cz>
 <alpine.DEB.2.02.1305291835300.2246@hadrien>
Message-ID: <20130529220923.GB25088@domone.kolej.mff.cuni.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 29, 2013 at 06:37:04PM +0200, Julia Lawall wrote:
> On Wed, 29 May 2013, Ond?ej B?lka wrote:
> 
> >
> > Hi,
> >
> > I am interested in common cleanup to convert K&R function
> > definitions to ISO ones (As gcc warning in -Wold-style-definition).
> >
> > Probably someone already wrote spatch so I ask here who?
> 
> Unfortunately, it is not supported.  The Coccinelle C parser makes at
> least an attempt to parse K&R function definitions, but the SmPL parser,
> ie the parser of the transformation specification language, doesn't accept
> them.
> 
Thanks, it looks that I will take plan B, parse -Wold-style-definition
output and try convert corresponding lines by script.
