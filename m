From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jan 2014 10:22:35 +0100 (CET)
Subject: [Cocci] infinitly loop in spatch?
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727F8BD2@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
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
 <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8BD2@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.10.1401211019360.2098@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 21 Jan 2014, ??(?? ??) wrote:

> When I use spatch to scan some file, I found it may loop sometimes, did anyone encounter too?

It can run for a very long time, especially when there are nested loops,
and these loops contain many conditionals.  Basically it is trying all of
the control-flow paths.  One option is to tell it to ignore loops, with
the --no-loops option.  This can be unsafe, because it could miss some
matches from the bottom of the loop back to the top, but that might not be
relevant to your pattern.  Another option is to put a timeout --timeout
120, for example (120 seconds).  If it exceeds that time, it will do
nothing for the file.

If you want me to look at the problem in more detail, please send the
semantic patch and some problematic code.

julia


>
> If using -debug,  it show pause at 'bind' step
>
> -----------------------------------------------------------------------
> HANDLING: /root/windows/ok_file.c
> -----------------------------------------------------------------------
> let's go
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> rule starting on line 1 =
> -----------------------------------------------------------------------
> dependencies for rule rule starting on line 1 satisfied:
> binding in = []
> binding relevant in = []
> -----------------------------------------------------------------------
> proto for rule starting on line 1 =
> -----------------------------------------------------------------------
> dependencies for rule proto for rule starting on line 1 not satisfied:
> rule starting on line 1 not satisfied
> binding in environment = []
> -----------------------------------------------------------------------
> Finished
> -----------------------------------------------------------------------
> HANDLING: /root/loop_file.c
> -----------------------------------------------------------------------
> let's go
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> rule starting on line 1 =
> -----------------------------------------------------------------------
> dependencies for rule rule starting on line 1 satisfied:
> binding in = []
> binding relevant in = []  <---  step here, then nothing more output.....     :(
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
