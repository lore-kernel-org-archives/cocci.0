Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA5AC88E7F
	for <cocci@archiver.kernel.org>; Tue, 15 Sep 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=fzY2Gx3kYKcibKIt2+RyfZ1K0b9WPd5KwFe7/f1Irqk=;
  b=Z4vG53MrFRelns3KPDrw2ssnm4KtssJ+CmRo/v1pFIEHZD5zFmYfyM74
   ZIeCi5enEe/JlzAWxsVQBoTJViW6mVYBqlpK5sovw66PLoFi8N4O0WRtD
   P2sIYT3ZRlAYdhZOerK38WZbYjSpchg2wdHE0ynOvsao8BZmFWd2uBSkk
   o=;
X-CSE-ConnectionGUID: dKFTMlFQQLaF3HugbSlC9A==
X-CSE-MsgGUID: cP9UQYnESCauWi6NF0goNQ==
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
   d="scan'208";a="294998449"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Sep 2026 10:45:53 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 49A27826F6; Tue, 15 Sep 2026 10:45:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4EB978050A
	for <cocci@sympa.inria.fr>; Tue, 15 Sep 2026 08:44:33 +0200 (CEST)
X-CSE-ConnectionGUID: eH5hsAa3Q1iDffCNix4oPQ==
X-CSE-MsgGUID: tA1BFomWRKCc0wV2VirxJw==
IronPort-SDR: 6aa8e950_+8dli7eDcH68MRLN38/KN1IW7Admi2IIEc9KgsOdaGe5833
 C5utNPJQxETH/uDZe43Wh0JnIeefGOk+dfCPmqw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FMBQBG6KhqfEzkfUpaglkCgj+BC2QwBFSNUoh5i3yMR?=
 =?us-ascii?q?IVeFIErPQIPAQMBCwEBPRQEAQEBAgMBNwGERo4KAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JAUuGR?=
 =?us-ascii?q?YI0AYILAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQIsPwEhNgENARsdAQMSEFsCEQEFASIBEoMCAYIiAQYQAQM3A?=
 =?us-ascii?q?wMOtiSNBwUCFoEBgg0GgmvYAAoZKA1yA4FmAgIBBgkBCgEBgTeEeCpPDoI/A?=
 =?us-ascii?q?YUidkSCVWmBIYIogRWDaYIfgWdShjAEgy6ULAEHBx8SCAEcBggCAkgVEgMEA?=
 =?us-ascii?q?wQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLBwUfCgIMFAooIhIrCgMqC?=
 =?us-ascii?q?xIPAxgVAQgGAgIEBAIEDAIJAgIFAwQCBA0DBAEBCAICLQMBAxkICQgCCwURG?=
 =?us-ascii?q?AwLBzEDEAkDHwMUFghFCAYWARoGBQYLNxUFDBEBAhsCHwQdEQgDARsEAgEHA?=
 =?us-ascii?q?gMEFgQCFAohAwMCAwUBAwMDBQICCgYHAQEBAwICCAMGAwoJAgUDGxgEAQICA?=
 =?us-ascii?q?wIBAggDBwgDDQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDCwECA?=
 =?us-ascii?q?wMFAwMFBQICBQUDBQICCgIDAwMCAQMCGggDBgMSARADAwYBAwcDBwIEAwkCC?=
 =?us-ascii?q?AMDCAgDFwMDBQECAgQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECB?=
 =?us-ascii?q?wIDBwIBGAMCBAgHBwUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFBgMCAhABC?=
 =?us-ascii?q?AoFBgICAhwDHQEDDwYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBAgMKAQIEA?=
 =?us-ascii?q?gUDAwEDAgMCBgMDAgUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDAgIDBQEEA?=
 =?us-ascii?q?wQDCgMCCAMDCAMMAhoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBAwIBAwMIC?=
 =?us-ascii?q?xUiAwEFAwMCAQMCBQMDGAICBAUDAwMDAwgEAgIBBwYEAgICAQUFBQQFBgIEA?=
 =?us-ascii?q?wgBAQUDAwoNAQIHDAMMBgMHAwMEBAMCBQoCBAEHBgcHCQcDAgMIAQELBAEDA?=
 =?us-ascii?q?woDAwUCAQEHBQMGAwcCAwMDBQQFAwILAwcCAgMDAwIpAQEBAwMDAwMEAwEDA?=
 =?us-ascii?q?QMDBwMFAwIOAggBCgMCBgMHBgMFAwMCAQIDAwURAwYEBQYZAgYROgEIAgMDA?=
 =?us-ascii?q?RQEBAUFAgUVAggBAwMFAwMDAwIFAwEFAQEDAwUDAwMDAwMEAQMEAgMHBggBA?=
 =?us-ascii?q?QECCAMDAgUDAwMEAwMCAQIUCQgHDAE8DAcKJAQEDCoBFRQFBCUZZwcHjysfg?=
 =?us-ascii?q?l+BDiyBfoFQAZIcC7JKNDMKBgGCSYEKToFmijyPPoV8GjOXU5MaLodmkHQjj?=
 =?us-ascii?q?WeECZIQN4Q+AgoHBxEkEoEyOoFcMxojgQFtgUlQAxkPkiSBPspbeQI7AgcCB?=
 =?us-ascii?q?w4DC4pTh0mBTAEB?=
IronPort-PHdr: A9a23:4uCKXx/JL8uQWf9uWfq1ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Y
 gqHv7420QKQFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEzIjt4A9sjdkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFijuwbaluI
 BmoogncuMkbjIt/Jq0s1hbHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68PlrRbMQRKR63UTT2saihVHDRTL4xH8RZfxrzD1tvFh1ymAPM35Vq47VDK/5
 Kp2UhDoiSMHNzkk8GHLj8F7kaxWrA69qxF53oXZe5+eOuZgcazBfNMaXWtBUdhXVyxdGYO3c
 o8DA/McMepEs4Xxol0Dpga8CwaxHuPi0j9GiGHo0KMn3eovEgbI0wMvEd8VrHjZr8/4OLsIX
 Oyp0KXFyyjIYfNM2Tf67YjFahQvofaXXbJwbMre01QkGh3fjlWXp4zlIyiV3fkKvmiZ6OpgT
 uKvi3M9pA1rvjev3MAsiofVhoIO11zJ7ip5wIMvKt25TE53e8KrEJxVtyyDMYZ9X8wtTX1yt
 ikg1r0GpYC0fDIMyJk/yRPSduGKfpWM7x/9W+ucIyt0iG9hdb6jmxq/9Uiux/H9W8S3zFpHo
 StInsfRu30QyRHd6tWLRudj8kqixDqC2Qbe4fxKL0AzkKrUMZ8hwrgom5oSt0TDBC72l1/sg
 K+YbEUp/PWj5ef/Yrj+pJKROJV4hhzgPqkugMCzH/o0PwsUU2WZ+OmwzLPu8E3jTLlUkvE7n
 bPVvI3VKMkfvKK1HgxY34kl5h2iFTmpys4YkmMCLF9deBKIkYzpO1bWLfD9F/i/glCsnC51y
 P/bILHtG5vNImXdnLv7crZ97ElcyAU3zd9B/Z5bFrYBIPfrVk/wstzXEAM5PhS2zuvoEtlxy
 50SVGKVDqOHLq/fskWE6+AuLuWUYY8aojf9K/wr5/70in85nEcQfauu3ZsMaHC4A+5pL1+Fb
 nr2hdcBH3sKvhEjQOHxh12CVCRcZ3e2X64m+j47D4emAZ/ZRo+xmLyBwDu7HppOa29aDVCDD
 Wvnd4SfVvcXaCOSJ9dhnSYeWbigTY8hzxCuuxXgx7ppNOrY4isYuon729hv++LTjQ0y9SBzD
 8mFzm2BV250kX0PRzE1xq5yuUJyxEqb3ahinfNYC99d6elRXwc/L5Hczuh6B8nsVQ3cYNuFU
 VimTsi4DT0rQdIxxNgOY0l5G9q8lBzMwy2qA7oNm7OWB5w086fc0mDpKchyxXnIyrUvgkUgT
 MdXKGKmg7Rw9xLPCIPRi0uXjr6ke6sE0C7W7GeDw3KDsltEXQBtTKvJRWsfZlPYrdvh5kPNU
 buuCbM/PwVZ0MCMMqREOZXVigBkWfPiMZz6an24n2P4UTSVwrKFKq7jZGwZ2A3cDlIFmkYd5
 yDCfS4/DSClqnmWNDVqFEKnN0Xt+u56oWj9VkYwzhGibkho2Py74EhGq+abTqYx2akEpS5pg
 C9zEkqml4bUDMGAugMnd79bb88muX9I0GvYs0p2OZn2fPMqvUIXbwki5xCm7B5wEIgV1JFy9
 BvCrSJ3IKOcixZaci+AmIv3IvvRI3Xz+xamb+jX3Evf2ZCY4PRH8+w2/nPkugzhDU8+6zN/y
 dAA0XyH5ojDSgEIVpztSR8f+B1zprWcaS44tMvPzXM5CaCvqXfZ3s4xQu4syxKuZdBaZaGDD
 w/vGosRHc+gNPdzs1esZxMAeutV8f18JNuoIt2B3qPjJ+N8hHSmgGBAtZh6yV6J/jFgR/Tg2
 p8Ex7SV0lHCWW6mylimtc/zlMZPYjR68nOX7y/iCcYRY6Rzed1OEmKyO4iswc04gZfxWnle/
 VrlBlUc2cbvdwDAJ1r6lRZd00gauxnF0WOx0iB0njc1r6GewD2GwuLscwACM3JKQ28qhEnlI
 Iy9hdQXFEayaA1hmByg7Ef8j69VwcY3Z2vUWkdVdm79NWZsTrDpnrWHas9LrpgvtGQfUeixZ
 0ybVq+ouwETgEaBVyNVwDE2cS3vu42swEA80TjAaiwp/DyGJ5IVp1+X/tHXSP9P0yBTQSB5j
 WKSHV2gJ5yy+s3SkZ7fs+e4XmbnV5tJcCCtw5nT0UnzrWBsHxC7mOi+39P9Fg1vmy38zNl3X
 GPDthHyfpKy/6u/OONjOEJvARWvjqgyUpE7iYY2iJwKjDIYgY6V4HNBmn30P8lAgIrxaXMMQ
 XgAxNufs22HkAVza3mOwYz+THCUxMBsMsK7bm0h0SU498lWCa2Q4dSohANNq0Gj5ULUaPl5x
 XIGzOc2rWUdm6cPsRYsySOUBvYTG1NZNGrijUbA49e7paRRLGGhFNr4nEh5htC8BfeJuAZSR
 G2gUpgnFC50qM54NRrA3Wby5YftZNTLJY1P8ETOzlGa1bgTd8x5n+Fv52IvIW/nuHw51+M3x
 Qdj2523psnPKmlg+r64Hg8NMzT0Y80J/TS+xa1an8uQw8WuBsA+RnNSBsauF6j4Vm1M5pGFf
 06UHTYxq2mWA+/aFA6bswJ9qm7XVousLzeRLWUYytNrQF+cIlZeiUYaRmZf/NZxGwa0ycjma
 Eo86CoW4wuyqBxXyv9hcRLlVWnDv16AZTI9SZzZJx1TpFInhQ+dIYmF4+R/EjsNtJ+mtwyQI
 yqQfQNGEXpQckOBDlHneLKp4JOTlorQTvr7JPzIb7KUrOVYXPrd3pOj3Lxt+DOUP9mONH1vX
 LUrn1BOVndjF4HFii0CHmYJwjnVYZfR93LesmVn69qy+/PxVEfz6JuTXvFMZM539Un+gL/fZ
 bHMwn8jdHAAkMtLnCGAyaBDjgRK2mc+Kn/0S+RG7WmUE8ey0udWF0BJMXsrbZkUv/xkjFUdZ
 5KJ2JSoiPZ5lqBnUQsdCQ6/ypnxN5BafT3vZhSaWiPpfPyHPWOZmZ+vPvGyGbcI3rkE6UHi6
 3HGTQfiJmrRzWmxD0L0P7ke0HHFYE4M/9zjF3QlQWn7EoC8Y0XjYoYr0GVkne1q2iGYcjNCe
 TlkLREXpeWevy1S360tRzwfsig3arTa0zCQ6+2SQnoPmd1sBCk81+dT4XBhjqBQ8DkBX/tt3
 i3bst9ppVii1OiJ0DtuFhRU+H5Ng8qQsENuNL+8lNEIUGvY/B8L8WSbCggb79pjBNr1vqlMy
 9/J3KvtITZG+tjQ8IMSHc/RYM6ANXMgN1LuFlu2REMdSiW3MGjEm0FHuPSb93nQo5Rg75a1w
 twBTbhUUFFzHfQfSwxkENEEPJZrT2YknLqc36tqrTK1qBjcQtkfv4iSCa7UWK+ybmzD3f8bO
 Uhto/uwN4kYO4zl1lY3b1B7mN+PAE/MRZVWpTUnaAYooUJL+Xw4T2sp2kujZBn+hR1bXfOyg
 BMyjRNzJOo38zK5qVUwPVrXrW07ik4/hc68qT+UeT/1aqy3WMsFbki8/1h0KZ79TwtvOEeqm
 ld4MT7fW79Lp75pdGQuhQOG/JUWQ7hTSqpLZBJWzvaSLaZNsxwUumCswklJ4vHAAJ1pmV4xc
 JKimHlH3hpqcN8/IaG4zEthy1FRgueDsnXt2LlrhgAZIEkJ/SWZfyta4CTg2ZEpIiOp+qpn7
 gnQwlOrnUADUvMrprRh8UZvY4y9
IronPort-Data: A9a23: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
 E4bn1ew3l0=
IronPort-HdrOrdr: A9a23:OZNP76/jkduS5s2BcSNuk+Fudb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKRcdcKO7SdC9qBLnhOhICOwqUYtKMzOW3FdAQLsC0WKA+UyoJ8SdzJ876U
 4IScEXZ7PN5DNB/KXHCXyDYrMdKa68gcKVbInlr0tFfEVPUeVN/g15AgGUHgldXw9dH6c0E5
 Ka+45uuyegUW5/VLXxOlA1G8z44/HbnpPvZhALQzQ97hOVsD+u4LnmVzCFwxYlVS9Vy7tKyx
 mOr+W53NTvjxiI8G6S64bh1eUZpDIn8KoDOCW4sLlYFtwrsHfpWG0uYczAgNl/mpDW1L9jqq
 i2n/5nBbU615qZRBDJnTL9nwbnyzog8Hnk1BuRhmbiu9XwQHYgB9NGnp8xSGqt16MMhqAO7E
 tw5RPqi7NHSRfb2Cjt7dnBUB9n0kKyvHo5iOYWy3hSS5EXZrNdpZEWuBo9KuZ2IAvqrIQ8VO
 V+BsDV4/hbNVuccnDCp2FqhNihRG46EBuKSlUL/saVzz9VlnZkyFZw/r1qol4QsJYmD5VU7e
 XNNapl0LlIU88NdKp4QPwMRMOmY1a9MS7kISaXOxDqBasHM3XCp9r86LA44+yjY9gTwIAzlI
 6EUFRDqGY0cU6rCcDm5uw2zvkMehTNYd3A8LAh23EigMyHeFPCC1z9dGwT
X-Talos-CUID: =?us-ascii?q?9a23=3ATgH0rWoYkN8kQtFOCm3GsCXmUc0FL33G5X6LGha?=
 =?us-ascii?q?5JWhnY5uUWQOXwJoxxg=3D=3D?=
X-Talos-MUID: 9a23:d0JK8wb9IOIy5uBTqxa1rh9lMfhSwI+lUF8zy6sHodmmKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="156920291"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDG8aaupmG7pwuZqU2UOLQJRS5AUmGwVVtTBRR?=
 =?us-ascii?q?2gGaBDl8rKhg5E5Sr9cnftWJaUomcx1KnZdrkXuXChcQMIoYMnUa1xFA?=
 =?us-ascii?q?VjFF0sGPHRbtq05hfogahqx2ikIOS//n4OTOjIJuLGTGxh7JNYM/Z9+6?=
 =?us-ascii?q?Op+UcRB6qNWgbP3ETu6d+L1g=3D=3D?=
Received: from mail-ed2-f12.google.com ([74.125.228.76])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 08:44:33 +0200
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso5007135a12.1
        for <cocci@inria.fr>; Mon, 14 Sep 2026 23:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789454672; x=1790059472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzY2Gx3kYKcibKIt2+RyfZ1K0b9WPd5KwFe7/f1Irqk=;
        b=Z1tYeRCtNnZYM8W0CW1BxqPRpHxNSqntfFSwxFDRjh4oVZjBQIogNAfcjSvqi3yvH9
         Ss3V93pRQoex4kkukzHU0RYd7n0rftjgFHQbYQa7sJau0nsCrW8ekTsCD4r/dedcEG0V
         McCcmz2W9Y9uXyQSgAMvBh0OIrfTGEcDrQD+sDJ28qT+ZibeIL99EEfe4AYiXnrsVE1h
         MiAvfFY0IYpjBiwp2sKdXpGSvqVQwVZn8/eQ0xYP7EGR7e7xhJrAc2g8sIEa21TyUZAM
         f2bbsADUyZlfFDO6k1ub41NLlmqd4r259B8A/5+JQBFp0B+4rqwKJAorkW7CcmpiiaTO
         rp4w==
X-Forwarded-Encrypted: i=1; AKwUvBzLsgPOfM+TKTJedMyegHRo5iFEcIGpBL/nuS6WgYVthJS6y4cTUfxas1MNJn5V9sGsM7A3gA==@inria.fr
X-Gm-Message-State: AFuF++lIzgUf0/rWWs5fTmLsTxHTs2qpqQMSm0ZeC2zpQoz4TjTjsFG6
	Kw8ntmGet8Z6PTDRLOSxzVP1epVcVGJ0dboViOW1+1euODWkh29Pi+N5LFhPhPcGqAE=
X-Gm-Gg: AYBFou1Y+qkjXNe2iHxltw/KhAeVcQjoS+kQ9tm8DgmkuXSuDdJkzhZRLo9IU1HQvr1
	cj/dTcULKZMNOM+w8s/A4DqGn701z5OdzUjyyeI9l1CKltiOuSWAoTFndI6Nj+fWl58wucLgsqB
	mykGAZBQkFHPZjOrqnVt5RoEHPQ6vLI5xg08DnuU8tpXj0BGfhteOekNUGampMoTUx+TLFChqpk
	OZ56sRvFG3Dd5NVDAl1V39r7rRRTNOjw+dMYx5S3O6JHlmOAaM5MgeAeyG3LH8gG7ncwi6w41ws
	LkPDNGGjSPLn/gekMphOWkPHXWfb3psT8t2G9YGR13v8Y8GyflaHVQNlLh+/IELfgZHSY4x21zF
	MJYzI2vbxyCiIDnhIjHDN/uG2MXfzTUZbefBVRmPZYloqAKK+lH5aRBFZLHACF01PB4wbWivIEb
	h/kwLz0d42jJr0MXdGejkD31dr49TmWSLNKqq00dK6GC/pj1nA3KcfM48ROvet8MFW7IRCO6KxN
	+yfaK750htJtbsx/FzCgaHG4o2Qu9a3euw9S+LadthFMKGXgpYd2dE7idnJPEXI8Lr0Vr8tlwjd
	F06wlM5fIk2Vi0Zo/oCnXTHA3kbYb2XPXydI5MnK42q2m8JF8cyjtbEqBRVTfrVm3ospZFTVsyS
	FBOqN5t49cew83YnvzgKWjhIKYGl1u0XVxUL8FrcnuT+hzNQEKJj4/0Xw+uz7A+Dnve3qacy2bo
	uF6K16nzxtekGby/Q+7Mj1ytVSVc9kCQz++3FgVJhkP0nNW+QyFlWlbMy+CoBOE0/8KyzoWHY+h
	BnJmIW4znABCrf3LXQ=
X-Received: by 2002:a05:6402:43c5:b0:6a9:5669:9b77 with SMTP id 4fb4d7f45d1cf-6a9f641ad5emr3599248a12.44.1789454671796;
        Mon, 14 Sep 2026 23:44:31 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (184.149.204.35.bc.googleusercontent.com. [35.204.149.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5920f4asm5081640a12.16.2026.09.14.23.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:44:31 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org,
	cocci@inria.fr
Date: Tue, 15 Sep 2026 06:43:27 +0000
Message-ID: <20260915064327.1377-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3734
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/uNu8ib7oxMP_qKt61y7y1w>

Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
called in a file if pm_runtime_use_autosuspend() is called and its
devm_* counterpart isn't present.

Without _dont_use_autosuspend(), removing devices causes resource leaks.

Assisted-by: LLM
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 scripts/coccinelle/api/pm_autosuspend.cocci | 64 +++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 scripts/coccinelle/api/pm_autosuspend.cocci

diff --git a/scripts/coccinelle/api/pm_autosuspend.cocci b/scripts/coccinelle/api/pm_autosuspend.cocci
new file mode 100644
index 000000000000..581e874cd10b
--- /dev/null
+++ b/scripts/coccinelle/api/pm_autosuspend.cocci
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find drivers that enable autosuspend via pm_runtime_use_autosuspend()
+/// but never call pm_runtime_dont_use_autosuspend() anywhere in the file,
+/// while not using devm_pm_runtime_enable().
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
+pm_runtime_use_autosuspend@p(dev)
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
+@@
+
+* pm_runtime_use_autosuspend(dev)
+
+//----------------------------------------------------------
+// Org and report mode
+//----------------------------------------------------------
+
+@script:python depends on org && !has_dont && !has_devm@
+p << has_use.p;
+@@
+
+msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend() or devm_pm_runtime_enable()"
+cocci.print_main(msg, p)
+
+@script:python depends on report && !has_dont && !has_devm@
+p << has_use.p;
+@@
+
+msg = "WARNING: pm_runtime_use_autosuspend() called without matching pm_runtime_dont_use_autosuspend() or devm_pm_runtime_enable()"
+coccilib.report.print_report(p[0], msg)
-- 
2.47.3

