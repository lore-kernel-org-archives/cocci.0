From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Jul 2017 23:09:32 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <alpine.DEB.2.20.1707042302280.2042@hadrien>
References: <WM!cc508729d042cf12207adee814670b88c105ae73cdaf601fdeb9c3e26fa32e7df0d4d49f847a216810550421de0d8de6!@mailstronghold-3.zmailcloud.com>
 <20170704162732.urhtl54j3gbj3myh@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041837300.11588@hadrien>
 <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
 <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041858400.11588@hadrien>
 <WM!6445a14b41a047e62e6e93d9a0da969d5ea2daf83555655349684d54f3d26f5ca8795d092a053f4ee93c2a22f577a788!@mailstronghold-1.zmailcloud.com>
 <20170704174632.v7ibsesdtquktbjs@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041948510.3327@hadrien>
 <WM!afea88a820c9c853667fab8a120e0e62e64bc1c9aacab0e42f4149cedda4906e7b85ddc1f742afe16ea78098b42a61f6!@mailstronghold-3.zmailcloud.com>
 <20170704191736.rcghven7t3ol5ih3@eos.mistotebe.net>
 <alpine.DEB.2.20.1707042302280.2042@hadrien>
Message-ID: <alpine.DEB.2.20.1707042306250.2042@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Jul 2017, Julia Lawall wrote:

> > @@
> > bindings
> > identifier x : script:python(some bindings, even from this rule) { code }
> > @@
> > a
> > -b
> > +new(stuff, x)
> > -c
>
> OK, maybe it could be
>
> identifier x = script:python(some bindings, but not from this rule) { code }
>
> Bindings from the same rule are problematic.  CTL is bottom up, so you
> don't know the bindings of the other variables when you are matching a
> given one.  I guess a possibility would be to ignore the scripts and
> collect all the bindings possible (ie any possible identifier for x above),
> and then check them at the end.

I'm sorry already for having suggested this.  It would be a mess, I think.
When there is ..., variables can have different values on different
control-flow paths.  I guess that their quantifiers could be pushed up
around the scripts that depend on them, but I'm not sure that the user
would find the result very understandable.

julia
