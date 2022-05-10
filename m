Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BA0C433FE
	for <cocci@archiver.kernel.org>; Mon, 16 May 2022 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=et/xiYs/rsa/96PjCIfZq4Lkirm6fP+CXISc9QiPIK0=;
  b=j9767hkHhWQY73jUgmvdDSrbHxNmrh6MvmikbOeTcWVZDYUZAbP7V5dw
   GkjDOpYQUlTduq5nPOFGNQwyUN4ds8v4yaxn70YIxK8/1KwehJ+ZQ8qJr
   kiyEBfDpcnxSl+8BFRVnFLxLx/q7akHj1VPB+c5UKw5XNNDuSB/nYfq1E
   I=;
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
   d="scan'208";a="36570637"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2022 22:18:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C23E1E4371; Mon, 16 May 2022 22:18:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AC3FAE0206
	for <cocci@sympa.inria.fr>; Tue, 10 May 2022 17:47:59 +0200 (CEST)
IronPort-SDR: 5Yi3q3AiooZf8yvMioT0+BRigQmycSSCUGkSKpt5KF6OKDK3RSB90T9w9Rj9ct2l5XKiDZQTSy
 ySHkpS8qkZacCMOe7NxxD/a7WEd0CGBWNUJ0wRib0dC13w+bZmaClAhGahUEV0U6PQcpVGho0X
 5hNeKGsLdAuDEANuxZbTlwerPKKlN9yk3QuY4aLoRjmIK0IvIEeF+kEpAyFYpQpLarh10j0y3T
 rQosZuFA9gr7UTWNrZSI91oVp3C/FUfUGOioqi+nTX4ixz277abMj7nJzXdlfE9nsAtnJkVQDC
 tkNnyFNwi+Bjmw27bki1nc0O
X-IPAS-Result: =?us-ascii?q?A0B9AwDZiHpif7CgVdFagliCJH5VLQROlVmcZhSBaAsBA?=
 =?us-ascii?q?wELAQEzDQIEAQE8AQaEPwKFPgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBRIFPgXQLAzENgjUpAYNkA?=
 =?us-ascii?q?gEDEiABDQEbHQEDDAYQAzghAhEBBQEcBgESIoJbAYJiAQMxoDaBBEGMRwUXg?=
 =?us-ascii?q?QGCCQaESwoZKA1nA4FZAgcJAQiBKoYVAYMtgzdpeicQgVVEgRWBPIRMgWdSh?=
 =?us-ascii?q?iYEjlEthT2BSwQFJAMDAhAUAwkEAgcGGg4DBwIBFwECCAIBCxYBARgFCQMEB?=
 =?us-ascii?q?QcNAwFAAwYDAx4PCAUSAgM0AgIBAQsCBgYEBgMBAQYDCQIEAhICAgQHGAoSC?=
 =?us-ascii?q?BQDAgYCIAUBBwUBBAMSBgwRAQoGBgEEAgoBAgIFBQwDAREBBAIGAgQEBBkUB?=
 =?us-ascii?q?AIEBAUGAgkIBwUWCwQKAhAGAQsSAgEGDAgCAgICAgQGDwcBDQUCAgQBDgIHB?=
 =?us-ascii?q?gMLAgMEAQcDBAQEBwwGDA4BAwEHAQQFAw0EAQEGAgsDBQoCAQIDDAEBBwQIA?=
 =?us-ascii?q?QECAgoCAQQCBwECBQMCAwgDAgMDAgIBAQQRAgMEAwQCAwEGAQEFAwIFAQMDA?=
 =?us-ascii?q?gEDAwMCAQQDBgkKBAgBBAQBAQERAgcHAgYDAwICAgIFAQINAQIBAgQDCAYCA?=
 =?us-ascii?q?xUBAgQBCgEFAgMKAgcDAQECBwUKAgcFAgcCAgMCAQUDDQEDBQIDAQEDAwIEA?=
 =?us-ascii?q?QIBAwMJAQMCAwMCAgICBQIDAgICCQMEAQcDAgEBBAUBBAMBAgoEBAMEAgQCB?=
 =?us-ascii?q?wIHAgQHAgEEBgMHBgQCAQcBAQQKBAMDAwEBBwECBQICAwIGEgYHAgQBAwQEC?=
 =?us-ascii?q?gICDAIHAQECAQEBAQICAQIHBQ4BAQEDAgMGAgUCAgEBAwgIAwIBBAEFAwEEB?=
 =?us-ascii?q?QMHAgEFCQIJAwMJAwEBBQEDAQkDAwMCCQMBAgICCwQDCAMDAgMEAgICAgEDA?=
 =?us-ascii?q?gcFCAQBBAoCAgIBAgIGAgEDGgECAwUCAgkMAQQCAgMBAwEBAggECQQCAwQCA?=
 =?us-ascii?q?QEDAgECAgEFAgMNBgEBAQECAwMBAgMBAQYDBAIIAhccFgEDAwIBAgICAgUCA?=
 =?us-ascii?q?gECAwICDQEBAQQCAQIBAgYBAwECAgMBAwECAgYCCwEDCQIBBwEFAwMCAgMBA?=
 =?us-ascii?q?QUQAgQCAQQCAQIEBQUCAQEBBAEDBAQIAgIBAwMCDgIEAQQBAgEBIwMEAgMCA?=
 =?us-ascii?q?gMXAQIBAgMDAwQGBwYCAQITAQIBAQEFAQIBAQQCBAQHCgMCAgIGAwMFAQECA?=
 =?us-ascii?q?wIBAQEHDAICAhMCBAoJAwEGAQoGBhUDAgQCAgECAgIKAwECAgEDAgkCAQIBB?=
 =?us-ascii?q?SUDAQEPJAEBAgIBAgIDBAcCAQQHAw0DAgEBAQUGCgMDAgMIDAIOAwIBAwMFA?=
 =?us-ascii?q?wICBAECBAwKAQIDAQICBAUFAwMFBgYhBxdQA5g0exMBKoEGlxWNFZ06NzQHg?=
 =?us-ascii?q?0yBOwYMiUuOb4VhGjGFRJEGDJF9hzqPKCCNBYNYlXsCCgcGECMSgSyCFTMaI?=
 =?us-ascii?q?4EBgjcJRQECAQEBDQECAQEDAQIBAgkBAQKSD4E+iGMBXCE0AjkCBgsBAQMJh?=
 =?us-ascii?q?UQmE4tyAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:vZPnba55KOhMTcX5UHXQjQxRtPPBchMFZxGqfqrLsTDasY5as4F+v
 mVJXTqBbPbcYWCkcop3bI+/800O7ZfXzNFgSQRkqylnZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2+aEvfDjW1nX4
 Y6r+5WFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 PVR7syCTFdqBerzm8oTYSsDEmJ+GoQTrdcrIVDn2SCS50jPcn+p2uk3SU9vYtNe9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9E7c0wJ18cqEHP6tH0p1k5SDEF+dgR5fZRLvi6tpR3TN2jcdLdRrbT
 5FEN2A1MEmfC/FJEk0XJLgSleL2un76fRxKlQi0+o4K+XeGmWSd15C0aIaPEjCQfu1Rl1mRo
 mbu7WX8CAsTct2Z0zuMtHy27sfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpPC4jgunR4saJ
 RVLpGwhqq898EHtRd74N/GlnJKalj4AAIpiFr1500ayyYTa0TTCBysEaRcUPbTKq/QKbTAt0
 1aImfbgCjpurKCZRBqhGlG8/WPa1c89fT9qWMMUcecWy4K8/9xr33ojWv4mQfHl1ISkcd3l6
 2nS9HBWulkFsSIcO0yGEb3vhjutot3QUldw6FyIACSq6QR2YIPjbIutgbQ60RqiBNbFJrVil
 CJe8yR70AzoJc/V/MBqaLtVdIxFH97fbFXhbadHRvHNDQiF9X+5Zpx36zpjPkpvOctsUWa3P
 RWK41oMtMIIYCXCgUpLj2SZW5RCIU/IRYSNaxwoRocmjmVZL1LYpH42OyZ8IUi0yhZ3y8nTx
 qt3ge71VSpAYUiW5DWxQOgZ3NcWKtMWlAvuqWTA503/i9K2PSbLIZ9caQfmRr1nscus/VqNm
 /4CZpPi40gOC4XWP3iHmaZNdwxiBSZgXvje9ZcHHtNv1yI8RwnN/deKke1/E2Gk9owJ/tr1E
 oaVABEHkgav3i2XQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPuK6js/UScYUZZ74i+LAxxPJ4V
 ahXdMCJA/AJQTPComxPYZ74pY1kVRKqmQPeZ3r/MGZjJ8ZtF17T59vpXgrz7y1RXCe6sM0Jp
 bf/hA7WRJw0QRtvUZTNY/W1wlLt5nUQwbogX0bBLtRJVl/r9Yxmd374gvMtcpMDLBzCwn2R0
 APPWUUUouzEookU9tjVhPDc/935TbcmRkcDRjvV97e7MyXe71GP+44YXbbaZy3ZWUP15L6mO
 rdYwvT6B/sNwwRHvo96JLB0lP5s6tbqoYha+QRqBnD8aVqmV+F7KX6c0MgT76BAy+MLuQayX
 U7TqNBWNa/TZJHgGV8VYRM5N6GNjK5K3DbV6vsxLQPx4youpOiLVkBbPh+tji1BLesqbNl0n
 7954MNGuRaijhcKM8qdinwG/Wq7KHFdAb4ssYsXAdO2hwd3mEtOZ4fQVn3/7J2VMYkeN0ArJ
 nqNmPOHie0DmAzNdH08EXWL1u1Y3MxctBdPxV4EBlKIhtuV2aNtjUMJqWw6HlZP0xFK8+NvI
 Ww3ZUd7EqODomVzj89ZUmHwRgxMCXV1IKAqJ4flSYEYc6WpaoAJBGg0OOLI5VxAtmwFIWYd8
 7afx2LoFz3teakdG8f0tVFN85TeoR5Zr2UuW/xL2+yKGpA7ZXzuharGia8gtU78Gc1o7KHYj
 bACwQuzAJEX8QYfpqQ6D8+R0rF4pNVo4oBdaakJwZ7l1l0wtN1/NfZi5qxxlg5wyyT2zHKF
IronPort-HdrOrdr: A9a23:9y+ZyaFkbw03OJlbpLqExceALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKIjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHCcqDf+rIAuPrzEllv4jjJg9WPHhXgmhbgTtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="35622457"
X-MGA-submission: =?us-ascii?q?MDENP9Pw310zcPuD9jZBZ1bW8KgfRUCBQrpC6a?=
 =?us-ascii?q?hwW++qGddw7IdQCFuIEoqAc6mSbG7B6+OBTqXDHr7dyyMcjLinVlqUkc?=
 =?us-ascii?q?UbRc4Wa3EN9iTh4fnu+m/pjrAF9FRflCz7UegII0Dve3SVK5aWRxVOwN?=
 =?us-ascii?q?EjlwlUEH/kzeeAAJGzLQRqTQ=3D=3D?=
Received: from mail-qt1-f176.google.com ([209.85.160.176])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:47:59 +0200
Received: by mail-qt1-f176.google.com with SMTP id e15so13822943qtp.3;
        Tue, 10 May 2022 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=et/xiYs/rsa/96PjCIfZq4Lkirm6fP+CXISc9QiPIK0=;
        b=IsDOgG2uagbr6NRW6ovKobMGvzpUOdJua8IomfIiNU6kDenE1Fu0AzzB5huYoyIsvM
         GSl1FP99vh+9EOCA2jtut5n00UVVVi+nImR31WrNC8RBBH61gz4c4CrrzfOdrYRluMqO
         Jjv9iPDqhRMZOXgb4joUBT6ed7fr9EBDeoSj3T1JobV6kw0/gQLLicraQZEnMONYFWol
         zed+b0HzJuKZzDuwmhmcMPniQkqvUuAv5H3zt3vjooHfAwp2dL3NH/OUkKUgOKc+wDoS
         XGJYn+r/V6HohEOATqEKIb8OtAbowchcKwtrUr6SaRzzdJQYSnRqmdjNkBQEdqfhM1Gc
         PKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=et/xiYs/rsa/96PjCIfZq4Lkirm6fP+CXISc9QiPIK0=;
        b=Dq5JnAMf7BmBt4OKmm0/nd7hZtQ0YbskvVu3EfyM7dHBTam5gEGyvTVcwqqUvS+kPt
         mggrELLZ4EsO/FXe+9VNsJyOhoDeTOdSvljA+9TQxSNtImtv1SgiuPLwcojitEKx1EF7
         Fy2KZMVKsFpHIFKQ4xocSrSqI1Ei5Dxa2qZ5Wr0oSyp+udolvq09Mfxq/5lp9pkBMDML
         0aFidPEq2Aciqw4oV2ht98zDpGO0SQdN3AprnCi2oPBZYoghgGiJ5ptYqIvaC1okarCA
         Er2RpPgnj6AkKXW9TrZrv11lUN+SHJfvFeUNk1Ugfj6KXle0EE/W5caOauaA4VjkhcqS
         pLlA==
X-Gm-Message-State: AOAM533xBM5/feJRV0OSls3nEhYw5DRrwSbrw8U/MZDqTEFY75kKU2tp
	fgkmBZB3HIaEBMJ4d/DZBiQ=
X-Google-Smtp-Source: ABdhPJy4QPoN+Z2RE2YbnC2pYatWTGT1l1v59rnUGl7znoVFZudpny6dgHhL6zpVCHzzIASWFVjQxA==
X-Received: by 2002:ac8:58ce:0:b0:2f3:a42d:ae28 with SMTP id u14-20020ac858ce000000b002f3a42dae28mr20031817qta.416.1652197677684;
        Tue, 10 May 2022 08:47:57 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id p5-20020ac84085000000b002f39b99f67esm9922487qtl.24.2022.05.10.08.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:57 -0700 (PDT)
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
Date: Tue, 10 May 2022 08:47:31 -0700
Message-Id: <20220510154750.212913-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 03/22] introduce nodemask.cocci
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 389
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/20220510154750.212913-4-yury.norov%40gmail.com>

Using nodemask_weight() to compare weight of nodemask against a number
or expression is common but wrong pattern. The more efficient way is
to use nodemask_weight_{empty,full,gt,lt,ge,le,eq} as appropriate.

This patch adds cocci script to test sources for this.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: linux-kernel@vger.kernel.org
CC: cocci@inria.fr
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                           |  1 +
 scripts/coccinelle/api/nodemask.cocci | 51 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 scripts/coccinelle/api/nodemask.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index ecd97fdd5d67..69f95d79e5a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3525,6 +3525,7 @@ F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	scripts/coccinelle/api/bitmap.cocci
 F:	scripts/coccinelle/api/cpumask.cocci
+F:	scripts/coccinelle/api/nodemask.cocci
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
diff --git a/scripts/coccinelle/api/nodemask.cocci b/scripts/coccinelle/api/nodemask.cocci
new file mode 100644
index 000000000000..1d8578640d97
--- /dev/null
+++ b/scripts/coccinelle/api/nodemask.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use nodes_empty rather than nodes_weight() == 0 etc
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
+if (nodes_weight@p(...)) S
+
+@script:python depends on report@
+p << rempty1.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0, "ERROR: use !nodes_empty()")
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
+ nodes_weight(...) cmp@p exp
+
+@script:python depends on report@
+p << rcmp.p;
+@@
+
+for p0 in p:
+        coccilib.report.print_report(p0,
+		"ERROR: use nodes_weight_{empty,full,gt,lt,ge,le,eq} as appropriate")
+
+@script:python depends on org@
+p << rcmp.p;
+@@
-- 
2.32.0

