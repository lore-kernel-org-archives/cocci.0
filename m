From: linjia@ruijie.com.cn (=?gb2312?B?wda8ziizzLb+ILij1t0p?=)
Date: Fri, 14 Feb 2014 12:39:51 +0000
Subject: [Cocci] =?gb2312?b?tPC4tDogIEZhdGFsIGVycm9yOiBleGNlcHRpb24gRmFp?=
 =?gb2312?b?bHVyZSgibm8gcHl0aG9uIik=?=
In-Reply-To: <alpine.DEB.2.10.1402140954210.2118@hadrien>
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
 <alpine.DEB.2.10.1402140954210.2118@hadrien>
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727FE30C@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



-----????-----
???: Julia Lawall [mailto:julia.lawall at lip6.fr] 
????: 2014?2?14? 16:56
???: ??(?? ??)
??: cocci at systeme.lip6.fr
??: Re: [Cocci] Fatal error: exception Failure("no python")

On Fri, 14 Feb 2014, ??(?? ??) wrote:

> I did some 'apt-get install update' and 'apt-get install upgrade' 
> today
>
> Then I found cocc can not work, it reports: Fatal error: exception 
> Failure("no python")
>
> But I run python -v is ok
>
> # python -V
> Python 2.7.3
>
> Why? How can I fix this?

Perhaps your python is not in a standard place?

I don?t know how python is placed..but the result of whereis is

# whereis python
python: /usr/bin/python2.6 /usr/bin/python2.7 /usr/bin/python2.7-config /usr/bin/python /etc/python2.6 /etc/python2.7 /etc/python /usr/lib/python2.6 /usr/lib/python2.7 /usr/bin/X11/python2.6 /usr/bin/X11/python2.7 /usr/bin/X11/python2.7-config /usr/bin/X11/python /usr/local/lib/python2.6 /usr/local/lib/python2.7 /usr/include/python2.6 /usr/include/python2.7 /usr/include/python2.7_d /usr/include/python2.6_d /usr/share/python /usr/share/man/man1/python.1.gz



What distribution of Linux are you using?  What version of Coccinelle do you have?
~~~~~~~~~~~ uname -ar
Linux debian 2.6.33.7-co-0.7.9 #1 PREEMPT Sat Apr 9 20:30:51 UTC 2011 i686 GNU/Linux

I installed 0.2.3.firstly,  then installed 1.0.0-rc19
julia
