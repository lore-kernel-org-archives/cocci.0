From: julia@ni.com (Julia Cartwright)
Date: Thu, 9 Mar 2017 10:21:47 -0600
Subject: [Cocci] [PATCH 00/19] fixup usage of non-raw spinlocks in irqchips
Message-ID: <cover.1489015238.git.julia@ni.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The following patchset introduces a new coccinelle patch,
irq_chip_raw_spinlock.cocci, which is used to identify irq_chip implementors
which acquire/release non-raw spinlocks, and in addition, a set of generated
patches for most cases identified.

On mainline builds, there exists no functional difference between
raw_spinlock_t and spinlock_t.  However, w/ PREEMPT_RT, the spinlock_t will
cause the calling thread to sleep when the lock is contended.  Because sleeping
is illegal in hardirq context, and because the irqchip callbacks are invoked in
hardirq context, irqchip implementations must not use spin_lock_t for
synchronization.

Patches build tested only.

Some notes:

  - In order to ensure that latency problems are not introduced for realtime
    kernels, the generated patches need to be hand audited to ensure that
    raw-spinlock protected regions are bounded and minimal.  I've done a quick
    audit for each of the modified drivers in this series, but please check my
    work.

  - There are a couple of matches which will require further intervention to
    fully fix.  Namely the Intel LPE Audio driver:

       drivers/gpu/drm/i915/intel_lpe_audio.c:169:30-38: Use of non-raw spinlock is illegal in this context (struct drm_i915_private::irq_lock)

    and the adi2 pinctrl driver:

       drivers/pinctrl/pinctrl-adi2.c:308:26-30: Use of non-raw spinlock is illegal in this context (struct gpio_port::lock)

  - This semantic patch is not comprehensive, there are other equally broken
    usecases which are not properly identified yet, such as the use of a single
    global spinlock_t declared via DEFINE_SPINLOCK() (found in arch/alpha, and
    perhaps elsewhere).

   Julia

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <mmarek@suse.com>
Cc: cocci at systeme.lip6.fr
---------
Julia Cartwright (19):
  Coccinelle: locks: identify callers of spin_lock{,_irq,_irqsave}() in
    irqchip implementations
  gpio: altera: make use of raw_spinlock variants
  alpha: marvel: make use of raw_spinlock variants
  powerpc: mpc52xx_gpt: make use of raw_spinlock variants
  gpio: 104-dio-48e: make use of raw_spinlock variants
  gpio: ath79: make use of raw_spinlock variants
  gpio: bcm-kona: make use of raw_spinlock variants
  gpio: etraxfs: make use of raw_spinlock variants
  gpio: pl061: make use of raw_spinlock variants
  gpio: ws16c48: make use of raw_spinlock variants
  gpio: zx: make use of raw_spinlock variants
  i2c: mux: pca954x: make use of raw_spinlock variants
  mfd: asic3: make use of raw_spinlock variants
  mfd: t7l66xb: make use of raw_spinlock variants
  mfd: tc6393xb: make use of raw_spinlock variants
  pinctrl: bcm: make use of raw_spinlock variants
  pinctrl: amd: make use of raw_spinlock variants
  pinctrl: sirf: atlas7: make use of raw_spinlock variants
  pinctrl: sunxi: make use of raw_spinlock variants

 arch/alpha/include/asm/core_marvel.h               |  2 +-
 arch/alpha/kernel/sys_marvel.c                     | 12 +--
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          | 52 ++++++------
 drivers/gpio/gpio-104-dio-48e.c                    | 38 ++++-----
 drivers/gpio/gpio-altera.c                         | 24 +++---
 drivers/gpio/gpio-ath79.c                          | 28 +++----
 drivers/gpio/gpio-bcm-kona.c                       | 48 +++++------
 drivers/gpio/gpio-etraxfs.c                        | 24 +++---
 drivers/gpio/gpio-pl061.c                          | 28 +++----
 drivers/gpio/gpio-ws16c48.c                        | 46 +++++------
 drivers/gpio/gpio-zx.c                             | 24 +++---
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 12 +--
 drivers/mfd/asic3.c                                | 56 ++++++-------
 drivers/mfd/t7l66xb.c                              | 20 ++---
 drivers/mfd/tc6393xb.c                             | 52 ++++++------
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           | 44 +++++-----
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             | 46 +++++------
 drivers/pinctrl/pinctrl-amd.c                      | 66 +++++++--------
 drivers/pinctrl/pinctrl-amd.h                      |  2 +-
 drivers/pinctrl/sirf/pinctrl-atlas7.c              | 44 +++++-----
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              | 26 +++---
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |  2 +-
 .../coccinelle/locks/irq_chip_raw_spinlock.cocci   | 96 ++++++++++++++++++++++
 23 files changed, 444 insertions(+), 348 deletions(-)
 create mode 100644 scripts/coccinelle/locks/irq_chip_raw_spinlock.cocci

-- 
2.11.1
