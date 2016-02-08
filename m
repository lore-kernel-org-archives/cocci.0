From: andrew.cooper3@citrix.com (Andrew Cooper)
Date: Mon, 8 Feb 2016 16:05:47 +0000
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <20160208155507.GF28980@pd.tnic>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic>
Message-ID: <56B8BCDB.9040701@citrix.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/02/16 15:55, Borislav Petkov wrote:
> On Mon, Feb 08, 2016 at 10:39:43AM -0500, Boris Ostrovsky wrote:
>> It does. Very much IIRC, the problem was not caused by an access to MSR but
>> rather some sort of address not being available somewhere.
> See below.
>
>>> - microcode application on Xen: we've had this before. The hypervisor
>>> should do that (if it doesn't do so already).
>> it does.
> Good.
>
>>> So yes, that paravirt_enabled() thing should go away. Even more so if we
>>> have CPUID leaf 0x4... reserved for hypervisors.
>> I actually think this was the original proposal until we realized we had
>> paravirt_enabled(). So we can go back to checking CPUID 0x40000000.
>>
>> We might also be able to test for (x86_hyper!=NULL) and have guests that do
>> microcode management prior to init_hypervisor() rely on hypervisors ignoring
>> MSR accesses (as they do today).
> Right, so the early loader can't do that as on 32-bit it runs even
> before paging has been enabled. So I *think* the thing with CPUID would
> be best. What does the xen hypervisor return in regs when I do CPUID(4)?
> I.e., how do I reliably detect it in the guest?
>
> I can whip up a quick patch and get rid of paravirt_enabled() while at
> it...
>

For compatibility with other virtualisation specs, Xen's cpuid leaves
shift depending on configuration.

Spec at
http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/include/public/arch-x86/cpuid.h;h=d709340f18d089560b959835eabb7b6609542c7e;hb=HEAD#l33

Basically, they are either at 0x40000000, or 0x40000100 if viridian or
vmware compatibility has been enabled.

~Andrew
