From: joe.hershberger@gmail.com (Joe Hershberger)
Date: Tue, 9 Aug 2016 10:22:58 -0500
Subject: [Cocci] Bad formatting when changing function prototypes
In-Reply-To: <ow4a8gmkqyd.fsf@mbp-thierry.rsr.lip6.fr>
References: <CANr=Z=bpk1DKiXODccy8Ru0QkP8EX0_v6BfVA2PvsOZ9gpiVXw@mail.gmail.com>
 <alpine.DEB.2.10.1608052249480.3315@hadrien>
 <CANr=Z=Zeg_fO7m9uDzK1HgV3i0QuQNt5dppr+mggRZ1sjXE8Bw@mail.gmail.com>
 <alpine.DEB.2.10.1608061236490.3433@hadrien>
 <CANr=Z=beMS-iN57j9z=kFvfTWV6fmwvddeSLfhppAfKAWPxd3A@mail.gmail.com>
 <ow4a8gmkqyd.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <CANr=Z=Z-Zm=mAayyzbBbb8q2_+n9t4=0-RocgOUcpkFir202pQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Aug 9, 2016 at 8:32 AM, Thierry Martinez
<Thierry.Martinez@inria.fr> wrote:
> Joe Hershberger:
>> Building worked fine, but the autotools errantly decided to built for
>> PCRE support even though I didn't have it installed. I think that's
>> new broken behavior since the 1.0.5 release
>
> This should be fixed by the commit 99f1de0 on GitHub.

Thanks!

-Joe
