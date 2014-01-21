From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jan 2014 08:48:25 +0100 (CET)
Subject: [Cocci]
	=?gb2312?b?tPC4tDogILTwuLQ6ILTwuLQ6ICBob3cgdG8gbWF0Y2gg?=
	=?gb2312?b?dGhpcyBjYXNlPw==?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727F8AEF@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
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
 <041CF35939B5534D851F16C30DD0B8CF727F8A3E@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210730200.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8ACB@fzex.ruijie.com.cn>
 <041CF35939B5534D851F16C30DD0B8CF727F8AEF@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 21 Jan 2014, ??(?? ??) wrote:

> I see, I should add '()' if I use '|'

Yes :)

julia

> 
> 
> -----????-----
> ???: cocci-bounces at systeme.lip6.fr [mailto:cocci-bounces at systeme.lip6.fr] ?? ??(?? ??)
> ????: 2014?1?21? 14:44
> ???: Julia Lawall
> ??: cocci at systeme.lip6.fr
> ??: [Cocci] ??: ??: how to match this case?
> 
> Thanks for remind.
> But to the "|" operator , I still don?t know how to use, for example, I wrote
> 
> 
> @disable comm_assoc@
> identifier fn, p;
> identifier I;
> type T,T1;
> expression C;
> @@
> -fn(...)
> -{
> -int p;
> -...
> -T I[C];
> | 
> -T I[C];
> -...
> -int p;
> -<+...
> -if(p > C){
> -...
> -}
> -...+>
> -}
> 
> 
> 
> It reports: init_defs_builtins: /usr/share/coccinelle/standard.h
> 126 127
> Fatal error: exception Failure("minus: parse error: 
>  = File "os.cocci", line 12, column 0,  charpos = 126
>     around = '|', whole content = |
> ")
> 
> -----????-----
> ???: Julia Lawall [mailto:julia.lawall at lip6.fr]
> ????: 2014?1?21? 14:32
> ???: ??(?? ??)
> ??: cocci at systeme.lip6.fr
> ??: Re: ??: [Cocci] how to match this case?
> 
> On Tue, 21 Jan 2014, ??(?? ??) wrote:
> 
> > Sorry, I made a mistake , if the checkpoint is local variable, I 
> > should write as
> > 
> > -int vp;
>   ...
> > -T I[C];
> 
> Also, you don't know if the array is declared before or after vp.  So you would need 
> 
> (
> - int vp;
>   ...
> - T I[C];
> |
> - T I[C];
>   ...
> - int vp;
> )
> 
> julia
> 
> > -<+...
> > -if(vp > C || ...){
> > 
> > -----????-----
> > ???: Julia Lawall [mailto:julia.lawall at lip6.fr]
> > ????: 2014?1?21? 11:35
> > ???: ??(?? ??)
> > ??: cocci at systeme.lip6.fr
> > ??: Re: [Cocci] how to match this case?
> > 
> > 
> > 
> > On Tue, 21 Jan 2014, ??(?? ??) wrote:
> > 
> > > Following is a code with bug
> > > 
> > > -----------------------------------
> > > void set_timeout_value(int iParam)
> > > {
> > > 	 int i;
> > > 	 byte b[100];
> > > 	 i = Geti();
> > > 	 if (i > 100 || i < 0){
> > > 	 	  return ;
> > > 	 	}	 	
> > > 	 b[i] = iParam;	/*  range of I is 0-100?so may overrun array* /
> > > 
> > > }
> > > -----------------------------------
> > > Now I write a patch to find it, like this
> > > 
> > > @@
> > > identifier fn, vp;
> > > identifier I;
> > > type T;
> > > expression C;
> > > @@
> > > -fn(...,int vp,...)
> > > -{
> > > -T I[C];
> > > -<+...
> > > -if(vp > C || ...){
> > > -...
> > > -}
> > > -...+>
> > > -}
> > > 
> > > 
> > > But it doesn?t work, give me a log:
> > > rule starting on line 1: position variables or mixed modifs 
> > > interfere with comm_assoc isobool (bool (int vp > int C) || ...)
> > 
> > I will look into it, but you could try putting disable comm_assoc in between the initial @@, if you just want to see if your rule is working a little bit.
> > 
> > julia
> > 
> > 
> > > 
> > > can anyone tell why, thanks
> > > _______________________________________________
> > > Cocci mailing list
> > > Cocci at systeme.lip6.fr
> > > https://systeme.lip6.fr/mailman/listinfo/cocci
> > > 
> > 
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
