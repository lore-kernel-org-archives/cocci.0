From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 14 Feb 2014 09:56:00 +0100 (CET)
Subject: [Cocci] Fatal error: exception Failure("no python")
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727FE284@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <041CF35939B5534D851F16C30DD0B8CF727F8AEF@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8BD2@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401211019360.2098@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FCF1B@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401260318480.2217@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FD05B@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401271332210.2139@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FD228@fzex.ruijie.com.cn>
 <CA+MoWDoW8bYPE=1muhQ4w7tUgPFK9xNDSQzo6idgnvZXkit-yw@mail.gmail.com>
 <041CF35939B5534D851F16C30DD0B8CF727FD30A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401280823560.2162@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FDDE6@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1402120722020.2039@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FE284@fzex.ruijie.com.cn>
Message-ID: <alpine.DEB.2.10.1402140954210.2118@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 14 Feb 2014, ??(?? ??) wrote:

> I did some 'apt-get install update' and 'apt-get install upgrade' today
>
> Then I found cocc can not work, it reports: Fatal error: exception Failure("no python")
>
> But I run python -v is ok
>
> # python -V
> Python 2.7.3
>
> Why? How can I fix this?

Perhaps your python is not in a standard place?

What distribution of Linux are you using?  What version of Coccinelle do
you have?

julia
