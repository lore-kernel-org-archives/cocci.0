Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1681ECAAA1
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=dxTj/I3PUkQUKU/kEBqM8NF/GoWZXbrGUgHxc82WI1l8WGw9V8eu3V6E
   Y+xJRJquwucdtlwEzxd2BHimmYpm65VX8cnJ3oYaGdrTY8f/LDcia3ySk
   Q6M5MaQHVAoMmMFs7Pc6m203MNkhEys9tToxa8hohPupDZ3zkt7+k5fv5
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (body hash did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="51289173"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 11:03:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79285E779C; Mon,  5 Sep 2022 11:03:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 06388E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 11:03:42 +0200 (CEST)
IronPort-SDR: wIlcmlWxzTsJJBZnkFny/xcSr3Z3WqsFWeUwxfyeUnfWDUjPhuqpArEkZM3tUZkNYRvtZWKMz9
 eR5FlBXaz0I7exVDY2or8EM8ZkyFsxVwXN9INyLDXFWjNL6kchM1ptpo094Ptl4RMKarpVu2UJ
 1gfUBNNstxwjSAgy++6X5A8XCxbAU9YVDx3xQ7mkPOcj4KuyR2wiNI7oq/ZkXzapYAqjLg8J67
 BpcF7mKMpY+K18N+mX4Q33L2KaHGpeEpa54av/UnE26aU/7zAiPxWPK6qlCFhFkaHwoM6J2QE8
 ss8OlC1XYH1GeVNg4/eS5Arl
X-IPAS-Result: =?us-ascii?q?A0BidQDkuhVjfzHdVdFahHx/WC4EUIYZhzOFbYJ9imSBB?=
 =?us-ascii?q?oYajBUTCwEDAQwBQAIEAQFyhBQnhEACHQcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBGAkZBw4OBWABYQMBRIFPgU8lCwMxDYI1DAwDh?=
 =?us-ascii?q?AsgAQ0BDA8eAxIQXhEBBQEQBgICPYJbgm0BAzADBJsygQRCjEcFF4EBggkGg?=
 =?us-ascii?q?h5DgW4KGSgNZwOBWQIHCQEIgSuKbYQ4gSEcgUlEiVY4hW4ElyEEBSMDAwIsB?=
 =?us-ascii?q?AcFSgIJAyMRDhAIBw0BOgYGBQEBDAIBBAEFAwEEBQMJAQUGAgkDAwkDAQEFA?=
 =?us-ascii?q?QMEAwMDAgcDAQIMBAgDAwIDBAICAgIBAwIHBQgEAgcCAgIBAgIGAgEDCQECA?=
 =?us-ascii?q?wUCAgkLAQQCAgMBAwEBAggECQQCAwQCAQEDAgECAgEFAg4FAQEBAQIFAQIDA?=
 =?us-ascii?q?QYHAggCDg4KAQMDAwICBQICAQIDAg0BAQQCAQIBAgYBAwECAgMBAwECAgMCB?=
 =?us-ascii?q?gkCBAEFAwMCAgMBAQUPBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBA?=
 =?us-ascii?q?gEBIwMEAgMBAxcBAgECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEBwkDAgIEA?=
 =?us-ascii?q?wMFAQECAwIBAQETAgICEgITAwEGAQ4FFAMCBAICAQICCgMBAgIBAwIJAgECA?=
 =?us-ascii?q?QUgAwEBDyQCAgICAgMEBwIBBAYDDQICAQEBBQYNAwIDCA0CBwMCAQMFAgIEA?=
 =?us-ascii?q?QIECgkBAgIBAgQFBwIBCAYFDQUJCwEBAgEDBwQDEQIFAwUFAwMCAQYEBQIDA?=
 =?us-ascii?q?QIBAQMEAQMEBgEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDAwEBAQQCA?=
 =?us-ascii?q?gICAgMDCAMCCAwBBgECAQQDAgIBAgcBBAEIAgEDAwUDBAEKDwMFAwEDAwIUC?=
 =?us-ascii?q?gUBAwgGCQIEBQIFAwIEAgMDAgIIAwIEAwILAwUEAgcTBwIDAgIFAgICAgIFB?=
 =?us-ascii?q?AMBAgICAgICBQIDAgEFAQICAQICAgQBAgIHBAIDAQMEDgQDAgIHAQICAQYCC?=
 =?us-ascii?q?gECAQQDAQEEAgQBAgUCBAEDAQIGAgQDCgIDAgICBggDAwwJAgMFAgQCAgcEA?=
 =?us-ascii?q?gILAQYCBwICAxABAwEEBQUDAwMJAgIDAgQCAgoBAQEBAgIBBQUCBAcPAgICB?=
 =?us-ascii?q?AICAgEDAgIBAQICBQQJEgICAwYEBgUDAggYAQYCAgEBAgIDAwIGAgECCAIEA?=
 =?us-ascii?q?QQFAgECAgICBAEDBgIDAQECAQICAwMCAwIEAwMBAgECAgIDAgICAwICARACB?=
 =?us-ascii?q?gYBAgICAgICAgIBAgYBAgECBAIHAgQDAgECAgUCAgIDAQEGAgQLAQMCBwYBA?=
 =?us-ascii?q?wIHBQIDAQQDBAMDBQYFDAkFBAEhAwICCAIHAgEFAwUBDwMCAgMCAgEECgIDB?=
 =?us-ascii?q?QIEAgEECQcCBAECCQMDBgIHBRgBAgIHBAwKAgICBQYCBAEDAwECAgMDBAIDA?=
 =?us-ascii?q?gQFAQUCAQIFBAICAQECBQIMAQIBBwYCBwMCAgIDAQEDAgECAQMDAgECAQEBA?=
 =?us-ascii?q?wYGBQYEAgMDBgICAgYCAgMCEgMIAgYDAgQBDQ8FBAcIAQIBAQIHAgQCBwkCD?=
 =?us-ascii?q?gIBBgEHAgIDAgIBAwICAQYEBwEDAgICAgICBQgFAwQFAgNN3W9hgnugDhoyg?=
 =?us-ascii?q?2QBkwGSR4tKhCKGZKMRhCcCCgcGECMSgUMjgVtNIxVsgWlNTgECAQEBDQECA?=
 =?us-ascii?q?QEDAQIBAgkBAQKSD4pgPzSGIoUMAg?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:+ifmoaNGTNqVAd/vrR2+kcFynXyQoLVcMsEvi/4bfWQNrUokhT0Gm
 zZLXmCGOP+LZjf8KtB0b4+x8BtSv5OAn9dgHHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EkLd9IR2NYy24DoW1/V4
 rsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2zsOJf7
 5Z2nKe/djcWYovAirg4bjBhRnQW0a1uoNcrIFC6uM2XilLcKj7in6QoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bjvhu7qIgVvrpxLwM3DPp8YuHdp1xnWCP8nRdbIRKCiCdpwhm1g25seQqy2i
 8wxWyIzYC7GfhFzFEo1Grg7vcKajHDRWmgNwL6SjfNvvzK7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjaiz2L/SawDuBt22236rBwXK9V4UVG7m1sPVthTV/21D/FjUsemmVhrqCo3WxZOJgd
 2oY6HYLkIELoRnDosbGYzW0p3uNvxg5UtVWEvEn5Azl9kYyy1bJboTjZm4RAOHKpPPaVhRxi
 QDUx4KB6ShH9ezKGSjEp994uBvrYXBNRVLucxPoWufs3jUOiIQ6jxaKUcw6VaDp35v6Hjb/x
 z3Mpy8771nysSLp//Thlbwkq2j0znQscuLTzluMNo5Cxl0jDLNJn6TytTDmAQ9ode51tGWps
 nkegNS55+sTF5yLnyHlaLxTQuvyvqjfam2G3wIH83wdG9KFqy7LkWd4sGEWGauVGptslcLBO
 xKL4VsMvPe/wlPzNPcqOupd9PjGPYC5TYi/PhwlRtVJZZd1eWe6ENJGNCatM5TWuBF0y8kXY
 M/FGe71VCpyIfk5kVKeGrhFuZd1nHxW7T2IHvjTkU/3uYdykVbPFt/pxnPVPr5nhE5FyS2Jm
 +ti2zyikkQPDb2hPnaJrub+7zkidBAGOHw/kOQPHsbrH+asMDhJ5yb5zexzdop7sb5Sk+uUr
 HixVlUJmlX6jHzDbw6Nbyk7Or/oWJ9+q1M9PDAtbQ74gSh9Pd734fdNbYYzcJkm6Pdnkqx5Q
 vwDTMOKXaZCRzHBzDICYMSvt4dlbhmq2VmDMnP9MjgydpJtXSLT/drgcle9/SUCFHvlus43o
 rnm3QTeGMJRSwNnBcfQSfSu01Lh5ShHyLwuBxPFe4ABdl/t/Y5mLz3KosU2e8xcew/ewja61
 hqNBUhKqOTIpbgz+oabiK2BqbCvDLIiTEdXGm/s7YG2OzPfyWytzNISS+2PZz3cCDr59aj+N
 +VYy/bwbK8OkFpQ6dEuFr9qyech/YKqqeMLiAtjG3rPYhKgDbY5eiuK2sxGt6tswL5FuFvpB
 hjepIECYbjZatn4FFMxJRY+arjR3/8jnDSPv+8+J1/35XMq8bfbA19eOQKA1H5UILdvath3x
 O4gvIsJ8VX6hEZ7dNmBiS9Q+iKHKXlZC/crsZQTAYnKjAs3ywEdPcaNVHeuuJzfOc9RNkQKI
 yOPgPaQjbprwEefIWE4EmLA3LYAiJkD0PyQIITu+7hUdhv5av4LMNl59D02SkFK1EwC3b4if
 GdsMEJxKOOF+DIAaA2vmYyzM1kpOfFb0hWZJ5g1eKnxQEyhV2iLJ2o4UQpI1F5M6HpSJ1C34
 5nBoFsIkl/WkAXZ0S47WEojoPvmJTC0Gssuh+j/d/m481IGjfYJT0Ngiafka/cqPC/puHD6m
 A==
IronPort-HdrOrdr: A9a23:tpad7qmOvw/XAteWLU2lOZU3uRDpDfIX3DAbv31ZSRFFG/Fw8P
 re5MjzsCWftN9/YgBFpTntAtjifZq+z+8N3WBuB8bEYOCOggLBR+FfBOPZogEIcBeOk9K1u5
 0QEZSWy+edMbG5t6vHCcWDfOrIuOP3lpxATN2x80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="22853872"
X-MGA-submission: =?us-ascii?q?MDECH85gWCTH2mh0oEGZcgnUl/knq3GHXBMaBC?=
 =?us-ascii?q?up6cxCTW+JHp/rRkP6+PSn6U/mGhLThyF2vxDA3qwfUfzMMxQVcFT8p2?=
 =?us-ascii?q?Nj0TQTfklsFpWzfu6o90NU8h/4DGFk8m09Qn46/rzGmKs/sFKtceTpqQ?=
 =?us-ascii?q?45pPr3Hwc0XNzmFa5BlqIt+w=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:03:41 +0200
Received: by mail-wr1-f49.google.com with SMTP id k9so10454944wri.0
        for <cocci@inria.fr>; Mon, 05 Sep 2022 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=jSl08FOstiUP7sA3XSzQu4LQ579ilrB04AII2EIwuDyUDDpTGQpk/kQmxDylkGvpYO
         6m1O+ZDxsQiWO2GEpmC8UP6OxkDDIeIntn9Rbj5sPH+kvNSftAt8WXbgDE+orunQpI6l
         EfB1cffH/dvGB8MB71Vo+G7Cn2cbZhpAC7og6Bh+HuJdNcluTpVDO8qXuK+o1TkltMbd
         dFCJzxXbFx0nDpgWdXAxhaAYzDxZgBIxLcwZgcc0Pf6HNtBfwiRZ/bq/EkRpjVYqfjS+
         2eLGSOmTqjzddK6ioOLPzDKKRV5qrk1Jtysunnx7Sh9FC6AzsQq9nRjsWgM+ZmCiUAyy
         r0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pTgYG+lq3r3RMS5b2B9nYxrGah+m5l/vea1Ne3HM0vuSrWPHF3vGdIru4QEeXkJwfb
         S1rZGBpVkfk6WzLwT2Jwlj1i7gF/8GQYNH0X2ybjqgHIji+RulPigsgXIHu0VDxHIntD
         OD2mUjRYO+I30kI+FHPP7H2dfzO/vWloPk1Jy8PfeGW3vYAX9df9/KiSRr3xCsI2easw
         R7CZBg6zLYRQIv614BFIfB3xMw5nP7IcZe2nDpxUDFrBjQW/DLQdRExjU4IrtDfLuEdS
         5mWq8f/16zyoWVUQLoHP6TL4tpz6pO83SXbNVb4weBYkxac5n5Wjp1iBu8IXOswZ4cvI
         NaDA==
X-Gm-Message-State: ACgBeo0xJZosyfYkr5fly0k62amobvBxQXm3bH7E1iKt0j7ykoqCK4Fi
	WZHEO42YuXZ4LxivZMslAKm51+lhkLE=
X-Google-Smtp-Source: AA6agR4D8lQzDfEJQG8714aLTjpRDc6xfzMWk7Esh8gtpV/AEBh0pMJiyW+8mTGLv7a09a9ININgng==
X-Received: by 2002:adf:f44c:0:b0:228:8686:552f with SMTP id f12-20020adff44c000000b002288686552fmr2149478wrp.587.1662368620663;
        Mon, 05 Sep 2022 02:03:40 -0700 (PDT)
Received: from theo.localdomain (ip-89-177-215-237.bb.vodafone.cz. [89.177.215.237])
        by smtp.gmail.com with ESMTPSA id bk16-20020a0560001d9000b002258235bda3sm8262760wrb.61.2022.09.05.02.03.39
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:03:40 -0700 (PDT)
From: Jan Tojnar <jtojnar@gmail.com>
To: cocci@inria.fr
Date: Mon,  5 Sep 2022 11:02:32 +0200
Message-Id: <20220905090231.3568609-1-jtojnar@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] 
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 538
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220905090231.3568609-1-jtojnar%40gmail.com>


