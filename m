Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2BCC4332F
	for <cocci@archiver.kernel.org>; Mon, 16 May 2022 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZBCHbbVfn2W7GCIwQZshDqoULkmiIrMZcuv1e33Ldn0=;
  b=AOk1k0dPTc5JtwQ3GLh7qwuKxHcci1WHjM90EhRIXTFIoH+0caEPJhxq
   8KCPeWlgUbPUaFb7j5opFUPt3Auincu+UhGzr2MD9sgzoLQgbIHYSXPji
   h0rhp3jS27n3fasq81XgO8Vv2L6G4V30TapduYZIEKj7PtV7JcMlP8cMW
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,230,1647298800"; 
   d="scan'208";a="36570656"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2022 22:18:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57C0BE4377; Mon, 16 May 2022 22:18:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7A991E0099
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 17:47:59 +0200 (CEST)
IronPort-SDR: IYjELWQ5+W91T7NaFweXAzCOB7h81S2oI0ciQ01HGMVbqomUJ210ANVX89L3MC+nHrgnDpeUWX
 jeXtKym4/tAO5gfu8FRm8L3cJsK38qzXsIUWQtfrMQNzFze1zY5pLV5y6f6FnMU2hDnqRhe0ck
 UT7LqCyIrHKyX5YIyvFlAxtwP9Y/GHEABItY0K6B9Dsl5UnWSQr+Mhlu9tZTzTryev8iXHZA/e
 WuQRYbenkIvK9XIKcivznC0fGu4k0jJ3xFD5Q2C6BvTn/Zs1jIPKub/GzwMMfy3camcEqHSqHQ
 LXy/fKJ3XNmO+8r/miQsLfMM
X-IPAS-Result: =?us-ascii?q?A0B7AwAAiHpif7OgVdFagliCJH5VLQROlVmcZhSBaAsBA?=
 =?us-ascii?q?wEMATMNAgQBATwBBoQ/AoU+Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhAwFEgU+BdAsDMQ2CNSkBg2QCA?=
 =?us-ascii?q?QMSIAENARsdAQMMBhADOCECEQEFARwGARIiglsBgmIBAzGgNIEEQYxHBReBA?=
 =?us-ascii?q?YIJBoRLChkoDWcDgVkCBwkBCIEqhhUBgy2DN2l6JxCBVUSBFYE8hEyBZ1KGJ?=
 =?us-ascii?q?gSOUS2FPYFLBAUkAwMCEBQDCQQCBwYaDgMHAgEXAQIIAgELFgEBGAUJAwQFB?=
 =?us-ascii?q?w0DAUADBgMDHg8IBRICAzQCAgEBCwIGBgQGAwEBBgMJAgQCEgICBAcYChIIF?=
 =?us-ascii?q?AMCBgIgBQEHBQEEAxIGDBEBCgYGAQQCCgECAgUFDAMBEQEEAgYCBAQEGRQEA?=
 =?us-ascii?q?gQEBQYCCQgHBRYLBAoCEAYBCxICAQYMCAICAgICBAYPBwENBQICBAEOAgcGA?=
 =?us-ascii?q?wsCAwQBBwMEBAQHDAYMDgEDAQcBBAUDDQQBAQYCCwMFCgIBAgMMAQEHBAgBA?=
 =?us-ascii?q?QICCgIBBAIHAQIFAwIDCAMCAwMCAgEBBBECAwQDBAIDAQYBAQUDAgUBAwMCA?=
 =?us-ascii?q?QMDAwIBBAMGCQoECAEEBAEBARECBwcCBgMDAgICAgUBAg0BAgECBAMIBgIDF?=
 =?us-ascii?q?QECBAEKAQUCAwoCBwMBAQIHBQoCBwUCBwICAwIBBQMNAQMFAgMBAQMDAgQBA?=
 =?us-ascii?q?gEDAwkBAwIDAwICAgIFAgMCAgIJAwQBBwMCAQEEBQEEAwECCgQEAwQCBAIHA?=
 =?us-ascii?q?gcCBAcCAQQGAwcGBAIBBwEBBAoEAwMDAQEHAQIFAgIDAgYSBgcCBAEDBAQKA?=
 =?us-ascii?q?gIMAgcBAQIBAQEBAgIBAgcFDgEBAQMCAwYCBQICAQEDCAgDAgEEAQUDAQQFA?=
 =?us-ascii?q?wcCAQUJAgkDAwkDAQEFAQMBCQMDAwIJAwECAgILBAMIAwMCAwQCAgICAQMCB?=
 =?us-ascii?q?wUIBAEECgICAgECAgYCAQMaAQIDBQICCQwBBAICAwEDAQECCAQJBAIDBAIBA?=
 =?us-ascii?q?QMCAQICAQUCAw0GAQEBAQIDAwECAwEBBgMEAggCFxwWAQMDAgECAgICBQICA?=
 =?us-ascii?q?QIDAgINAQEBBAIBAgECBgEDAQICAwEDAQICBgILAQMJAgEHAQUDAwICAwEBB?=
 =?us-ascii?q?RACBAIBBAIBAgQFBQIBAQEEAQMEBAgCAgEDAwIOAgQBBAECAQEjAwQCAwICA?=
 =?us-ascii?q?xcBAgECAwMDBAYHBgIBAhMBAgEBAQUBAgEBBAIEBAcKAwICAgYDAwUBAQIDA?=
 =?us-ascii?q?gEBAQcMAgICEwIECgkDAQYBCgYGFQMCBAICAQICAgoDAQICAQMCCQIBAgEFJ?=
 =?us-ascii?q?QMBAQ8kAQECAgECAgMEBwIBBAcDDQMCAQEBBQYKAwMCAwgMAg4DAgEDAwUDA?=
 =?us-ascii?q?gIEAQIEDAoBAgMBAgIEBQUDAwUGBiEHF1ADmDR7EwEqgQaXFY0VnTo3NAeDT?=
 =?us-ascii?q?IE7BgyJS45vhWEaMYVEkQYMkX2HOo8oII0Fg1iVewIKBwYQIxKBLIIVMxojg?=
 =?us-ascii?q?QGCNwlFAQIBAQENAQIBAQMBAgECCQEBApIPgT6IYwFcITQCOQIGCwEBAwmFR?=
 =?us-ascii?q?CYTi3IBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:IxNGraMbNx25xLfvrR1ukcFynXyQoLVcMsEvi/4bfWQNrUol0zFTz
 DQbDG6OPa6DYWbzeNlxYd+29U9SuZHTzIIwS3M5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EsLd9IR2NYy24DkWlvV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Iuv9uk
 9ljvqCdUBoSMajrqu4TSBxhRnQW0a1uoNcrIFC6uM2XilTaKj7imqo/Sk4xOoIc96B8BmQmG
 f4wcmhcKEDewbvomPTiFbgEascLdKEHOKsOp2txizfeF/E4aZ/GSqTOo9Rf2V/cg+gXRqmHP
 ZJGN1KDajz4fA91IRQoGagms86Nvkb5KwUAoUC88P9fD2/7lVQtitABKuH9ftWVTMFRtlSZo
 2jc9iL4BAsbPZqR01Kt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgfVF/+uOXgz0DnBIMZJ
 EsT9S4j66M18SRHU+URQTW5hVGb5RIyUOZ9CvAB5wSq+KDa+AOgUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYSLNnltzhWPiURX5PVPudgdfElRYu4iLTJUby0OQHow6QcZZm/WsQWmoq
 w1muhTSkFn6sCLm/6Cy/FSCmi7145aQEV9z6QLQUWaoqAh+YeZJhrBEC3CLsZ6sz67DFDFtW
 UTofeDAtIji6rnTzESwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbJteIGWwP
 R+O4l8PjHO2AJdMRf8nC25WI5R6pZUM6fy4PhwpRoETPcAuLFHvEN9GPBTOhDqFfLcQfVEXY
 M/HK65A/F4VDqNoyDfeegvu+e5D+8zK/kuKHcqT503/j9K2PSfJIZ9YbgbmRr1mtMus/VSNm
 /4CZpDi40gOAIXWPHOLmaZNdgtiBSZgVfjLRzl/LLHrzvxOQzF/VZc8ANoJJ+RYokiivr2Wo
 SvhChQImDISRxTvcG23V5yqU5u3Nb4XkJ7xFXVE0Y+A1ydxbICxwr0YcpdrL7Ar+PYyn/FxR
 vgBPc6HB60XGDjA/j0ca7j7rZBjJEz731LQY3L9bWhtZYNkSizI5sTgIVni+SwIOSy96pkzr
 rim4QXETMdRXA9lFsvXNKmiwgrp73gQke5/RWXSJdxXdBm++YRmMX2jgfo+IsVKIhLGn2PI2
 wGTCBYehO/Mv45lqImT1f7Y99+kSrIsEFBbEm/X6aeNGRPbpmfzk5VdVOuofCzGUDym9ainY
 9JTxa6uPfACmmFMrNMgQbtmyKQJ5+zvqaVf+QJqESiZdF+sEL5hfiCL0MQT5K1AwrhV5Vm/V
 k6VoIUIPLyIPIb8DAdUKlN6P6KM0vYbnjSU5vMweR2o6Chy9buBcENTIxjc13AHfeUtaNsok
 bU7pcobyw2jkR52YNyIuSZZqjaXJXsaXqR765wXXN3xhgwwxg0QaJDQEHWqspSGatEJK1VzZ
 zHN2/uEiLNbyU7PNXE0ECGVj+ZagJ0PvjFMzUMDdwvVwIub3qdv0U0D6ykzQyRU0g5Dj7B5N
 F9tOhAnPq6J5Tpp2JVOUm3E99ut3/FFFpEdCmfllVE1i2GtX23JaXQhYKODpR9ItW1beTdf8
 feTz2ONvfMGui3u9nNaZKKng6WLoR9NGsnql8WuHsDDFJ4/CdYgqrH7fnIG8nMLHuto7HAqZ
 oBWECJYZqjyNCpWqKo+Y2VfOXL8VzjcTFF/rTpdEG/l0I0SlPxeGdRDFqxpRv5wGg==
IronPort-HdrOrdr: A9a23:Gyu7EqB1OValyJflHemB55DYdb4zR+YMi2TDGXoBLCC9Ffbo6v
 xG+c5w6faaskd3ZJhNo6HiBEDEewKlyXcX2/hqAV7dZniBhILAFugLhuvfKn/balbDH4ZmtJ
 uIGJIObOEYY2IK7/oSIzPVLz/j+rS6GWyT6ts2t00dND2CopsP0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="13712076"
X-MGA-submission: =?us-ascii?q?MDEY9maR9SunccF7BUyFWUcIys8YOTYvWVS/X3?=
 =?us-ascii?q?7sEKh/hqCijDZpBS1FdiVMIvl5J/sTEY0M7GEQhdYAVzeD1Csv5VXWLT?=
 =?us-ascii?q?YLKHBuDPYFWZQee6GMV27DssSUtUTcVq8trmWbLowwBO3DpiXqopO/Ji?=
 =?us-ascii?q?nnX+pMgtwbZwiedAZaB5CzSw=3D=3D?=
Received: from mail-qt1-f179.google.com ([209.85.160.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:47:58 +0200
Received: by mail-qt1-f179.google.com with SMTP id o11so13801513qtp.13;
        Tue, 10 May 2022 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBCHbbVfn2W7GCIwQZshDqoULkmiIrMZcuv1e33Ldn0=;
        b=dQ1GWa7V+6A4Ba0P/Loz6vdV8JkdlmKJOFYNtQyPpOLMo+TUFCoGk3C/oxbyjIEUR9
         qF8YHJmazC8RFIO7AvVXR3xUfjNQprYyQiXRQ7saJ8W/DkT0ozzAasW7JG9L2ALUYFkp
         1TQXGYSjQpdi8zpVvuxcZdxEJNTnzJv26oWSGrcJIyHWNod9AjDbXvzlay+wvTIF2anN
         lViq1b7ZCcsfVpRDVzOcNeOEVCXUbStQRloVX3eRJMtCSoFzL4Bs0SRTHObbsJITWZtZ
         +1NYpYaxGJfQv++ZyHlLTWtyWsO8HylA0GPqD6YiSYpwm79JUee4tVWS6sVbTTj2+oRb
         QF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBCHbbVfn2W7GCIwQZshDqoULkmiIrMZcuv1e33Ldn0=;
        b=ZAtRWTuUehT2Pd7GFrFtPvOf7aU9uIts/UE2TKHYT4lboGjRLgANQB6ThzP+avGgwE
         A6CE7WoiLi/WIBtAFd2b7emc36nn0UdS+/Co2jTB6tjZ1HC5Z5AUbWK0Vd+mWy1EOffs
         yBl9WnkBRrhJ0gD95QCNQ4nN+F3Vl+tRSrQHQ6iQScPuokHCCXBxU1lOL+dWj6h6kirA
         I3Uq2fy5BpFMiJqSGMCYEowd78C3pYDS2zwVUltLHWGcLoVzspGavt9iJWEnudpM28eZ
         Zta2ze1mKE/P0SKh4sMx5jUZ+YXGEgV40VTxWrbn+sFhDn2BVahhQU556tVka4ds9wrT
         TqPQ==
X-Gm-Message-State: AOAM5328SCDFtisp1zElpl5Shsw+uCPiY9dhcezRjIBzxKDMFFjUk6Io
	alG7vtLHgSnUtt0rwTfQtK4=
X-Google-Smtp-Source: ABdhPJyJdQoZPyN3OxTbCUAfBqM+mpRRLD8sKoA6zBSO0+BMr1gYl5dyLfJnD+oibRJ+xp3OG2oVWg==
X-Received: by 2002:ac8:7d86:0:b0:2f3:c523:19a2 with SMTP id c6-20020ac87d86000000b002f3c52319a2mr20026391qtd.566.1652197676437;
        Tue, 10 May 2022 08:47:56 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id e13-20020a05620a014d00b0069fc13ce23esm8906393qkn.111.2022.05.10.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:56 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	cocci@inria.fr
Date: Tue, 10 May 2022 08:47:30 -0700
Message-Id: <20220510154750.212913-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 02/22] introduce cpumask.cocci
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 390
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/20220510154750.212913-3-yury.norov%40gmail.com>

Using cpumask_weight() to compare weight of cpumask against a number
or expression is common but wrong pattern. The more efficient way is
to use cpumask_weight_{empty,full,gt,lt,ge,le,eq} as appropriate.

This patch adds cocci script to test sources for this.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: linux-kernel@vger.kernel.org
CC: cocci@inria.fr
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                          |  1 +
 scripts/coccinelle/api/cpumask.cocci | 51 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 scripts/coccinelle/api/cpumask.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index 17fd10824636..ecd97fdd5d67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3524,6 +3524,7 @@ F:	lib/find_bit_benchmark.c
 F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	scripts/coccinelle/api/bitmap.cocci
+F:	scripts/coccinelle/api/cpumask.cocci
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
diff --git a/scripts/coccinelle/api/cpumask.cocci b/scripts/coccinelle/api/cpumask.cocci
new file mode 100644
index 000000000000..2eb930dbe9c4
--- /dev/null
+++ b/scripts/coccinelle/api/cpumask.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use cpumask_empty rather than cpumask_weight() == 0 etc
+///
+// Confidence: High
+// Copyright: (C) 2022 Yury Norov
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual org
+virtual report
+virtual context
+virtual patch
+
+@rempty1 depends on !patch@
+position p;
+statement S;
+@@
+
+if (cpumask_weight@p(...)) S
+
+@script:python depends on report@
+p << rempty1.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use !cpumask_empty()")
+
+@script:python depends on org@
+p << rempty1.p;
+@@
+
+@rcmp depends on !patch@
+expression exp;
+binary operator cmp = {>, <, >=, <=, ==, !=};
+position p;
+@@
+
+ cpumask_weight(...) cmp@p exp
+
+@script:python depends on report@
+p << rcmp.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0,
+		"ERROR: use cpumask_weight_{empty,full,gt,lt,ge,le,eq} as appropriate")
+
+@script:python depends on org@
+p << rcmp.p;
+@@
-- 
2.32.0

