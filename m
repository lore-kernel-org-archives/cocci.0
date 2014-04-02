From: joe@perches.com (Joe Perches)
Date: Wed, 02 Apr 2014 00:56:17 -0700
Subject: [Cocci] Clarification for source code style reformatting
In-Reply-To: <533BBA12.1040105@users.sourceforge.net>
References: <1396374174.21529.93.camel@joe-AO722>
 <533BBA12.1040105@users.sourceforge.net>
Message-ID: <1396425377.32040.7.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2014-04-02 at 09:19 +0200, SF Markus Elfring wrote:
> > The output is apparently correct and compilable.
> > It is just not kernel style.  I'm not sure there
> > is a defect really, just wanted to bring it up.
> > 
> > Maybe the first transform could be better written.
> 
> It seems that the shown differences in source code formatting come from your
> first semantic patch rule.
> Does your update suggestion fit to implementations of functions which had a
> non-void return type before?

void functions cannot have non-void returns.

> > $ cat void_return.cocci
> > @@
> > identifier func;
> > expression S;
> > @@
> > void func(...) {

This test is only for void functions.
