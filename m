Return-Path: <SRS0=b0Di=WJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EBC32750
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2019 12:32:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287512067D
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2019 12:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jD9ZzgIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287512067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7DCWJJC005968;
	Tue, 13 Aug 2019 14:32:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5987B778B;
	Tue, 13 Aug 2019 14:32:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 287D47778
 for <cocci@systeme.lip6.fr>; Tue, 13 Aug 2019 14:20:28 +0200 (CEST)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7DCK5uM000433
 for <cocci@systeme.lip6.fr>; Tue, 13 Aug 2019 14:20:22 +0200 (CEST)
Received: by mail-qk1-f201.google.com with SMTP id g125so8747115qkd.7
 for <cocci@systeme.lip6.fr>; Tue, 13 Aug 2019 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=6PgFwT5ybpsMvR73n2NchUIwCDCLdMXSL/zekwZUPV0=;
 b=jD9ZzgIfaS51gL704kQ5B3pyAxRwAkFR5KAAxqD03+kRrbNxZasQJhXNSpL5IUD3WC
 2DcnSWgyDaPoRPIGpldT8mFFTh+D7IvMFxHm7iTt3sA8pZKFy6cUm7d9XJwv/DbGCbp4
 apBL8JeZNEGLLuEGK/kJMrUVLy5ehYl2bswCIbpRo4AUdG9z8T7qN7EYG2g6iDYunndi
 bgvRTsfFKIeh+lV0TGQh07MMCHE7knk8t4nlw97npIIZj92U8RBDn5AI9/CVxQe6kk0P
 ifVqrzVa67t41udCVDvV3Mua+k4Gh9mqtC5Z6kseL7iHwIkqxHgzBvcScP5+7WLk7K57
 pDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=6PgFwT5ybpsMvR73n2NchUIwCDCLdMXSL/zekwZUPV0=;
 b=fXp/Dqb4+MZpV1cXurprEqI2+GvYj4lQ9vIRroo6edmm5l0JtD53wlmH42LLbzJMtL
 c2zOimZ+Mmlyx+TS7BIOwOBeLXdeLNVNHtepFmYmbO96TFVYZ+82cAV/K7U4uTFCQcku
 18dgytYHTTlReHw5foFMgn8Y5lfGmh3xqafJ5+FR3h/wg4wzU1XftB+GpP3ybpUFGWgq
 s5aoNP7xn4t4k678QzYLLsomsRwwyvn5DJDOxdzNpt3png+PvbJCuP5W7hyLdMWbjSJZ
 FiyVXkGMN2Kd4CghZsqwPAapO8d6nlwQor3Q8ynT33OkkXRUXdvuQMaulFHhZNSv5MjH
 jOUQ==
X-Gm-Message-State: APjAAAVRmbPjOlJ0DtkL8asRSQajoBxNyGLImp6/chlESl/Lm37WK7z6
 mTXc04v2EvE/DhPbA0OyVpdTjuncUzbVGg==
X-Google-Smtp-Source: APXvYqwoPPvVp4wXK2/Ekm9uHbCBVrd0HTIovQY6Rl1JP2NcFK3PdJFfhx8kL4FpENxmnwm0ne/g50Y+okhRyQ==
X-Received: by 2002:a0c:e28e:: with SMTP id r14mr11313674qvl.32.1565698744842; 
 Tue, 13 Aug 2019 05:19:04 -0700 (PDT)
Date: Tue, 13 Aug 2019 13:16:57 +0100
In-Reply-To: <20180716122125.175792-1-maco@android.com>
Message-Id: <20190813121733.52480-1-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
From: Matthias Maennich <maennich@google.com>
To: linux-kernel@vger.kernel.org, maco@android.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Aug 2019 14:32:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 13 Aug 2019 14:20:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 13 Aug 2019 14:32:18 +0200
Cc: kstewart@linuxfoundation.org, linux-m68k@vger.kernel.org, oneukum@suse.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        usb-storage@lists.one-eyed-alien.net,
        David Howells <dhowells@redhat.com>, Will Deacon <will@kernel.org>,
        hpa@zytor.com, joel@joelfernandes.org, sam@ravnborg.org,
        cocci@systeme.lip6.fr, linux-arch@vger.kernel.org,
        linux-scsi@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        x86@kernel.org, lucas.de.marchi@gmail.com, mingo@redhat.com,
        geert@linux-m68k.org, Johannes Weiner <hannes@cmpxchg.org>,
        stern@rowland.harvard.edu, kernel-team@android.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>, sspatil@google.com, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, jeyu@kernel.org, maennich@google.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
        Adrian Reber <adrian@lisas.de>, michal.lkml@markovi.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Richard Guy Briggs <rgb@redhat.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, sboyd@codeaurora.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>, maco@google.com,
        pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>, linux-modules@vger.kernel.org
Subject: [Cocci] [PATCH v2 0/10] Symbol namespaces - RFC
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

As of Linux 5.3-rc4, there are 31203 [1] exported symbols in the kernel.
That is a growth of almost 1000 symbols since 4.17 (30206 [2]).  There
seems to be some consensus amongst kernel devs that the export surface
is too large, and hard to reason about.

Generally, these symbols fall in one of these categories:
1) Symbols actually meant for drivers
2) Symbols that are only exported because functionality is split over
   multiple modules, yet they really shouldn't be used by modules outside
   of their own subsystem
3) Symbols really only meant for in-tree use

When module developers try to upstream their code, it regularly turns
out that they are using exported symbols that they really shouldn't be
using. This problem is even bigger for drivers that are currently
out-of-tree, which may be using many symbols that they shouldn't be
using, and that break when those symbols are removed or modified.

This patch allows subsystem maintainers to partition their exported
symbols into separate namespaces, and module authors to import such
namespaces only when needed.

This allows subsystem maintainers to more easily limit availability of
these namespaced symbols to other parts of the kernel. It can also be
used to partition the set of exported symbols for documentation
purposes; for example, a set of symbols that is really only used for
debugging could be in a "SUBSYSTEM_DEBUG" namespace.

I continued the work mainly done by Martijn Coenen. In this v2 the
following changes have been introduced compared to v1 of this series:

- Rather than adding and evaluating separate sections __knsimport_NS,
  use modinfo tags to declare the namespaces a module introduces.
  Adjust modpost and the module loader accordingly.
- Also add support for reading multiple modinfo values for the same tag
  to allow list-like access to modinfo tags.
- The macros in export.h have been cleaned up to avoid redundancy in the
  macro parameters (ns, nspost, nspost2).
- The introduction of relative references in the ksymtab entries caused
  a rework of the macros to accommodate that configuration as well.
- Alignment of kernel_symbol in the ksymtab needed to be fixed to allow
  growing the kernel_symbol struct.
- Modpost does now also append the namespace suffix to the symbol
  entries in Module.symvers.
- The configuration option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS allows
  relaxing the enforcement of properly declared namespace imports at module
  loading time.
- Symbols can be collectively exported into a namespace by defining
  DEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile.
- The requirement for a very recent coccinelle spatch has been lifted by
  simplifying the script.
- nsdeps does now ensures MODULE_IMPORT_NS statements are sorted when
  patching the module source files.
- Some minor bugs have been addressed in nsdeps to allow it to work with
  modules that have more than one source file.
- The RFC for the usb-storage symbols has been simplified by using
  DEFAULT_SYMBOL_NAMESPACE=USB_STORAGE rather than explicitly exporting each
  and every symbol into that new namespace.

This patch series was developed against v5.3-rc4.

[1] git grep "^EXPORT_SYMBOL\w*(" v5.3-rc4 | wc -l
[2] git grep "^EXPORT_SYMBOL\w*(" v4.17    | wc -l

Matthias Maennich (10):
  module: support reading multiple values per modinfo tag
  export: explicitly align struct kernel_symbol
  module: add support for symbol namespaces.
  modpost: add support for symbol namespaces
  module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
  export: allow definition default namespaces in Makefiles or sources
  modpost: add support for generating namespace dependencies
  scripts: Coccinelle script for namespace dependencies.
  usb-storage: remove single-use define for debugging
  RFC: usb-storage: export symbols in USB_STORAGE namespace

 MAINTAINERS                                 |   5 +
 Makefile                                    |  12 ++
 arch/m68k/include/asm/export.h              |   1 -
 drivers/usb/storage/Makefile                |   2 +
 drivers/usb/storage/alauda.c                |   1 +
 drivers/usb/storage/cypress_atacb.c         |   1 +
 drivers/usb/storage/datafab.c               |   1 +
 drivers/usb/storage/debug.h                 |   2 -
 drivers/usb/storage/ene_ub6250.c            |   1 +
 drivers/usb/storage/freecom.c               |   1 +
 drivers/usb/storage/isd200.c                |   1 +
 drivers/usb/storage/jumpshot.c              |   1 +
 drivers/usb/storage/karma.c                 |   1 +
 drivers/usb/storage/onetouch.c              |   1 +
 drivers/usb/storage/realtek_cr.c            |   1 +
 drivers/usb/storage/scsiglue.c              |   2 +-
 drivers/usb/storage/sddr09.c                |   1 +
 drivers/usb/storage/sddr55.c                |   1 +
 drivers/usb/storage/shuttle_usbat.c         |   1 +
 drivers/usb/storage/uas.c                   |   1 +
 include/asm-generic/export.h                |  14 +-
 include/linux/export.h                      |  92 +++++++++++--
 include/linux/module.h                      |   2 +
 init/Kconfig                                |  14 ++
 kernel/module.c                             |  67 ++++++++-
 scripts/Makefile.modpost                    |   4 +-
 scripts/coccinelle/misc/add_namespace.cocci |  23 ++++
 scripts/mod/modpost.c                       | 144 ++++++++++++++++++--
 scripts/mod/modpost.h                       |   9 ++
 scripts/nsdeps                              |  54 ++++++++
 30 files changed, 421 insertions(+), 40 deletions(-)
 create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
 create mode 100644 scripts/nsdeps

-- 
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
