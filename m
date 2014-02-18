From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Feb 2014 08:34:36 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogIHdoYXQgaXMgdGhlIGZ1bmN0aW9uIG9mICdw?=
	=?gb2312?b?b3NpdGlvbicgaW4gU01QTA==?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727FE87E@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <CA+MoWDoW8bYPE=1muhQ4w7tUgPFK9xNDSQzo6idgnvZXkit-yw@mail.gmail.com>
 <041CF35939B5534D851F16C30DD0B8CF727FD30A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401280823560.2162@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FDDE6@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1402120722020.2039@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FE284@fzex.ruijie.com.cn>
 <CAAxaTiN=n76TLavcDEj3NBBL5=DdUKWc0b6AeOs_5FTzBhxNDg@mail.gmail.com>
 <041CF35939B5534D851F16C30DD0B8CF727FE31D@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1402141356280.2118@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FE3D7@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1402150713320.1988@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FE613@fzex.ruijie.com.cn>
 <CA+MoWDqML-ZhpOTr1gyzdh9NWgq53y15JX70hOVgpBcQWaDriQ@mail.gmail.com>
 <041CF35939B5534D851F16C30DD0B8CF727FE87E@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.02.1402180833580.1997@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 18 Feb 2014, ??(?? ??) wrote:

> Thank to all 
> 
> What the differentce among 'Identifier declaration statement' in metavariable portion?
> I  just guess they all can be used to express a name of variable or function

An identifier can be used to express the name of a variable, a function, a 
field, the name of a structure, the name of an enum, the name of a 
#define, etc.

julia

> 
> For example:
> 
> @@
> Identifier a; or declaration a;?
> @@
> ...........
> 
> 
> 
> -----????-----
> ???: Peter Senna Tschudin [mailto:peter.senna at gmail.com] 
> ????: 2014?2?17? 21:35
> ???: ??(?? ??)
> ??: cocci at systeme.lip6.fr
> ??: Re: [Cocci] what is the function of 'position' in SMPL
> 
> p is a position metavariable. It is useful when you want to print line and column numbers of interesting parts.
> 
> The @p means that the position of what matches to 'i' will be saved into p.
> 
> There is some information available at:
> http://coccinelle.lip6.fr/docs/main_grammar.pdf
> 
> On Mon, Feb 17, 2014 at 6:45 AM, ??(?? ??) <linjia@ruijie.com.cn> wrote:
> > e.g. in find_unsigned.cocci
> >
> > @u@ type T; unsigned T i; position p; @@  i at p < 0
> >
> >
> > what is the difference with
> >
> > @u@ type T; unsigned T i; @@
> >  i < 0
> >
> >
> > and what is the meaning of operator '@' ahead 'p'?
> >
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> 
> 
> 
> -- 
> Peter
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
