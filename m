Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0143C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iwiokRL+A5T31Uey5wDHfoo+mp6zGabrAoF65o28YUE=;
  b=TyFzFvLyBZoZinLeWm6SlDEMIpvBAIUgD9UDaXbPjQaBN4Buu/yWmQ9m
   1Dsr+f7+AKagLi6e1ooxjyO2LEn/XbargKcoNDuh3eV5wka2r3dAhA8sF
   A48CWmWq6olWvjVnZcdy4WJihHCarD0vKYccZcAbwNUfAFWD86gQphG5r
   E=;
X-CSE-ConnectionGUID: zVxpmJDvQrSEz54kRKJsow==
X-CSE-MsgGUID: aQpjyqurQlSmdkRHqyE8Gg==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734180"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:44 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DF5AF8046E; Fri, 24 Jul 2026 10:54:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 11766819FC
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:39 +0200 (CEST)
X-CSE-ConnectionGUID: xglFYA2iQNW2KD05zRDU+g==
X-CSE-MsgGUID: pJavqqb/TDWXnFr9JIkbiQ==
IronPort-SDR: 6a6261bb_q1ehHU93tz/eGtrTVHvraz32ypVIJep+4AUpJ6RfcjJOhUq
 i3ZlQToTRnk9PSvwVzD6CO78w9p5BKPMV6v+INQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E7CABdYWJqfDLYVdFaHgEBCxIMggULAoI/FoFTMwRUl?=
 =?us-ascii?q?QcGim+CGTACh1OKT4E/PQIPAQMBCwEBTwIEAQEBAgSEfgKNYAIeBwEEMAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIph?=
 =?us-ascii?q?k8NSQEBBAsBBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQUCLF8CAQMSIAENARsdAQMMBhA7IAIRAQUBHAYBEiKCY?=
 =?us-ascii?q?IIjAQYQAQM3AgG2SoECQoxSBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBN?=
 =?us-ascii?q?wGEdypdA4I6hSN1hAJ6J4EYgRCEfoIfgjmGMASDLpIqAQcHHxIIARwGCAICS?=
 =?us-ascii?q?BUSAwQDBAQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiE?=
 =?us-ascii?q?isKAyoLEg8DDQYFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZC?=
 =?us-ascii?q?AkIAgsFERgMCwcxAxAJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEHREIA?=
 =?us-ascii?q?wEYBAQCAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCAgIGA?=
 =?us-ascii?q?gMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKBgkBA?=
 =?us-ascii?q?QEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECAgEBA?=
 =?us-ascii?q?QIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICCgIDA?=
 =?us-ascii?q?wMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDAwMDB?=
 =?us-ascii?q?QECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDAwUBA?=
 =?us-ascii?q?gcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBAQIBA?=
 =?us-ascii?q?ggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFBQEDA?=
 =?us-ascii?q?QoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEA?=
 =?us-ascii?q?wUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDBAIDA?=
 =?us-ascii?q?QIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDCwICA?=
 =?us-ascii?q?yECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMICxgDC?=
 =?us-ascii?q?wkIBwwBPAwHCiQEBAwqARQUBQQlGWcHBwKNaCOCQAGBDYIpgVEBAQGVPQGPE?=
 =?us-ascii?q?KAhSR4JAQYCYIFngQoVCi+bX4V8GjOXU5MZg1iHP41xI5FwkkeEPgIKBwcRJ?=
 =?us-ascii?q?BKBMjqBXDMaI4EBbYFJUAMZD44hDBaDYMwVNTU9AQEHAgcOAwuBaIN2gk6GX?=
 =?us-ascii?q?IEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:/1N1OK2kvGW7IfrclJotZAqjBJYkLtp133Aq2lEZdPWaSL38qy
 nIpoVn6faQslwssR4b6Le90cW7MBDhHNtOkPEs1NSZLXPbUQmTXedfBOLZqlWKexEWtNQtrp
 uIG5IeNDSaNykfsS+V2njbL/8QhPeCtI6n7N2w856vd21XgmNbgjuRcjzra3GejTMpOaYE
X-Talos-CUID: 9a23:VU8JB2+hpaJbb1stLJOVv14bHu4UWyfc9VHveWyUUTt7cpGoClDFrQ==
X-Talos-MUID: 9a23:8du0twRofk7v7aIFRXT0pjh8Ld5ipJiCN3ALv49XmeiHPy1JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815332"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGJZ3ufRAqZvgk4eKeZBEc1kCq2aT9NLdoduV?=
 =?us-ascii?q?J/XkSquqLG8J0SQzjU7BKSsaD+b38xxvSbf8W4n/r7vJjii/YsL0itfP?=
 =?us-ascii?q?9ZGd7bsAqpu+BmSUFzsby9ILMYXUOzMwGjnUiR6mvliiXxC/p43qlsjd?=
 =?us-ascii?q?2lRMmSE/08aPT1xtWnRIsSzA=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:23 +0200
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso754500a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832441; x=1785437241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iwiokRL+A5T31Uey5wDHfoo+mp6zGabrAoF65o28YUE=;
        b=kNzo1/eJrYs9irNJArCkJ73TaxhVoQLEPRlfHDCerqPf3tjyhcwsuYZqC3Tw1ivQJg
         zlmVy+hFXvOsKJuKg+fqNJTAnYLythZziuzxJpvkC8il2S4JHK5X1nFtQte3crHUtUqW
         ryNDl5hQAu1lkt680J8IkQXgsOYimMzEuVQzszdhOsXcWlLWGYSuYuEfeLZw+OkcIIby
         fpo1rQpAa5FzxAzpzzYy3Zg9LTMtJ7BbUNaPV0aNzx5PYeJgvNIZ1O4W/z/Rmpi7dDM8
         SDHCLbd7PsFxBo1LWjZfTEOeySv3t8ekcBmnz1IgXcQJuITbWWkd0oaKYiE/jxjt1f40
         sM+g==
X-Gm-Message-State: AOJu0YyBN/pCi0NpeKDG+Q1Zt2qb+5S/4K8OjRELV07RcHxcbddlFaJL
	JDs55yq1tehRf8vJwzxBnGZ0+mJJWoQK8fE++rSKPV8JXrKeZ/MnnRsD
X-Gm-Gg: AR+sD10Q8hzoWzXyJGM8C4sF3Xlg7bVDlO8la+OE4zJFpSErnOiyUyCsEcB6RjNUwYj
	0zcKsodiOv/raVEIi2RplB9269rcxCTdUHrgOUsq5u/DPqek5yEGCMyLlLy5LFghVWF+gNqSWCx
	DOkh8icBckIXPH3rzCe/VSLU/xEemoMmuQyjg1us1yyXn3Iw9/FJs34hcCDfufN/uLqTlsq7bwG
	mWk9yS9zMG7pGn1+aVBOjn6C8RM2ov+CwFXFoCHpvKLXjdeSsTQKd/Oe+8zyiIYEMhjnEjqLcg5
	y1GfVhxwHsEkYopMXgi0iznq8iOu1aRejUg0Ec0tk+wIr3ffwe1lXyzef4TQFj7kpyFL8pHqvJ/
	0n0HlSjsLRndPXcnF1vi0zUJDOTMx7L0by3vymSz1RQmnZIPAzVo9mTK7d9hs7j+YxWIlhfSn
X-Received: by 2002:a17:90b:52cd:b0:38e:5ce1:ae30 with SMTP id 98e67ed59e1d1-38ec8468567mr3576355a91.14.1784832441260;
        Thu, 23 Jul 2026 11:47:21 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:20 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Steve French <sfrench@samba.org>
Cc: cocci@inria.fr,
	Bharath SM <bharathsm@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	samba-technical@lists.samba.org,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>
Date: Fri, 24 Jul 2026 03:45:36 +0900
Message-ID: <20260723184538.3888637-35-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 34/36] smb: client: remove conditional return with
 no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3630
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/W5v5WpdfF8pDPeHRvCjyxw>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 fs/smb/client/smb1maperror.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/smb/client/smb1maperror.c b/fs/smb/client/smb1maperror.c
index ab3d09613c91..395299f9121b 100644
--- a/fs/smb/client/smb1maperror.c
+++ b/fs/smb/client/smb1maperror.c
@@ -234,11 +234,7 @@ int __init smb1_init_maperror(void)
 	if (rc)
 		return rc;
 
-	rc = mapping_table_ERRSRV_is_sorted();
-	if (rc)
-		return rc;
-
-	return rc;
+	return mapping_table_ERRSRV_is_sorted();
 }
 
 #if IS_ENABLED(CONFIG_SMB1_KUNIT_TESTS)
-- 
2.43.0

