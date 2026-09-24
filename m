Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D3C9830E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AWSaSv8m1xTsAwBFAkhn0LN3Bdbe0QujogDORt/K2BA=;
  b=hXnle4aEjb4R2C5KVEAJQiPAmFgLsf9ru3sio1iMq7/KUu9ogxdU0Ugp
   nFCmcmFBDoSVukBtURtjafrKHB97HGIHLI/Q0zE28c08iyVXtcigM/6fA
   nWUwcfpaq6O2LPCFBr9/+p7F6wnnvtiDp0vRNWtRhv1hJQgvxzOB5pysl
   M=;
X-CSE-ConnectionGUID: EBCIcRD8Tf+cJUkz2486Sg==
X-CSE-MsgGUID: IKx5MBTORSicuR8ablR1hQ==
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
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="scan'208";a="297140623"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2026 13:12:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C920D8183C; Sun, 27 Sep 2026 13:12:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2CCCF80E56
	for <cocci@sympa.inria.fr>; Thu, 24 Sep 2026 18:26:33 +0200 (CEST)
X-CSE-ConnectionGUID: 6AY3gWEQSTuYxRG4E72RUQ==
X-CSE-MsgGUID: zHUyRpXTQUuSQRti6kxoKg==
IronPort-SDR: 6ab54f38_vmo92N/e4EZ5nVsbX1/nBuacPcb3BY6g/NsJxjYEjFQjFq+
 NyY6NHOAEMt25zcIzc1CqohmNNhr0Lpx85+x7ZA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E7BgBqTrVqfIzhfUpaglkCgj+BC2EzBFQEjU6IeYEWi?=
 =?us-ascii?q?jQykiEUgSs9Ag8BAwELAQFEDQQBAQECBDiERgKOCgIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQGJR?=
 =?us-ascii?q?AGCBIEsYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEFAg0fXwIBAycLAQ0BGx0BAwwGEDsgAhEBBQEcBxKDAgGCIgEGEAEDNwMRt?=
 =?us-ascii?q?iWMcRYFAhaBAYINBoJr2AAKGSgNdYFmAgIBBgkBCgEBgTeEeSpdA4I8hSR2g?=
 =?us-ascii?q?xlpeieCKIEVgnN2gh8rgTxShjAEgy6CXZImAQcHHxIIARwGCAICSBUSAwQDB?=
 =?us-ascii?q?AQBAgsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEisKAyoLE?=
 =?us-ascii?q?g8DDQYFFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFE?=
 =?us-ascii?q?RgMCwcxAxAJAx8DFBYIRQgGFgEaBgUGCzcVBQwRAQIbAh8EHREIAwEUBAIBC?=
 =?us-ascii?q?QMEFgQCFAogAgMDBgMKCQIFAxsYBAECAgMCAQIIAwcIAw0DBAIDAwMEAQICA?=
 =?us-ascii?q?QEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDBQMDBQUCAgUFAwUCAgoCAwMDA?=
 =?us-ascii?q?gEDAhoIAwYDEgEQAwMGAQMHAwcCBAMJAggDAwgIAxcDAwUBAgIEAwMICAQDA?=
 =?us-ascii?q?wQCAgMMBQMCAwMFAwMHAgQCBAMDAQUBAgcCAwcCARgDAgQIBwcFAgsEAggED?=
 =?us-ascii?q?QkEAgQCAg8EBgMDBwEBAgEHBQYDAgIQAQgKBQYCAgIcAx0BAw0GAQkFAgEFD?=
 =?us-ascii?q?gcFAgIYAwYCAwYFAQMBCgsBAQIDCgECBAIFAwMBAwIDAgYDAwIFBQUDCQcFD?=
 =?us-ascii?q?gkBAwMGBQICAwIDAQIIBAYFAwICAwUBAwMEAwoDAggDAwgDDAIaAgUDAwMGC?=
 =?us-ascii?q?QMHBwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsVIgMBBQMDAgEDAgUDAxgCAgQFA?=
 =?us-ascii?q?wMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECBwwDDAYDBwMDB?=
 =?us-ascii?q?AQDAgUKAgQBBwYHBwkHAwIDCAEBCwQBAwMKAwMFAgEBBwUDBgMHAgMDAwUEB?=
 =?us-ascii?q?QMCCwMHAgIDAwMCKQEBAQMDAwMDBAMBAwEDAwcDBQMCDgIIAQoDAgYDBwYDB?=
 =?us-ascii?q?QMDAgECAwMFEQMGBAUGFwIGEToBCAIDAwEUBAQFAgUVAggBAwUDAwMDAgUDA?=
 =?us-ascii?q?QUBAQMDBQMDAwMDAwQBAwQCAwcGCAEBAQIIAwMCBQMDAwQDAwIBDQQCBQMGA?=
 =?us-ascii?q?gIEAgQBBwMBAgIDAwMDAQIEBAIHBAUCDAMEAgMDBQIDAgMLBgIQBAIDAwMDA?=
 =?us-ascii?q?xABAgsGAxQFCwQGBwUDDwUBBQcHCwkIBwwBPAwHCiQEBAwqARUUBQQlGWcHB?=
 =?us-ascii?q?wKQEh6BcnJTKBMBExgXC35dIoEvAQEBlT2Mc6I/SR4JAQYCDVSBZ4EKFQovj?=
 =?us-ascii?q?CKPPoV8GjOEBJNPkxoul197I4I2iTeBeoQJkVF2hD4CCgcHESQSgTI6gVxwU?=
 =?us-ascii?q?DFtgUkSAT0DGQ+OLhaDYIUTxwhCNQI7AgcCBw4DC4gCihqBTAEB?=
IronPort-PHdr: A9a23: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
 PZESlpP3gtiaJg+IqmCfMJ0
IronPort-Data: A9a23:eOnSsKMrr4Pc7hfvrR1Gk8FynXyQoLVcMsEvi/4bfWQNrUor1zBWm
 GUaWGrQbv7ZNmqmKY93aN6zoRwP65eEzYdnHgZtpSBmQlt09fbIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVqicfHw3Hlc+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kkw1BjOkGlA5AJmNKoX5Aa2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 b2hhrTpIesdBZAgrcxBO/VuO3EnbPceoNcrFlDk2SCb5xWun3IBWJyCBmluVWET0r8f7W2ja
 ZX0gd3CB/yOr7ve/V61dgVjrpoKHZLkA64mgU19/CHjIqoLHsr5fpyfsLe03B9o7ixPNfPXZ
 s5cdj81KRqZOVtAPVAYDJ94l+Ct7pX9W2IE7gvP+OxtuTWVlVApuFTuGIK9ltiiTMFcmF2er
 3rLpDykUjkVMdWezXyO9XfEaurnx3KlB9JOTu3gnhJsqE+z+30pEC0qbGammsCDlk/gWMJYC
 ENBr0LCqoBpqRXzEYijN/Gim1aPuRUXWvJLAugi4UeMzLDV6kCXHAA5oiVpbdUnsIopQGZv2
 AbT2dzuAjNrvfueTnf1GqqoQS2aZwEkdmA9SBY/cRY08+PM/Kxs1Cjyd4M2eEKqteEZDw0c1
 NxjkcTTr7AajMpOyKDhuF6e2XSjoZ/GSgNz7QLSNo5E0u+bTN78D2BLwQGFhRqlEGp/ZgbY1
 JTjs5bAhN3i9bnXyESwrBwlRdlFHcppzwEwcXY0QsB5qGXzk5JSVY9X5z56KQ9oNM1CEQLUj
 LvokVoJvvd7ZSP0BYcuOt7ZI5pwkcDIS4++PtiKNYomX3SEXFXblM2YTRTNhzi1+KXt+IljU
 aqmnTGEVixDUvw2kWLqF4/wE9YDn0gD+I8afrijpzzP7FZUTCX9pW4taQPSMLIK/+mfrR/L8
 t1SEcKPxl8NGKf9eyTbu8pbZ1wDMXFxV9i8pt11Z9yzBFNsOFggLPvNnpInWYhuxJpOmsnyo
 3qSZ05/yXjEv0PhFzmkUH5YRYnUbc5Nlk5jZS0IFnS06kcnereqvfs+dYNoXLwJ995D7P9TT
 tsFcequH/8VFzTM1AkPSLXA8LVNeAiaugaVGy+DfjIEXoVBQjbR8YTOZTrf9ygpDwiZv+Quo
 5yNjwP6R8IYZgJAVcz5VtOm/2mTj1M8xt1gfhLvCcYJXlfv661oGjzVotooBf9UMjTF5D+R9
 zjOMCciveOX/rMEqojYt56Lv6KCMrVbDEFFO0L58LzvFy3R3lT78L96SOzSIAzsDjLlyp6DO
 9dQ4er3asAcvVBwtIF5LbZn4IQ+6/brpJ5Y1g5UJ2rKXXv6FoJfJmS64ucXup1v3rN5vS6Ea
 nCL8PReOpSLP5rBO3wVLwwHcO+C9K81nh//0PcLG3j5tRRHpOe/bUZvPhe3mHN8KplxO9gb2
 usPgpMdxDG+rRsICey4qB5o2V6CFVE+dpk2l4o7BdbrgzU7y1sZbp37DDT30a61aN5NExcLJ
 2aUjZXdm7gGnlvmTEsjMHmQ2+AH1JIEly1X/QVTO3WIhdv3qfsl1zJB8TkMb1p0zzcW98lRK
 2RUJ0lOCqHWxAhRhe9HRHGKJwFNIDa7637B4QIFu0OBRnb5S1GXCnM2PNi82Xww8kVeT2B9x
 66ZwmO0agTaVpj98QVqUHE0tsG5a8J68zDDv8WVH86lOZ0eShi9i4+MYVs4kTfWMfkTtmbm+
 9YzpP1RbJflPxE+u6c4UomW9YoBQSC+eVBtf6tTw7MrL0r9JheJxjm8G2KgcJhsJtvL03OCJ
 e5AG8Ztbym6hQGy9m01JKhUOLJlvu8b1PxbcJPRGGM2mb++rD1ojZHuyhbDlFIbG+tJr8JsB
 b7SJhSjE3ORj0R6g2XijtdJEUvmbMgmZD/T5vGU8uIIJq0TsOtqV1wD4pGwmme8aSxK1RSeg
 y3bbYSLzeY4kYVItKnvG5VlGA+bB47SVuOJ0QbrqPVIT4rFHvnvvjMviGvMHlppL5pIfP9oz
 5Kfs8XS3nLVmJoTTEbnw4KgEYtN7uWMBNtnCNr9diRmrHHTSf3S7Asm0EHmDI5Cj/d2xNStH
 im8Y+uOLe8lYc9XniBpWnIPAiQmKvrFa4n7rnmAtNWKMB8W1DLHIP6B9XPEaWJ6dDcCC6bhC
 z3b6uqf2dRFkLtiXBM0JelqI5tdEm/RXaELc97Qtz7BKkKKhliEmKXplDt+yDXtJ0SHLv3H4
 sP+dkCjTCixhaDG8ogI+cg69BgaF210juQMb1oQsYw+wSyzCGkda/8RK9MaA5VTiTb/z4z8e
 CqLVmY5FCHhRn5RRH0QOjg4stu3XYTi++sVJwDFO2uRYiayQZyFWv5vr30m7HBxdT/uiuqgL
 LnyP5E20geZmvlUqSQ7v5RXQtuLAtvVw3sJ/Qb2lMma79M2H+ARzHI4dOZSfXWvLiwO/Xkn4
 UA6QGlFRAewTkuZ/QOMvZJKMElxgQ4DBAnEoctCLBgzdmlbICB9JCXDBtzO
IronPort-HdrOrdr: A9a23:RdVp/6updPR1RHod6XmmiuGt7skDudV00zEX/kB9WHVpmwKj5q
 STdZMgpGPJYVMqMk3I9urwXpVoLUmsl6KdpLNhRotKPzOWxVdAUrsSlLcKqgeIc0aOldK1l5
 0QCZSWYOeRMbEQt7ec3ODXKadE/PC3tI+vnvnX1HpgQEVHbKt6/x5lBgvzKCFLbTgDK558Op
 T03KR6TvmbFkj/rP7XOpB8ZZm6mzQDrvPbXSI=
X-Talos-CUID: =?us-ascii?q?9a23=3ACGPsXWrjD3GxFmCxrD0DyS/mUZ4MQybS81rpGHO?=
 =?us-ascii?q?lOHZTZ+G4FgWqxZoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AvMfIpA1SEV4YDZ/ed3WAjXRVWTUj8YSTGXoVoak?=
 =?us-ascii?q?/htS/DBZsOmmenDOUTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,120,1787004000"; 
   d="scan'208";a="296784280"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE55gS/+5f9HP0YG/Isklf21tdzO5TRtgjqZL?=
 =?us-ascii?q?MlRyrH0MoFJ0F+m8qVz+5VBgYvMhuguzAGpbAMvkrwx3kwZr3qkgW/dV?=
 =?us-ascii?q?Lv3N7rk8M5RgUSYKMvGqyzCc2F0GCF1UMp4Nr4e9Mhqtpy73FHgqF908?=
 =?us-ascii?q?LDBQMNVBOSmGZviWG7FPCt7Q=3D=3D?=
Received: from mail-wm2-f12.google.com ([74.125.225.140])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 18:26:33 +0200
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so232075e9.0
        for <cocci@inria.fr>; Thu, 24 Sep 2026 09:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267192; x=1790871992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AWSaSv8m1xTsAwBFAkhn0LN3Bdbe0QujogDORt/K2BA=;
        b=SF1ySywqoxj+jLXVO71OPoSpng2b0SgGE4aQ/oe+SyjKp4BmDJ8ivJn/zMhcHKSONI
         x/D9n0MWwVrr4wEsdlpGD8aZ7CoGbnJe8H5Qn84CZcwAX3o4XmrtwuGQWGULRorMnRBf
         ujDI6PQtcwlghJH+1fM7PRM9JD+SKnbaEkOFo+DPsH2xrwEUbaU14T+T8XcOvsxDpu0M
         UF8rPRkmWCreSNsvugf6YDLLBXXhPKhOVH+3VPsao5WfsRuQ7ra0Jc7NWyJHf29dO0fV
         K6a/MHp5SorvQTdAreUpWiPySlJIMSFeeUEVzjUVE4CHNXVpsAkc2s21OQ2jL51nDIBs
         G88g==
X-Forwarded-Encrypted: i=1; AKwUvBwhyEsm0BkxMEGEPIYUKtfdxs1aX1duSPzNE4C4nLHutFvzWzCras/o9ahcb0lvl+ZdRJ0YVw==@inria.fr
X-Gm-Message-State: AFuF++lfgOGRm9I0u8fts3S2RwmXpP8vwIele1STn4EDK58FgFGpO+L8
	JD0BsD0r9Nl6TjVUsC1KCfOCq3Rvz7S1azzV5TddgUUAAOivX4pEcGWL
X-Gm-Gg: AYBFou3jc9BvGvIeMz37Y3UlSE6fAY9Byo0TV1dSz+NhFOpVo9kayKO0urE2hQdfclj
	2Stqc9xcJ7306qHowg91jJXv7yqBrGYPHGDDGSmUa/K/m+eUs4YXjfuPuC9le1M+m1aNvwD7ePK
	DrfTWKFSJI0YmGlE6/0hdVBV7vbyFs+1GhJPf9q2s8PVlmhDwQueKTT0q9BoYrIsuR27lO7fQP/
	lxv70x1CwJAN9mTbJUjuVNo6X4bxVC6oEfr4NwJxkemvmmiwd6sbrftNYWqznsAB/U92yz2SN3w
	JLKeZKT2/GBMtkN3/DZtjbQ9DkPP1yKS0cI0RLqgkoKmUq4pX99A+XDZHB//qXmJS98kFIOS41E
	2hZrk2dCktHM9iV1OQmUssVZ02uGFbi5q62WLJmcFl4ThHHV6Qw41Nx+iKmydD7mGi35YM2Q0u2
	ZXdp1lelPQFpC5NE+YkAHGTCfsN1M+xJlO473XPcXYvNAL4g2JMtVJtP537MfJIJb7LmQ3ahIAV
	HVWfVc1q6AHXJ0Ywugrp65zm8Xl3wsrHy9ry2SqYFr+JlM+gQJz
X-Received: by 2002:a05:600c:4e8f:b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fe66d062bmr53610055e9.7.1790267192082;
        Thu, 24 Sep 2026 09:26:32 -0700 (PDT)
Received: from ptb-02009389.paris.inria.fr (wifi-pro-83-031.paris.inria.fr. [128.93.83.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe2730da9sm72242425e9.4.2026.09.24.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:26:30 -0700 (PDT)
From: Ella Ma <alansnape3058@gmail.com>
To: Julia.Lawall@inria.fr,
	nicolas.palix@imag.fr
Cc: alansnape3058@gmail.com,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Thu, 24 Sep 2026 18:25:22 +0200
Message-Id: <20260924162522.912050-1-alansnape3058@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831134336.45540-1-alansnape3058@gmail.com>
References: <20260831134336.45540-1-alansnape3058@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Ella Ma <alansnape3058@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3744
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/o1aafTPfR4BAGaSEnMUI-g>

Using __cleanup(kfree) will pass the stack address of the annotated
local variable to kfree functions. This will lead to invalid
deallocation issues. Inspired by CVE-2026-45959 and similar bugs
recently detected.

Signed-off-by: Ella Ma <alansnape3058@gmail.com>
---

Changes in v2:
- Add virtual rules `report` and `org` as suggested by Sashiko
- Remove `kvfree_sensitive` from rule `cleanup` as suggested by Sashiko
- Add `free_percpu` to rule `free`
- Add `kfree_const` to rule `cleanup`

Currently, the five functions in the `free` rule are all the functions
of `void (*)(const? void *)` type with a `DEFINE_FREE` definition in the
code base. So I adopted all of them.
Function `kfree_const` is added as it is of the kfree family and used
more frequently than other kfree-family functions (even more frequently
than some of those having a `DEFINE_FREE` definition).
https://elixir.bootlin.com/linux/v7.3-rc3/A/ident/kfree_const
(found in 64 files in v7.3-rc3).

This cocci script can report the bug fixed in
https://lore.kernel.org/lkml/20260617142632.3298984-1-vulab@iscas.ac.cn/

 scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 scripts/coccinelle/free/cleanup-free.cocci

diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
new file mode 100644
index 000000000000..63216ec5d865
--- /dev/null
+++ b/scripts/coccinelle/free/cleanup-free.cocci
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find __cleanup(kfree)
+/// Using __cleanup(kfree) will pass the stack address of the annotated
+/// local variable to kfree, causing an invalid free.
+/// I.e., `T v __cleanup(kfree);` --> `kfree(&v);`
+/// Such usage is impossible to be correct.
+///
+// Confidence: High
+// Copyright: (C) 2026 Ella Ma
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+// Suggesting using __free for the functions with a DEFINE_FREE definition.
+// Update this list when new DEFINE_FREE definitions are added.
+@free@
+attribute name __cleanup;
+symbol kfree, kfree_sensitive, kvfree, kvfree_atomic, free_percpu;
+type T;
+identifier v, n;
+position p;
+@@
+
+(
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
+)
+)
+  );
+|
+  T v __cleanup@p(
+(
+  n
+&
+(
+  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
+)
+)
+  ) = ...;
+)
+
+@script:python depends on report@
+p << free.p;
+n << free.n;
+@@
+
+coccilib.report.print_report(
+  p[0], f"ERROR: found `__cleanup({n})', do you mean `__free({n})'?")
+
+@script:python depends on org@
+p << free.p;
+n << free.n;
+@@
+
+coccilib.org.print_todo(
+  p[0], f"ERROR: found `__cleanup({n})', do you mean `__free({n})'?")
+
+
+// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
+// The following list only contains frequently used functions. Supplement it if
+// necessary.
+@cleanup@
+attribute name __cleanup;
+symbol vfree, vfree_atomic, kfree_const;
+type T;
+identifier v, n;
+position p;
+@@
+
+(
+  T v __cleanup@p(
+(
+  n
+&
+(
+  vfree \| vfree_atomic \| kfree_const
+)
+)
+  );
+|
+  T v __cleanup@p(
+(
+  n
+&
+(
+  vfree \| vfree_atomic \| kfree_const
+)
+)
+  ) = ...;
+)
+
+@script:python depends on report@
+p << cleanup.p;
+n << cleanup.n;
+@@
+
+coccilib.report.print_report(
+  p[0], f"ERROR: `__cleanup({n})' will free the annotated variable, rather than its pointee")
+
+@script:python depends on org@
+p << cleanup.p;
+n << cleanup.n;
+@@
+
+coccilib.org.print_todo(
+  p[0], f"ERROR: `__cleanup({n})' will free the annotated variable, rather than its pointee")
-- 
2.34.1

