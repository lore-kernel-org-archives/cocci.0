From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Feb 2016 16:55:07 +0100
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
 paravirt_legacy
In-Reply-To: <56B8B6BF.6030007@oracle.com>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
Message-ID: <20160208155507.GF28980@pd.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Feb 08, 2016 at 10:39:43AM -0500, Boris Ostrovsky wrote:
> It does. Very much IIRC, the problem was not caused by an access to MSR but
> rather some sort of address not being available somewhere.

See below.

> >- microcode application on Xen: we've had this before. The hypervisor
> >should do that (if it doesn't do so already).
> 
> it does.

Good.

> >So yes, that paravirt_enabled() thing should go away. Even more so if we
> >have CPUID leaf 0x4... reserved for hypervisors.
> 
> I actually think this was the original proposal until we realized we had
> paravirt_enabled(). So we can go back to checking CPUID 0x40000000.
> 
> We might also be able to test for (x86_hyper!=NULL) and have guests that do
> microcode management prior to init_hypervisor() rely on hypervisors ignoring
> MSR accesses (as they do today).

Right, so the early loader can't do that as on 32-bit it runs even
before paging has been enabled. So I *think* the thing with CPUID would
be best. What does the xen hypervisor return in regs when I do CPUID(4)?
I.e., how do I reliably detect it in the guest?

I can whip up a quick patch and get rid of paravirt_enabled() while at
it...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
