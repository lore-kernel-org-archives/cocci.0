From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jan 2014 17:42:02 +0100 (CET)
Subject: [Cocci] how to match this case?
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727F89C4@fzex.ruijie.com.cn>
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
Message-ID: <alpine.DEB.2.10.1401211741120.2098@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

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
> rule starting on line 1: position variables or mixed modifs interfere with comm_assoc isobool (bool (int vp > int C) || ...)
>
> can anyone tell why, thanks

I tried the above code exactly, and I didn't get the problem.

I also tried removing int i; and changing i > 100 to iParam > 100, and
then it was able to remove the function definition.

julia
