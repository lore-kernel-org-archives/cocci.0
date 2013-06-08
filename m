From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Jun 2013 21:06:28 +0200 (CEST)
Subject: [Cocci] Removing pointer declaration
In-Reply-To: <20130608190217.GB2997@katana>
References: <20130608172853.GA2997@katana>
 <alpine.DEB.2.02.1306082052560.1968@localhost6.localdomain6>
 <20130608190217.GB2997@katana>
Message-ID: <alpine.DEB.2.02.1306082104520.1968@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Jun 2013, Wolfram Sang wrote:

> Hi Julia,
> 
> On Sat, Jun 08, 2013 at 08:53:19PM +0200, Julia Lawall wrote:
> > On Sat, 8 Jun 2013, Wolfram Sang wrote:
> > 
> > > Hi,
> > > 
> > > This spatch:
> > > 
> > > @@
> > > int *p;
> > 
> > This should be "identifier p".
> 
> I noticed meanwhile. Is it because the type cannot be checked because
> the pointer has not been declared yet? And, in general, can I get some
> more info about what went wrong besides "parse error" somehow? --debug
> didn't help.

It is an identifier because it is a name.  Not an int like 32.

Unfortunately, it is hard to get a yacc-like parser to generate helpful 
error messages.  The code that one writes doesn't know about the context 
that it is in.

julia
