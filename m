Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D023C531F9
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Eq7DVzYHyMqOagO/PFvTOoCKowMxqeglDmPdQ8+nQ8k=;
  b=KwviL5384aVmW/2MYJ7vm7mM/uG3BEXvWwjf9uDK5oKQeEu68cdQXmFa
   ajgBasxa3hzUSyK9UutrO6w6eud7nVYyeSyL6j1xvZ+A11TclpKaUzWfE
   iHmuvloCzsgFFtmi0pCFK/0EA5sWXnhO5lsG24ZjRINvA0GQ9no7RSCnn
   A=;
X-CSE-ConnectionGUID: oKsj3NgfQVurI08JZM6zlw==
X-CSE-MsgGUID: R9zqTelsTP+52GYgxsOwGQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871796"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 13BCE805E9; Sat, 25 Jul 2026 13:44:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 10EB8802B7
	for <cocci@sympa.inria.fr>; Sat, 25 Jul 2026 13:35:38 +0200 (CEST)
X-CSE-ConnectionGUID: Or7eqw6kSf+HHYggPXMWvA==
X-CSE-MsgGUID: 1WL+X4BRRdmulBEZmNJNTg==
IronPort-SDR: 6a649f89_aZGwVAMH5GUozC/1TSZU2v861QPBu3ZpvkP7BCSlycutZLp
 TsNxXotrsIetsZfh4RmGD4PqEbrWEKh9D9GKHpQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EgBgCKnmRqfCzYVdFSCIJZAoI/FoFTMwRUlQcGgT6JM?=
 =?us-ascii?q?YIZMAKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYQIeBwEEMAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NS?=
 =?us-ascii?q?QEQAQQBAYIBgSVhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQUCLF8CAQMSIAENARsJFAEDDAYQOyACEQEFARwGARIigmCCIwEGE?=
 =?us-ascii?q?AEDNwIBtkWBAkKMUgUCFoEBgg0GgmrXfgoZKA11gWMBAgIHCQEKAQGBNwGEd?=
 =?us-ascii?q?ypdA4I6hSN1RIM+eieBGIEQhH6CH4FrEjyGMASDLoJIj3gBBwcfEggBHAYIA?=
 =?us-ascii?q?gJIFRIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKK?=
 =?us-ascii?q?CISKwoDKgsSDwMNBgUVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBA?=
 =?us-ascii?q?xkICQgCCwURGAwLBzEDEAkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdE?=
 =?us-ascii?q?QgDARgEBAIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICA?=
 =?us-ascii?q?gYCAwMDCgECAQEBAQEBAQIHAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKB?=
 =?us-ascii?q?gkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECA?=
 =?us-ascii?q?gEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICC?=
 =?us-ascii?q?gIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDA?=
 =?us-ascii?q?wMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDA?=
 =?us-ascii?q?wUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBA?=
 =?us-ascii?q?QIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFB?=
 =?us-ascii?q?QEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDA?=
 =?us-ascii?q?wMEBQUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDB?=
 =?us-ascii?q?AIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDC?=
 =?us-ascii?q?wICAyECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMIC?=
 =?us-ascii?q?xIJFgMLCQgHDAE8DAcKJAQEDCoBFBQFBCUZZwcHAo11I4I/AYEOgQBvXIEvA?=
 =?us-ascii?q?QEBkWySYqAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZLphaI5FwkkeEPgIKB?=
 =?us-ascii?q?wcRJBKBMjqBXDMaI4EBbYFJUAMZD45fg0TOSTU1PQEBBwIHDgMLgWiDdokqg?=
 =?us-ascii?q?SCBKxU0gUwBAQ?=
IronPort-PHdr: A9a23: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
 emqlD5KeWxKXP0v8KoCyw==
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:NirRta6hHzdNvWT93QPXwOzXdLJyesId70hD6qm+c20xTiX+rb
 HSoB1/73XJYVkqKRYdcLy7Scq9qDbnhOZICOoqTM2ftWvdyQ2VxehZhOOIowEIWReOjdK1vZ
 0AT0EUMqyVMbEVt7eZ3CCIV/glhPeImZrGuQ4c9RtQpMNRBp2Ilz0Jczpz23cZeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3Axpjpx2ujWG4nAdfhRPIMh00I6IsCaCLQ1WiOIHS?=
 =?us-ascii?q?2SkZJebKacW+1x71Nxp8=3D?=
X-Talos-MUID: 9a23:UH3+4wiQNiBVM+KQOTALicMpbfhMoJTyIno3nZAbv+OpBylWGRGhg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="152929182"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH+LoS+vML1BJeMZl0uk3jNEG8jaXBdCEygya?=
 =?us-ascii?q?HNNx7hdUY3KamU66FDWE4fBoF/cxK+kZkES2C8AkQROhbKFWU9HU68RM?=
 =?us-ascii?q?85UoBJfgni/o1LqB0treApsFlJr69OPNChFmtN+UNdmJaukNvnSaewun?=
 =?us-ascii?q?i+XYVI/MHv8YNNCOuRkhAxGg=3D=3D?=
Received: from mail-pj1-f44.google.com ([209.85.216.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 13:35:37 +0200
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1047279a91.3
        for <cocci@inria.fr>; Sat, 25 Jul 2026 04:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979336; x=1785584136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eq7DVzYHyMqOagO/PFvTOoCKowMxqeglDmPdQ8+nQ8k=;
        b=gFefSsBoq5JGyW98rdMeFvH7kyXL8Hri5JhQNsywumjOOOem2hwXB5P8V+A+OoQt1b
         prTExPde05XDJviQ9z6/sgVpuFlN4EwV+aQpKtHelNeV3+n6+Ac+dxf1LMTqHprU9utT
         ClW/L1wRJi4Jrm8uVci8bZlzVGAN+p0DZqZgANA9yHnR8zUTTjIrS6KSaXSw48MVhWsI
         D1aYfEYkxVbl9ur3XnztMwqrNFQaVTAgjcJoQxeujVprF8683V4yvp/H52fbRbQLD8bc
         /92iU/f42dMjJ8GNKfy1x0LsVzJfL+Fohy7ErPZPUOKlIU6bIxOxHLtHQqNHPCzpuS2n
         rrTQ==
X-Gm-Message-State: AOJu0YzS08Q4o9wWL7rS8pJw/UqpLP0WHed19Gz9AMvGnZ7ZCL9TDWWC
	otCyg+x3eEnof+yUUOfUMjDe27ox2veVZFfJVD4z/lMmPO5RBRuLK3D66CQISkbb
X-Gm-Gg: AR+sD12FpoOuTXnSHVUL40HvVYZWqXsAZSaWaBsn56qUJ/BW+DKq2+3/+Qu9Oa8p6a3
	XPBEwDTMHeIImZPa36Chs60a1HeKZuQjF7ttcrivL/+PSl+Dowju3Yt1VcmAxbphjPYqBIi/iuJ
	n51ZIZsQXtMeLi4lcOLk2S4bIO/wj69jZTmMvYy/XfPoxpSFrOll7e+/BSEzZ6/lUToFCzxQWlT
	U416eiGhfJdEkV9rJDPNA3wTNMEZOFsIM8uYzI6/uqpx/XjxnZ/UDEg7pME/mjwNdO0c4poNmS+
	ArW/Rr+Px2jIi+KEtE4YjmRyJLENPFJNhE2sugamzWA1CkwsU9BtGi7zqic7zPmhH2v2RI3QZF/
	J9WUMjp15fK1oQaA2UV1t8n08nXVaSL0/hxSIkKdAnXgdvlMSImTMGq6Lavs+IKo8Ert7HCOE
X-Received: by 2002:a17:90b:4a51:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38f295145c9mr2201065a91.16.1784979335666;
        Sat, 25 Jul 2026 04:35:35 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08ae3079sm1539083a91.3.2026.07.25.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:35:34 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sat, 25 Jul 2026 20:32:40 +0900
Message-ID: <20260725113303.691676-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725113303.691676-1-ekffu200098@gmail.com>
References: <20260725113303.691676-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 2/3] coccinelle: double_lock: improve performance
 when no double lock exists
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3657
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/IWMVVvIsL4nC0IlTSDcNiA>

The 'balanced' rule collects the locks that are taken and released
under the same condition, to prevent them from being reported as a
double lock. It runs on every file that contains a lock call.

To avoid this, collect the double-lock candidates first, so that
'balanced' runs only when one exists. The report then excludes what
'balanced' found.

Every double lock that can be reported is also a candidate, so the
same reports are made as before and the output does not change. A
report-mode run over every .c file in the tree produces identical
output.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 scripts/coccinelle/locks/double_lock.cocci | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/locks/double_lock.cocci b/scripts/coccinelle/locks/double_lock.cocci
index 619cfc714409..381060849a7b 100644
--- a/scripts/coccinelle/locks/double_lock.cocci
+++ b/scripts/coccinelle/locks/double_lock.cocci
@@ -38,7 +38,20 @@ write_lock@p1
 write_trylock@p1
 ) (E1@p,...);
 
-@balanced@
+@r_candidate exists@
+expression x <= locked.E1;
+expression locked.E1;
+expression E2;
+identifier lock;
+position locked.p,p1,p2;
+@@
+
+lock@p1 (E1@p,...);
+... when != E1
+    when != \(x = E2\|&x\)
+lock@p2 (E1,...);
+
+@balanced depends on r_candidate@
 position p1 != locked.p1;
 position locked.p;
 identifier lock,unlock;
-- 
2.43.0

