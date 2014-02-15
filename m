From: linjia@ruijie.com.cn (=?utf-8?B?5p6X5ZiJKOeoi+S6jCDnpo/lt54p?=)
Date: Sat, 15 Feb 2014 02:30:04 +0000
Subject: [Cocci] =?utf-8?b?562U5aSNOiAg562U5aSNOiAgRmF0YWwgZXJyb3I6IGV4?=
 =?utf-8?q?ception_Failure=28=22no_python=22=29?=
In-Reply-To: <alpine.DEB.2.10.1402141356280.2118@hadrien>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
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
 <CAAxaTiN=n76TLavcDEj3NBBL5=DdUKWc0b6AeOs_5FTzBhxNDg@mail.gmail.com>
 <041CF35939B5534D851F16C30DD0B8CF727FE31D@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1402141356280.2118@hadrien>
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727FE3D7@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Sorry , I didn?t describe clearly.  Well,  The step is following:

1  I installed cocc by using deb package 'coccinelle_0.2.3.deb-1_i386.deb' at first.   All is ok.

2  Then I think its version may be too low. So I downloaded the source of version 1.0 and make install.  All is ok.

3  I made some 'apt-get install upgrade and update' for another reason, I didn?t think it has something to do with cocc.

4  the problem occur when I use cocc. 

5  I found I can run cocc by "/usr/bin/spatch " , but not by "spatch ",  I think there is some chaos in the cocc config now, see following...

root at debian:~/windows/ctest/cocc# /usr/bin/spatch -version 
spatch version 0.2.3 with Python support
root at debian:~/windows/ctest/cocc# spatch -version
spatch version 1.0.0-rc19 without Python support and with Str regexp support 
root at debian:~/windows/ctest/cocc#



-----????-----
???: Julia Lawall [mailto:julia.lawall at lip6.fr] 
????: 2014?2?14? 20:58
???: ??(?? ??)
??: Nicolas Palix; cocci at systeme.lip6.fr
??: Re: [Cocci] ??: Fatal error: exception Failure("no python")

On Fri, 14 Feb 2014, ??(?? ??) wrote:

> # spatch --version
> spatch version 1.0.0-rc19 without Python support and with Str regexp 
> support
>
> but I didn't make and make install with option '--without-python '
> that is I pressed  ./configure --enable-release, just it
>
>
> and now when I run "/usr/bin/spatch -sp_file ....", all is ok, it 
> seems version 0.2.3 runs but "spatch -sp_file " reports fail, seems version 1.0 runs?

I'm not sure to understand what you are doing.  Are you compiling coccinelle from the source code, or are you using one from a distribution.
If you are compiling from source code, what does it say about python when you run ./configure?

I think that you are not the first to have this problem.  Maybe search for python on the gmane archives of the mailing list:

http://blog.gmane.org/gmane.comp.version-control.coccinelle

julia


>
> -----????-----
> ???: npalix.work at gmail.com [mailto:npalix.work at gmail.com] ?? Nicolas 
> Palix
> ????: 2014?2?14? 17:51
> ???: ??(?? ??)
> ??: cocci at systeme.lip6.fr
> ??: Re: [Cocci] Fatal error: exception Failure("no python")
>
> Hi,
>
> On Fri, Feb 14, 2014 at 8:57 AM, ??(?? ??) <linjia@ruijie.com.cn> wrote:
> > Then I found cocc can not work, it reports: Fatal error: exception 
> > Failure("no python")
>
> You get is error when spatch has not been compiled with Python support but you are still using cocci file with Python snippet.
>
> Does ' spatch --version' report python support ?
> Such as
>      spatch version 1.0.0-rc15 with Python support and with PCRE 
> support
>
> Regards,
> --
> Nicolas Palix
> Tel: +33 4 76 51 46 27
> http://lig-membres.imag.fr/palix/
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
