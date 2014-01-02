From: linjia@ruijie.com.cn (=?gb2312?B?wda8ziizzLb+ILij1t0p?=)
Date: Thu, 2 Jan 2014 12:57:58 +0000
Subject: [Cocci] =?gb2312?b?tPC4tDogtPC4tDogtPC4tDogtPC4tDogIGhpIGFsbCwg?=
 =?gb2312?b?aG93IHRvIG1hdGNoIHRoZSBhcmdzIGluIGZ1bmN0aW9u?=
In-Reply-To: <alpine.DEB.2.02.1401021111560.2182@localhost6.localdomain6>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401020939060.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F485B@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021014460.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F488A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021024400.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F5C4F@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021111560.2182@localhost6.localdomain6>
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727F5CA5@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Cocc version? I guess it's got by -v?
# spatch -version
spatch version 0.2.3 with Python support
maybe it is up to date?



and old version of grammer pdf is downloaded from: http://www.emn.fr/z-info/coccinelle/docs/main_grammar.pdf
thank you tell me the new version of pdf 


-----????-----
???: Julia Lawall [mailto:julia.lawall at lip6.fr] 
????: 2014?1?2? 18:18
???: ??(?? ??)
??: cocci at systeme.lip6.fr
??: Re: ??: ??: ??: [Cocci] hi all, how to match the args in function

On Thu, 2 Jan 2014, ??(?? ??) wrote:

> Thank you very much, it works now!
> 
> And do u know where can I get more document about SmPL grammer?  I 
> only have a < The SmPL Grammar (version 0.1.4)Research group on 
> Coccinelle June 5, 2009> Which describe some simply, and there are not 
> enough examples,

I wonder where you got that version?  The version on the Coccinelle web page is for version 1.0.0-rc18 and is available here:

http://coccinelle.lip6.fr/docs/main_grammar.pdf

It is probably not very useful for learning Coccinelle, though.

If you are using Coccinelle version 0.1.4 you will need to upgrade.

One good resource is the mailing list, which is archived on gmane:

http://blog.gmane.org/gmane.comp.version-control.coccinelle

There are some examples with explanations on the web page:

http://coccinelle.lip6.fr/rules/

There are many examples without explanations here:

https://github.com/coccinelle/coccinellery

There are also examples in the Linux kernel source tree, in the scripts/coccinelle directory.

julia
