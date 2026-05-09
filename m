Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB8FCD343F
	for <cocci@archiver.kernel.org>; Sat,  9 May 2026 06:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=lvYLGpO0gTwZRqtEtmuixgfYJ0Fx1OhnY4UsHfPWmNM=;
  b=N8KCX92Ico2HBewkeAF/5Qk/IG7J9D7A38zv8DMpoiAZf9TQEMqELwsT
   d96YDRsYmSAqMep/vRbcCsLHK62lxeOgBwrTcX4qrU/CcUCUnD2N0IA94
   IXnv3AFyGr8n6EYAgA1DRcHQ9H9paRHiGnuMv7Qq3NLsFW5M0zPVj5NFV
   I=;
X-CSE-ConnectionGUID: XMB5vnfnQSmT9OXypH/91A==
X-CSE-MsgGUID: YtQPRVQDTCmS5zhFyoFEfw==
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
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275962725"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2026 08:15:43 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E64EE80518; Sat,  9 May 2026 08:15:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 83CC98051C
	for <cocci@sympa.inria.fr>; Sat,  9 May 2026 08:15:37 +0200 (CEST)
X-CSE-ConnectionGUID: RkJb8DcAROuyAISLuPjD5A==
X-CSE-MsgGUID: bAPV0r3sQg+bNT86RaSM9A==
IronPort-SDR: 69fed109_pSdED/clwjcHgqL68ENJorH1R1bki1E4I2WkIYWXe3eLFR4
 AHjLUWNqXKhjZDx9S/Wb05ZXS7yfNAFJ9HPC+ag==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GrAwAb0P5pgA4P49RaglmCQYEIXjQEC0kIhFCPU4F0h?=
 =?us-ascii?q?GuPEYh5gWmBaQIPAQMBDTQaAQIEAQEBAgMBgguCao0/Ah4HAQQzBg4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw47hk8NgluBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR?=
 =?us-ascii?q?20dAQERJzQCEQcOAnMBAYJ+AYIiAQYQAQM2Bw0GtV6BMoEBggwBAQaBRgWBH?=
 =?us-ascii?q?9d8HywiWoFnAwaBHy6FcoJLHAEFbol+Jw+BVUSBPAuCR4NQAQMYf4EGDoMOg?=
 =?us-ascii?q?mmCJoEOjnyBShwDWSwBVRMXCwcFgWYDgQZuMh2BIz4XNFgbBwWBS4QSgQEBh?=
 =?us-ascii?q?F54Iy8DToEHAgELbT03CQsbBD2LPR0PgyVFlXmRPKFFNAeCOIFnBYFfDIkIg?=
 =?us-ascii?q?SaVPwYTL4Nxk2EOkwsemGiOCZVghViBfiSBXDMaJIM2UAMZD5JWgQvCA0UyA?=
 =?us-ascii?q?gkyAgcCBw0DC4VEAQGMVoFLAQE?=
IronPort-PHdr: A9a23:hn2KTxXZt4xSYSxvDO69pTNJLXvV8KwMXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtids6oP0rOM7/CoGTRZp8ra7DZaKN0EfiRGoPtVtjRoONSCB0z/IayiRA0BN
 +MGeXlbulqWCgxrIvv4fEDYuXao7DQfSV3VPAtxIfnpSMaJ15zkn++99IfObApWmTGzfa19L
 AmsrQXWq8IanZZuJrw+xxbHonZEYfhayX9nKV6Oghrw+Mi98Z1++ChUp/4t6tRMXKr0cqk3V
 7BUECgqP2Uo78D3qBfPSheC6XQbXmgKiBRDHhLL7Av9Xpf/syv6svRy1SyHNsDoTr46RCqv4
 b5zRBHnkCkIOCc1/X/YhMJtlK5Urw6vqBJ5w47PfYGaL+F+cb/HfdMbXmVOQMBcXDFcD4ymb
 osPC+0BPftEr4T4ulADoweyCRWqCejyzDJDm3340rAg0+k5Eg/I0gMvENwQvnrUsdv6KKgcX
 PupzKTK1zjPc+9a1Sn/5YXObxsvoeuMXbV1ccfJzkcgDRnFjlaNqYz+Ijib2eANs2aB7+phU
 +KvhHMspgZ2rDe13McsiZTJhpkPxl7L8SV5zpw1Jdy+SE50etOlHoVfuDqAO4RrXMwvWmdls
 zs1xbMao5C0ZjQKyIg5yB7FbfyKa4aF7w7+WeqMLjl0mXBoda+hixuu7UWty+PyWtSo3VtOo
 CRInMTBum0Q2hLc5MaLVuZw81u81TuOyQzf9OFJLE4ymKHGJZAhxbswmYASsUTFBiL2mUP2j
 LWXdko+4OSo5f7nbq34qZ+aK497lBv+Pr4rmsy7B+kzLwsAX3CD9OiiybHv41f1TKtUgvA0i
 KXVrZDXKd4GqqO2BQJez5wt5AylDzi81dQVhXkHI0xBeBKAl4XpPlbOIO3kDfuljVWjjixky
 +rbMbL/GpnNL37Dn6n9fbtl9UJQ1RQ/wcpB655KCLwNOu//V0/ruNDFARI1Kwm0zPzmCNV52
 IMeQ2WPAqqBPa3Vq1CI/OEvI/SXZIMPtzj9L/Yl5+TvjX8/ll8QZqeo0oUMZ3yiA/tpPV2VY
 WDwjdcZDWcKog0+QfT2h12FTTFce3eyUrkn5jA7DYKmFZ3MSpqsgLyHxie7H4dZanpIClCWC
 XvocZ6LVO8WaC2OOs9hjiAEVb+5RoM8zR2uuxH1y71kIOTO4iAWu53t2MBv5+LNixE89iZ6A
 tyY02GKUmF0gnkERjEo069ku0By10mM3bBljPxbFNxT4utEXB81O5HS0eJ0F8z/VATZctiUT
 VapWM+mDi0pQ9wp2tEAe0lzF825jhDb0SqnG6UbmqCWCpIp6q7cxGDxJ8hlxHbGyqYhi14mT
 9NXO2O/nqBx+FubO4mcmEKSnKeCdKIG3SeL+n3Q43CJuRR9WRRzTL6NcHQRfErQopytw0rYT
 KK1T5kjPBFAz8GqNaZALNHk2wYVDMz/McjTNjri01y7AgyFk+vkhOvCfmwc2H6YE00Yi0UI+
 m7AMwEiByCnqmaYDTp0FFupbVm/ufJmpiadSUk5hxqPc1Unz6C8rzscn/+BULU+2rweuSEug
 yp5FhCx0oGeEMKO8jJoZ74UetYh+BFC3GPduRZ6O8mFJrphm0VYXgB5pULo2D1oB48GncV55
 Ggywl9ULqSVmEhEayve3Z30PejPLXLu+Rm0d6PM8lTZzcrQ5aoFrvg1w7n6lCeuEEdqs3Bu0
 t0OlmCZ+o2PFw0KF5T4Tkcw8RF+4bDceCg0oY3OhzVqNuGvvznO1shMZqNtwwu8f9pZLKKPF
 RPjW8wcCc+0LeU2ml+vJhsaNeFW/aQwMouobfyDkKKsOe9hmnqhgwElqMhY21iP6jE6Z+rGx
 ZcDzNmH0wHBWzq9xFatv8brmJxVMCkIFzn3wizlCYhNI6xqKNxSUyH0eZLxn4g43sK+PhwQv
 ESuDF4HxsKzLB+bblimmBZVyVxSunu/3y2x0z1zlTgt6KuZxi3Hher4J39lciZGQndviVD0L
 M26ldcfCQKNZhIqiQDjyEL03aldq4xgImOVTUoCLE2UZylyF7C9sLaPeZsFzZoysjhMFsm4b
 0qbTLHVvBYQlS/uVTg7pnhzZ3ShvZP3mAZ/gWSWISNorXbXTsp3wA/W+N3WQfM5MiMufCBjk
 nGXA1G9O4Ls5tCIj9LYtfj4UWu9V5pVeC2tzIWatSL963c4SRG4mvmynJXgH21YmWfe3sNpS
 D6OgRLyeIjt2IylPOghckQgCFLn6sV8E51zicNq3ctWgyJFwMzIuyNb2W7oec1Ww6f/cGYAS
 Vtpi5bO7Q7p1VciZnOFyoTlV2mMl85oZt20eGQTiWo268FHDrvR7aQRx3Iv5ADi8kSIPL4kw
 mR4q7Nm8nMRjuAXtRB4yyycButXBkxEJWn3kAzO6dmiraJRbWLpcL6q1UM4k8ryadPK6gxaR
 nv9fY8vWCFq6cAqenfFyn7u8cfJfNfKbNQcngKZmVHMgqIGTfB53upPnidhNW/n6DcAwvQ4k
 Aco8JW0pomBJE1y8aj/DhMSZViXL4sDvzrqi6hZhMOf2YuiS45gFjs8V5ztVfu0ETgWuKevJ
 0OUHTY7sHveBavHEFrV9hJ9t3yWWcPOVTnfNDwDwN5lXhXYOEFPnFVeQmAhhpBgXgn4wcv8b
 AFm6zpX6lOwo0lJzf90cgnxVX3ArR2kLCg5Qt6TIX80pklLtULSLNDb5OVuGSpVuIKspkqBJ
 ySSNQFPEH1MUVeOGlTgeOCn49WZteOfA4/cZ7PHM7CJtPAbXOyDwoi3lNJv+TrVcM6IOzF0B
 vk/kCKvRFhfHMLU03UKQi0TzGfWatKD4Qy74mtxp9y+9/LiXETu45GOAv1cK4cn/Rf+mqqFO
 +OK4UQxYT9FypMBw2PJw7kDzRYTjS9pbTykDbUHs2bEUqvRnqZdCxNTZTl0MYNE6Kc13w8FP
 sC+6Ju9zrljkvs8EEtIT3Tkndy1I9MHKSexORKPBUqGMqiHOSyew8zzZvDZK/UYh+FVuhus/
 DeDRhW6ZHLZzWavDk3paL0f6UPTdAZTs4y8bBt3XG3qTda9Lwa+LMcyljouh7s9mnLNM2cYd
 zl6aUJE6LOKvkY6yr1yHXJM6n19IKyKgSGcuqP9I4wVrOAtLyB6jeNc71wlxrET4CwOF5kX0
 GPC68VjpV2riLzF0j18TB9HsSpGnqqOulh+f7rU/N9MVDyXmXBFpXXVABMMqdx/D9TpsK0F0
 dnDmpX4LzJa+s7V988RbyA7AN2KOjwtPEiwcNYxJBQIR3inODOH76S8uPSV62HTsZUw7JThy
 sJmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:r/5ys6hVjXzIgX3dzMD9G/7Ia3BQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3AWZ+5cWm+/bmUlFfs988/Wq3kp63XOUfe7n2AD0S?=
 =?us-ascii?q?RM0F0WZS0cnuNwKFIzuM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3As2aG8g++0CN/7q8BakYSJ22Qf81B25r2EhsWqJp?=
 =?us-ascii?q?Fse+4ZXJKMgy43R3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="146116151"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDES5g7H1VGm6bP1nwCwVTzphbmdmIG0yruR0g?=
 =?us-ascii?q?IGhB6QVrA5GmKASV1TRKYmPbBinKZVY/bMK25dSzJ3kUl8Y8mHOQzwJb?=
 =?us-ascii?q?U1FwU54vGs6oLK+2Y33mtDjFd4YnICaYGV8mJWvak1DMQrB35JnW35uH?=
 =?us-ascii?q?bNgU104E7SxuWPpYQOxwKwCw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 08:15:37 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1w4qvv0npX-00HEUM for
 <cocci@inria.fr>; Sat, 09 May 2026 08:15:36 +0200
Message-ID: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
Date: Sat, 9 May 2026 08:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:L5PQJaIkaDXB2dtmWAB698gZSl+mj3OoKM+3S9/HAhiwNOmfKyQ
 UGsrupN/yZ0DU/yir6ADPfSsHUMaAcYEeQnirLW67TtDd34yRzkJuSkjTTM8Xo4xowSq0FM
 kMPG2wfeRLXFryvUuYn0EeJeCi9A6pWCoCQQnAl7bQE7lJnvnR30Nes3R+/Ox4cwuM2z1Yk
 89MZcl+6v6z4mg1TcNH3A==
UI-OutboundReport: notjunk:1;M01:P0:gewssr2TthM=;kwiRFxG5/yb1PzWSZuvnLbK8c+Z
 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
 pvyPDr3BX1vXEZ5ZMT1vSM5A==
Subject: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3486
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/UAqU7P2moG74OsvKh7VAuA>

Hello,

A programming interface is used by the Coccinelle software for parallel data processing.
https://gitlab.inria.fr/search?search=Parmap.parfold&nav_source=navbar&project_id=18465&group_id=10912&search_code=true&repository_ref=master
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/enter.ml#L1283-1299

Corresponding results are concatenated so far.
I would appreciate if data can occasionally be combined by other algorithms.

I imagine that unique constraints can be taken better into account accordingly.
Some information would be usable as key data on demand then, wouldn't it?

Regards,
Markus
