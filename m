Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0DCC05027
	for <cocci@archiver.kernel.org>; Thu, 26 Jan 2023 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:to:cc:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=3CFe1t4P+3FfzM80rDpGLVDJnMv8e1UCNX7pPuC4XSU=;
  b=sXM3ifjRaVLmcjxChnqfo6JHb41d9lOE7l0Zo5ENHdVSP8IuocYdIWCt
   cVY8w6KPxJXPPVFuCdJ+dZmul0WstLFdajWcc2a+FCRcUa/KXyImtxhHy
   4u/GxIx2x+xV38uUdwD9AU3INBeIFng+zV8hJxxcQJcaZtEATdmezCRvd
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@pefoley.com
X-IronPort-AV: E=Sophos;i="5.97,248,1669071600"; 
   d="scan'208";a="89556179"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jan 2023 14:17:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 464FCE021F; Thu, 26 Jan 2023 14:16:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11E25E732F
	for <cocci@sympa.inria.fr>; Fri, 13 Jan 2023 18:29:42 +0100 (CET)
IronPort-SDR: 63c19505_NE1alYTBEZ8G486lsuN8556MRE/x6j7buCis5M1UN+ZZBod
 uyXvtf4w6Dt74wQDF2wDEFqNfOBwKH54RINxl6A==
X-IPAS-Result: =?us-ascii?q?A0F3AgC0k8Fjf7OgVdFagQmBT4FbUoFdLgRQhE+tCIFWg?=
 =?us-ascii?q?X4PAQMBCwEBRAQBAQQDhH+FGAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBAQIQAQEbBxkHDg4FJIVoDYI4KQGBfCyBWRYRHQEBNwE0A?=
 =?us-ascii?q?iYCNgEFAQwWARIiglyDIwMBn12BBEKLMoEygQGCCAEBBoJimmaBXgkJAQiBA?=
 =?us-ascii?q?iyJDYNjgzeBIVsBgU2CUYIshAuEEIJnhSeICwGCM4MBh2IKgT18gScOTHx3H?=
 =?us-ascii?q?DcDCQMHBSwdQAMLGA0WMgoTLTUWSisaGweBCiooFQMEBAMCBhMDIAINKDEUB?=
 =?us-ascii?q?CkTDScmawkCAyFmAwMEKC0JIB8HJiQ8B1Y3BQMCDx83BgMJAwIfUHABLxISB?=
 =?us-ascii?q?QMLFSpHBAg2BQZSEgIIDxIPLEQOQjc2EwZcASkLDhMDUEcZbwSCDAovKJ5EA?=
 =?us-ascii?q?YEOg3kBkTKEB4wwZp4RgTYGg3OgZzGWexSSGgGXSSCiZDSEKwIKBwYQI4E/O?=
 =?us-ascii?q?oFcMxojgW6BSU8DGQ+SEop8IzQ7AgcLAQEDCYZHgwOCWQEB?=
IronPort-PHdr: A9a23:Nu9CFBNpMKCy6pRgh1ol6naRBxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6gr3Q+CDNmTwskHotSVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5Z3ebx9MiTe+br9/K
 Bq7phjNu8cLhodvNqk+xhzVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3Q
 rJEAjsmNXs15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRTiv6
 bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSGFcXMheSjZBD5u8Y
 YUBEuQOMvpXoYb+qVUQsxawAhKhBP/txzJSmnP7x7E23uYnHArb3AIgBdUOsHHModvvKqgST
 f66zLPVxjvDaPNW3Sny6YjVeR0mufGDQ7xwcc3VyUYxFwLJkE6dqZT7MDOb0eQNt3aU7up6W
 e2zjG4nrhh8rz6yzcgjlofHnJgaykzY9Spn2oY1I8W1RVN7bNCkE5Zdqi+XOYtqTs4gXWxlp
 iQ3x7MCtJO5fCUHxpQpyh/RZvCacYWE/xPuWemMLDtlgH9pZrGyiwis/UWm1+byVdG03U5Uo
 iZZltTArHMA2hzJ5sSaS/Zx4l2t1SuN2g3X8u1IP0E5mbbHJ5MkzbM8ipUevVjGEyPonEj2g
 rSZe0A59eWm9+jrfrDrq5yfOoJ2kQ7zN6YjldKxAeQ2NwUOUXaU9Oaz2bDm/ED0Q65FguMwn
 6LEqp7VP94bqbS8AwJN0oYs9RK/DzC+3dQdh3YHLVZFdAuej4j1Jl3COf74Aeq9jlmoijtry
 PfGPrruApXJMHfPiqvufbF460JEyQozy85Q545MB70fPP7+XlX9ud/YAxMjLgC5wvrrBM9g2
 o4cXW+DGqqZP7nTsV+M6OIvOe6MZIoNtTblNfcl6fnujXsnll4dY6WkxoMXZ262HvRhJ0WWf
 3rtjs0dHmcNuwoyVOrqh0aaXj5Je3myR7485i08CI++EIvPXpqtj6CZ3CenAp1WYXhLBUyLE
 Xj0a4qEWuwBaDmSI89kijwLT6KtS44n1RG0tQ/10aBrLuTO+n5QiZW29sVx5uSbsRgt/DhwR
 5C/zmWMRidQl3wBQzse3aZloEU7xE3VleBegvdfEdVIr8tAVgYqfcrazud9D9npHBrIetaZY
 FejS9rgDytnHfwrxNpbW0thFs/qoBfH0jviV6cYmbuPCY1u2rrR0X/1Ktc7wHHDgvpyx2I6S
 9dCYDX1zpV08BLeUsuQyx3xf8eCcK0d2HWI72Kf1S+Vu1keVgdsUKLDVHRZZ03MrN2/6FmRB
 6S2B+EBNQ1MgdWHNrMMcsfg2E1LSvDnNcWES3q8lWC0CAfOzbSJP8LxY2tI5CzGEwAflhwLu
 3OPNAwwHCCk9nrTAjtqGEO1S1vh/+56pWL9RUgxnEmRd0M08b2z91YOgOCEDfMe2rVRoCA6t
 zB9B0qwxfrTAtuE4hN9JeBSOIxsplhA0m3dukp2OZnIw7lKoFkYfkw3ukrv004yEYBciY0xq
 2tsygNuKKWe2VcHdjWC3Jm2NKeFYm/1tAuibaLbwDS8mJ6f57sP5fIkql7ioBDhF0ws9G9i2
 sVU1H3U74vDDQ4bW5b8Gkgt8B0yq7bfayg7r4TasB8kebG5vDjG1sNzLPMoxBGkcsYZO6SBV
 UfzH8AcG8myObkygVH6JhkAPe1U6Os1J5b8L6rAiPPtZbg42mv53Dcigsg1yE+H+itiR/Sd2
 p8Ex6rdxQ6bT3Lni0/ntMnrmIdCbDVUH2ylyCGiCpQCA886NYsNF2qqJNW6g9tkgJu4EWZV+
 lmnCkJc8Nekdx2WYk271gpVnxdywzTviW6jwjp4nit85LKS0ivKzvW4XAIKNGlPSXgkhlDpa
 9vR7ZhSTA2jaA4nkwGg7EDxyv1ApahxGGLURF9BYyn8K2wKvrKYjrOZeIYP7ZoptX4SS+Gge
 RWBTaa7pRIG0iTlFm8YxTYhdjjstI+r1xB9jWucKj50oh+7MYloyBnY4NHNH9ZJ0zQBQCRpz
 zLQAxCwMsKo8tOdi5rY+rrmBiTxC9sKL3GtlNzR/CKgrXVnGxi+g+y+lriFWUAh3Cn32sMrH
 STEoRDgY5X6gqGzMOZpZE5tVxf378t3HJ07k5Nl3slBnyhHwMzLpTxezjagVLcTkbjzZ3cMW
 zMRltvc4Qy+nVZmMmrM3IXhEHOU3spmYdC+JGIQwCM0qc5QW8L2pPRJmzV4pl2goEffe/94y
 30FxPUp7HML2ckRtQQqyiiMRLsVGAMLWE6k3wTN9N24oKhNMSy3fLa30Edvx/i5Ab+FpgxNH
 n3+f91xeE04ptU6O1XK3nrp74jic9SFdtMfuCqflBLYhvRUIpY8xbIawDBqMmXnsTg52vY22
 FZwiIqistHNeAAPtOqpRwRVPTrva4YP9yHx2OxAy92O0dnnH409SG5WGsK5FbTyTG1U7bO9a
 06PCGFu9CvdQ+GEW1bBsAE+6CuedvLjf3CPeCtHk5M7HEPbfAoHx1pMFDQiwsxnSEbwmJ2nI
 B8/vndLvhb5skcelbgubkW5CzaF4l/vM2dRKtDXLQIKvF4eoR6PbIrGqLo0Rn8Q/4X9/lXVe
 irCOFsOXSdRHRbdT1H7Yuv3uoKGqrnEQLL4d7yXP9Ds4aRfT6van8r+lNs7uW/WZoPXeSA9R
 /wjhhgZBC4/RpSfwmRVDXRQznOFbtbH9k3lpGst9ZH5q66tAEW2tO7tQ/NEONFrsXhamI+lM
 OidzGZ8IDdcjdYXwGPQjaMYxBgUgj1vcD+kFfIBszTMReTegP0fCRlTcC51OMZSisB0lgBQJ
 c7WjM/03b9kn7Y0DVlCT1nohsCuY4QDPWi8MFrNAEvDOq6BIHXHxMT+YKX0TrM17q0crxqrp
 TOSCFPuJByGnjjtEgmzaKRC1X7KehNZv465f1BmDm2iBNPqZxunMcNm2D07xbpn4xGCfWUYM
 DV6bwZMtujKtXIe0qg5QjIZqCM6fLrh+W7R9eTTJ5cIvOE+By11k7kf+3Em0/5O6zkCQvVpm
 SzUp9ooole8k+DJxCA0NXgG4jtNmo+Pul1vfKvD8ZwVE27J8hUJ4HTKIwwHqdxhB8ypsKdVg
 Iuq9uq7OHJZ/tTY8NFJTdDTM96COWE9PADBHTfVCE4cUWfuOziA1gpSl/ad8nDTpZ8/4MuJ+
 tJGWvpQU1o7EekfA0JuEYkZIZt5aTgjlKaSkM8C4XfWRPj5QcxbutXeSqvXD6yweXCWir5LY
 xZOyrT9f9x73mjTw0FsbV13jcLBHE+CBbilTQV5YwEzpEhctnN5Sz9qs38=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gnQ1lq9NsVuIb44Z1o5uk+AyI+orL9Y04lQ7vn2ZhyYlCPBw8P
 re+sjztCWE7wr5PUtLpTnuAtjjfZqxz+8X3WBzB8bHYOCZghrQEGgK1+KLqF3d8kXFl9K1vp
 0QFpSWZueAdmRSvILQvU2ECN4rwtmB/smT9J/j5kYoYA10Z6Rn9gtjTiSWAiRNNXZ7LKt8OZ
 aC6s9Avja6PU4WYMOyG2UfU4H41qH2fVHdDSLuxSRL1OBDt1yVAcbBYmWlN94lPQ9y/Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,214,1669071600"; 
   d="scan'208";a="45015754"
X-MGA-submission: =?us-ascii?q?MDHQ31ahNQ2S92++GXVewWtwZeU6LONQexS2Tq?=
 =?us-ascii?q?930EtlHSitcK5oyPwTScspwvrlztW9t0gE2o3coAv7DangLw8MHjIUS4?=
 =?us-ascii?q?yPOxHmYnRrXO9QsTZ8JGk76AOXIT67J5Jxdaya7ZAgL0+ot5aLoMqkYT?=
 =?us-ascii?q?DMpZl6EWB3nBJL8JtYit5VyA=3D=3D?=
Received: from mail-qt1-f179.google.com ([209.85.160.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 18:29:41 +0100
Received: by mail-qt1-f179.google.com with SMTP id d16so6640823qtw.8
        for <cocci@inria.fr>; Fri, 13 Jan 2023 09:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CFe1t4P+3FfzM80rDpGLVDJnMv8e1UCNX7pPuC4XSU=;
        b=XEAHraYnZZnyAOjUopJsKlc6GJZ3bSMSBGMIjhsUB26AHbVdASIA1RQu+GM1h8v68g
         uKhKuA9JHTpBC7J000kpZ4EEDmCvbv1d34Ur5c/gHet/SwbmhzkfKf4kuGhNbejt4310
         /Z7obismOr3B01ZxVI836oH6m3Xvw2jYwXl3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CFe1t4P+3FfzM80rDpGLVDJnMv8e1UCNX7pPuC4XSU=;
        b=IMVaOBZzlpnG9xHZ2Fwr4UPo/xwyBYzF68FnCMTr9hV3mRpkt6MFIAQXl6T5knRoTG
         UnbRVyI0OdPrL6Bj1ECyOeNh41uUymWK856oUkV8znP4puNfAc9j6yPEQBDNB97Gl/O3
         2K4OYc3U6iHW/LAHvBD9VSTxr5OiyXTSJz3D79wzShatzze65nOn8sg9Tyg1p6tfZw6B
         /Mb+YXBYYaKbe8GOD8L8xCSb8WV6MJp0hU47KbIVrrb8ymw8DEZQlmBNQ76aYr2TF6Pt
         sKxpUiFM9rjmmUxVoiEH690q1XLevP2d5sKy1HeCj/+peu6UPc5RrrMDoIwBLDLwT09m
         KrOQ==
X-Gm-Message-State: AFqh2krAMfhquiGEz084S+Hw2zr38bOoeWYrADVfgUxNGQsOFjvvSSNG
	3Jpk3P5RWIFt1b6jP+7QliY9NsO5oInhhSLJ8OHj1w==
X-Google-Smtp-Source: AMrXdXvRV69bnVP6msDnCyGfW+FutPKf4g24ZRCpSaFPk5yEjX2/jRqgXCvJ3fj2c2HED+o0GqBzsw==
X-Received: by 2002:ac8:785:0:b0:3a9:81f7:2d7f with SMTP id l5-20020ac80785000000b003a981f72d7fmr104698600qth.11.1673630979086;
        Fri, 13 Jan 2023 09:29:39 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id l6-20020ac81486000000b003a981f7315bsm10853389qtj.44.2023.01.13.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:29:38 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 13 Jan 2023 12:29:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAACVwWMC/x2NSQqAMAwAvyI5W+gCgn5FPLQxag5WSUQE8e9Wj
 8MMzA1KwqTQVTcInay85QKurgCXmGcyPBYGb32wzgWDGyIb59vQJI+2wQClTVHJJIkZl69eox4k
 n9iFJr7+QT88zwtagJvxcAAAAA==
To:
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673630978; l=833;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=v5ElnF2s+TFSKaksEa19tLKUsIOtwh2WjBET16twCuw=;
 b=1iFr8Ne5IpvgtFtEYGYG8MAj2N/lI6CDyjwiBXfV8ia3RDLcii2hvzzqXYK6VOeP6VTuTX5mfhGq
 7gxgpzQuBpFLX7t0s0VMeq+1u8Ua2XtBQzSwLUtdR5WkCLiARM3M
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] scripts: coccicheck: Avoid warning about spurious
 escape
Reply-To: Peter Foley <pefoley2@pefoley.com>
X-Loop: cocci@inria.fr
X-Sequence: 817
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/20230113-cocci-v1-1-0f4ae50494d3%40pefoley.com>

e.g.
grep: warning: stray \ before -

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 2956fce8fa4f..fb492f032c5f 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -18,7 +18,7 @@ fi
 SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
 
 USE_JOBS="no"
-$SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
+$SPATCH --help | grep -e "--jobs" > /dev/null && USE_JOBS="yes"
 
 # The verbosity may be set by the environmental parameter V=
 # as for example with 'make V=1 coccicheck'

---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230113-cocci-12936b2c06c3

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
