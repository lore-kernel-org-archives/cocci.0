Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CEAC02195
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nGzkSXXrA7jYqSv+MBWBhKjKjIZTADsGXE7oxPj/cDg=;
  b=nmRMcuPZvCKv9Pz/PfBg0E1KQQbOsWX/wR4hT1b2yGej/Acnt8JVscWX
   UBiRKfa+KNDVJ7BemjUEr625Q+IqkY3TbbLRmjonooGhRbRP2Hc5SV1bK
   6dCXCX4coFeXJl2WTG0uB/T+EUZKnhZVEo5F8THT68l0ZossJvCh46RvD
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325280"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C904EE0E3D; Tue, 28 Jan 2025 10:13:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11548E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 22:12:43 +0100 (CET)
IronPort-SDR: 67940249_r2OD9IqH2DHYD5D4MjzQzpui0g1GbCqiqjDU2XkGmU2Btfw
 0BJhQUryYAz8AB/AnRM9LgS89e6NBCJjqAS7E3w==
X-IPAS-Result: =?us-ascii?q?A0E4BAAUAZRndLTWVdFagQmDRVJ9WjMEUwSEUo9OgiEDn?=
 =?us-ascii?q?EKBaoEsPg8BAwELAQE5CQIEAQEDBDiBVIJwAgICinUCHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABIyAOEimFew2CYgGBJGECBQM7A?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINH14BAQEBA?=
 =?us-ascii?q?gESER0BGx0BAwELBgULDQICERUCAiIRAQUBHAYBCwcUDoJggi8BAw4jAwEQr?=
 =?us-ascii?q?EmBBUKKRHqBFQUCFoEBgg0GgmnXcwoZKA1vgWECBwkBCoEGLoR0KVyCOAMaA?=
 =?us-ascii?q?XJ6g387g0J6J4Iogz1PMz6DfEcVKoMcgmkEgi+BEGSBKoEKgQyHNYNdgTtfg?=
 =?us-ascii?q?V8WISV7LIRnQgQSXC9AiDAIAQYfEgkJEwYKAksLChIDBAMEBAECCxMJAwMCD?=
 =?us-ascii?q?gIIAwIIBhkBPxIEEwoNCwcFHwoIDBEKKAMiBA4rDwNZBTQBCAYCAgQEAgQCC?=
 =?us-ascii?q?gIJAgIIBwIUAwIEBAIBBRIDCwEFBgUBAQQMDgICAwMCAgEIAgIBAQIUAQQDA?=
 =?us-ascii?q?QcCAQQDBQMKAQEBAgEEFAYDBQMDBwMEAgMCBgIEBQUCAgMDAgMBAwMCAQIDC?=
 =?us-ascii?q?RAPFgICAwQCBgICAQQmAgEVBQIDBAICBwICAwECAQICAgQCBAICBgMJCAECA?=
 =?us-ascii?q?gcBAgICAxUCBQEECQMDBRIMIAMCAgICAwcKAwUCAQECBAMDAwMJDQcCAwECA?=
 =?us-ascii?q?QMFAwECAQIJAwYCAgMDBBIZBQMCDwMCAQUEAggQCwcBAQ8UBQQJBRUDBgIDA?=
 =?us-ascii?q?xYLBAUDAwMBDA8OAgILAxcFAQEHAQMNCAMEBAIDAwkCARABAwQCCQIEAQIKA?=
 =?us-ascii?q?gICAgIEAQEFBAIEAwIFAgIBCAQDAwMNBAMICAMFAwwSAgICCQIDAQIDAwMED?=
 =?us-ascii?q?QgdBQkRCwIJAwQNAgQCAgEGAwYKBhUBAhgCAgYMBAMDCAMCAwICAQICAgERA?=
 =?us-ascii?q?gIJCA0FCQUGAgIVAwIDCAEJAw8DAhQBBgIIAwcBAQQCAgoRCgEBAgIBBiYDA?=
 =?us-ascii?q?QECFBMHAwgCAgICBhYMAQUHAwcPBQUEAgIWAwMSBAQQAgIDAwIBARQGFQEFA?=
 =?us-ascii?q?gMGCwEGAQIFBAIDBAISAhEVAwMEBgMBAgoQAgQCCQoBBQQDBwUCHwMDAgIFC?=
 =?us-ascii?q?wIIAgIFAgUHAwkOAQIFAwQJAhQCEAICAgIIFgICAgUeAyYCBAMDAwMLAQICD?=
 =?us-ascii?q?gkDBDoGEQQCAwMCDgECAgsBAgIEAgMBBAcJAwMJCgcBCg0HAgIKCAkQAQICD?=
 =?us-ascii?q?wcDAgICAgYHDgMCEw8FBgYCCgcNCwIBAgITAgMJBgMFDQMHBAoNAhUCFgUDI?=
 =?us-ascii?q?AIICQsCBxECBRIDDgUDAgIRBAIDBgUDAQcBFwMHCAICDAICAgIFAgUCBRcRA?=
 =?us-ascii?q?Q0EAwMDAggBBBUGAwkIKhsSAQEBBQEJAgMCAwQIAwMDAgMEDAsCAQcIAwMGC?=
 =?us-ascii?q?wgJBgMCBwgZAwUEAwcFCyECBgMCBAUEAQUCFQ0CAxkCBgMGFAkMAgYNAQcJA?=
 =?us-ascii?q?wcBAQECAgIIAQUFEgIDBAIFBAQBAQgDAwQGAgEDAgICAQQCCgEBAQIKAggKA?=
 =?us-ascii?q?QkTBAMIAwMDAwMFAQICCAQTBQUCAQUMEwwBCgYDBgMEAgICCwcCAwMDAgcBC?=
 =?us-ascii?q?xoJAgEDAgIFAgIBBQMCAggEAwIBAQkCAwIIAQICAQECAgIEAQcBBAcGAQECB?=
 =?us-ascii?q?AICNwIBAwkCBQEBAQ4CAgQCAgMCAgIEAgQBAgYLBAUNAQECAQICAQEBBAEIA?=
 =?us-ascii?q?wEBAQICAwMFAwUIDxABARcLFR0CCQMjDwMLCQgTPQwHMgQ2ARQUBwYlgQCcP?=
 =?us-ascii?q?z2DfoEjCBAgUSAHZjUEQJJACINHsAEHgmmBNYwYkiSDJDOEBIFXiy+GOpMPm?=
 =?us-ascii?q?HwiixBZgXmVU4UsAgoHBhEjEoFJI4FccIEBgjYJCjwDGQ+OWYNChRTBGSk1A?=
 =?us-ascii?q?gE5AgcBCgEBAwmFaYo5gUsBAQ?=
IronPort-PHdr: A9a23:C7P4ERKVr5+L7GY4P9mcuMJvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvLM00wOCANiBo9t/yMPo8InYGlY8qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebgtViDanfL9/L
 hq7oQrRu8QWn4dpN7o8xAbOrnZUdOtawn9lK0iUkxjg+Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXjSi8
 rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTmZFR8pdSjBNDp+5Y
 4YJEuEPP/tXr5PlqlUNsBWwBReiCf3hxDBKiH/5waI03OouHgzdwAwgBsgDvGjIoNjvNqofV
 /2+wqnSzTXEavNbwTHz55bPchAnu/6MR69/cc3MwkQyDQPCjE6QopHiMjORyOsNtHOU7/B6W
 uK0kWIotxp8ojeqxsg2i4nJgpgZxUzD9SV82Ys4I8CzR0Fnb9C+CpRQqz2aOJVsQsMkW2xmt
 yk3xqMEtJC0ciUG1JcqygDdZvGJfIaG7BztWemMLTpkgH9oZLCyihK9/0WkxODxVsa53VJLo
 ydBjtTAqGwA2hrO4caJTft9+12u2TeJ1w3L6eFLP1o0lazFJJ4l2LIwkYATsUvFEyTrm0v2l
 Lebels49uWs8ejqYbXrqoWCO4NphQzyKLkil8+jDeggLAQDXHSX9Ou52bH+5kL0TrBHgec1n
 6XFrZzXINkXq6+lDAJa14sv9QiwAyu63Nkdk3QIMVFIdROCgoXqNVHDLv/1APKjjFmunjdk3
 PbLNaD/D5XJM3jDi6vhcqhn60BByQoyzM5Q6opIBrwHPfn9QFX+tMbCAR88KwG0w/joCNF61
 o4GXGKAGK6ZMKfLvV+Q4uIjPvCAZIEItDv+N/Qp/fHujXg+mV8Seammw4EbZ2y/HvRjO0mZY
 HzsjckdEWoSoAYyUOjnhEeBXDNTfXq+Qb8w6z4hBI67DorPWpihgLmb0ye6Gp1WaHpGCleJE
 Xrwc4WLRfAMZzmIIsB7iTwIT6SuRpQu1RGrrgD6yr5nIvDI9S0fsJLvzN516PbLmhEo6TN0F
 9id032KT2xsgG8EXyU207xnoUxh1leD1rB1jOBfFdNP+/xJUxw3NYXczux/E9D9QBjNftaPS
 Fa8Q9WpGys9Ttwrw9MWeUZyB82ijgzf3yqtG7IVk6aEBZIu/aLY23j8PMd8y3fD1KY6lVkpW
 NFDNWyghq5l9gjcHZTFk0uDl/XiSaNJ+i/G82OK1iKioU9CXRV2XO2RW3EUYU/ftpL1+03YQ
 qSoBJwsNQ9FwMSFMKIMYdrs2xEOYP7+ItnYfyqJmmG7BR+S2vvYaIP3YWgbwGPFCU4PkwkJ4
 V6HOQU3HSCnqWXXFjAoHlXqNQek1OBjsnTzZUYu0QiOb0op/Lq4+hcfzaiZQPMe3rsO+yc8o
 ip5HX6+0sjQBt7GoBBuKvZye9Q4tXNK0mTQrQB6dra6prsq0loTdA5ttlio3D14D4xBlY4hq
 3Z8n1k6Er6RzF4UL2DQ5pv3ILCCbzCqpHhHCobT01Dai5ON/7sXre8/sxPltR2oEUwr9zNm1
 cNU2j2S/MaCFxIcBLT2VEt/7B1mv/fCeCBo447T32dlKu+/mjDH0tMtQuAiz0XoZM9RZZuND
 xS6CMgGH46rIe0ulUKua0cAMedY7qcveciOeP6P2artN+Flz3q9lWoSxod73wqX8jZkDO7F2
 5FQ2/aDwg6OTCvxln+ku8Hz3JhAPHQcRzrnjyfjA4FVa+t5eoNj5X6GBcqxy50+gpfsXyUd7
 1u/HxYd39fvfxOOblv71AkW1EINoHXhlzHqhzpz2yokqKaSxkmsi6zraQYHN2hXRWJjkUakI
 I66iMofVVSpaA5hnQWs5ELzzaxW7KplKGybTUBNdinwZ2ZsN8n4/r6PZMRV4Yhuug1YVe29Z
 RaRTbu86xoW3iX/HndPkSghfmLisZH4khpmzWOFeSwr/TyJJIcqnEuZvYyEFpszlnIcSSJ1i
 CfaHA25NtitppCPkovb9/u5TySnX4FSdi/iycWBsjG67CtkG07a/bj7l9v5HAw9ySK+2cNtU
 HCCqBv7aJPizOKxGe1id0hsQlT77oApf+M22pt1n5wW1XUA09+R8H0Ni27od95z1qf3bX5LT
 jkOiY2d8E3u30ttKWiMzoTyWyCGw8dvUNK9Z3sfxiM3680i5L681LVfhmM1p1O5qVmUev1hh
 nIGzuNo7ncGguYPsQ5rzyOHA7lUE1MKdSDrkh2J6Zi5osA1LC6rfL+6zkNl29uJA7SLowUaU
 3H8MpsvBi5/6MxjPUmEiiWirNG5PoOJMZRK5kXcmgyIl+VPLZMtivcG4EgvcXnwu3Eo0a9zj
 BBj2427oJnSLmxs+KyjBRsLfjbxZs4V5nTslfMExpfQj93pRMw9XGxbBMiNL7rgCj8ZuPX5O
 hzbFTQ9rizeAr/DBUqE718gqXvTEpetPnXRJX8DzNwkSgPOQS4XyA0SQjg+mYY0Uw6ww8m0O
 kN04ToL70W+oTNDz+tpM1/0VWKV92LKIn8kDYOSKhZb9FQI40rSO9aX9aR4Ny5d95yl6geKL
 ybIAmYARXFMUUuCCVf5O7Co7tSV6OmUCN21KP7WaKmPo+hTBL+YgIii2Yx883OQJ92CazN8W
 uYj1BMJDhUbU4zJ3i8CQCsNm2fRYt6H8V2irzZvoJn38ey3Clmyo9LeU/0IbYopo1fs3e+CL
 7LC2no/c20DkMpSnTmQj+FOuTxawyB2K2vzT/JZ7XSLFOSI3fUPRx8DN3Etao0Ss/N6jlELY
 YmB0pv0zuIq0aRzUgsDDA273JnuPJxvQSn1NUubVhnXcu3ceHuThZmwOP30SKUM3rwM51vp5
 mndQwm7eW7a3zjxC0L2broK1XDHekQY4MbkLHMPQSDiVI60MEXqdo8qy2RskftswSqVfW8Eb
 WomKh0L8+3WtHICxK04Qj0J72I5f7PdxWDDtLieccxQ6bwyU0EW36pM6XA+gdO59QliQ/p40
 GvXp99q+BS9l/WXjyFgSFxIoypKg4SCuQNjP7/Y/99OQySM+hVF9miWBxkQwrktQtTyp6Bdz
 MTOn6PvOX9D9dzT584VG8nTLoqOLnMgNRPjHDOcAhECSHanMmTWhkoVl//3lDXdtp8htp3lg
 4YDUJdeXV0xU+seUwFrRYxaZphwWTwgnPiQi8tJrXuyoR/NRdlL65DKUvXBZJenYD2djLRCe
 14J2eaiddVVZtC9gRU+LAAqxNeveQKYR91Gryx/YxVhpUxM9CM7VWgvwwf+bRvr5nYPFPmyl
 xpwiw1kYO1r+i2/hjV/blfMuiY0l1E83Nv/hjXEOjr8K62qVJoQAAL7skEwNtXwRAM/PmjQ1
 QR0cSzJQb5cle4qbWdwlArVoodCA9ZZRKxAJQcUnLSZPqVwl1tbrSqjyAlM4u6PWv4A3EM6N
 JWrqXxHwQdqatU4cLfRKKR+xV9VnquSvyWs24jZIScbLkcJtXuWIWsG4RxQcLYhICWs86pn7
 gnQw1Orl0ADUvMrprRh8UZvYoxoKgrv1rdCLga6MOnNd8uk
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+Sq0bKi42538DCRaumWO950OTHBQXiEji2hC6mlwRA09TyVXrb
 HWoB19726JtN9xYgBcpTnkAsO9qBznhOZICOUqTNCftUzdyRCVxeJZnPXfKl/bakjDH4dmvM
 8KAspD4Z/LfCJHZK7BkWqF+r0bsb26Gc6T9IHjJjtWPH5XQpAlwAFjFA6BH0F6ACVAD4EoDY
 eR66N8ywaISDA4aoCUCBA+MdQrZOelqHslW3M77tIciTVmRAnJ1ILH
X-Talos-CUID: =?us-ascii?q?9a23=3AZV3hU2kwdt3/FHXj8kMWWplSOoXXOULz50nJB0u?=
 =?us-ascii?q?XMj4zQ4GoZma/1rlcwtU7zg=3D=3D?=
X-Talos-MUID: 9a23:Dfm3bQXLReTt2THq/AW83W5MCtpD2q+vA2EQu9YHuunZGDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,232,1732575600"; 
   d="scan'208";a="107314862"
X-MGA-submission: =?us-ascii?q?MDFHZ1SSWzSkzS7wd13eY+LnSTgvua8TkrJ/jc?=
 =?us-ascii?q?rX6W6TsRfZJORoAbZE8C1TdPSvxKUBa577KMRR8A2istcO5zCxfnE9lg?=
 =?us-ascii?q?fMrTmrLMJKxsGbtUiweJlQa90ptijOkmLf33iXcTz2Ox4LDhd/TiJGrH?=
 =?us-ascii?q?6cB5nxj9OnWu2uoXm5Pf/SEA=3D=3D?=
Received: from mail-pl1-f180.google.com ([209.85.214.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 22:12:41 +0100
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21628b3fe7dso45382465ad.3;
        Fri, 24 Jan 2025 13:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737753159; x=1738357959; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nGzkSXXrA7jYqSv+MBWBhKjKjIZTADsGXE7oxPj/cDg=;
        b=MFdwgdhyps8E4nPE3ZEMCv2SnEgsNaRCgjZFSB/aUzbUoSM7v0+6VM7dLtRWgLwVpH
         7pV/YOAvc06y63upOXa/KoAMcT25DaKpr9usOUXtdAQ1+ip41AY9r2CzSV2LjWYHj3sF
         H9TY6ROpRrO1z7aOZTmTEuDArv8bGem1yurrqLht2X3ynVrBTzfp5wv08KYgdDW7u/Te
         iqSqmakFVwuEPteoIDBNtVln0eQP3bJDhwdDhnd/5KL4P7V8XeVS1sgD3DV/eenvzxLi
         LZtXwODS/AaeHEBvRf2AoFXltNBhbK4BFm3CBgdDOdnc+IAeqDW29+WrA+U7+VuBjef+
         5oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737753159; x=1738357959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGzkSXXrA7jYqSv+MBWBhKjKjIZTADsGXE7oxPj/cDg=;
        b=WP4qoF/Jfi3sKdw2oorHTUqAMgjsFGZ8EgFhclSY8wu3hq7184nfThl/8wI9xpHWTY
         /bU5AH4p4Fhu04y3GjkBjjNenZh7is4GccgAYDIBk8hdv7+gIPVeOoz9y3XjK4hYjl4l
         ShN0PGmqbZb0p+BtfwPf/dmq5hKZ7XELekSTE0nkvVB5P6Fx0sgMIrgSnx5JtAyarWM4
         GyjDJ+s1nAz1FPhKHVF7DcUJTXAWXkoWEDUGfdkItwIr9JwGtsGVuB/yZ1as5i8OSbhJ
         hVFeQIg4QyOLF4N71c2d/MH0kFsnuNeVFPv5YNUecdTvVjWzL2i23CAWDwUCP67CV4pI
         jS/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB0kh/59darwr53TwfOXzhN7soRvNbzIDX1Y9uBGdRbrBYf+vk1x/Xt/bijeE+QYk+6dTQlgw=@inria.fr, AJvYcCWthuAdt+OH5mvxZzHMl1XQ0TmBPQwcSoo7nUPY1Pmz0eu6vYQOWpO/DpL5DkAZkyPvGp2od+o0bEzqZEk=@inria.fr
X-Gm-Message-State: AOJu0YxJR49cBiV4X2oOTl/NiwfKvPyoOVAJct2V49SfdkZgzO2verGc
	aDWBTTicPkJu31YyfC3GuLqGeXuUBhk3l3sdT12LrpmLki6JK+M8
X-Gm-Gg: ASbGnctxMQy5rCnHAaMU16CEH0PdRg9nICiGYbgT9xp1jvRrSLmao/JT9Vtb9rv+32b
	z3RZyeKzGPuBXDzjIXsAZgPo0+B+jF6JlFmmRdUgmzB1TcUO9GAoRfGAYZ9h/PxGUQZD1Wrbgwc
	eGXW5XFyztf/HSJ5H3ptD2IPyCdwm+s3KLRmhhN7BVZEO5/ZXVzOF4AKUUY96IjwadfH2m3HkJa
	YT5RDiMzAWBPA0nqe4LF2sTQGy3zeEfemJmAaRjzzAd37X+S2jMHHg9ccRNJ+u7RJvBbqvAI1lx
	XiuGTHHsgt2csCqrtZzN3MVfCPbctvatizr8tO/wDuXYX60stJg=
X-Google-Smtp-Source: AGHT+IGQunDQe7Ga5HOHK7oamtTMzDBL11HRtkIJFu1joG/eqDIl8j9Lzcy6B1FtF7LxRuD9eZKMmQ==
X-Received: by 2002:a05:6a20:a11d:b0:1d9:aa1:23e3 with SMTP id adf61e73a8af0-1eb215901d5mr59465264637.32.1737753157707;
        Fri, 24 Jan 2025 13:12:37 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb? ([2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac495d5531bsm2099472a12.47.2025.01.24.13.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 13:12:37 -0800 (PST)
Message-ID: <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
	 <mchehab+huawei@kernel.org>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kunit-dev@googlegroups.com, 	nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, 	Julia.Lawall@inria.fr, kernel@collabora.com,
 torvalds@linuxfoundation.org, 	gregkh@linuxfoundation.org,
 daniels@collabora.com, shreeya.patel@collabora.com, 	denys.f@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, 	melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, 	broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org, 
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Date: Fri, 24 Jan 2025 18:12:24 -0300
In-Reply-To: <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
		 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
		 <20250124081250.GA24731@pendragon.ideasonboard.com>
		 <20250124135203.040d0852@foz.lan>
		 <20250124130021.GA6853@pendragon.ideasonboard.com>
	 <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2262
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/bd37528d1c704951cb86a751a5c81e4c76962f51.camel%40gmail.com>

On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote:
> Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Laurent Pinchart a =C3=A9=
crit=C2=A0:
> > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > >=20
> > > > > It's been a few years since I first thought on finding a good way=
 of helping
> > > > > kernel developers testing their patches, while making use of the =
free runner
> > > > > minutes Gitlab offers. It can greatly simplify the testing for pe=
ople who are
> > > > > new to kernel development, or students trying to understand it be=
tter.
> > > > >=20
> > > > > And this patchset allows that to happen :)
> > > > >=20
> > > > > Actually, I spoke to Helen last year, and to enable it to run on =
the free
> > > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > >=20
> > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redha=
t.com/ =20
> > >=20
> > > Sounds interesting!
> > >=20
> > > > Gitlab as an open-source software project (the community edition) i=
s one
> > > > thing, but can we please avoid advertising specific proprietary ser=
vices
> > > > in the kernel documentation ?
> > >=20
> > > Every time Gitlab is mentioned, the brand of the company that
> > > developed it and has been providing proprietary services is also
> > > advertised. If you're not happy with that, you should move to use
> > > a git forge developed by some open source community.
> >=20
> > I'm fine mentioning the gitlab community edition, I'm not fine
> > advertising gitlab.com SaaS in the kernel source tree.

Hello Laurent,

I see your point, and I see no issue on removing the two last lines of CI_T=
AGS
documentation.

I just added this information on documentation because the default runner u=
sed
for the Free Tier of Gitlab does not work for this CI, as it needs more
resources to run. This information can be added on some other place, but at=
 the
time I thought it would be ok to let it be there.=C2=A0
This other runner I mentioned in the patch is also available on the Free Ti=
er
(free as in beer).

I would like to make it clear that I have no connection/affiliation to Gitl=
ab,
other than a free account in their system, which I use for some CI. I have =
no
interest on advertising anything from them.

My only objective is to make it easier to hobbyists/beginners to use those
available free minutes to test some change before sending the patch, if the=
y
think that's valuable.

>=20
> I've just looked attentively, the intention is just to explain you may ne=
ed to
> set gitlab variable in your project fork in order to select correctly siz=
ed
> sized runners in your own instance.

That's correct

>  Its is not strictly about commercial gitlab.com instance.=C2=A0

Exactly, the change is about being able to choose the runner you want.

> The default only works with the original project used
> instance (which is not gitlab.com as far as I know), but the comment refe=
r to
> companies that will choose gitlab.com internally to reduce their IT cost.

Correct.
Companies can benefit on that, but my focus was on hobbyist (or begginers) =
who
may want to test their patches on free CI before sending them to the ML.

>=20
> Its quite a stretch to call this "advertisement", that makes it looks ver=
y
> dramatic. I personally believe its quite ahead of most other gitlab CI to=
 take
> into consideration running these pipelines on foreign (to the project)
> instances.
>=20
> Nicolas

Thank you!
Leo

>=20
> >=20
> > > The way I see, the best would be if the CI integration could work
> > > with more than one type of forge and being able to use any
> > > free Git??b-CI runners that would be available for developers to
> > > use, as this would allow testing more subsystems with CI, thus
> > > increasing code quality.
> >=20
>=20

