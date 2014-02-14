From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Fri, 14 Feb 2014 10:51:29 +0100
Subject: [Cocci] Fatal error: exception Failure("no python")
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727FE284@fzex.ruijie.com.cn>
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
Message-ID: <CAAxaTiN=n76TLavcDEj3NBBL5=DdUKWc0b6AeOs_5FTzBhxNDg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Fri, Feb 14, 2014 at 8:57 AM, ??(?? ??) <linjia@ruijie.com.cn> wrote:
> Then I found cocc can not work, it reports: Fatal error: exception Failure("no python")

You get is error when spatch has not been compiled with Python support
but you are still using cocci file with Python snippet.

Does ' spatch --version' report python support ?
Such as
     spatch version 1.0.0-rc15 with Python support and with PCRE support

Regards,
-- 
Nicolas Palix
Tel: +33 4 76 51 46 27
http://lig-membres.imag.fr/palix/
