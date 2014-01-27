From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 27 Jan 2014 13:34:02 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogIGhvdyB0byB3cml0ZSBzdWNoIG1hdGNoaW5n?=
	=?gb2312?b?IGNhc2U/?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727FD008@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401021418020.2088@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727F5D5A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401030705560.2150@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F89C4@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210433490.2092@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8A3E@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210730200.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8ACB@fzex.ruijie.com.cn>
 <041CF35939B5534D851F16C30DD0B8CF727F8AEF@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8BD2@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401211019360.2098@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FCF1B@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401260318480.2217@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FD008@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.02.1401271333430.2139@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 27 Jan 2014, ??(?? ??) wrote:

> In SMPL,   'When != something'  means 'something' doesn?t exist ?

Yes, within the execution path(s) matched by ...

julia

> 
> 
> 
> -----????-----
> ???: Julia Lawall [mailto:julia.lawall at lip6.fr] 
> ????: 2014?1?26? 19:19
> ???: ??(?? ??)
> ??: cocci at systeme.lip6.fr
> ??: Re: [Cocci] how to write such matching case?
> 
> On Sun, 26 Jan 2014, ??(?? ??) wrote:
> 
> > In my project, it's required that if function A is called, and function B must be called following, just like this
> >
> > Foo(...)
> > {
> >    If ... {
> >        A(....);
> >        ...
> >        B(....);
> >    }
> > }
> >
> > Or
> >
> > Foo1(...)
> > {
> >         A(....);
> >         B(...);
> >  }
> >
> >
> > How to write a patch to find the missing case? Such as
> >
> > Foo(...)
> > {
> >    If ... {
> >        A(....);
> >        ...
> >    }
> > }
> >
> > Or
> >
> > Foo1(...)
> > {
> >        A(....);
> >        ...
> > }
> 
> A(...)
> ... When != B(...)
> 
> julia
> 
