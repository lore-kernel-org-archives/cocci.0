From: bp@alien8.de (Borislav Petkov)
Date: Sat, 6 Feb 2016 23:04:37 +0100
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
 paravirt_legacy
In-Reply-To: <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
Message-ID: <20160206220437.GA4435@pd.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Feb 06, 2016 at 12:05:32PM -0800, Andy Lutomirski wrote:
> int __init microcode_init(void)
> {
>         [...]
>         if (paravirt_enabled() || dis_ucode_ldr)
>                 return -EINVAL;
> 
> This is also asking "are we the natively booted kernel?"  This is
> plausibly useful for real.  (Borislav, is this actually necessary?)

There was some breakage on 32-bit pvops with that.

> Seems to me there should be a function is_native_root_kernel() or
> similar.  Obviously it could have false positives and code will have
> to deal with that.  (This also could be entirely wrong.  What code is
> responsible for CPU microcode updates on Xen?  For all I know, dom0 is
> *supposed* to apply microcode updates, in which case that check really
> should be deleted.

So there are two aspects:

- the guest loading the microcode driver. Xen should behave like
qemu+kvm does: emulate the MSR accesses the microcode loader does.

- microcode application on Xen: we've had this before. The hypervisor
should do that (if it doesn't do so already).

So yes, that paravirt_enabled() thing should go away. Even more so if we
have CPUID leaf 0x4... reserved for hypervisors.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
