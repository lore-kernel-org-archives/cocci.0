Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC001C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p/qIoU8Za5orhZcX78RRvB80P5yuArnqpPKEdRCSBmk=;
  b=bz/RX9HKv01EMDiv6PyHltXN1AvzRPDe8Kzogzp2BhQyfWwowtpud7i9
   3Pkhzs6c/dQqOz6H9Z5LPfez1cBDo1dt75Okts1GY2JO0APcyJeru/Y4h
   jT5WXQxJZpn+pwXSLVn3LCzZHU2IN7QYgUHzozu7bZc6FcO54zce9qgZM
   g=;
X-CSE-ConnectionGUID: K3kwfRy6RqO+R7HzzHMBwQ==
X-CSE-MsgGUID: slmM7f4tRZSB5C1njg6MyQ==
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
   d="scan'208";a="287734468"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 91D64803FA; Fri, 24 Jul 2026 10:54:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5760C81964
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 22:27:48 +0200 (CEST)
X-CSE-ConnectionGUID: WC6GGKnESgy4/y/M3P4EQw==
X-CSE-MsgGUID: MK7VvVdVRJeBNVSZMIhJOQ==
IronPort-SDR: 6a627944_YE6qNPgQbc9BWj0THCNAJjZZnY9+XuEZy0lsAlJHsG++efi
 nLJZnyUY0y4/zjKiBko4AgRfeHTW+dnG2Q+sSrA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FnAgAQd2JqfDbbVdFaHgEBCxIMggULAoI/WoEONAQLG?=
 =?us-ascii?q?TCEWI9SgiSLd4dVik+BPz0CDwEDAQ1RBAEBAQIEhH4CjWACHgcBBDAJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZBw4SKYZPD?=
 =?us-ascii?q?UkBEAGCBwGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQIsXwEBAQMSER0BGx0BAwwGBQsNAgImAgIgAQERAQUBHAYTIoUDA?=
 =?us-ascii?q?QYQAQM3A7Y8gQJCiz2BFQUCFoEBgg0G2mgKGSgNcgOBZgIHFAEBgQkuhHgqX?=
 =?us-ascii?q?YI9IAGBcIQHG4Nneicbgg2BSoJ2PoFSTYIkFYNGgmoEgiKBDJIIJggBBhcDB?=
 =?us-ascii?q?wcJBQQJEwYFBQI/CQYFChIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwoNC?=
 =?us-ascii?q?wcFHwoCDBQKKCIEDisKAQIBVTABCAYCAgQEAgQCCgIJAgIFBwIRAwQBAQgCA?=
 =?us-ascii?q?gMqAwEDGQgJCAILBREYDAsHMQMQCQMCHRcWBQgRNAgGFgEaBwUGCwEgFhQBB?=
 =?us-ascii?q?QwRAQIbAiEEHQEQCAMBBwMOBAQCAQsDBBYECAkEDAEBDwEKEhUDAwsDBw8CD?=
 =?us-ascii?q?QcUBSADAg4CCQgMFwICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMDAQEDA?=
 =?us-ascii?q?QQEAwMCAwUBAwMDBQICCgYJAQEBAQMCAggDBwMKCQIFAxsDHAYBAgIDAgECA?=
 =?us-ascii?q?wYDBwgDCAUDBAIDAwMEAQICAQEBAgMBAwMEAwEGAgEDBwICAwMDCwECAwMDB?=
 =?us-ascii?q?QMFAQUDBQICAwUFAwUCAgoCAwMDAgEDAhwDCAMGAxIBEAMDBgEDBwMHAgQDC?=
 =?us-ascii?q?AQDBgIDCAMDAgkIAxYGAwMDAwUBAgICAwUDAwMICAQDAwQCAgMMAgYDAwMCA?=
 =?us-ascii?q?wMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECAwsEAgQGB?=
 =?us-ascii?q?A0JBAIEAgIPBAQFAwMHAQECAQIIBQYDAgIRBQgKBQYCAgIdAyEBAgEPBgEJB?=
 =?us-ascii?q?QIBBQ4HBQICChIDBgEBAwQFBQEDAQoBCwEBAgMDAQQFAwMFBwECBAIHAwMDB?=
 =?us-ascii?q?AMDAwMBAQICBAYEAwIDBwMDAwMDBAMFBQMCBQIEAwUDBwIDAwIBBQoBBAUEC?=
 =?us-ascii?q?gEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGBQMDAwUCAwMCAgIDAwUBBQIDA?=
 =?us-ascii?q?wMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhAgUDAwMDBgMHAwMEAwMDBwcCAwIDB?=
 =?us-ascii?q?wMCBQIHBQMDBQMGAQMCAQMDCAsYAwsJCBM9AQsHMgQ2ARQUBSkhX415I4JAA?=
 =?us-ascii?q?YENgikXlnoBjxOgHnFogz+bX4YWM6psg1iHP41xkhOXHxEkEoEyOoFcMxoIG?=
 =?us-ascii?q?xVsgjZQAxkPjiEMFoNgy2YpMj0BAQcCBw4DC4FohwKJMoFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:jdWEe6lJbgmGP9Sx7iWIY7zo5gxkIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeW26BaPeKY2v8c98nb4vg9E5UsJeDzNZiGwFvrixnRC4T+ZvOCP2ncnv9bniYRiHhZBI+v
 p9GMrEsD+htEySC/k/1WlTFhSMhvU1dbuOkUIYoAggoG0k8Dntn0Us98wIAqtYAqcCjBA+Qs
 s/FrcTaOVu0sxZ5KWt8B5ir8XuDh9ys/mlF1rACTaoT5gGGyCNOVcp3yZyZdhMUfKEERoZWe
 M6YlNlVzkuBlz8xB9WslKrMc0Fiatb6IQiUh3NKbLOpix5EqzZa+v5T2C00NC+7Ix3Q9zxA4
 I0lWa6YEG/FDYWV8AgpaCS0JgkiVUFw0O+ecCLn6aR/+GWdG5fk660G4EjbpuT08M4vaY1F3
 aVwxDzg8nlvLg95qV62YrAEuygtECXkFLw05F5P7jf0Nvk3HdfSBICR3YN15Shl06iiHd6GD
 yYYQT9mbRCFegMWf1lKVNQxm+CngnS5eDpdwL6XjfBvsi6DkUoriemrbYa9lt+iHa25mm6Do
 2zc8mLyAjkVMdWezXyO9XfEaurnx3OkBt1OSOXhnhJsqHiwmVINNhEob3m2i9+HsXybetJ9D
 HVBr0LCqoBpqRXzEYijN/Gim1aPuRUXWvJLAugi4UeMzLDV6kCXHAA5oiVpbdUnsIovW2Vv2
 ALV2dzuAjNrvfueTnf1GqqoQS2aBgNLAkAhYwI/QhpZpMikhdoL0j/2UYM2eEKqteEZDw0c1
 NxjkcTTr7AajMpOzrviuF6a33SjoZ/GSgNz7QLSNo5E0u+bTN/+D2BLwQGEhRqlEGp/ZgfZ1
 JTjs5bGhN3i9bnXyESwrBwlRdlFHcppzwEwcXY0QsB5qGXzk5JSVY9X5z56KQ9oNM1CEQLUj
 LvokVoJvvd7ZSP0BYcuOt7ZI5pwkcDIS4++PtiKNYomX3SEXFXblM2YTRTNhzi1+KXt+IljU
 aqmnTGEVCdLUP83l2LvFo/wE9YDn0gD+I8afrijpzzP7FZUTCT9pW4taQPSMLIK/+mfrR/L8
 t1SEcKPxl8NGKf9eyTbu8pbZ1wDMXFxV9i8pt11Z9yzBFNsOFggLPvNnpInWYhuxJpOmsnyo
 3qSZ05/yXjEv0PhFzmkUH5YRYnUbc5Nlk5jZS0IFnS06kcnereqvfs+dYNoXLwJ995D7P9TT
 tsXcfqyE8ZwFzbO1h4bZ6bTtIZJKRah31qPGwGHYzEPWYFqaCKU293jfza0zi0CCxe4j80cp
 7el8AT6R8IYZgJAVcz5VtOm/2mTj1M8xt1gfhLvCcYJXlfv661oGjzVotooBf9UMjTF5D+R9
 zjOMCciveOX/rMEqojYt56Lv6KCMrVbDEFFO0L58LzvFy3R3lT78L96SOzSIAzsDjLlyp6DO
 9dQ4er3asAcvVBwtIF5LbZn4IQ+6/brpJ5Y1g5UJ2rKXXv6FoJfJmS64ucXup1v3rN5vS6Ea
 nCL8PReOpSLP5rBO3wVLwwHcO+C9K81nh//0PcLG3j5tRRHpOe/bUZvPhe3mHN8KplxO9gb2
 usPgpMdxDG+rRsICey4qB5o2V6CFEFdbJV/hKomWNfqriEJ1mB9ZYftD36qwZOXNPRJHEoYA
 h6Vo6vglb5j9FvwTCcxHFXn2+Biq4wEk01IxgVaJnCiuNnMttko1jJ/rBU1SQV0yE1c8uRRY
 2JECWx8FZ+szRxJ2vdRfjmLMB4bIg+a4Wnz+kstuEjGaXfwTU3LDmk2GdjVzXAj62gGIwRqp
 uCJ+ljqQRPBXZ/UzCAtfWVHtva6b9h61jOaqfCdB87fQqULO2v0sJSPO1gNhQDsW/4qpUv9o
 uJvwuZ8RIv7OQMUoIw5E4Oq7qsRej/VOF19Rexdw41REVH+YD2S3R28G3K1cO5JJN3I9hacI
 O5qLcRtSR+/9XivqhY2OK0yGIJ3zcUZvIc6RrDWJGA9o+S+qBhtu8nu7STQvjIgbOhvtscfE
 bnvUQy+PFaevlZqvlPcjdJlPzO4aOYUZQen0+GS9v4IJq05s+ptUB8T1+K0tkqKLABXzgKwg
 zKaQYSLyeY4mIJmsLbxI/8SGyS1NtLBe+Ca+y+js9l1TI3uMOWfkyg3u1XYLwBtEr9JYOtOl
 JOJq8zS8HLembQLD1DihJiKEpdW6fWIXOZ4Ntz9KF9Yl3CgXPDAzgQi+WfiD7B0i/JYu9eaQ
 jWnZPuKddI6X8lXwFtXYXN8FzcfE6HGUbfylxiirvijCgkv7iKfFYmJrUTWVGB8cjMEH7bcC
 QWu4van2Y1+nbR2XRQBA6lrPo98LFrdQpAZTtzWtwSDL2yWk1iH66rDlx0h1GnxMUO6Mv3Gu
 LDLehuvUy6JmvD4/IkM+cg69BgaF210juQMb1oQsYw+wSyzCGkda/8RK9MaA5VTiTb/z4z8e
 CqLVmY5FCHhRn5RRH0QOjg4stu3XYTi++sVJwDFO2uRYiayQZqeWf5vq3sm7HBxdT/uiuqgL
 LnyP5E20geZmvlUqSQ7v5RXQtuLAtvVw3sJ/Qb2lMma79M2H+ARzHI4dOZSfXWvLiwO/Xkn4
 UA6QGlFRAewTkuZ/QOMvZJKMElxgQ4DBAnEoctCLBgzdmlbICB9JCXDBtzO
IronPort-HdrOrdr: A9a23:jE17O6hze2au0KuyfLyMX1ZrcnBQXjYji2hC6mlwRA09TyXGra
 yTdaUguCMc1gx6ZJjvo6H9BEDmewKjyXcV2/hvAV7GZmbbUQSTXfhfBOfZslvd8mjFh4lgPM
 RbAs1D4b/LfCNHZK/BiWHSLz9j+qjizEnCv5al854Cd3AWV4hQqyh+ERiSCUB7SU1rApAjBI
 OA6scvnVudUEVSQMD+KXUMQvTZq8ejruOfXTc2QzAirCeB5AnYi4IS0CL54v7daV1yKH4ZgA
 r4rzA=
X-Talos-CUID: 9a23:lqSyx2FQoa+SeFP5qmJY3xA7NeMjX0bS3SuXMgidUl41ZYSKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AupzHAg96OYZ+eLGjTnbEGOGQf+JLvJqwNkwzq7c?=
 =?us-ascii?q?Lke+6Dh5VGje/qw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287674401"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGPPk3CbuFPgR4WeHndvvsZuE9+TXYWdIAz7C?=
 =?us-ascii?q?szokTnE7XXXRSiX7G26UgpSVqSbns1596m8FKZLdYeeYuy4UXMumBiDm?=
 =?us-ascii?q?fwjTV0HKkW2VxsrKa5J0ZIk7nNpWV1yVXr4ysy/ZdhuRx57MYcojMpJt?=
 =?us-ascii?q?f6bF9Bf7NrBUHdlmIFTlZU/A=3D=3D?=
Received: from mail-qv1-f54.google.com ([209.85.219.54])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 22:27:47 +0200
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f0e5e36912so9119386d6.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 13:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784838467; cv=none;
        d=google.com; s=arc-20260327;
        b=i/XFUPNs+Uwg3jcDweFeU2WQXF+JDfVOFVQ8QncblJOmq8nD6WQM5MfYmB4f0jRVCz
         OFZa+ymaiDvWrqtpxNBiXyo7lIS283PB9HKuBMkHAkyDxY8ps2XtU8WjkV/e6iqp9wUO
         r0ALRc2HkMk/Vd0501cGIUB3qUaLg7T/NVtvuMMbEW5Ta6fFz0i57HwwQSI49eTOc1+o
         TKAHPNS+hMxNaWSAn2WzXP/TPnvsEnrm2IVbmQ2Z4v/JorWic2eOd+kvfNNQYYJvvSGe
         B/7tWrZQePTo0C7+I4FSRKN7HpDOnX6qD92ppgWB8G/OrDAQhd891qrL+Aku0mOnp7bB
         i+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p/qIoU8Za5orhZcX78RRvB80P5yuArnqpPKEdRCSBmk=;
        fh=dEIiFRBxVNNKaYrSsl/EQntFgqEQYYVsoWVeoRmmCh8=;
        b=ltKlVcoX/l65CBFCWQkuQKbibYkpVqgbNgR3J7vSjWkugNXEFMURyKpfAb9LeKnk5K
         X4LluXXxkQFoQSOM6gvuwpnz8lLBnMWz2Y8XLm2XjJq8NQHBbXNdXQbgTQFt9EGsI9Qp
         2knpo837pNfZCvO+wYIcrjAXGT/ubBGGznKU4t1eb1SlLrSVorlzMb6pdry2wNp6/D7h
         6RCr1HAjp1KDEy1eqwicJBWLUOkGLt/r3np2yFPbFfgm4N0/MUKyiGVzaoUOF6AziA6p
         e3jpRv55bC6QIAwN3XgzIMB2nhUFktL09QBQrESqb8EW/4vC57BU74EuDssS9mix7avp
         pXxg==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838467; x=1785443267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/qIoU8Za5orhZcX78RRvB80P5yuArnqpPKEdRCSBmk=;
        b=Bd/gk9r3F9mY6gXursFGHDTvhxiRDJOsyPlGKWb/YEKa1tAtPWVB5XG0mudSVW1wyo
         mKf1IiutowhLtBFiq4IlF4YVyHNDr6nz12dYuS94NRfdK140ETd72j/mpFUgeAhpQRHE
         TwTUh0/7R73H8ZKctrXUuMYGQ4u4Hu5K8DOstOUGhXdmZmp0xzXzHbZLVIJ7sWz1kUWK
         F9ibeLDuTZkqNFTeq8larO7ba1+G5G/bI9niDNXqOC3LMdQEOFBkoSJmDeHgtZQvZHZR
         q8sulQ3y4dysSvu7twLH5ti33FzEkH1/A4VZ93HPEp85b3Lz57Bo6+dCp1+iVnjHmPRs
         FuGg==
X-Forwarded-Encrypted: i=1; AHgh+RoLvvd9PtcmmJ8N1edvJ7hL/KobjVMYYBOH06CusxLF0nIAnNQ9lU5n4X7tLozE2d5NqnKocQ==@inria.fr
X-Gm-Message-State: AOJu0YxIZhHBa8NgJaoZNv5G2Vn32bZ+vREywpBAr1ceZsxZI491gpWx
	Y0IFbTk7QtoW1LrcydOLI6Im1dcsJU2fLiUu3txWHWlR1h1bp43VKwweyMDbyzA/6QsGxBFL3X4
	Wwbk1bpzyYWCaG4RBwbVGs/sh24/F9rM=
X-Gm-Gg: AR+sD13oOaspR3J8o7xLxJ+3L+U8UPKgrg+ykM8V0ZD9oBlQIDEmfWUfYccmVrHjBml
	nNKLJDpt+PsEQ1fLxOHNW5CPo/4VtompgH1KvCbS3bFlfM9y51MzyDrT9hHWYEYjvaN0A5zI9IH
	HDqnLXlQJp/zctBEV1aiofk/4IhEue7ib3aHH/msyc7bcYc+0SVgbxKGXiTZgILrt848yEi7l/G
	kDcuH4It1Ef9++68/AhGMuzRM6RUZiFunAR40Dju6SQHUEmO37LSYhStU9gjDPvB8qAkTdOxCM2
	GauWAauih7K3gLAK/QtHI+mW3ieqZ6+fHmFJwWqDuYvVE10ebbyyhehNvDdsaJLHQhD1GQb9cEh
	wQ3drDQm/RZP46y46qw+75GCMUwqVdrAUYtpi3/22drxtl5rVB0d5FnJ0xVJ6MFIi3zV9/QXxK2
	c=
X-Received: by 2002:a05:6214:1309:b0:8e7:8d53:2417 with SMTP id
 6a1803df08f44-907ca58b1d4mr58955846d6.27.1784838466656; Thu, 23 Jul 2026
 13:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <20260723184538.3888637-35-ekffu200098@gmail.com>
In-Reply-To: <20260723184538.3888637-35-ekffu200098@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 23 Jul 2026 15:27:35 -0500
X-Gm-Features: AUfX_mxnuBmU386xHCrO9KVt4FbuF22Bv2uMtB3Rok005YRa9Pud7LorDFd8BFc
Message-ID: <CAH2r5muT20HXUANLnXQc1dAAvs+N=jFneSsV9gUqS8GE-wWNPQ@mail.gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Steve French <sfrench@samba.org>, cocci@inria.fr, 
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, samba-technical@lists.samba.org, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 34/36] smb: client: remove conditional return
 with no effect
Reply-To: Steve French <smfrench@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3638
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/XwFvlZ1yJ4REeZNwkWArfg>

You can add my Reviewed-by if it is not going through my tree.

Which tree do you want this changeset to go through?

On Thu, Jul 23, 2026 at 2:04=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
>
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  fs/smb/client/smb1maperror.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/fs/smb/client/smb1maperror.c b/fs/smb/client/smb1maperror.c
> index ab3d09613c91..395299f9121b 100644
> --- a/fs/smb/client/smb1maperror.c
> +++ b/fs/smb/client/smb1maperror.c
> @@ -234,11 +234,7 @@ int __init smb1_init_maperror(void)
>         if (rc)
>                 return rc;
>
> -       rc =3D mapping_table_ERRSRV_is_sorted();
> -       if (rc)
> -               return rc;
> -
> -       return rc;
> +       return mapping_table_ERRSRV_is_sorted();
>  }
>
>  #if IS_ENABLED(CONFIG_SMB1_KUNIT_TESTS)
> --
> 2.43.0
>
>


--=20
Thanks,

Steve
