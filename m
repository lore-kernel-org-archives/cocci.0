From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Jan 2014 10:16:21 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogIGhpIGFsbCwgaG93IHRvIG1hdGNoIHRoZSBh?=
	=?gb2312?b?cmdzIGluIGZ1bmN0aW9u?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727F485B@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401020939060.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F485B@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.02.1401021014460.2182@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2 Jan 2014, ??(?? ??) wrote:

> Well, now I wrote as following:
> 
> @@
> identifier fn, vp;
> typedef bri_vlan_set_t;
> @@
> fn(...,bri_vlan_set_t vp,...);

Oops sorry.  I you want to match only the prototype, you do need to put 
the type out front.  So it would be

 @@
 identifier fn, vp;
 typedef bri_vlan_set_t;
 type T;
 @@
 T fn(...,bri_vlan_set_t vp,...);

julia
