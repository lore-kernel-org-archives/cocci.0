Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E1AD3B7FB
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8AVvEyvWC2fkEJL3PqyJSguhBu9IhDhFSy9YM6eVTZ8=;
  b=JgRWIsQHe4Q7H54UWoE9wIksS3kvw6h6WhWrSWC08fGS+5aAOZkTJ6J7
   EHw8gjnSjlHjlQnz2pLQNK7RuB+pKpkFr9N/bLGBO5ZPi+X7eO0tNiL4A
   4s2L6mPq1LxlOjioywwDzOF5aM989ajI88/BPUfccjBPAIfKzTwQJGz0Q
   w=;
X-CSE-ConnectionGUID: 6QmtzaXQSmyM+nTNMCqzkA==
X-CSE-MsgGUID: lRynJ+RnRrKDeMh10LVlpQ==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253494951"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:09:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 505ADE0D11; Tue,  9 Dec 2025 11:09:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 74233E0157
	for <cocci@sympa.inria.fr>; Tue,  2 Dec 2025 20:31:44 +0100 (CET)
X-CSE-ConnectionGUID: 4Zxsq5EIR2280yDcazB5OQ==
X-CSE-MsgGUID: YnTPoI+/TteyKe7PHeeyXw==
IronPort-SDR: 692f3ea0_qBMgTWB8NLALos2/mwJTQq4k/VvxJNByAQ/TD+pbujqQR8+
 fNDvIaGzAo7vkhJsh//LS3mgQf9qTlqwb0JMUWQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FeAABzPS9pga3XVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wQBAQsBgW1SgWEzBFSvCIdbAg8BAwELAQFPAgQBAQMEhQACjGcCHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4ZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AgEDEiABDQEBNwEPUTMBBQEcBhMig?=
 =?us-ascii?q?mCCIwEGSgMBpAOBBUKMcIEBggwBAQbcJ4FkCQkBCoE3AYVth2Nxg356JxuBS?=
 =?us-ascii?q?USEfYQKhn2DNIYikzpIgR4DWSwBVRMNCgsHBVuBCAM1DAsqFW4yHYEjPhhzh?=
 =?us-ascii?q?F0eZw8GgRGDTwaJEQ+IAYI8IwMLGA1IESw3FBsGPm4HlBxPgjF7E5k7jxGhD?=
 =?us-ascii?q?oQmgWQMmGGHBk2EUZMBDJMNLodlkHOjflqEPQIKBwcRJIFaJIFcMxowgypPA?=
 =?us-ascii?q?xkPjiGJE79tIjU8AgcLAQEDCYVDJhOLbjSBSwEB?=
IronPort-PHdr: A9a23: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
 5H+9xqoNCpobMQyIK3NIexO1FcC38qz
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7QLWlqn8b8Xdf25N4/elUaTiLIrpDfLp3DAbv31ZSRFFG/FwWf
 re+8jzsiWE9wr5PUtLpTnuAtj4fZqxz+8R3WBVB8bZYOCEghrVEGgB1/qb/9SIIUSXnZ8+6U
 4jSdkCNDSZNykYsS+Q2njfLz9P+qjizImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmV7LKt8Op
 7ZyMQvnVSdkLcsAfhTxENpYwEOnbz2ferdEGU77tcciDWzsQ==
X-Talos-CUID: 9a23:CG9dbG0zQkyCv7UZ3cXxULxfRvI1aWSA4VbqeRXoUXdFQ7SHYwK3wfYx
X-Talos-MUID: 9a23:vCAuawbUSOQ2XeBThjnQvDZDd4BU/6m/K01SqbULtti0Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,243,1758578400"; 
   d="scan'208";a="252425156"
X-MGA-submission: =?us-ascii?q?MDET3Ta4pgc1E5JQCk6tnU68I8Gv23CRl+KunE?=
 =?us-ascii?q?w/0r0wWL5keXwYV4Pt3sF6P36BUh4U8BKSNMezgCQosJkkDPlO08R/Yf?=
 =?us-ascii?q?Iu8f2L6BPlPc0cfQDaDzJ8cYFdqzGn/VaSyjbY3qHAGYn5SpiJhMlGld?=
 =?us-ascii?q?fYWxE2EZcHu8rrrl8Vi5Waiw=3D=3D?=
Received: from mail-pg1-f173.google.com ([209.85.215.173])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:31:43 +0100
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso3445977a12.0
        for <cocci@inria.fr>; Tue, 02 Dec 2025 11:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764703902; x=1765308702; darn=inria.fr;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AVvEyvWC2fkEJL3PqyJSguhBu9IhDhFSy9YM6eVTZ8=;
        b=HurKpjW2d726gXzXTaCMdoLO3kktU3hEH5Ntk1yyl3F6fbiI3J1Ufnds/R/JwYSibj
         FteyboC3bAm6MBE5mDp30Qcp+VGY0Soq1xUpHwn8RvEVvZ7D6CCFVxhUhmdLsIu4q/EE
         9ISn2V3F8iFUiciUM6Hzl5OLsWJCEiRJt+G4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703902; x=1765308702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AVvEyvWC2fkEJL3PqyJSguhBu9IhDhFSy9YM6eVTZ8=;
        b=c6iKrCO16D3FSLlY0POkZUag5AWTAtv4QGzysEbf4O4eIsGcqdm9fAjizRVNMJDUbA
         dVU6CV1qnUNbw7u8wWYR7lfTApaelcEidKlvPqrn4qDH8vGry2R641rSFmA/1WAR65cV
         1rcpcVOVlm/F6yQxgRMm8ascp0HHCZz0rE94ycTAHOepCAaU5/Sz22dEtb6sQ4sMTBqJ
         ro+rA7Q82UmiaPas3rwfNdXEFxlPVUDPc7VG6mXKjGXgCOItEhhLeoec334UYwg9zi5N
         Sucwhu6PztqThi5Y5cFd4sMv32pPlZQM1sNLkB8jnzRzNGZsbf//RcvtYonotcPRgVFL
         3rxA==
X-Forwarded-Encrypted: i=1; AJvYcCWNsE+S3zktI/qM/LFsg/8BjngnJTTUvU9wgx+3bUZC/PhVAZO3wezhLJ4i1YG/qsAV7Bww7A==@inria.fr
X-Gm-Message-State: AOJu0YyXmhni2bUi2HDShKdN/ZTJDMAV5YCob2/4mVIJyINs1nyC4NLH
	dMWJ3etGMGGIgvPGUBeFvSABSmP5US4foNFXq2L5bAVsIS0PuCPMnWVX0h2kA2NdWw==
X-Gm-Gg: ASbGncsNoymvud0IgJ4v3VXjiGOTBsvOdOgVejZebAaFimkzVYItAh+nKLM7kbjscm6
	xl2IZge6X1R5uUo3w7K6xqONLvhf5Fx7is3SsBeQ80BF1AsstArEX4HyxPrZfBJXfyQ95cvnbgO
	BMP8pdd99RZgIKOamG3bxZiSTA/PDzUDlb+Z5idFGjZ5iHfOKGp/p7AreR1dx/p/163Ubxyf0et
	qw0OYrZmCBEX2GJZ9JzBiT5lPPATcNzbVNAhAeBr71OrEQSLbO3mhpmM4lCzUSQkcimdJj7fsA3
	TCmBM57TUVWOhJpHXtL3so7Dbdks/FLCni/mxf/Y9k7WFYSmhZEifbJNrZjJftF/G4kplL4taaV
	j0rr4oug59RwGVEKhUENh3UWDTQr+O1sI54PS+hGhnLA4NifTbbE3FXFTri2pXaZ61grNz/jLBp
	Ky7ZWq32wa1iCydp09MFGibB2PTTPEoVc6r/pz5pkXuY6cE6U+Xg==
X-Google-Smtp-Source: AGHT+IFlEs5RNDUI+Ae+Fm5enXUxDsZ/Kn0ynDmaIrBeKwQbRekMa0hOru8vRQqFZBYSBtOCQg82QA==
X-Received: by 2002:a05:7301:dd84:b0:2a4:8576:abf5 with SMTP id 5a478bee46e88-2a94174da37mr16919602eec.23.1764703902305;
        Tue, 02 Dec 2025 11:31:42 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a9655ceb04sm56575977eec.1.2025.12.02.11.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:31:41 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Brian Norris <briannorris@chromium.org>
Date: Tue,  2 Dec 2025 11:30:26 -0800
Message-ID: <20251202193129.1411419-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202193129.1411419-1-briannorris@chromium.org>
References: <20251202193129.1411419-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 3/3] coccinelle: Drop pm_runtime_barrier() error
 code checks
Reply-To: Brian Norris <briannorris@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3252
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/20251202193129.1411419-3-briannorris%40chromium.org>

This function doesn't return anything any more, so the compiler would
notice any bad error handling before any cocci script would.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 scripts/coccinelle/api/pm_runtime.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index 2c931e748dda..bf128ccae921 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -37,7 +37,6 @@ ret@p = \(pm_runtime_idle\|
 	pm_runtime_put_sync_autosuspend\|
 	pm_runtime_set_active\|
 	pm_schedule_suspend\|
-	pm_runtime_barrier\|
 	pm_generic_runtime_suspend\|
 	pm_generic_runtime_resume\)(...);
 ...
-- 
2.52.0.158.g65b55ccf14-goog

