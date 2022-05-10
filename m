Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E077EC433EF
	for <cocci@archiver.kernel.org>; Mon, 16 May 2022 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pU7kC1SMo4mlTP7fmR59ozkw+4jH/4NJrCGuFJdf6A4=;
  b=hgA74UipNDFM3FdStB9iDj8FVMbWmbGO2H87sYE+DmDqAUnldX8dxhra
   gKyV1LZmxyM3g5duBLcOi3XflXWD4kiG4IB5NxLaEFmb6etEniZMUxlka
   u4KDx4Lru1XhRtUdDluWwuxhUCER/itn6ufiDC+xWC/BD/5VfVg/gcqTk
   8=;
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
   d="scan'208";a="36570614"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2022 22:18:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45EC5E4372; Mon, 16 May 2022 22:18:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 210F1E0206
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 17:47:57 +0200 (CEST)
IronPort-SDR: EQJ5fERxeseAo3cYDlk9//vbXBrfkcQnM0y95765zN7axQhlpij+AuER1gzWc/9rvopGWZzxXf
 vOlfGFmg3xY1M0gguVQxCa7vP7GwFldnarfuuqYC4CslzR4P8GL6ZHuNqvlSPZ7UcFs4pL+cbu
 C+ErEnuUYCT7G1z9nx2/aGRUCgTCgYe9/mSgKja5e3iQwNlB5Kby6IIdNZ4iLBpGY7TcTiVXta
 8Ig7OnKNrxXM48SGYNzTelOUr3traMQFtwtKbXWoEZTFlX+f9GDOeVaZCSM51r9kWXqAH5IJCW
 BjOF17kpBAj5yQH7z8YqLxHR
X-IPAS-Result: =?us-ascii?q?A0B9AwDZiHpif66gVdFagliCJH5VLQROlVmcZhSBaAsBA?=
 =?us-ascii?q?wELAQEzDQIEAQE8AQaEPwKFPgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgXQLAzENgjUpAYNkA?=
 =?us-ascii?q?gEDEiABDQEbHQEDDAYQAzghAhEBBQEcBgESIoJbAYJiAQMxoDaBBEGMRwUXg?=
 =?us-ascii?q?QGCCQaESwoZKA1nA4FZAgcJAQiBKoYVAYMtgQiCL2l6JxCBVUSBFYE8hEyBZ?=
 =?us-ascii?q?1KGJgSOUS2FPYFLBAUkAwMCEBQDCQQCBwYaDgMHAgEXAQIIAgELFgEBGAUJA?=
 =?us-ascii?q?wQFBw0DAUADBgMDHg8IBRICAzQCAgEBCwIGBgQGAwEBBgMJAgQCEgICBAcYC?=
 =?us-ascii?q?hIIFAMCBgIgBQEHBQEEAxIGDBEBCgYGAQQCCgECAgUFDAMBEQEEAgYCBAQEG?=
 =?us-ascii?q?RQEAgQEBQYCCQgHBRYLBAoCEAYBCxICAQYMCAICAgICBAYPBwENBQICBAEOA?=
 =?us-ascii?q?gcGAwsCAwQBBwMEBAQHDAYMDgEDAQcBBAUDDQQBAQYCCwMFCgIBAgMMAQEHB?=
 =?us-ascii?q?AgBAQICCgIBBAIHAQIFAwIDCAMCAwMCAgEBBBECAwQDBAIDAQYBAQUDAgUBA?=
 =?us-ascii?q?wMCAQMDAwIBBAMGCQoECAEEBAEBARECBwcCBgMDAgICAgUBAg0BAgECBAMIB?=
 =?us-ascii?q?gIDFQECBAEKAQUCAwoCBwMBAQIHBQoCBwUCBwICAwIBBQMNAQMFAgMBAQMDA?=
 =?us-ascii?q?gQBAgEDAwkBAwIDAwICAgIFAgMCAgIJAwQBBwMCAQEEBQEEAwECCgQEAwQCB?=
 =?us-ascii?q?AIHAgcCBAcCAQQGAwcGBAIBBwEBBAoEAwMDAQEHAQIFAgIDAgYSBgcCBAEDB?=
 =?us-ascii?q?AQKAgIMAgcBAQIBAQEBAgIBAgcFDgEBAQMCAwYCBQICAQEDCAgDAgEEAQUDA?=
 =?us-ascii?q?QQFAwcCAQUJAgkDAwkDAQEFAQMBCQMDAwIJAwECAgILBAMIAwMCAwQCAgICA?=
 =?us-ascii?q?QMCBwUIBAEECgICAgECAgYCAQMaAQIDBQICCQwBBAICAwEDAQECCAQJBAIDB?=
 =?us-ascii?q?AIBAQMCAQICAQUCAw0GAQEBAQIDAwECAwEBBgMEAggCFxwWAQMDAgECAgICB?=
 =?us-ascii?q?QICAQIDAgINAQEBBAIBAgECBgEDAQICAwEDAQICBgILAQMJAgEHAQUDAwICA?=
 =?us-ascii?q?wEBBRACBAIBBAIBAgQFBQIBAQEEAQMEBAgCAgEDAwIOAgQBBAECAQEjAwQCA?=
 =?us-ascii?q?wICAxcBAgECAwMDBAYHBgIBAhMBAgEBAQUBAgEBBAIEBAcKAwICAgYDAwUBA?=
 =?us-ascii?q?QIDAgEBAQcMAgICEwIECgkDAQYBCgYGFQMCBAICAQICAgoDAQICAQMCCQIBA?=
 =?us-ascii?q?gEFJQMBAQ8kAQECAgECAgMEBwIBBAcDDQMCAQEBBQYKAwMCAwgMAg4DAgEDA?=
 =?us-ascii?q?wUDAgIEAQIEDAoBAgMBAgIEBQUDAwUGBiEHF1ADmDR7EwEqgQaXFY0VnTo3N?=
 =?us-ascii?q?AeDTIE7BgyJS45vhWEaMYVEkQYMkX2HOo8oII0Fg1iRIoRZAgoHBhAjEoEsg?=
 =?us-ascii?q?hUzGiOBAYI3CUUBAgEBAQ0BAgEBAwECAQIJAQECkg+BPohjAVwhNAI5AgYLA?=
 =?us-ascii?q?QEDCYVEJhOLcgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:qH2wm60mOMhTl119ufbD5Rh3kn2cJEfYwER7XKvMYLTBsI5bpzJWy
 zQYCm6FaKqOajOmftxyboqzpBwD6JbSzIJkTwBu3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW17U4
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+hcz
 IoSk4OpdTsOZJXrqOUzDjxFNj4raMWq+JefSZS+mcmazkmDame1hvs3Ux1wMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmezjDLAz2qzPL+GzVG8bkmB91yCfC/E8Ro7rTKDD5Nse1zA17ixLNa2DO
 ZBDNWc1BPjGS0R+OXFGEIogpd2X2ljFbyBT80ucgINitgA/yyQoiOS3WDbPQfSOTNpcmkKwt
 GPD9X7wRBAcLt2WjzSfmlqngeTEnAvgSYcKHfu58ORriRud3AQu5AY+UFK6pbyglhf7VYsAd
 wob/S0hqaV0/0uuJjXgY/GmiEapukFDfcVJL9Edsjmq+qv6viOEI3dRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWppZS1puf8QdSaaXh9EIMSWcMXZVBavIS78enfmjqKH4kzSvfk5jHgMWiom
 2jikcQou1kEYSc2O0iT+FnGh3e1usGMQFdqukPYWWWq6g4/b4mgD2BJ1bQ5xaYcRGp6ZgPb1
 JThpyR4xL5WZX1qvHLVKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9aJGWwO
 haO6V4KuME70J6WgUlfM9LZ5yMCnfiIKDgZfq28gidmOcUuLFDfokmCm2bJhT62yiDAbp3Ty
 b/CKZr2ZZrrIatgyzWySo8gPUwDl0gDKZfobcmjlXyPiOLADFbMEOttGAbQM4gRsfzcyC2Io
 o43H5bbkH13DbyuCgGJq9J7BQ5RdhATW8umw/G7g8bZfWKK7kl6W6GPqV7gEqQ595loehDgp
 C/iABMIkwqv7ZAFQC3TAk1ehHrUdc4XhRoG0eYEZD5EAlAvPtSi6rkxbZwyceV1/eBv168mQ
 PwMesHGCfNKE2yV9zMYZJj7jYpjaBX73VLUb3T5OGAyL8x6WgjE2t74ZQ+wpiQDCyyAs8Fh8
 bCt0wXsR4UOGlZ5B8HMZfPzlF685CBPmO97U0bSDMNUfUHgrNpjJyDr3604JsgNLVPIwT7Dj
 1SaBhIRpO/spY4p8YmR1frU8dvxS+YnRxhUBWjW67qyJBL2xGv7zN8SSvuMcBDcSHjwp/eva
 OBT+Pf2b68KkVNMhIxjSuo5wK874ezvkL9U1AFTGnvGMgawAbR6L3jahMRCu/EfxrJdvgfqC
 EuD9sMAZeeMMcLhVUcNfU8rN7vfk/4TnTbW4LI+J0CjvH17+7+OUENzORiQiXwCcOEkbtt9m
 epx6tQL7wGfiwYxNorUhC5j8WnRfGcLVL8qt81HDYK32BAnzEpOPc7VBiPsus3dbtxNNgwzP
 mbRivOd2/JTwU3Nd3d1Hn/IhLIPiZMLsRFM7VkDO1XZxYaf16FvhEVcoWYtUwBY7hRbyOYva
 GJlAEt4ePeV9DByickfAm2hFmmt3vFCFpAdFrfIqIHYc6VsfmnELWl4IPrUuU5ArD4acT9c8
 7WVjm3iVF4GuS03MjQaASZYRz7LFLSdNTEuXOioGs2EG98xZj+NbmqGez8TsxW+aS8urBSvm
 ASpldqcrYX0MCcRp+swDIzyOXH8jvybDDQqfMyNN5/l0Y0RlP9eFNROx42MlhtxGsH3
IronPort-HdrOrdr: A9a23:re7xPKOMBpoqvMBcTuyjsMiBIKoaSvp037Dk7TEVdfUzSL3kqy
 nKpp4mPHDP+VEssR0b6LO90ey7MAvhHP1OkPMs1MmZLW/bUQKTRekIjbcKgQeQYBEWntQ96U
 4KSdkbNDSfNykZsS842mWF+hQbreVvPJrGuQ6n9QYVceiiUc9d0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="35622452"
X-MGA-submission: =?us-ascii?q?MDHg4oGRd2K7uF2szTdRC2ZDxGoX25/YHvhh9l?=
 =?us-ascii?q?4y8FLg2NO+SPbC+doEHqzmZCIJ7TRZ7AUhyfVbwhWOHUloXQhq04veQ8?=
 =?us-ascii?q?HqGeoMicnHomAatvu+oDy7UhqippvQD/ySVVBNeFhkUkeoKsqtZyxrBO?=
 =?us-ascii?q?7GsFIM4oLUDEz4VB1OTFK2Lg=3D=3D?=
Received: from mail-qt1-f174.google.com ([209.85.160.174])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:47:56 +0200
Received: by mail-qt1-f174.google.com with SMTP id y3so13830637qtn.8;
        Tue, 10 May 2022 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pU7kC1SMo4mlTP7fmR59ozkw+4jH/4NJrCGuFJdf6A4=;
        b=jeTHL+zkb3ae98nnxoN+7AqqNSKIUvIKbCWy+KKPO0Yy+e0/IyD3M34Wwav9VY1MqP
         qBtHfminh+20L3UJ7VVq6aII3BSzarzWFYYI7OVAvt/38fBzk2Sj1ujp/Gqfvf4NmXRy
         HlohiNCPcThYZxFcUkOF3g0Imw0+5WTe7k0AUNXstVavNcPvzbP1hoHfGqYsWW7MEt8W
         dDl/3v4Lqf0fmdzWHiAjG2zocG+y6zMvXRrjwN64xPnmf1YdjS2EwK4u++MG6hvtG8XA
         BmSmG3hQvIkRhuqg3H3SPE5VwjKil3ri3u6auyhPuo5T7/ZWE9oDA+/k3R+Va+ocz6aP
         VZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pU7kC1SMo4mlTP7fmR59ozkw+4jH/4NJrCGuFJdf6A4=;
        b=HIJd2isR+EEqn+VJblw92picD2j78KcH9yfxn6fGMzBgPKc9M9/rW+7pT4/yl+4YfO
         dDTN7W7MfKmJ/55b/IFrdeHvcfctx8lgdN2IVD4DnIGRCdYGfLzKTEfsKohU3GI3LMbr
         d+vFBtohQ4kmYJvqF3fFrlaKV3suSQRO0QHz2M1eHdzWMDAHPnQZYaB2pdGVVnHkflEf
         XTG3+i/pc4pNqL/Wd4qcsM6PPA5PDhZiPFWbtVQtMBflIh1jJ8y8q8rStQNayYUBs58J
         W+q+CVn8B6m7xnzQ6ejvDF8oYAT7oXCBgwK02clGd0+AwK+AvcTm+nvYOX3jq7jyoYIK
         Qe/w==
X-Gm-Message-State: AOAM5326lpfW+RLl/ATKBpZsUphud6UlxfmelEZIJszRSg7TGv8JtqoH
	ZC9mBpPSnMKWKXvcSC6gwp0=
X-Google-Smtp-Source: ABdhPJy2pJ02ApIgBhzwy2wz2hCj3CKDavdxJ7zOVAt2upsy4uouBW6BbQL5+JNwjE1EnvY1ZSwPkQ==
X-Received: by 2002:a05:622a:587:b0:2f3:ced4:60ba with SMTP id c7-20020a05622a058700b002f3ced460bamr15492635qtb.493.1652197675159;
        Tue, 10 May 2022 08:47:55 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id d16-20020ac851d0000000b002f39b99f6bbsm9527839qtn.85.2022.05.10.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:54 -0700 (PDT)
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
Date: Tue, 10 May 2022 08:47:29 -0700
Message-Id: <20220510154750.212913-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 01/22] introduce bitmap.cocci
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 388
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/20220510154750.212913-2-yury.norov%40gmail.com>

Using bitmap_weight() to compare weight of bitmap against a number or
expression is common but wrong pattern. The more efficient way is to
use bitmap_weight_{empty,full,gt,lt,ge,le,eq} as appropriate.

This patch adds cocci script to test sources for this.

Because for short bitmaps there's no performance adwantage of conditional
bitmap_weight over regular one, and because readability of latter
may be considered better, bitmap_weight_{gt,lt,ge,le,eq} cases are
marked with WARNING.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: linux-kernel@vger.kernel.org
CC: cocci@inria.fr
CC: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                         |   1 +
 scripts/coccinelle/api/bitmap.cocci | 104 ++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 scripts/coccinelle/api/bitmap.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index f57e6d38a542..17fd10824636 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3523,6 +3523,7 @@ F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/nodemask.c
 F:	lib/test_bitmap.c
+F:	scripts/coccinelle/api/bitmap.cocci
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
diff --git a/scripts/coccinelle/api/bitmap.cocci b/scripts/coccinelle/api/bitmap.cocci
new file mode 100644
index 000000000000..24ff1809ba1f
--- /dev/null
+++ b/scripts/coccinelle/api/bitmap.cocci
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use bitmap_empty rather than bitmap_weight() == 0 etc
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
+@rfull depends on !patch@
+position p;
+expression E1, E2;
+binary operator cmp = {==, !=, <};
+@@
+
+ bitmap_weight(E1,E2) cmp@p E2
+
+@script:python depends on report@
+p << rfull.p;
+@@
+
+coccilib.report.print_report(p[0], "ERROR: use bitmap_full()")
+
+@script:python depends on org@
+p << rfull.p;
+@@
+
+@rempty1 depends on !patch@
+position p;
+statement S;
+@@
+
+ if (bitmap_weight@p(...)) S
+
+@script:python depends on report@
+p << rempty1.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use !bitmap_empty()")
+
+@script:python depends on org@
+p << rempty1.p;
+@@
+
+@rempty depends on !patch@
+position p;
+@@
+
+	bitmap_weight@p(...) == 0
+
+@script:python depends on report@
+p << rempty.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use bitmap_empty()")
+
+@script:python depends on org@
+p << rempty.p;
+@@
+
+@not_rempty depends on !patch@
+position p;
+@@
+
+ bitmap_weight(...) @p> 0
+
+@script:python depends on report@
+p << not_rempty.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use \"!bitmap_empty()\"")
+
+@script:python depends on org@
+p << not_rempty.p;
+@@
+
+
+@rcmp depends on !patch@
+expression exp;
+binary operator cmp = {>, <, >=, <=, ==, !=};
+position p;
+@@
+
+ bitmap_weight(...) cmp@p exp
+
+@script:python depends on report@
+p << rcmp.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0,
+		"WARNING: use bitmap_weight_{gt,lt,ge,le,eq} as appropriate")
+
+@script:python depends on org@
+p << rcmp.p;
+@@
-- 
2.32.0

