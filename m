From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 3 Jun 2015 16:50:38 -0700
Subject: [Cocci] [PATCH v4 0/6] x86: document and address MTRR corner
	cases
In-Reply-To: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CAB=NE6VFvUj0Wg3dN8JogmfULxMejcymMJz9otUZ5xv=nwEEww@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Apr 29, 2015 at 2:44 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This series addresses one commend fix on the table for mtrr_add()
> effect on the PAT case when UC- is used. Other than that it is
> the same as v4.
>
> Luis R. Rodriguez (6):
>   x86: add ioremap_uc() - force strong UC, PCD=1, PWT=1
>   x86: document WC MTRR effects on PAT / non-PAT pages
>   video: fbdev: atyfb: move framebuffer length fudging to helper
>   video: fbdev: atyfb: clarify ioremap() base and length used
>   video: fbdev: atyfb: replace MTRR UC hole with strong UC
>   video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()

Ville,

the x86 patches are in and on their way to the next version of Linux.
Can I trouble you for your review of the atyfb driver changes?

 Luis
