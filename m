From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Feb 2016 16:46:08 +0100
Subject: [Cocci] [PATCH v2 3/3] paravirt: rename paravirt_enabled to
 paravirt_legacy
In-Reply-To: <56B8B4D8.7050208@oracle.com>
References: <1454733014-15237-1-git-send-email-mcgrof@kernel.org>
 <1454733014-15237-4-git-send-email-mcgrof@kernel.org>
 <CALCETrU3DaqUeo-n2dV_UmeAcTEV2dQRtxyb-atMP6WFDDif3Q@mail.gmail.com>
 <20160206085930.GF25240@wotan.suse.de>
 <CALCETrWSiN+te_0aYH0NH9oBzGALLhKqxkupiGwbAm2GdCNyVQ@mail.gmail.com>
 <56B8B4D8.7050208@oracle.com>
Message-ID: <20160208154608.GE28980@pd.tnic>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Feb 08, 2016 at 10:31:36AM -0500, Boris Ostrovsky wrote:
> This range is reserved for hypervisors but the only hypervisor that uses it
> is Xen PV (lguest doesn't run in 64-bit mode).

Yeah, this is mentioned in arch/x86/include/asm/page_64_types.h:

/*
 * Set __PAGE_OFFSET to the most negative possible address +
 * PGDIR_SIZE*16 (pgd slot 272).  The gap is to allow a space for a
 * hypervisor to fit.  Choosing 16 slots here is arbitrary, but it's
 * what Xen requires.
 */
#define __PAGE_OFFSET           _AC(0xffff880000000000, UL)

It is also in Documentation/x86/x86_64/mm.txt:

ffff800000000000 - ffff87ffffffffff (=43 bits) guard hole, reserved for hypervisor

albeit a bit laconic.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
