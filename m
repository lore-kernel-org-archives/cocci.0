From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Sat, 6 Feb 2016 09:59:30 +0100
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
 paravirt_legacy
In-Reply-To: <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
Message-ID: <20160206085930.GF25240@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Feb 05, 2016 at 11:11:34PM -0800, Andy Lutomirski wrote:
> On Feb 5, 2016 8:30 PM, "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> >
> > paravirt_enabled conveys the idea that if this is set or if
> > paravirt_enabled() returns true you are in a paravirtualized
> > environment. This is not true by any means, and left as-is
> > is just causing confusion and is prone to be misused and abused.
> >
> > This primitive is really only useful to determine if you have a
> > paravirtualization hypervisor that supports legacy paravirtualized
> > guests. At run time, this tells us if we've booted into a Linux guest
> > with support for legacy devices and features.
> >
> > To avoid further issues with semantics on this we loosely borrow
> > the definition of "legacy" from both the ACPI 5.2.9.3 "IA-PC Boot
> > Architecture Flags" section and the PC 2001 definition in the PC
> > Systems design guide [0]:
> >
> >   paravirt_legacy() is true if this hypervisor supports legacy
> >                     x86 paravirtualized guests.
> 
> This needs to be far more concrete.  I'm reasonably well versed in x86
> details relevant to kernels ans I have *no clue* what your semantics
> mean.

Interesting. I'm glad you're chiming in :)

> > +/**
> > + * struct pv_info - paravirt hypervisor information
> > + *
> > + * @supports_x86_legacy: true if this hypervisor supports legacy x86
> > + *     paravirtualized guests.  The definition of legacy here adheres
> > + *     *loosely* to both the notion of legacy in the ACPI 5.2.9.3 "IA-PC Boot
> > + *     Architecture Flags" section and the PC 2001 "legacy free" concept [1]
> > + *     referred to in the PC System Design Guide [2] [3] on Chapter 3, Page 50
> > + *     [4].  Legacy x86 guests systems are guest systems which are not "legacy
> > + *     free" as per the PC 2001 definition, and in the ACPI sense could have
> > + *     any of the legacy ACPI IA-PC Boot architecture flags set. These are x86
> > + *     systems with any type of legacy peripherals or requirements.
> > + *
> > + *     Examples of some popular legacy peripherals:
> > + *
> > + *       a) Floppy drive
> > + *       b) Legacy ports [1] such as such as parallel ports, PS/2 connectors,
> > + *          serial ports / RS-232, game ports Parallel ATA, and IEEE 1394
> > + *       c) ISA bus
> > + *
> > + *     Examples of features required to support such type of legacy guests
> > + *     are the need for APM and a PNP BIOS.
> 
> Seriously?
>
> I think you just defined every standard native x86 system
> as well as QEMU/KVM as "legacy".

I was a afraid it was too broad, but its why I used "loosely".

> Can we just enumerate this crap?  I propose:
> 
> Xen PV and lguest are paravirt_legacy.  Nothing else is
> paravirt_legacy.

Fine by me!

> The addition of new paravirt_legacy support is
> strongly discouraged.

Fine by me, but Boris is re-using that for HVMLite on his recently
proposed patches. Do we want that ? I'll also note that the goal
is to ensure its hardware_subarch will be 0 (PC), meanwhile old
PV will be Xen (although this hasn't been set yet). This mess is
part of the reason why I do think stronger semantics and clearer
definitions will help here. Without strong semantics I can't help
address the dead code concerns I've been rambling over.

HVMLite is just a rebranding for PVH done right, and then it seems PVH will be
dropped and we'll have HVMLite rebranded back to PVH I guess it seems.

The enumeration of legacy crap by ACPI boot flags seems to provide enough
details to suit our needs if we really wanted to zero down on the specifics of
what paravirt_legacy() means, there are these flags:

/* Masks for FADT IA-PC Boot Architecture Flags (boot_flags) [Vx]=Introduced in this FADT revision */
#define ACPI_FADT_LEGACY_DEVICES    (1)         /* 00: [V2] System has LPC or ISA bus devices */
#define ACPI_FADT_8042              (1<<1)      /* 01: [V3] System has an 8042 controller on port 60/64 */
#define ACPI_FADT_NO_VGA            (1<<2)      /* 02: [V4] It is not safe to probe for VGA hardware */
#define ACPI_FADT_NO_MSI            (1<<3)      /* 03: [V4] Message Signaled Interrupts (MSI) must not be enabled */
#define ACPI_FADT_NO_ASPM           (1<<4)      /* 04: [V4] PCIe ASPM control must not be enabled */
#define ACPI_FADT_NO_CMOS_RTC       (1<<5)      /* 05: [V5] No CMOS real-time clock present */

I checked and I didn't see qemu using any of the ACPI boot flags,
but I suspected qemu instances must use a series of legacy crap.
Likewise for KVM.

coreboot defines legacy free when you don't have any of the above flags set:
#define ACPI_FADT_LEGACY_FREE   0x00    /* No legacy devices (including 8042) *

Would it be sufficient to just stick to "pv legacy" equivalent
of requiring just ACPI_FADT_LEGACY_DEVICES and ACPI_FADT_8042 ?

I should point out It turns out ACPI_FADT_NO_CMOS_RTC matches lguest's and it
seems that's the only reason we have that RTC PV flag and the features pv
field... with the linker table + x86 subarch use it should be relatively simple
to remove paravirt_has_feature() paravirt_has() and PV_SUPPORTED_RTC. lguest
would just be the only subarch that opts out.

  Luis
