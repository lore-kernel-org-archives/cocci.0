From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Feb 2014 10:00:56 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogILTwuLQ6ICB3aGF0IGlzIHRoZSBmdW5jdGlv?=
	=?gb2312?b?biBvZiAncG9zaXRpb24nIGluIFNNUEw=?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727FE8BD@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
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
 <alpine.DEB.2.02.1402180833580.1997@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FE8BD@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.10.1402180958070.2083@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 18 Feb 2014, ??(?? ??) wrote:

> Thanks,  So, what's the difference between 'statement' and 'expression'?
> I guess statement means a complete line in c code, such as  's = socket(...);' while expression means an incomplete part, e.g. right hand of operator, 'socket(inet, 0, 0, 0)' ?

A statement has no value.  So like s = socket(...); but also if (...)
return;, etc.

An expression has a value.  So like 3 + 4, f(), etc.  x = y without a
trailing semicolon is also an expression.

There is a simple grammar for a C-like language here:

http://marvin.cs.uidaho.edu/Teaching/CS445/c-Grammar.pdf

This is not the grammar that we follow, but it can give the idea.

julia
