Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D36C88E73
	for <cocci@archiver.kernel.org>; Tue, 15 Sep 2026 08:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=nbKMiLOc33crfrU5bcQxom00qh7LV3rqb/B4HYkvqSE=;
  b=W5ZpPbFLblW0nQqPL9SZmblBH9PcGuptMhrvI2GrnvjN8NR733PXvSzN
   3yGcSEJtvRb8wcr9XoOQuKrFH/KnifCok/+JUGPd9G22FUTfs+7PZRnh5
   s2s/fcn9o7E7LJ/nt3hjGXEyRmzbbUkGYkGektXkKhXt++GGCYpBjfs36
   E=;
X-CSE-ConnectionGUID: SFvYoLtsSI20J3D2CcOA/g==
X-CSE-MsgGUID: 0JsTEe5eQfWjXLmh6rIHHQ==
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
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="294998362"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Sep 2026 10:45:49 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E11BF826F8; Tue, 15 Sep 2026 10:45:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C56CE8050C
	for <cocci@sympa.inria.fr>; Mon, 14 Sep 2026 17:12:09 +0200 (CEST)
X-CSE-ConnectionGUID: k5BCpl//Q2GB37dcOt7XOw==
X-CSE-MsgGUID: VQaOcHLjRJm/rmVyWN5ZEg==
IronPort-SDR: 6aa80ec9_Q8DeT/KtLkkpEt/WVrNrQioapz/bUmSHL+/e9sb7F5cYVeO
 YYATb/ItVCnhvbe+qUoauC3zJ/7+q6nrlE72knQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GuCAAWDqhqfIzkfUpaHgEBCxIMggULAoI/gQtkMARUj?=
 =?us-ascii?q?VKEZoQTi3yMRIVeFIErPQIPAQMBCwEBPRQEAQEBAgMBNwEPhDeOCAIeBwEEM?=
 =?us-ascii?q?AkOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHD?=
 =?us-ascii?q?hIphk8NSQFLhkWCNAGCCwGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQECLD8BITYBDQEbHQEDEhBbAhEBBQEiARKDA?=
 =?us-ascii?q?gGCIgEGEAEDNwMDDrk/jQcFAhaBAYINBoJr2AAKGSgNcgOBZgICAQYJAQoBA?=
 =?us-ascii?q?YE3hHgqTw6CPwGFIoE6glVpgSGCKIEVg2mCH4FnUoYwBIMulBEBBwcfEggBH?=
 =?us-ascii?q?AYIAgJIFRIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCD?=
 =?us-ascii?q?BQKKCISKwoDKgsSDwMYFQEIBgICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DA?=
 =?us-ascii?q?QMZCAkIAgsFERgMCwcxAxAJAx8DFBYIRQgGFgEaBgUGCzcVBQwRAQIbAh8EH?=
 =?us-ascii?q?REIAwEbBAIBBwIDBBYEAhQKIQMDAgMFAQMDAwUCAgoGBwEBAQMCAggDBgMKC?=
 =?us-ascii?q?QIFAxsYBAECAgMCAQIIAwcIAw0DBAIDAwMEAQICAQEBAgMBAwMEAwEDAwIBA?=
 =?us-ascii?q?wcCAgMDAwsBAgMDBQMDBQUCAgUFAwUCAgoCAwMDAgEDAhoIAwYDEgEQAwMGA?=
 =?us-ascii?q?QMHAwcCBAMJAggDAwgIAxcDAwUBAgIEAwMICAQDAwQCAgMMBQMCAwMFAwMHA?=
 =?us-ascii?q?gQCBAMDAQUBAgcCAwcCARgDAgQIBwcFAgsEAggEDQkEAgQCAg8EBgMDBwEBA?=
 =?us-ascii?q?gEHBQYDAgIQAQgKBQYCAgIcAx0BAw8GAQkFAgEFDgcFAgIYAwYCAwYFAQMBC?=
 =?us-ascii?q?gsBAQIDCgECBAIFAwMBAwIDAgYDAwIFBQUDCQcFDgkBAwMGBQICAwIDAQIIB?=
 =?us-ascii?q?AYFAwICAwUBBAMEAwoDAggDAwgDDAIaAgUDAwMGCQMHBwIDBwMCBQIHBQMDB?=
 =?us-ascii?q?QMGAQMCAQMDCAsVIgMBBQMDAgEDAgUDAxgCAgQFAwMDAwMIBAICAQcGBAICA?=
 =?us-ascii?q?gEFBQUEBQYCBAMIAQEFAwMKDQECBwwDDAYDBwMDBAQDAgUKAgQBBwYHBwkHA?=
 =?us-ascii?q?wIDCAEBCwQBAwMKAwMFAgEBBwUDBgMHAgMDAwUEBQMCCwMHAgIDAwMCKQEBA?=
 =?us-ascii?q?QMDAwMDBAMBAwEDAwcDBQMCDgIIAQoDAgYDBwYDBQMDAgECAwMFEQMGBAUGG?=
 =?us-ascii?q?QIGEToBCAIDAwEUBAQFBQIFFQIIAQMDBQMDAwMCBQMBBQEBAwMFAwMDAwMDB?=
 =?us-ascii?q?AEDBAIDBwYGCwkIBwwBPAwHCiQEBAwqARUUBQQlGWcHB48QH4JdgQ4sgX6BU?=
 =?us-ascii?q?AGSHAuySjQzCgYBgkmBCk6BZoo8jz6FfBozl1OTGQEuh2aQdCONZ4QJkhA3h?=
 =?us-ascii?q?D4CCgcHESQSgTI6gVwzGiOBAW2BSVADGQ+OIoQCgT7KW3kCOwIHAgcOAwuKU?=
 =?us-ascii?q?4dJgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ibaRgqjbnqRYUAdPf3XpdjqtX161lhQKZh0ujC45NGQN5FlHY01je
 htvCG2EPfjeZ2fzLdAkboq3pk8CsMfRx4U1GgU+qyFnRn8W8JqUDtmwEBvMMnLJJKUvbmo3t
 pREMoGowOMcFyKH+E/1atANiVEmiMlkk5KlULas1hhZHFEiEGF9z0o6xYbVu6Yw6fChGQSBp
 NjulMPWPV6hylZcP3kdg065gEoHUM/a5nVC4TTSWdgR5AWAzyhMUMpFTU2MByKQrrd8TrbSq
 9nrl+nRElPxp38FFt6jm7DnRUwGKpa6FRSOkHdfR5+5iRFEoCEouo5jXBbLQRo/Z52hxrid+
 f0V3XCCYV5B0p7kwYzxZyJl/xRWYcWqzpeXeCnl6ZT7I3ruKBMAy902ZK0/0BZxFuxfWQmi/
 tRBQNwBg4zqa0tbD9tXR8E17vnPIvUHM6sc51tL1TWeSs98brqYHKnBwsMH7BAv05Um8fb2P
 6L1aBJqZRXEJhBNYBIZUch4k+CviX3yNTZfrTp5p4Jovy6KllE3iuK9doOJIrRmRu0N9qqcj
 mDB5GTkC1cRLtuR1SHc2n2pj+7L2yj8Xer+EZXip6I60AbPlzJ75Bs+a2KyhvKZrkyEedcYM
 Ukq6xUI8Jof+xn+JjX6d0bl+Sbb70B0t8BrO+Y94wqM4rHF5h6QQGkCVD9ILtI83PLaXhQv3
 16N2t7rX3lh6efTRnWa+bOZ6zi1PED5MFPuewcHECEu+92k57hpoTiUEdpoN7LqvvrqTGSYL
 y+xkMQou1kEYSc2O0iT+FnGh3ehpMKMQFdvoArQWW2h40VyY4vNi22UBbrzsqcowGWxFwfpU
 J04dy62srFm4XalynXlfQn1NOv1j8tpyRWF6bKVI3Xey9hd0yX+JNgPsW8WyLZBPcEDdjvkK
 E7VskU52aK/yECCNPctC6roU5pC5fG5SbzNCKqIBvIQOcMZXFHcrElTibu4hTyFfL4Ey/xnY
 c/znAfFJSpyNJmLOxLtGLlBi+dyl3xmrY4RLLiipymaPXOlTCb9Yd843JGmNIjVNYvd+FiFo
 eVMfdCH0QteW+DYayzau9xbZ1MTIHRxQdi8p8VLf6TRakBrCUMwOc/3mLkBQo1Cm7gKt+Hq+
 nrmZFRU5mCijlL6KCKLSEtZVpXRYbhFo0kWAwkQLHez+n16YY+Q/KYVLJQ2Wr889d1c9/1/T
 thbWsDZAv1wVSj1xDMMSabMvKljKRKh31OINQWYfQllLoJBRhPIyPDgbADA5CkDNQvplMoc8
 pmL9BLXfooHfCtmVP3pUfOIy0igm0QdlMZZfVr6EvMKdGrCqIFVejHM1NkpKMQyGDD/7zq91
 TfOJywHpOPI8rQHwPOQiY+q946WQvZDRGxEFGzm7JGzBynQ3kyn5aRiCO+oXzTsZFnYyZWYR
 9d+7q/DaaUcvVNwrYBDPa5hzvs+6/vRtrZq9FlYM0uRXWu7KIFLAyeg5tZOhJ1v17UCmAqRW
 2CzwPd4F4iNGvvYFA82GFJ4QMWFjeoZixvD38QTeU/a3hJ6zJCDcEdVPiSPthBjEatIANsl7
 Nol6eEr6F2Zqxs1M9y5oDhe2EaSI1chDag2lJEoL7X6qwgsy1hHMI7VKhH2xJSpet8WABEhM
 BG9tvCbh71j2VfzKSsvNHnS3NhygYYFlwBKwWQjeXWKgsTO3P9u7SZ73T8yHwFZ7jBG3dlsO
 2NtCVZHGKWW8xpsh+lBR2qJGTwdIDGooWvK1EovlkDCaluBD1z2M2w2PNiS8HAj825zeiZR+
 Jeawj3HVQnGUd7Q3Cwgf1xMsN3mEMJM8zPdlPCdH8iqG4cwZRzniPSMYUsKsx7WPtMjtnbYp
 OVF/PdCVoOjDHQ++5YEMoi90agcbDumJ2YYGPFow/4vLFHmITq33WCDFlC1dsZzPMf1yE6fC
 fF1B8dxRh+7hTevrDcaOPY2GIVKvsUVvfgMRrC6AlQ9keq7jiFou5fu5CTBlDcVY9Fxo/0cd
 KLVVRy/S1K1u1UFtVPJnsd+PkiAXeIlfyz5heC8z/UIHckMscZqakAD7YG3tHS0bipi5wyf5
 gOaVpSLzednmIFgv678K4pPGzSLLcjXUcKW+juSqPVLV8vEau3VhjMWq37mHgVYBqQQUNJJj
 oawsMb78UfGnbQuWUXbpsWlO5gSwv6tTcxVH9nSPlADrRCdWcTp3QQPy1q4JbNNjtlZwMutH
 Cm8V+edav8XXMV71lROSi0DDSsYNbv7Xp3gqQy5sf6ILBoXii7DDdG/8E7WfXNpTTAJN7L+G
 z3Lla6XvP4Al7t1BTgAG/1CKL17KgW6WaIZKvvAhQPBBWys2l6/qr/ukCQ70g7yC16GLd3b5
 KzUTR2vZTWwv6D1lOtiibJQhSFOLnhBgrgXRHk/qu5G02XwSCZMKOkGKpwJB61FiiG4htmye
 DjJa3BkEinnGyhNdRLn+tn4QwODHao0N8zkIiAytVahA8ts6Fhs3JM6nsuh35t3Rtcn5OSuK
 NVb93+qexbomNdmQuEc4vH9iuBirh8fKrTk5mil+/EewT5HaVnJ6JClNAVIXC3DVcrKkS0n4
 EArEHtcThjTpVHZSK5dlr08JP3dlDzqxjQsKyyIxb4zfmldIPJokJXCBg047lHPgAnm6lLDq
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:alZFSqOfeDayV8BcThKjsMiBIKoaSvp037BZ7TEKdfU1SL3gqy
 nKpp4mPHDP+VIssO9Jo6H8BEDtewK+yXcX2/h2AV7BZniAhILAFugLhuvfKlXbehEWndQtsJ
 uIBpIOc+EYY2IK7/oTlWKDYqodKJDtytHWuc7ui1loCS9lApsO0+67MGqm+49NKTWufaBJbK
 Z0L/Aomwad
X-Talos-CUID: 9a23:SEWmb2F7ZKOcl9KSqmJkqWQ/AsRiNUSH412LfEOzLno2eJqKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Ayg3K5w1mcInbetA0awZdz84DgDUj3Z2nL0sttZc?=
 =?us-ascii?q?8mczDLylOKgi70QaaTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="294883496"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDF2P1+aAxJUaaxxtpYJf90AVGbam9NDKyGU+I?=
 =?us-ascii?q?7n+q2k8XJ6TAhSC0sf1as+npI4zeV+pSjsLLZhaW5PeCeoh5AF8IKCAb?=
 =?us-ascii?q?jTu0e5/tyKsrpOjExVjkrleypvsrHByILAPUs5CZ635Y2Z4alKGdjB7Q?=
 =?us-ascii?q?zDg9jcFODcMZrpq/JsSRMDZw=3D=3D?=
Received: from mail-ej2-f12.google.com ([74.125.228.140])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 17:12:09 +0200
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so362123466b.2
        for <cocci@inria.fr>; Mon, 14 Sep 2026 08:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789398729; x=1790003529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbKMiLOc33crfrU5bcQxom00qh7LV3rqb/B4HYkvqSE=;
        b=P71F6wT9v2oh7RRNO1KJL4ZlaPgCUIJBCvCx8QHUEmiyzNKnNg8WOvT7KxtbOL33LB
         2yqTxslueXEFyIQRWrWPhtPECoVlL7o/2WE+KOFmHDpJ+mwWz3K+iA6qpgPIM2Ybga2K
         lX46htdzhhvWsIWdMT8HDriYlAr7jMohTtvpD6nnjUSnQ9bizu1ERw5WbMR/y8mAQHM0
         yyV0S7Edtw0hdlvG+8vVnHGgNJOz1MVfVxhlhv6aaAePcBbJf9ln7cGlGTUV1qyPMWki
         Y+uKNv5o4t6AE/a7TVnQvW3CP3ag/+Uh4R9DqULHThEowEnTD7wiqLMgJNYlLrnvzm5E
         SN9A==
X-Forwarded-Encrypted: i=1; AKwUvBweEs5ABpC+VwEKxFOpKQt191OGV4AdeBDUqgyNVdX4fSfcbj1qqPbcD992YpNlTaxB68MJeA==@inria.fr
X-Gm-Message-State: AFuF++lVk1ynjQ9w102EI3uQiUNLh2VEDUMT1gWOGt6Er56oidX/MqHX
	BvMlL0dveRmmZRumHoM/Df9EgWV3JhjBPBvzEAnh6dPfAPaPHaVgTdGL/G3GgCK1Ij4=
X-Gm-Gg: AYBFou3RHd2uosIeR8cwtjoexPbK5+uFAs421eJ64HFatza6FY+47GY7nQd70GuNb7t
	lFZ7pJNWtN9nCZoFVV/Q4Y9Dx9vEAh1MLypqO6MwbSrsOK9kWc0Jq28abMwAo3syPmnxRSBa1hw
	VenBnwi8+s8pKBeVgv0mz7HpTUU4MiEqspPcLfkex+0gAWRwL7kCBb/fE9Aof57FzLIepwtqjXF
	HiNxIS+kZe5BT7TeHtkgJWbopTVvndsvZiTG+S73ceKm8Ud68fY+CntHqqZ4NiUIXh0YntoFXEf
	R8aBENjgwd+BoS3GMw2KyUiF2QBi9Bc4S85czJHuJAOjb7pcmAMScThhHLYySqDGrTTPHvSJMV2
	aFtUR62TSNPVJtXFVNEnm6ojsy3Zu4mZ4ZhZQBmCHC47Fifee9UPkTSSlM4vEkc0rmpY0mDY4Rf
	yX6ubn609hV84c50SmdXCnUgTOY2rbcJiwZ103apC2nKshjCZtfP9S69CASABSxCz9HJ7KKv91i
	fCKGDhReRrZcE4woC2F5YzQafYjQ5xHF3M/QfkDuHQta9z94ftk6G/YWlf7qe510szAG4BZd3E2
	qkauQd2izbFpn9C2xOiSRCoc5FrJ61M4G2X5yR/xDj7MKtwCTPLWNRS5KGjR+cug2HoqalCr+mO
	04iAa1qBqnZYmBNVRFDHUVsKNmqpQMuCXFghrukZf4A7GcGxFdPH3eqshdFdsbsV0wQQwhR4Hmz
	NbQaJHdhJjWTCYG57uU+G8B1dtfPv65pR8QyXII0HxbB4aobQaLOPr75a9G2Sl7rdO0iMQq1N7a
	V8JKpLZoYP9pOrb
X-Received: by 2002:a17:906:6a04:b0:c29:6de8:d143 with SMTP id a640c23a62f3a-c29b865bb71mr195478066b.19.1789398728795;
        Mon, 14 Sep 2026 08:12:08 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (196.177.12.34.bc.googleusercontent.com. [34.12.177.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660654f2sm446317666b.28.2026.09.14.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:12:08 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 14 Sep 2026 15:11:45 +0000
Message-ID: <20260914151145.1328-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3731
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/XVj_sqkIbzcupBi92kFoDg>

Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
called in a file if pm_runtime_use_autosuspend() is called and its
devm_* counterpart isn't present.

Without _dont_use_autosuspend(), removing devices causes resource leaks.

Assisted-by: LLM
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 scripts/coccinelle/api/pm_autosuspend.cocci | 62 +++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 scripts/coccinelle/api/pm_autosuspend.cocci

diff --git a/scripts/coccinelle/api/pm_autosuspend.cocci b/scripts/coccinelle/api/pm_autosuspend.cocci
new file mode 100644
index 000000000000..2354396d9344
--- /dev/null
+++ b/scripts/coccinelle/api/pm_autosuspend.cocci
@@ -0,0 +1,62 @@
+//SPDX-License-Identifier: GPL-2.0-only
+//
+// Confidence: High
+// Copyright: (C) 2026 Joshua Crofts
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --no-includes
+
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+// Detection
+//----------------------------------------------------------
+
+@has_use@
+expression dev;
+position p;
+@@
+
+pm_runtime_use_autosuspend@p(dev);
+
+@has_dont@
+expression dev;
+@@
+
+pm_runtime_dont_use_autosuspend(dev)
+
+@has_devm@
+expression dev;
+@@
+
+devm_pm_runtime_enable(dev)
+
+//----------------------------------------------------------
+// Context mode
+//----------------------------------------------------------
+
+@depends on context && has_use && !has_dont && !has_devm@
+expression dev;
+position has_use.p;
+@@
+
+* pm_runtime_use_autosuspend@p(dev)
+
+//----------------------------------------------------------
+// Org and report mode
+//----------------------------------------------------------
+
+@script:python depends on org && has_use && !has_dont && !has_devm@
+p << has_use.p;
+@@
+
+msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend or devm_pm_runtime_enable()"
+cocci.print_main(msg, p)
+
+@script:python depends on report && has_use && !has_dont && !has_devm@
+p << has_use.p;
+@@
+
+msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend or devm_pm_runtime_enable()"
+coccilib.report.print_report(p[0], msg)
-- 
2.47.3

