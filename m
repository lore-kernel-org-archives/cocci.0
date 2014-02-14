From: linjia@ruijie.com.cn (=?utf-8?B?5p6X5ZiJKOeoi+S6jCDnpo/lt54p?=)
Date: Fri, 14 Feb 2014 12:43:44 +0000
Subject: [Cocci] =?utf-8?b?562U5aSNOiAgRmF0YWwgZXJyb3I6IGV4Y2VwdGlvbiBG?=
 =?utf-8?q?ailure=28=22no_python=22=29?=
In-Reply-To: <CAAxaTiN=n76TLavcDEj3NBBL5=DdUKWc0b6AeOs_5FTzBhxNDg@mail.gmail.com>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210730200.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8ACB@fzex.ruijie.com.cn>
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
 <CAAxaTiN=n76TLavcDEj3NBBL5=DdUKWc0b6AeOs_5FTzBhxNDg@mail.gmail.com>
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727FE31D@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

# spatch --version
spatch version 1.0.0-rc19 without Python support and with Str regexp support

but I didn't make and make install with option '--without-python '
that is I pressed  ./configure --enable-release, just it


and now when I run "/usr/bin/spatch -sp_file ....", all is ok, it seems version 0.2.3 runs
but "spatch -sp_file " reports fail, seems version 1.0 runs?

-----????-----
???: npalix.work at gmail.com [mailto:npalix.work at gmail.com] ?? Nicolas Palix
????: 2014?2?14? 17:51
???: ??(?? ??)
??: cocci at systeme.lip6.fr
??: Re: [Cocci] Fatal error: exception Failure("no python")

Hi,

On Fri, Feb 14, 2014 at 8:57 AM, ??(?? ??) <linjia@ruijie.com.cn> wrote:
> Then I found cocc can not work, it reports: Fatal error: exception 
> Failure("no python")

You get is error when spatch has not been compiled with Python support but you are still using cocci file with Python snippet.

Does ' spatch --version' report python support ?
Such as
     spatch version 1.0.0-rc15 with Python support and with PCRE support

Regards,
--
Nicolas Palix
Tel: +33 4 76 51 46 27
http://lig-membres.imag.fr/palix/
