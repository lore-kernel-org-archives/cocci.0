From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 5 Feb 2016 23:11:34 -0800
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
	paravirt_legacy
In-Reply-To: <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
Message-ID: <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Feb 5, 2016 8:30 PM, "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
>
> paravirt_enabled conveys the idea that if this is set or if
> paravirt_enabled() returns true you are in a paravirtualized
> environment. This is not true by any means, and left as-is
> is just causing confusion and is prone to be misused and abused.
>
> This primitive is really only useful to determine if you have a
> paravirtualization hypervisor that supports legacy paravirtualized
> guests. At run time, this tells us if we've booted into a Linux guest
> with support for legacy devices and features.
>
> To avoid further issues with semantics on this we loosely borrow
> the definition of "legacy" from both the ACPI 5.2.9.3 "IA-PC Boot
> Architecture Flags" section and the PC 2001 definition in the PC
> Systems design guide [0]:
>
>   paravirt_legacy() is true if this hypervisor supports legacy
>                     x86 paravirtualized guests.

This needs to be far more concrete.  I'm reasonably well versed in x86
details relevant to kernels ans I have *no clue* what your semantics
mean.

> +/**
> + * struct pv_info - paravirt hypervisor information
> + *
> + * @supports_x86_legacy: true if this hypervisor supports legacy x86
> + *     paravirtualized guests.  The definition of legacy here adheres
> + *     *loosely* to both the notion of legacy in the ACPI 5.2.9.3 "IA-PC Boot
> + *     Architecture Flags" section and the PC 2001 "legacy free" concept [1]
> + *     referred to in the PC System Design Guide [2] [3] on Chapter 3, Page 50
> + *     [4].  Legacy x86 guests systems are guest systems which are not "legacy
> + *     free" as per the PC 2001 definition, and in the ACPI sense could have
> + *     any of the legacy ACPI IA-PC Boot architecture flags set. These are x86
> + *     systems with any type of legacy peripherals or requirements.
> + *
> + *     Examples of some popular legacy peripherals:
> + *
> + *       a) Floppy drive
> + *       b) Legacy ports [1] such as such as parallel ports, PS/2 connectors,
> + *          serial ports / RS-232, game ports Parallel ATA, and IEEE 1394
> + *       c) ISA bus
> + *
> + *     Examples of features required to support such type of legacy guests
> + *     are the need for APM and a PNP BIOS.

Seriously?  I think you just defined every standard native x86 system
as well as QEMU/KVM as "legacy".

Can we just enumerate this crap?  I propose:

Xen PV and lguest are paravirt_legacy.  Nothing else is
paravirt_legacy.  The addition of new paravirt_legacy support is
strongly discouraged.

--Andy
