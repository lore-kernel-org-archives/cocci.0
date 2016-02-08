From: andrew.cooper3@citrix.com (Andrew Cooper)
Date: Mon, 8 Feb 2016 16:26:36 +0000
Subject: [Cocci] [Xen-devel] [PATCH v2 3/3] paravirt: rename
 paravirt_enabled to paravirt_legacy
In-Reply-To: <56B8BE58.6070003@oracle.com>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic> <56B8B6BF.6030007@oracle.com>
 <20160208155507.GF28980@pd.tnic> <56B8BCDB.9040701@citrix.com>
 <56B8BE58.6070003@oracle.com>
Message-ID: <56B8C1BC.9040603@citrix.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/02/16 16:12, Boris Ostrovsky wrote:
>
>
> On 02/08/2016 11:05 AM, Andrew Cooper wrote:
>>
>> For compatibility with other virtualisation specs, Xen's cpuid leaves
>> shift depending on configuration.
>>
>> Spec at
>> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/include/public/arch-x86/cpuid.h;h=d709340f18d089560b959835eabb7b6609542c7e;hb=HEAD#l33
>>
>>
>> Basically, they are either at 0x40000000, or 0x40000100 if viridian or
>> vmware compatibility has been enabled.
>
> (Also in arch/x86/include/asm/xen/cpuid.h in Linux tree).

The other complication is that, for a PV guest, you must use the forced
emulation prefix for the cpuid instruction to trap into the hypervisor.

This either means you must be sure you are under Xen to start with, or
use an extable entry to catch the #UD fault if you are not under Xen.

~Andrew
