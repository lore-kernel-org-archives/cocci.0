From: linjia@ruijie.com.cn (=?gb2312?B?wda8ziizzLb+ILij1t0p?=)
Date: Tue, 21 Jan 2014 03:46:58 +0000
Subject: [Cocci] =?gb2312?b?tPC4tDogIGhvdyB0byBtYXRjaCB0aGlzIGNhc2U/?=
In-Reply-To: <alpine.DEB.2.02.1401210433490.2092@localhost6.localdomain6>
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
 <alpine.DEB.2.02.1401030705560.2150@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F89C4@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210433490.2092@localhost6.localdomain6>
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727F89FB@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Like this?  @disable comm_assoc@

After I added, the warning dissapper, but nothing matched output,  it seems skip the statement I intended....?

init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: single2.c

-----????-----
???: Julia Lawall [mailto:julia.lawall at lip6.fr] 
????: 2014?1?21? 11:35
???: ??(?? ??)
??: cocci at systeme.lip6.fr
??: Re: [Cocci] how to match this case?



On Tue, 21 Jan 2014, ??(?? ??) wrote:

> Following is a code with bug
> 
> -----------------------------------
> void set_timeout_value(int iParam)
> {
> 	 int i;
> 	 byte b[100];
> 	 i = Geti();
> 	 if (i > 100 || i < 0){
> 	 	  return ;
> 	 	}	 	
> 	 b[i] = iParam;	/*  range of I is 0-100?so may overrun array* /
> 
> }
> -----------------------------------
> Now I write a patch to find it, like this
> 
> @@
> identifier fn, vp;
> identifier I;
> type T;
> expression C;
> @@
> -fn(...,int vp,...)
> -{
> -T I[C];
> -<+...
> -if(vp > C || ...){
> -...
> -}
> -...+>
> -}
> 
> 
> But it doesn?t work, give me a log:
> rule starting on line 1: position variables or mixed modifs interfere 
> with comm_assoc isobool (bool (int vp > int C) || ...)

I will look into it, but you could try putting disable comm_assoc in between the initial @@, if you just want to see if your rule is working a little bit.

julia


> 
> can anyone tell why, thanks
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
