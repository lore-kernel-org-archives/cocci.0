Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9B8C531FA
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/nXlwcFamigkva6bDWgvzoIWdAmElQTTWvr7VWxupS0=;
  b=oOnjTqUrcoHFBG2oQYvvewH/MmW1/Sc7RIiagLNAeBmioVhxLD8NCdYH
   7Gvoc9KsggvAE2KESfoZqOx0F0gHBnnqe0QvlSkMKB6fzX7/wrMDHYCJ5
   5ltwnbearW0SRRRlQMXsMJvcQ2Bqf2/6cCzamfb7Xio2gRABxnYJRCLT1
   k=;
X-CSE-ConnectionGUID: RuUViJmySw2u1Y0VOb0EHA==
X-CSE-MsgGUID: Gi8UX/pgTZCfGOE+xK3BDg==
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
   d="scan'208";a="287734241"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F2279803D0; Fri, 24 Jul 2026 10:54:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 67F0581A37
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:39 +0200 (CEST)
X-CSE-ConnectionGUID: nhDWB3pFSVSiq0LfNreIcw==
X-CSE-MsgGUID: zw/aw8nUTlaWT3a6Cbqvxw==
IronPort-SDR: 6a6261bf_pr9YElf6kQqfBZgzFUemaGQsEkMozvb1j1QAgvBjx776wvh
 Asz1mbf5vRUA9llYcAvnLo+nT5ud0fnytS3dDnA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJBgBdYWJqfC7YVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBDiERgKNYAIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIphk8NSQEQA?=
 =?us-ascii?q?QQBAYF6gSxhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSIAENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2SoECQoxSBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA4I6h?=
 =?us-ascii?q?SN1hAJ6J4EYgRCEfoIfgjmGMASDHBKSKgEHBx8SCAEcBggCAkgVEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhICKQoDKgsSD?=
 =?us-ascii?q?wMNBgUVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBAxkICQgCCwURG?=
 =?us-ascii?q?AwLBQIKJwMPAQkDHwMUGwhFCAYWARoHBQYLNxUFDBEBAhsCIQQdEQgDARgEB?=
 =?us-ascii?q?AIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDAg4CCQgMFwICAgYCAwMDC?=
 =?us-ascii?q?gECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDA?=
 =?us-ascii?q?gIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DBAIDAwMEAQICAQEBAgMBA?=
 =?us-ascii?q?wMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDAwIBA?=
 =?us-ascii?q?wIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFAQICA?=
 =?us-ascii?q?gMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECBwIDB?=
 =?us-ascii?q?wIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECCAUGA?=
 =?us-ascii?q?wICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICChIDBgIDBAUFAQMBCgELA?=
 =?us-ascii?q?QECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDBQUDA?=
 =?us-ascii?q?gUCBAMFAwcCAwMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEB?=
 =?us-ascii?q?gUDAwMFAgMDAgICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFA?=
 =?us-ascii?q?wMDAwYDBwMDBAMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHD?=
 =?us-ascii?q?AE8DAcKJAQEDCoBBg4UBQQlGWcHBwKNaCOCQAGBDYIpgVEBAQGkTqAhSR4JA?=
 =?us-ascii?q?QYCYIFngQoVCi+bX4V8GjOXU5MZmQgjkXCSR4Q+AgoHBxEkEoEyOoFcMxojg?=
 =?us-ascii?q?QFtgUlQAxkPji0Wg2DMFTU1PgEHAgcPAoFzg3aJKoEggStJgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:yhwD1qwmJ51KhfblYq96t+fdwirEfRIJ4+MujC+fZmUNrF6WrkUBm
 GscCjjVM/uIMDPwedp1bt++oBlXsMLRy4NnTQRuqS00HyNBpOP7WeiUfxz6V8+wBp2aHRg/t
 63ySfGZcZtqFieEzvuJGuK8xZWp/fjQHtIQMMadZGYpA1MiEH5/4f5as7ZRqpZyhtSkCB+6t
 9r3osnOUHeowDcc3lg8sspvkzsx+q6v0N8klgZmP64T4wWFzyl94K83fMldEVOoGuG4IcbhH
 44v/JnhlkvF8hEkDM+Sk7qTWiUiXr7IMAGSvWFdUq6kjwIqjnRaPnETaZLwwW8O49m4t4gZJ
 Odl7PRcei9wVkH4o9nxZjEEe81IFf0fqeWfeRBThuTIp6HOWyOEL/yDlyjaN6VAkgp8KTgmG
 fD1tFnhx/1M7g676OvTdwViuigsBM/rELw14WlO9g/iDO9+ZZ7lWajr7sANiV/chugWdRrfT
 88QaD4qdBaZJhMTZBEYD5UxmOrujX76G9FagAjN9Oxnvi6JlVI3jOaF3Nn9IrRmQe1YnUiWu
 ziepzyoUjkVMdWezXyO9XfEaurnxH6hCNtPT+bonhJsqE+MgWUMWBsraV+ynsXigxCVUctBO
 1NBr0LCqoBpqRXzEYijN/Gim1aPuRUXWvJLAugi4UeMzLDV6kCXHAA5oiVpbdUnsIouR2Vv2
 APX2dzuAjNrvfueTnf1GqqoQS2aPyg5EkVZfQE/czAE+oHHrqcpgzPEUYM2eEKqteEZDw0c1
 NxjkcTTr7AajMpOz6fiuF6b3XSjoZ/GSgNz7QLSNo5E0u+bTN/1D2BLwQKDhRqlEGp/Zgfb1
 JTjs5bGhN3i9bnXyESwrBwlRdlFHcppzwEwcXY0QsB5qGXzk5JSVY9X5z56KQ9oNM1CEQLUj
 LvokVoJvvd7ZSP0BYcuOt7ZI5pwkcDIS4++PtiKNYomX3SEXFXblM2YTRTNhzi1+KXt+IljU
 aqmnTGEVC9HUPQ3kmfnH4/wE9YDn0gD+I8afrijpzzP7FZUTC/9pW4taQPTPrIK/+mfrR/L8
 t1SEcKPxl8NGKf9eyTbu8pbZ1wDMXFxV9i8pt11Z9yzBFNsOFggLPvNnpInWYhuxJpOmsnyo
 3qSZ05/yXjEv0PhFzmkUH5YRYnUbc5Nlk5jZS0IFnS06kcnereqvfs+dYNoXLwJ995D7P9TT
 tsBcp+yB/hzayvi1x1ASrTXqoZdWgyhrl+MNXD9YRwUXZ1pdyrW8PDKIyrt8ygzVASqh9png
 o+fhx76bIIHTV4+Dcjtd/OkyW2qj0UdgO5fW0jpIMFZXUfRrKxGGnfWteAmBcMhMjDR72Kq7
 BmXChImuuX9mY85393Xj6SirY3yMe9BMmdFPmvc/5CkHDL7+ze9/Ip+T+q4RzDRe2fq8qGEZ
 +8O7fXdMuUCrWlaobhHDLdn4qIv1eTB/4YA4FxfI0zKSFC3BpdLAHqMh5BPv5IQ4I5pg1K9X
 0bX9+RKPbmMBtjeL2cQAwgYdcWG6+Afn2jDzPYyIXii3hRNwpi8bRxwMSWP2QtnF5kkFKM+w
 Owkhtwa1BzntDouLeS9r35180aiEyU+dpsJ57AgPZ/Tqws0y1t9T4TWJQ3o7bquNdhdEEkYD
 QWFpajFhr5j6FLIWCMsHHrgwdhfvM4qvRxUxgUOPGayx9jP3Kc2+DZz8j0HaBtf4Tsa8uB0O
 0ltb1ZUI4fX9RhWpcFzZUKeMCAfOw+85Wrw1EovqG3Va2KKR179BjQxFsjV9X9I7l8GWCZQ+
 Y+p7VrMUBHoTZnX5TQzU0s0kM7TZ4V92SOakf/2AvnfOYcxZAfkpaqcZWAojR/DKuFpjW3lo
 dhaxspBWZfZBwUx/ZJiU5K70I4OQi+qPGZBGPFt3J0YFFHmJQ2d52K8FFCTSOhsedrx7k6KO
 +5/LJluVjO/9hq0gBI1OKouG4JwzdkVvIcsW7WzPmMXkaqtnhwwurLqyyXOrmsKQdJvrMUDF
 r3sZw+ySlK3u38FtFLO/e9lO3W5a+YqfAfT/v6428RXGoMhsNNDS1AT0Ly1jUqJNTlhwgOxk
 CrcQJPW5t44kIRloJTxI/8SGyS1NtLBe+Ca+y+js9l1TI3uMOWfkyg3u1XYLwBtEr9JYOtOl
 JOJq8/R4EzemrQ9DkT1usOkLLZbwOmMUM58ENPFHFMDkQSsAMbTsgY+oUamIpl3ofZhz8iAR
 S7jTeCvdNQQCuxv9FcMZwdwSx8iWrnKNIH+riaArtOJOBgX8SrDCPiFrXbJT2VqRhUkCq3EK
 D3fmqiRv4hDjYF2GhU7KelsAMZ4LH/dSKIWTYDNmgfCPFa4oGGpm+XErgUh2wHpG3PfMcfd4
 LD5fDbcWim2mpn1yIB+j9QvkDwRVXpzuLxlNAZVsdt7kCuzA2M6PPwQe8dOQI1dlivpkor0f
 nfRZW8lEj/wRilAbQ662tn4QwODHaYbD78V/NDyE5+8ME9axb9sAYeNMg9l6nZyPyPhlaSpd
 Y9Y9Xr3MRy8hJpuQI7/IxB9bfhPnpvnKrAgoCgRUPAexz4RBLwL0DpqGw8luenvDZTWjEuST
 YQqbTksfax4IHId1e5vfndUHFcSuzaHI/DEq8uQ6I63hrh3B9GsBBEy1y8fH1HDgAk3yGYye
 E7K
IronPort-HdrOrdr: A9a23:bfVbNKGij3n5QfDwpLqEzMeALOsnbusQ8zAXPo5KOHlom6uj5r
 2TdZEgvyMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKPjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHyTj9PdJl7tfvys+VbCTlo0uFjzsGV0gZ1XYBNu9TKCNLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3A64jcdGt5AV5oWA2lt8PQmM6h6IsjclHi5izIDXS?=
 =?us-ascii?q?GMmdwEJmbb0Wd2ah7xp8=3D?=
X-Talos-MUID: 9a23:t3TACAVgSqfrK/zq/C3zwzh9ZMFV36CnN3xWmMstsdCaJTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815338"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH0zKfJgN5P8O5VzwhGADPT+dJjhkC9Z5EB2P?=
 =?us-ascii?q?T3gbISlbQyPNHf28kHdpJCMIUghJh0iDtnWm6aUhe6bUKDxxf9nLcsyc?=
 =?us-ascii?q?tTDu5wp0jivH3G2n7xsxJoZglR5wLAU9iEys4D9hVprFPOTIL/AM0DIA?=
 =?us-ascii?q?QTnxdkyshU5fvds6CyYZJQzg=3D=3D?=
Received: from mail-pj1-f46.google.com ([209.85.216.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:27 +0200
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3811f512167so961919a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832445; x=1785437245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nXlwcFamigkva6bDWgvzoIWdAmElQTTWvr7VWxupS0=;
        b=U5FiEcjo3928vK9Hp9UDXAsTdK857XC4C+aPwfGOtj06sBSIVDFg4X86+kijHFOecN
         itr2fT7x9V7e92ZjrMJjaSUiUpuOpXUZ7J6LZ9hMs3OJ794W3MCq8jNWA+gOcCXlnTOc
         ZHKqHJN74uu1IRsGL0O7bJNzECcRGKHv+bjor9uzZSCL8VFThrs2KriUUHDLmp+VO6wO
         DDEUo4bcS5rK5ShM9fIqZeIpI6upnzDboNOTLbeXycm/KaaXAGA0kGpWC5r96DepI+ug
         RZz6K3OOqhwvJucN0swf9Axt0QhTNtjGUQywHqfWzF8VVx9WOXsRRynXvqIqYpF0+7er
         7+rA==
X-Gm-Message-State: AOJu0YxmWfmowQoIVxrAcDg6mYHj7XrsRQ1L543rtOQUvfBbJYfvA2Hd
	m2iKX0fayDRg/FszhbgrsCMH+YBohZxhTxKWa9YEgarg6vM7A/C4NNUw
X-Gm-Gg: AR+sD12cNBcpPLU8ybT9vamMoOHb5zsT4TNsw4W3EQ1RI/UF7nmOI1marmOkyUyQwbh
	fdkbSs70Db7covFPVLdhjTvW3rlGUG6727EbWYlMiaXqvjd3dILCDCw9aNFWxl5Pr6s8L00xFeG
	83xVMPsl7bKhYhxTVjV3sAxqOGrbA/FUg9oJml5mCpINo1hCwl6TE2k4nVM8Ed3QggFeylbEWpk
	fiNv5YleNOMxKJNMzhMOmVBsXPh7MC/KLw1QPLvwPh+Iy4krX/qHLBdLhl2ApHWDbvsBsKsysJr
	Nr40qaMg3a6WJE7OHT+FEuR47UafMISKsLPakFpFjQWYJ30Bqi0nvlw3bFpbaT37WfQTq0l5JRg
	H+6jRYDs5l6cBD8p1CECeGeOr7O8SHqZ74GSt0QlNKyjB0SQwFQKQhrGCPOrDOsTL9vXsrF/K
X-Received: by 2002:a17:90b:1649:b0:38e:2e16:859b with SMTP id 98e67ed59e1d1-38ec65f37c0mr3966608a91.20.1784832445197;
        Thu, 23 Jul 2026 11:47:25 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:24 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Date: Fri, 24 Jul 2026 03:45:38 +0900
Message-ID: <20260723184538.3888637-37-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 36/36] memblock: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3632
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/jCAaiHoFKgtxN9_YOIlCLQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 mm/memblock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 036316e9138b..6941fdaa3473 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2614,15 +2614,10 @@ static int __init prepare_kho_fdt(void)
 
 static int __init reserve_mem_init(void)
 {
-	int err;
-
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
 
-	err = prepare_kho_fdt();
-	if (err)
-		return err;
-	return err;
+	return prepare_kho_fdt();
 }
 late_initcall(reserve_mem_init);
 
-- 
2.43.0

