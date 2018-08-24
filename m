From: joe@perches.com (Joe Perches)
Date: Thu, 23 Aug 2018 17:25:51 -0700
Subject: [Cocci] [Fwd: Re: [PATCH] rtc: sun6i: Use struct_size() in
	kzalloc()]
In-Reply-To: <alpine.DEB.2.21.1808232014550.2536@hadrien>
References: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
 <700bfdf296aa112799b6a6f091162cc34f6fef10.camel@perches.com>
 <CAGXu5jL3C78vkVL968HtBdLZgRYYQp4_pTKMT=BTJnk5z6CH3w@mail.gmail.com>
 <alpine.DEB.2.21.1808231759050.2376@hadrien>
 <CAGXu5jLjOtG0jTt2ZVyZe7ivBfZhRTyOKai0fHMzPFxUCr3LRg@mail.gmail.com>
 <alpine.DEB.2.21.1808231811110.2376@hadrien>
 <4a992fbb6ae172baf3c76ed979bf6804914b089e.camel@perches.com>
 <CAGXu5jKdbGCLdSQFTdGnhgN+tNKHFV=XEkapgtYmx+hK79NMbw@mail.gmail.com>
 <0258fc5a24ad69f75f615d88fc93c714a91cb684.camel@perches.com>
 <alpine.DEB.2.21.1808232014550.2536@hadrien>
Message-ID: <881775fc5dad6aeb44467b1073ed45bcf75f9767.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2018-08-23 at 20:17 -0400, Julia Lawall wrote:
> 
> On Thu, 23 Aug 2018, Joe Perches wrote:
> 
> > On Thu, 2018-08-23 at 15:27 -0700, Kees Cook wrote:
> > > On Thu, Aug 23, 2018 at 3:21 PM, Joe Perches <joe@perches.com> wrote:
> > > > On Thu, 2018-08-23 at 18:13 -0400, Julia Lawall wrote:
> > > > > 
> > > > > On Thu, 23 Aug 2018, Kees Cook wrote:
> > > > > 
> > > > > (a + b) * c
> > > > > 
> > > > > It will consider a pattern with the parentheses removed, but that pattern
> > > > > won't match anything, because real trees that consist of a + b * c are
> > > > > parsed in a different way.
> > > > 
> > > > spatch 1.0.4 doesn't seem to:
> > > > 
> > > > $ spatch --version
> > > > spatch version 1.0.4 with Python support and with PCRE support
> > > > $ cat match_mul.cocci
> > > > @@
> > > > expression a, b, c;
> > > > int d;
> > > > @@
> > > > 
> > > > *       d = a * b + c;
> > > 
> > > But "(a * b) + c" for the rule does:
> > 
> > Yes, but not for other valid uses like below:
> > 
> > $ cat match_mul.cocci
> > @@
> > expression a, b, c;
> > int d;
> > @@
> > 
> > *	d = (a * b) + c;
> > $ cat test_mul.c
> > int a, b, c, d;
> > 
> > void foo(void)
> > {
> > 	d = ((a * b) + c);
> > 	d = ((a * b)) + c;
> > 	d = (a * b) + c;
> > 	d = a * b + c;
> > }
> > $ spatch -sp-file match_mul.cocci test_mul.c
> > init_defs_builtins: /usr/lib/coccinelle/standard.h
> > HANDLING: test_mul.c
> > diff =
> > --- test_mul.c
> > +++ /tmp/cocci-output-23856-7e83f7-test_mul.c
> > @@ -4,6 +4,4 @@ void foo(void)
> >  {
> >  	d = ((a * b) + c);
> >  	d = ((a * b)) + c;
> > -	d = (a * b) + c;
> > -	d = a * b + c;
> >  }
> 
> I'm not sure to get the point.
> 
> If you think that people may fully parenthesize the code, then ((a * b) +
> c) would be a reasonable option for the pattern.  I'm not sure why double
> parentheses, ((a * b)) + c, should exist in the first place.

People who write code do a lot of unnecessary things.
It's code I've seen in the past.
It occurs more with expressions than identifiers.

It'd be nice if coccinelle could parse arbitrarily
parenthesized code and script down to its minimal
logical requirements and match as maximally as possible.

cheers, Joe
