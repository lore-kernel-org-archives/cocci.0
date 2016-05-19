From: mmarek@suse.com (Michal Marek)
Date: Thu, 19 May 2016 09:57:34 +0200
Subject: [Cocci] [PATCH] coccicheck: Fix missing 0 index in kill loop
In-Reply-To: <alpine.DEB.2.10.1605171633460.3068@hadrien>
References: <20160516125558.GA352@www.outflux.net> <573B2B89.7060004@imag.fr>
 <alpine.DEB.2.10.1605171633460.3068@hadrien>
Message-ID: <573D71EE.9000604@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 17.5.2016 v 16:33 Julia Lawall napsal(a):
> 
> 
> On Tue, 17 May 2016, Nicolas Palix (LIG) wrote:
> 
>> Le 16/05/16 14:55, Kees Cook a ?crit :
>>> By default, "seq" counts from 1, but processes were starting counting
>>> from 0, so when interrupted, coccicheck would leave the 0th process
>>> running.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied to kbuild.git#misc.

Michal
