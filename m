From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Mon, 8 Feb 2016 10:31:36 -0500
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
 paravirt_legacy
In-Reply-To: <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
Message-ID: <56B8B4D8.7050208@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On 02/06/2016 03:05 PM, Andy Lutomirski wrote:
>
> Anyway, this is all ridiculous.  I propose that rather than trying to
> clean up paravirt_enabled, you just delete it.  Here are its users:
>
> static inline bool is_hypervisor_range(int idx)
> {
>      /*
>       * ffff800000000000 - ffff87ffffffffff is reserved for
>       * the hypervisor.
>       */
>      return paravirt_enabled() &&
>          (idx >= pgd_index(__PAGE_OFFSET) - 16) &&
>          (idx < pgd_index(__PAGE_OFFSET));
> }
>
> Nope, wrong.  I don't really know what this code is trying to do, but
> I'm pretty sure it's wrong.  Did this mean to check "is Xen PV"?  Or
> was it "is Xen PV or lgeust"?  Or what?

This range is reserved for hypervisors but the only hypervisor that uses 
it is Xen PV (lguest doesn't run in 64-bit mode).

The check is intended to catch mappings on baremetal kernels that 
shouldn't be there. In other words it's not Xen PV that needs it, it's 
baremetal that wants to catch errors.


>
>          if (apm_info.bios.version == 0 || paravirt_enabled() ||
> machine_is_olpc()) {
>                  printk(KERN_INFO "apm: BIOS not found.\n");
>                  return -ENODEV;
>          }
>
> I assume that is trying to avoid checking for APM on systems that are
> known to be too new.  How about cleanup up the condition to check
> something sensible?

The check here I suspect is unnecessary since version is taken from 
boot_params and thus should be zero for Xen PV (don't know about lguest 
but if it's not then we could just set it there).

>
>          if (!paravirt_enabled() && c->x86 == 5 && c->x86_model < 9) {
>                  static int f00f_workaround_enabled;
>          [...]
>
> This is asking "are we the natively booted kernel?".  This has nothing
> to do with paravirt in particular.  How about just deleting that code?
>   It seems pointless.  Sure, it's the responsibility of the real root
> kernel, but nothing will break if a guest kernel also does the fixup.

Yes, I also think so.

>
> int __init microcode_init(void)
> {
>          [...]
>          if (paravirt_enabled() || dis_ucode_ldr)
>                  return -EINVAL;
>
> This is also asking "are we the natively booted kernel?"  This is
> plausibly useful for real.  (Borislav, is this actually necessary?)
> Seems to me there should be a function is_native_root_kernel() or
> similar.  Obviously it could have false positives and code will have
> to deal with that.  (This also could be entirely wrong.  What code is
> responsible for CPU microcode updates on Xen?  For all I know, dom0 is
> *supposed* to apply microcode updates, in which case that check really
> should be deleted.
>
> void __init reserve_ebda_region(void)
> {
>           [...]
>          if (paravirt_enabled())
>                  return;
>
> I don't know what the point of this one is.

Not sure about this one neither.

>
> pnpbios turns itself off if paravirt_enabled().  I'm not convinced
> that's correct.
>
>          /* only a natively booted kernel should be using TXT */
>          if (paravirt_enabled()) {
>                  pr_warning("non-0 tboot_addr but pv_ops is enabled\n");
>                  return;
>          }
>
> Er, what's wrong with trying to talk to tboot on paravirt?  It won't
> be there unless something is rather wrong.  In any case, this could
> use is_native_root_kernel().

As in apm_info case, I don't think this check is necessary.

>
>          if (paravirt_enabled() && !paravirt_has(RTC))
>                  return -ENODEV;
>
> This actually seems legit.  But how about reversing it: if
> paravirt_has(NO_RTC) return -ENODEV?  Problem solved.
>
> paravirt_enabled is also used in entry_32.S:
>
> cmpl    $0, pv_info+PARAVIRT_enabled
>
> This is actually trying to check whether pv_cpu_ops.iret ==
> native_iret.  I sincerely hope that no additional support is *ever*
> added to x86 Linux for systems on which this is not the case.

I think we can use ALTERNATIVE(... X86_FEATURE_XENPV) here.

-boris

>
> So yeah, I think the right solution is to delete paravirt_enabled.
>
> --Andy
