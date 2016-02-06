From: luto@amacapital.net (Andy Lutomirski)
Date: Sat, 6 Feb 2016 12:05:32 -0800
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
	paravirt_legacy
In-Reply-To: <20160206085930.GF25240@wotan.suse.de>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
Message-ID: <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Feb 6, 2016 at 12:59 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Fri, Feb 05, 2016 at 11:11:34PM -0800, Andy Lutomirski wrote:
>> On Feb 5, 2016 8:30 PM, "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
>> >
>> > paravirt_enabled conveys the idea that if this is set or if
>> > paravirt_enabled() returns true you are in a paravirtualized
>> > environment. This is not true by any means, and left as-is
>> > is just causing confusion and is prone to be misused and abused.
>> >
>> > This primitive is really only useful to determine if you have a
>> > paravirtualization hypervisor that supports legacy paravirtualized
>> > guests. At run time, this tells us if we've booted into a Linux guest
>> > with support for legacy devices and features.
>> >
>> > To avoid further issues with semantics on this we loosely borrow
>> > the definition of "legacy" from both the ACPI 5.2.9.3 "IA-PC Boot
>> > Architecture Flags" section and the PC 2001 definition in the PC
>> > Systems design guide [0]:
>> >
>> >   paravirt_legacy() is true if this hypervisor supports legacy
>> >                     x86 paravirtualized guests.
>>
>> This needs to be far more concrete.  I'm reasonably well versed in x86
>> details relevant to kernels ans I have *no clue* what your semantics
>> mean.
>
> Interesting. I'm glad you're chiming in :)
>
>> > +/**
>> > + * struct pv_info - paravirt hypervisor information
>> > + *
>> > + * @supports_x86_legacy: true if this hypervisor supports legacy x86
>> > + *     paravirtualized guests.  The definition of legacy here adheres
>> > + *     *loosely* to both the notion of legacy in the ACPI 5.2.9.3 "IA-PC Boot
>> > + *     Architecture Flags" section and the PC 2001 "legacy free" concept [1]
>> > + *     referred to in the PC System Design Guide [2] [3] on Chapter 3, Page 50
>> > + *     [4].  Legacy x86 guests systems are guest systems which are not "legacy
>> > + *     free" as per the PC 2001 definition, and in the ACPI sense could have
>> > + *     any of the legacy ACPI IA-PC Boot architecture flags set. These are x86
>> > + *     systems with any type of legacy peripherals or requirements.
>> > + *
>> > + *     Examples of some popular legacy peripherals:
>> > + *
>> > + *       a) Floppy drive
>> > + *       b) Legacy ports [1] such as such as parallel ports, PS/2 connectors,
>> > + *          serial ports / RS-232, game ports Parallel ATA, and IEEE 1394
>> > + *       c) ISA bus
>> > + *
>> > + *     Examples of features required to support such type of legacy guests
>> > + *     are the need for APM and a PNP BIOS.
>>
>> Seriously?
>>
>> I think you just defined every standard native x86 system
>> as well as QEMU/KVM as "legacy".
>
> I was a afraid it was too broad, but its why I used "loosely".
>
>> Can we just enumerate this crap?  I propose:
>>
>> Xen PV and lguest are paravirt_legacy.  Nothing else is
>> paravirt_legacy.
>
> Fine by me!
>
>> The addition of new paravirt_legacy support is
>> strongly discouraged.
>
> Fine by me, but Boris is re-using that for HVMLite on his recently
> proposed patches. Do we want that ? I'll also note that the goal
> is to ensure its hardware_subarch will be 0 (PC), meanwhile old
> PV will be Xen (although this hasn't been set yet). This mess is
> part of the reason why I do think stronger semantics and clearer
> definitions will help here. Without strong semantics I can't help
> address the dead code concerns I've been rambling over.
>
> HVMLite is just a rebranding for PVH done right, and then it seems PVH will be
> dropped and we'll have HVMLite rebranded back to PVH I guess it seems.

PVH/HVMlite had better not be "paravirt" in this sense, I hope.

>
> The enumeration of legacy crap by ACPI boot flags seems to provide enough
> details to suit our needs if we really wanted to zero down on the specifics of
> what paravirt_legacy() means, there are these flags:
>
> /* Masks for FADT IA-PC Boot Architecture Flags (boot_flags) [Vx]=Introduced in this FADT revision */
> #define ACPI_FADT_LEGACY_DEVICES    (1)         /* 00: [V2] System has LPC or ISA bus devices */
> #define ACPI_FADT_8042              (1<<1)      /* 01: [V3] System has an 8042 controller on port 60/64 */
> #define ACPI_FADT_NO_VGA            (1<<2)      /* 02: [V4] It is not safe to probe for VGA hardware */
> #define ACPI_FADT_NO_MSI            (1<<3)      /* 03: [V4] Message Signaled Interrupts (MSI) must not be enabled */
> #define ACPI_FADT_NO_ASPM           (1<<4)      /* 04: [V4] PCIe ASPM control must not be enabled */
> #define ACPI_FADT_NO_CMOS_RTC       (1<<5)      /* 05: [V5] No CMOS real-time clock present */
>
> I checked and I didn't see qemu using any of the ACPI boot flags,
> but I suspected qemu instances must use a series of legacy crap.
> Likewise for KVM.

So shouldn't Linux find out things from the FADT by reading the FADT
rather than squishing them into a confusing single function?

Anyway, this is all ridiculous.  I propose that rather than trying to
clean up paravirt_enabled, you just delete it.  Here are its users:

static inline bool is_hypervisor_range(int idx)
{
    /*
     * ffff800000000000 - ffff87ffffffffff is reserved for
     * the hypervisor.
     */
    return paravirt_enabled() &&
        (idx >= pgd_index(__PAGE_OFFSET) - 16) &&
        (idx < pgd_index(__PAGE_OFFSET));
}

Nope, wrong.  I don't really know what this code is trying to do, but
I'm pretty sure it's wrong.  Did this mean to check "is Xen PV"?  Or
was it "is Xen PV or lgeust"?  Or what?

        if (apm_info.bios.version == 0 || paravirt_enabled() ||
machine_is_olpc()) {
                printk(KERN_INFO "apm: BIOS not found.\n");
                return -ENODEV;
        }

I assume that is trying to avoid checking for APM on systems that are
known to be too new.  How about cleanup up the condition to check
something sensible?

        if (!paravirt_enabled() && c->x86 == 5 && c->x86_model < 9) {
                static int f00f_workaround_enabled;
        [...]

This is asking "are we the natively booted kernel?".  This has nothing
to do with paravirt in particular.  How about just deleting that code?
 It seems pointless.  Sure, it's the responsibility of the real root
kernel, but nothing will break if a guest kernel also does the fixup.

int __init microcode_init(void)
{
        [...]
        if (paravirt_enabled() || dis_ucode_ldr)
                return -EINVAL;

This is also asking "are we the natively booted kernel?"  This is
plausibly useful for real.  (Borislav, is this actually necessary?)
Seems to me there should be a function is_native_root_kernel() or
similar.  Obviously it could have false positives and code will have
to deal with that.  (This also could be entirely wrong.  What code is
responsible for CPU microcode updates on Xen?  For all I know, dom0 is
*supposed* to apply microcode updates, in which case that check really
should be deleted.

void __init reserve_ebda_region(void)
{
         [...]
        if (paravirt_enabled())
                return;

I don't know what the point of this one is.

pnpbios turns itself off if paravirt_enabled().  I'm not convinced
that's correct.

        /* only a natively booted kernel should be using TXT */
        if (paravirt_enabled()) {
                pr_warning("non-0 tboot_addr but pv_ops is enabled\n");
                return;
        }

Er, what's wrong with trying to talk to tboot on paravirt?  It won't
be there unless something is rather wrong.  In any case, this could
use is_native_root_kernel().

        if (paravirt_enabled() && !paravirt_has(RTC))
                return -ENODEV;

This actually seems legit.  But how about reversing it: if
paravirt_has(NO_RTC) return -ENODEV?  Problem solved.

paravirt_enabled is also used in entry_32.S:

cmpl    $0, pv_info+PARAVIRT_enabled

This is actually trying to check whether pv_cpu_ops.iret ==
native_iret.  I sincerely hope that no additional support is *ever*
added to x86 Linux for systems on which this is not the case.

So yeah, I think the right solution is to delete paravirt_enabled.

--Andy
