Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F493C53213
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4ythMD/8HygMBBur9HX2jCV0xO6Blk6zNXYU5eF8R0o=;
  b=Aubyf1mJyj4wrtqZCcjV4GeMVTIOiCWSLgEcy3pv/yiZX4lrzqYgDSHV
   bCZWX4tzGiZWO/PNwLKxzKFSI9eFBjsxbF9dRM5FNUwLEmNIWB0Jt2CPI
   wwzi9h37h0Y1SiCV02WXIFMamCt6X6f5ahtm53rOPA8dHFCAxcHXOVvcp
   Y=;
X-CSE-ConnectionGUID: qEbRWnTSQo2X9v4e8TOy5A==
X-CSE-MsgGUID: rlnokmTfTQC1iTVbN7C8UA==
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
   d="scan'208";a="287733049"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:53 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8877E803D0; Fri, 24 Jul 2026 10:53:53 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9963881964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:04 +0200 (CEST)
X-CSE-ConnectionGUID: 07xE8nKeT2i4V+TxyWvkeQ==
X-CSE-MsgGUID: 6DKuA1SOSgKPiZcSgSxpWg==
IronPort-SDR: 6a62616b_IjhIErbwiLqKOX8ygdgfk6opi3mR8ZPrqWi/psucsu88z2Q
 AR1CSyQ1Wl5yYXCj6CFIe+tv9DrQAa+DvRV+C1g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HFBABZYGJqfDLYVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKSIoE/PQIPAQMBCwEBTwIEAQEBAgQ4hEYCjWACHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPDUkBEAEEA?=
 =?us-ascii?q?QGCAQGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsXwIBAxIVCwENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQow8FgUCFoEBgg0G2mgKGSgNdYFjAQICBwkBCgEBgTcBhHcqXQOCO?=
 =?us-ascii?q?oUjdYQCeieBGIEQhH6CH4I5hjAEgy6SKgEHBx8SCAEcBggCAkgVEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICKQoDIAoLE?=
 =?us-ascii?q?g8DDQYFFQEBBwYCAgMBBAIEDAIJAgIFAwEDAgQGBAMDBAEBCAICLQMBAxkIC?=
 =?us-ascii?q?QgCCwURGAwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdE?=
 =?us-ascii?q?QgDARgEAgICAQsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCA?=
 =?us-ascii?q?gIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKB?=
 =?us-ascii?q?gkBAQEBAwICCAMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECA?=
 =?us-ascii?q?gEBAQIDAQMDBAMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICC?=
 =?us-ascii?q?gIDAwMCAQMCHAMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDA?=
 =?us-ascii?q?wMDBQECAgIDBQMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDA?=
 =?us-ascii?q?wUBAgcCAwcCAQsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBA?=
 =?us-ascii?q?QIBAggFBgMCAhEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFB?=
 =?us-ascii?q?QEDAQoBCwEBAgMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDA?=
 =?us-ascii?q?wMEAwUFAwIFAgQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDB?=
 =?us-ascii?q?AIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDC?=
 =?us-ascii?q?wICAyECBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMIC?=
 =?us-ascii?q?xgDCwkIBwwBPAwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgkABgQ6CKIFRAQEBk?=
 =?us-ascii?q?hIBB5I0oCFJHgkBBgJggWeBChUKL5tfhXwaM5dTkxmZCCORcJJHhD4CCgcHE?=
 =?us-ascii?q?SQSgTI6gVwzGiOBAW2BSVADGQ+OLRaDYMwVNTU+AQcCBw8CgXODdokqgSCBK?=
 =?us-ascii?q?0mBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:aM0xPa+fjF/AEMuV04UpDrUDdXqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 GZMD2iFPv7YNmT1f4okbd/ipB5SvsPTydNnG1Zr+ysxFiIbosfsO4ilIxarNUt+DOWTFRM9t
 512hvrodZ1vECeE/n9BFpC78BGQAInRHuKU5NbsY343HUk4Dn9413qPosZh6qZwm9+1HgiRj
 t37pszbKTeN1iV9Wo4uw/vrRChH4rKo5Vv0gnRkPaoV5ACEzCFFZH4iDfjZw0XQEtE88tGSH
 L6rIIGRpgvx4xorA9W5pbf3GmViaqLSJwWHlk1NUKGkhBVYzgRqukrsHKd0he9/0l1lrvgpo
 Dl/ncXYpTQBZ8UgrN8gvyxwT0mSC4UWoe6deSDXXfu7lCUqe1O0qxln4dpf0Ycwoo6bCkkXn
 RAUxaxkgrluSItazZriItSAiPjPI+GzY5My6ndDwA2DDKoYAqzTUprU5tJhiWJYasBmRZ4yZ
 uIcYDtrKQzCOlhBZw9RB5U5k+OlwHL4dlW0qnrP/ftxszWVllUvluW1WDbWUoTiqcF9k0WWq
 H+cpzyhU0EyO9mWyD7D+XWp7gPKtXmrB9xMSu3lqZaGhnXN6k8OIUQtcmC0gsG4uEWFVOlPM
 3Mbr39GQa8arxHyFoasAXVUukWstRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQNkvtctzXT5zk
 1HUx5XmAjtgtLDTQnWYnluJkd+sEXBKPUJSYwwJcVEEv+egnJEisQzMQ+82RcZZkebJ9SfML
 ydmRRXSap0WhM8Pkr25pBXJ3mrqqZ/OQQo4oA7QWwpJDz+Vhqb8P9TABbvzt64owGOlor+p4
 iJsdy+2srhmMH11vHbRKNjh5Znwjxp/DNEjvbKfN8J8rmzyqiDLkXF47zZ5K0NkescCcnmBX
 XI/TTh5vccJVFPzNfEfS9voV6wCk/K8ffy7Dau8RoQVMvBMmPqvpn0Gibi4hT21yBBEfGBWE
 cvzTPtA+l5DUPk+nGroGrZFuVLprwhnrV7uqVnA50zP+dKjiLS9Fd/p6XPXNr1pvpCX6h7Y6
 chePMaswhBSGr+2KCrO/IJZaRhAIXEnDNqk44ZaZ8ySEDpAQWsBMv72xa9+WopHm68OqPzE0
 EvgUWBlyX3+p0b9FyO0Vl5ZZojCY7NDvFMgHCl1PV+Xy3kpOomuy6EEdqoIR7os9c097PstT
 /A6ZNmLLfNfbgv2ohE2MJ/39t1kfjuWmDPUbjaEYSc+TbFkVQfm6t/pRSqx1SgsXw6cl9oyn
 K2k7SzfGaE8fgVFCN3ETd6e1HazgCQto/1zVE72PdVjQkXg34x0ISjXjPVsAcUzBTjc5zmdj
 SC6PAw5oLTTnooL79X5v6CIgIO3Ge9YHEABPW36766zBBbK7FiY3o5Mf+aZTw/zDFqu1v2ZW
 txU6PXgPNksvlVA6dN8Gok265MO3YLkorsCwzl0GHnOUU+QNYphBXu7xuhKiLxGw+5ImAmxW
 3/XwOJgB5eyBJrHHmISdS0fVcbS8dEPmzLX0+Y5H1Wi2g9z44i8cBtzOzuitXVjCYVbYa0Zx
 dUvgso00zCEqwELN4+Ghx9E9m7XIX0nVb4mh64gA4Tqq1QKz29YU5nuUwr0yY6qR9YQC2YmP
 g6rgLHmgpJCzHHjaFs2L2DGhsBGtKQNuTdL7V4MHEuIkdz7nc0K3AVd3DA0bwZNxDBF7r5XF
 lkwEHZqNIOM0ixNluEab1uzGgpEOgKVynbxx3QNimfdaUuiDU7JE0EQJseP+1I/4UtHXz0G4
 oyd9nnpYQzqcO71wCE2f0xv8N7nbN5p8zz9iNKVJNuEE7Y6cAjarPeXP0RQkCTeAOQ1mEHjj
 stp9rwpaaTEaAghk5diAIyejbktWBSIIVJZes5Y/YQLIHr9fQ+j0j3fOmGzfcJwf8bxy3GaM
 PA3BMxzVEWZ7h2s/xQ7Hq8HJoFmkME5vOQifqzZHk9Ykr+9gAcwjrfu2HnfvkEJTe9qs/4BE
 aLKVjfbEmWvlXpewGDMi89fO1uHW9oPZSyi/eWL6tcMJcsmsshzVG0xjoKbs2mkDw982xeyo
 gn4RrT3ytZ6wt9GhLrcEaRkBieIGOyuUsC18AS56YhBVtbxL83PlVIxgXv2MztGOYA+X4xMq
 o2Ml9rszWX5s60QUWuEv7WgTYxy+teXcNRbFunVPUtqt3KOd+G06iRS5l3iD4JCle1sw/WOR
 iy6TZCVXsEUUdIM/09lQXFSPDhFApumc5q6gz22qsmNLR0v0QbnCteD3l2xZEF5ch44AbHPO
 jXWid2PuO8B9J9tASUaDc5IG5V7eV/veZU3fu3L6AW3MDOavUOgiJDDyzwb9jD5OluVGp3b4
 LXEZCTEWjachaXq9Oxd4qtO5kA5LXAkjecJKxdXv5Y8jj2hF2cJINgMKZhMWNkejiX204q+f
 z3XKncrDSLmRzlfbBHg+5LZUxyCAvAVcMLMTtDzE5h4tw/tbG9BPFdgysuky3J/ez+m1OP+b
 N9Dojv/OR++xpwvTuEWjhB+bSGL2duCrk/kO2ik+yAxP/raKboP3X1lWgFKUEQr1unTwV7TK
 zFdqX9sGSmGpI2YLSqkU3FQERAd+jjoyl3EqMtJLMn34+2m8QGL9BEz1ywfHFHOgATm6YPin
 U/KelY=
IronPort-HdrOrdr: A9a23:nntxL6gm8Dc5zv+BKL6szx+zOHBQXv4ji2hC6mlwRA09TyVXrb
 HKoB19726ItN91YhsdcL+7Sc69qB/nhP1ICMwqTM+ftWrdyRGVxeNZnO3fKlTbckWUltK1l5
 0QCJSWYOeQMbEQt7ef3ODXKadD/PC3tI6twcnRpk0DceioUc1dBsVCZzpzancGPTWuzKBWKK
 ah
X-Talos-CUID: =?us-ascii?q?9a23=3A4dBKkmtR+hyx9wS17YIP19AK6It9LW3wnHHzLnP?=
 =?us-ascii?q?iCDpXC4GFWGCO+65dxp8=3D?=
X-Talos-MUID: 9a23:ko5IJgj5k7uhydIfFkirqcMpautL/o33M2c2nrY+uvuPDiNLKy+ig2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287666857"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFKr8z+ZpNo1Y4wGH01NumoEIawchKma9X6c9?=
 =?us-ascii?q?kwqW5FJRWkV2CWfVPlsfDWjfeEj2tcrJ1m1m+dsuvxOUWcd5CvuEfaI3?=
 =?us-ascii?q?EAqa8l8bTYEVJTIGZQJA/VmXQlHoEf514ieknSu8C/TBIi04fuban+Zl?=
 =?us-ascii?q?Z/7mueYKRp0Ta+TaaXWwd+wg=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:03 +0200
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so689705a91.1
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832362; x=1785437162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ythMD/8HygMBBur9HX2jCV0xO6Blk6zNXYU5eF8R0o=;
        b=l0P21yo3WWJVHOKlM5y03bzmLzv5o/7Gzl3vy2CYvw5WivL0if2Ckhf6DapkSdW5m7
         jkVHcFVGyiUU4CmOdQyRo82BXBmp8bElVAfDC69VhC/18MLt3feuBYlfsguQd75bNpU2
         QzFjK99vrM2a3z8d1wd27mfrZLbO155yerQ27LxCZDcDtJViZD8TSgUVUbEKS7JcyEgL
         QgyNerRrsONBp122Vq0xKArpKTvDMeFP1Mjjg/lqa74rsctWpgS6H/Gt8U5h0TNgQlsc
         L9MYMN9KqjabV5NEyB7Xo43ioETCESN0ES9hAZHBqMCfsKRvmPGw+zGMbBVNkTUhi9Ds
         u/iw==
X-Gm-Message-State: AOJu0Yz1NehWTn79AT46/wWZ0THKmYOieDxlSdxFU3aDZsG9KbNT81Mu
	q6tIgD/ik7/RuFDvKZsITVmYBP03Fe7XVJ8t472SKcwZdtsJCXJsHZVg
X-Gm-Gg: AR+sD10ZIzcMR8QKksZPsitWuPHQY7Grr0XthnkC4IRTKJRpAJwxgXxpWJ4yWgwwEJy
	VHkCrBc3d8jMLMUMJs40ti5ATQUz2/X/YQoVwJFBcZQo9ZvU5gztf1yZdZuhnhJZPETjj770KpH
	M/LEnROX7Ww4hZ2rfpcs5i5TUbFCI0V/nGv1H8jYh3l177Hb9pI9xU6V+u17vO38+T9Gbb3dL+w
	NITsIegfaQln6Ar3UiIxw6ZP9rp1lOf+Adr27ocAq1ZqraLIzVH1UOWmvl3KrSUzcRbTdl98cmo
	UK9IBJrqNaoJDpwG3PeZ9kI5x5zqU2j9PQZojBPO56euqiK6MbXqIM4WtPe8KDh8AVM5CEg/Xk9
	EBIAulTKGODozoL6yf+GuLqsESvcrFJtaBtIh+I5xdq1lzhvSqALs/z6yjulxpp0EGHVR6gof
X-Received: by 2002:a17:90b:524b:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-38ec6461d6dmr4058236a91.16.1784832361816;
        Thu, 23 Jul 2026 11:46:01 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:01 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: cocci@inria.fr,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:05 +0900
Message-ID: <20260723184538.3888637-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 03/36] drm/radeon: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3600
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/4b4fZw_PtWrtWQ6RGDKwGg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c |  6 +-----
 drivers/gpu/drm/radeon/kv_dpm.c | 30 ++++++++++--------------------
 drivers/gpu/drm/radeon/si_dpm.c | 14 ++------------
 3 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 703848fac189..11707f5aaa6b 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5244,11 +5244,7 @@ static int ci_set_temperature_range(struct radeon_device *rdev)
 	ret = ci_thermal_set_temperature_range(rdev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
 	if (ret)
 		return ret;
-	ret = ci_thermal_enable_alert(rdev, true);
-	if (ret)
-		return ret;
-
-	return ret;
+	return ci_thermal_enable_alert(rdev, true);
 }
 
 int ci_dpm_late_enable(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_dpm.c
index 1693b36fc52d..fc5252ff2a26 100644
--- a/drivers/gpu/drm/radeon/kv_dpm.c
+++ b/drivers/gpu/drm/radeon/kv_dpm.c
@@ -843,16 +843,11 @@ static int kv_populate_samu_table(struct radeon_device *rdev)
 	if (ret)
 		return ret;
 
-	ret = kv_copy_bytes_to_smc(rdev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, SamuLevel),
-				   (u8 *)&pi->samu_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return kv_copy_bytes_to_smc(rdev,
+				    pi->dpm_table_start + offsetof(SMU7_Fusion_DpmTable, SamuLevel),
+				    (u8 *)&pi->samu_level,
+				    sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
+				    pi->sram_end);
 }
 
 
@@ -902,16 +897,11 @@ static int kv_populate_acp_table(struct radeon_device *rdev)
 	if (ret)
 		return ret;
 
-	ret = kv_copy_bytes_to_smc(rdev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, AcpLevel),
-				   (u8 *)&pi->acp_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return kv_copy_bytes_to_smc(rdev,
+				    pi->dpm_table_start + offsetof(SMU7_Fusion_DpmTable, AcpLevel),
+				    (u8 *)&pi->acp_level,
+				    sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
+				    pi->sram_end);
 }
 
 static void kv_calculate_dfs_bypass_settings(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 4b10715f951c..4323f86000ac 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -6418,22 +6418,12 @@ static int si_set_temperature_range(struct radeon_device *rdev)
 	ret = si_thermal_set_temperature_range(rdev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
 	if (ret)
 		return ret;
-	ret = si_thermal_enable_alert(rdev, true);
-	if (ret)
-		return ret;
-
-	return ret;
+	return si_thermal_enable_alert(rdev, true);
 }
 
 int si_dpm_late_enable(struct radeon_device *rdev)
 {
-	int ret;
-
-	ret = si_set_temperature_range(rdev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return si_set_temperature_range(rdev);
 }
 
 void si_dpm_disable(struct radeon_device *rdev)
-- 
2.43.0

