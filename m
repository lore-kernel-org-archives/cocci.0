From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 29 Apr 2015 14:11:03 -0700
Subject: [Cocci] [PATCH v3 0/4] pci: add and use pci_iomap_wc()
In-Reply-To: <1429647702-17315-1-git-send-email-mcgrof@do-not-panic.com>
References: <1429647702-17315-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CAB=NE6WYA8GVV1S9ZUhSRAJcpABd4OcCO_a0xWgw2oyKGJ4evQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Apr 21, 2015 at 1:21 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This series adds pci_iomap_wc() variants and makes use of them
> to framebuffer device drivers.
>
> Luis R. Rodriguez (4):
>   pci: add pci_iomap_wc() variants
>   video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
>   video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
>   video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()

Bjorn,

I'll repost this series with a the addition of one extra patch that
adds a respective devres helper pcim_iomap_wc().

 Luis
