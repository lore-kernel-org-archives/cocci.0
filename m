From: luca@coelho.fi (Luca Coelho)
Date: Tue, 11 Sep 2018 14:22:44 +0300
Subject: [Cocci] Weird problem trying to match code inside a function
In-Reply-To: <alpine.DEB.2.20.1809111059590.3671@hadrien>
References: <fa1892a1698ad83235d455a947c354a54fa34c1d.camel@coelho.fi>
 <alpine.DEB.2.20.1809111059590.3671@hadrien>
Message-ID: <9ff5075ecd90926d1e47060f0309cd2c0e531ba2.camel@coelho.fi>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2018-09-11 at 11:05 +0200, Julia Lawall wrote:
> 
> On Tue, 11 Sep 2018, Luca Coelho wrote:
> 
> > Hi Julia,
> > 
> > I bumped in to another weird problem.  I'm trying to match some
> > code
> > inside a function that has a specific struct as a parameter, but I
> > can't get it to work.
> > 
> > This is cocci code I tried first:
> > 
> > http://pastebin.coelho.fi/6f8f346822a7c99e.txt
> > 
> > And this is the file I'm trying to match:
> > 
> > http://pastebin.coelho.fi/f73f542932add1c6.txt
> > 
> > The led activate op changed from being a function that returns void
> > to
> > one that returns int and I had to backport that.
> > 
> > The strange thing is that if I have only the first rule, it works
> > fine,
> > but when I add the second rule it fails.
> 
> I didn't look at the code in detail, but there is a restriction on
> metavariables that are not position variables that are inherited from
> one
> rule to another.  Such metavariables have to have only one value.  If
> there is more than one possible value, the original match fails
> completely.
> 
> For example, if you do:
> 
> @r@
> expression E;
> @@
> 
> f();
> ...
> -g(E);
> 
> This will do the right thing for:
> 
> f();
> if (x)
>   g(3);
> else g(4);
> 
> But if you do:
> 
> @r@
> expression E;
> @@
> 
> f();
> ...
> -g(E);
> 
> @@
> expression r.E;
> @@
> 
> - xxx(E);
> 
> Then nothing will happen at all.  Because in the first rule, it is
> not
> able to find a unique binding for E.
> 
> A solution can be:
> 
> @r@
> expression E;
> position p;
> @@
> 
> f();
> ...
> g(E at p);
> 
> @s@
> position r.p;
> expression E;
> @@
> 
> - g(E at p);
> 
> @@
> expression s.E;
> @@
> 
> - xxx(E);
> 
> Position metavariable can take on many values, even if they are
> inherited.

Ah, I think this explains the problem.

I tried to add the position thing in my rules, but I didn't succeed. 
I'll have to try again at some other time.  My rules without matching
inside a function work fine, so I'll leave with that for now.

Thanks!

--
Luca.
