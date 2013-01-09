From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Jan 2013 21:14:25 +0100 (CET)
Subject: [Cocci] Matching outside of blocks
In-Reply-To: <20130109194512.GB11410@avionic-0098.adnet.avionic-design.de>
References: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
 <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
 <alpine.DEB.2.02.1301091811250.2053@localhost6.localdomain6>
 <20130109194512.GB11410@avionic-0098.adnet.avionic-design.de>
Message-ID: <alpine.DEB.2.02.1301092106190.2053@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> While we're at it, I was going to follow up with another semantic patch
> to remove error messages in the devm_request_and_ioremap() errors paths
> because the function outputs an error message itself already. In many
> cases this results in an if block becoming a single line, so CodingStyle
> requires the { } to be removed. Is there any way to do that
> automatically?

One solution would be to put eg

if (...)
- {
(
  goto l;
|
  return ...;
)
- }

at the end of your semantic patch.  That will affect everything, but if 
you don't mind doing a little extra work on the side, it could be helpful 
to submit patches to fix up those as well.

The other solution is to do it as part of removing the printing command.  
That is, to first have a rule that does something like (you can fill in 
all the transformation parts that I have left out):

x = devm...;
... when != x = e
if (x == NULL || ...)
- {
- f(...,c,...);
  return ...;
- }

And then have a second rule that does the more general case where the { } 
don't need to be removed.

c should be declared as char [] c;

I'm just assuming that anything with a string argument is undesirable. On 
the other hand, there is no way to match something like
KERN_EMERG "string".  Another alternative would be just to put all of the 
names of the error reporting functions that you know of.  You can also put 
them in a ( | ), ie

(
- printk(...);
|
- f(...,c,...);
)

It take the first match that works out, so you don't have to worry about 
the cases being disjoint.

julia

> > When any allows there to be any assignment before ret = E.  What you are 
> > interested in is the last assignment, in particular the last assignment of 
> > the value that is returned.  Not putting anything on the ... at the end 
> > will give you this shortest path property.  If you are really worried 
> > about gotos, you could also put when != goto l; where l is an identifier 
> > metavariable on the first ...  But I think that the chance of a problem 
> > there is minimal.
> 
> Thanks for explaining this. I had been wondering about "when any". I'm
> very new to coccinelle so there's still a lot to learn.
> 
> Thierry
> 
