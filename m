From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 10:51:52 +0100
Subject: [Cocci] [PATCH 00/19] fixup usage of non-raw spinlocks in
	irqchips
In-Reply-To: <cover.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
Message-ID: <CACRpkdYner6CzdM_Rmd+z_tr1K-i4Ov0n8BwiyqAJ91F3950tQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Mar 9, 2017 at 5:21 PM, Julia Cartwright <julia@ni.com> wrote:

> The following patchset introduces a new coccinelle patch,
> irq_chip_raw_spinlock.cocci, which is used to identify irq_chip implementors
> which acquire/release non-raw spinlocks, and in addition, a set of generated
> patches for most cases identified.

Wow that is really impressive. I expect to apply all that
are applicable to GPIO drivers. I guess this really lowers
the bar to run realtime on a whole slew of systems.

Yours,
Linus Walleij
