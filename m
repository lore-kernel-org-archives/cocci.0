From: johannes@sipsolutions.net (Johannes Berg)
Date: Tue, 18 Sep 2018 12:43:57 +0200
Subject: [Cocci] moving const instead of not matching?
In-Reply-To: <alpine.DEB.2.20.1809181239470.3737@hadrien>
References: <1537262433.2957.18.camel@sipsolutions.net>
 <alpine.DEB.2.20.1809181239470.3737@hadrien>
Message-ID: <1537267437.2957.22.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2018-09-18 at 12:41 +0200, Julia Lawall wrote:
> > but then I ran across a place that had a const, and the result was
> > rather unexpected:
> > 
> > $ spatch --sp-file /tmp/test3.spatch /tmp/test.c
> > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> > HANDLING: /tmp/test.c
> > diff =
> > --- /tmp/test.c
> > +++ /tmp/cocci-output-8879-8411db-test.c
> > @@ -1,4 +1,4 @@
> >  int main()
> >  {
> > -	memcpy(dst, (const u8 *)src, sz);
> > +	memcpy(dst, src const, sz);
> >  }
> > 
> > 
> > Why is the const being moved there, rather than not matching?
> 
> To get it to not match this case, put disable optional_qualifier in the
> rule header.

Ok, I can try that.

>   There is an isomorphism that allows it to not care about
> whether things like const or volatile are present or not, but apparently
> it is not deleting it as it should be.

Still seems like a bug?

> If you want to match the const case, you can make some other rules with
> const explicitly.

Right. I tried to put that before this one, but somehow it still
resulted in the same. Perhaps if I disable optional_qualifier for both
it'll work.

> > spatch version 1.0.6.
> 
> You may want to upgrade, although it's unrelated to this issue.

Yeah, I'm (obviously) aware, but with all the version number issues with
1.0.7 I haven't gotten around to it :)

johannes
