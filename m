From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 09 Feb 2017 14:03:11 +0100
Subject: [Cocci] using "attribute" in - context?
In-Reply-To: <alpine.DEB.2.20.1702091346030.2006@hadrien>
References: <1486640886.17671.0.camel@sipsolutions.net>
 <alpine.DEB.2.20.1702091346030.2006@hadrien>
Message-ID: <1486645391.17671.1.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2017-02-09 at 13:47 +0100, Julia Lawall wrote:
> 
> On Thu, 9 Feb 2017, Johannes Berg wrote:
> 
> > Is there a way to make this work?
> > 
> > @@
> > identifier fam;
> > attribute __ro_after_init;
> > attribute __genl_ro_after_init;
> > @@
> > ?struct genl_family fam
> > - __ro_after_init
> > + __genl_ro_after_init
> > ?= {...};
> 
> Not currently, I think.??I think that Coccinelle only recognizes
> attributes on function definitions.

Ok, thanks. I'll just define __ro_after_init to nothing then :)

johannes
