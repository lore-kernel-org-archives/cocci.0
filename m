From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Mon, 8 Feb 2016 10:39:43 -0500
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
 paravirt_legacy
In-Reply-To: <20160206220437.GA4435@pd.tnic>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <20160206220437.GA4435@pd.tnic>
Message-ID: <56B8B6BF.6030007@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On 02/06/2016 05:04 PM, Borislav Petkov wrote:
> On Sat, Feb 06, 2016 at 12:05:32PM -0800, Andy Lutomirski wrote:
>> int __init microcode_init(void)
>> {
>>          [...]
>>          if (paravirt_enabled() || dis_ucode_ldr)
>>                  return -EINVAL;
>>
>> This is also asking "are we the natively booted kernel?"  This is
>> plausibly useful for real.  (Borislav, is this actually necessary?)
> There was some breakage on 32-bit pvops with that.
>
>> Seems to me there should be a function is_native_root_kernel() or
>> similar.  Obviously it could have false positives and code will have
>> to deal with that.  (This also could be entirely wrong.  What code is
>> responsible for CPU microcode updates on Xen?  For all I know, dom0 is
>> *supposed* to apply microcode updates, in which case that check really
>> should be deleted.
> So there are two aspects:
>
> - the guest loading the microcode driver. Xen should behave like
> qemu+kvm does: emulate the MSR accesses the microcode loader does.

It does. Very much IIRC, the problem was not caused by an access to MSR 
but rather some sort of address not being available somewhere.

>
> - microcode application on Xen: we've had this before. The hypervisor
> should do that (if it doesn't do so already).

it does.

>
> So yes, that paravirt_enabled() thing should go away. Even more so if we
> have CPUID leaf 0x4... reserved for hypervisors.

I actually think this was the original proposal until we realized we had 
paravirt_enabled(). So we can go back to checking CPUID 0x40000000.

We might also be able to test for (x86_hyper!=NULL) and have guests that 
do microcode management prior to init_hypervisor() rely on hypervisors 
ignoring MSR accesses (as they do today).

-boris
