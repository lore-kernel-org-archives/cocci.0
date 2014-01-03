From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 3 Jan 2014 07:09:55 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogtPC4tDogtPC4tDogtPC4tDogtPC4tDogIGhp?=
	=?gb2312?b?IGFsbCwgaG93IHRvIG1hdGNoIHRoZSBhcmdzIGluIGZ1bmN0aW9u?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727F5D5A@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401020939060.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F485B@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021014460.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F488A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021024400.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F5C4F@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021111560.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F5CA5@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401021418020.2088@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727F5D5A@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.02.1401030705560.2150@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 3 Jan 2014, ??(?? ??) wrote:

> well, I downloaded the debian install package from ' coccinelle.lip6.fr.'
> 
> http://coccinelle.lip6.fr/download.php
> quote:
> Packages exist for several distributions:
> Debian, thanks to Eugeniy Meshcheryakov
> http://packages.debian.org/squeeze/coccinelle, maybe it hasn?t updated for a long time??

The debian package is updated regularly, I believe.  But the link on the 
Coccinelle web page doesn't go anywhere.  I will try to update it, but if 
you are using debian, then you could take the version in your package 
manager?

I see that the version in Debian squeeze is indeed 0.2.3, but I think that 
version of Debian is out of date.  The current stable version is wheezy, 
which has 1.0.0~rc12.  The testing and unstable versions have 1.0.0-rc19.

julia

> 
> -----????-----
> ???: Julia Lawall [mailto:julia.lawall at lip6.fr] 
> ????: 2014?1?2? 21:20
> ???: ??(?? ??)
> ??: cocci at systeme.lip6.fr
> ??: Re: ??: ??: ??: ??: [Cocci] hi all, how to match the args in function
> 
> On Thu, 2 Jan 2014, ??(?? ??) wrote:
> 
> > Cocc version? I guess it's got by -v?
> > # spatch -version
> > spatch version 0.2.3 with Python support maybe it is up to date?
> 
> No, it is quite old.  The current version is 1.0.0-rc19 If you like, you can get it from github:
> https://github.com/coccinelle/coccinelle
> 
> > and old version of grammer pdf is downloaded from: 
> > http://www.emn.fr/z-info/coccinelle/docs/main_grammar.pdf
> > thank you tell me the new version of pdf
> 
> OK, that website is quite out of date.  Use coccinelle.lip6.fr.
> 
> julia
> 
