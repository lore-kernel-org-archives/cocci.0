Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84051D3B7EA
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=UyAV6b1dCSPUCut9ORTRvQyMGZe7GCYluMBZNHP/w0U=;
  b=fMOJIPVP90Pyo4HxM+B3PT9GnlYypdcvzDTlQYmhpbnhdNlNEwY/uccS
   w9EIod0HcHj+VFq1h1+HqAbf5L5nbiVNSlZkxaEY4N7oinSN/kGEe2IIY
   9AyOhksx56Jyclh5gBWaOg+T8ajLDPKzTwBY33id76y/jn2TEGf82XIq8
   0=;
X-CSE-ConnectionGUID: k+Gp7dhNS56o1I+kC18N6Q==
X-CSE-MsgGUID: TZOTpie0TNqhuN7oILtXtg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253494864"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:09:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DB72E0CEC; Tue,  9 Dec 2025 11:09:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 23DA9E0157
	for <cocci@sympa.inria.fr>; Tue,  2 Dec 2025 20:31:41 +0100 (CET)
X-CSE-ConnectionGUID: LxEVF6G+R6KIk3+FN6Db2g==
X-CSE-MsgGUID: 53QsiJIFSVeHTSHaJviOhg==
IronPort-SDR: 692f3e9c_xIi24R/la1+1+3eOSrURxiLtExTquDOV6ULj7ZfchsjDNi5
 69tjaq9ClGts2i7RRM1TQsQYETM1in0vDT/LoMg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G3AQBzPS9pfLHWVdFaglmBblKBAl8zBFQElkWYP4Veg?=
 =?us-ascii?q?X0CDwEDAQsBAUQLAgQBAQMEhQCMaQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQ0BAQUBAQECAQECBAYBAhABASIZBw4SKYZPDYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAg2BABYgAQ0BATcBgRMBBQEiEyKCYAGCIgEGSgMBEKNzgQVCjHCBA?=
 =?us-ascii?q?YIMAQEG3CeBZAMGCQEKgTeFbodjcYN+gSEbgUlEglCCLYJKgVuGYoM0hiKTO?=
 =?us-ascii?q?kiBHgNZLAFVEw0KCwcFW4EIAzUMCyoVbjIdgSM+GHOEXR5nDwaBEYNPBokRD?=
 =?us-ascii?q?4gBgjwjAwsYDUgRLDcUGwY+bgeUHE+CMYEOHBCBIJQ6gzWPEYE1n1mEJoFkD?=
 =?us-ascii?q?IoulTlNl1IMkw0uh2WQc4wOgXqWUIQ9AgoHBxEkgUQ6gVwzGjCDKhI9AxkPj?=
 =?us-ascii?q?i0WiHG/bSI1AjoCBwsBAQMJhUMmE4tuKwmBSwEB?=
IronPort-PHdr: A9a23:srdxuxCqc5RoWLnYjwzMUyQUrEoY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4xygeRFtSHo7Ic0qyK6PumATdBqb+681k8M7V0HycfjssXmwFySOWkMmbcaNPMUWkRM
 f8GamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj4RvJrwtxhfVrXdFf+tbzn5sKV6Pghrw/Mi98ZBt/ihKp/4s+ctMWrjmcqolS
 rBVEDspP2cp6cPxqBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVM8PuQr84QCqv4
 ah2RhPwhygJKzA28GfMisxtl61buw6upwZ+w4HPfo6YMud1c77HctMbQWpBWdtRVzBED4ihY
 YYDE/YNMOBFpITmuVAAsQWxChWtBOP3yz9HmHn23bEh0+88FQ3KxREsE84SvHjRqtj+KaUcX
 v2vzKTQzTvNce1b1yrz5obLdR4urv6CUKlsfcfS00QjCxnIgkmMpYHjIjib1v4Ns2+e7+d4S
 O+vkW8npBt3ojOy3sksjZPJhpgUylDf6C50x506Jce5SEFhZ96kFpxQtzuAN4t3WcMvWH1nu
 CYgyr0BvJ67fTUKyJE9yx7YcfyHfJGF7xT+X+mePTl2nmhqeK6jhxms60igzPXxW8a13VtLo
 CRIncfAu38D2hHR9MWKV/pw8lmv1DuO2A7f9uFKL08qmafVK5Ms3LE9moYXvEnfECH7nEv4g
 a2Le0gi5+Om5ePnYrD8qZ+dMY95kgL+Pbo0msy5H+s4NhICX2+B+eSz0rDo4E73QK1Sg/Eoj
 qXUtIrWKMcbq6KjHQNZz4ku5wyiAzqk0tkUhWcLI0hZdB6bioXkOVXDL+7kAfq6nVijjjVmy
 OzDM7DiB5jCMGPMnKn6crt49kJQ1QU+wcxa6p9VCrwOOuz/V0rsu9PFEBM2LQq5yPv9Btpnz
 IMRQ2ePD7eZMKzMtV+I4foiI+yWa48UvDbxMuAl5/rzgXMgl18RYKuk0JkNZHC3GfRmJEqZY
 X7yjdsbDWgKuQ8+QPTriF2ETzFTe26/U7wg6jw/Eo6rDofOSpqzjLCc0yq3BIBaa2JEB1yUF
 HfnbYSEW/MCaCKIJc9hlyQJWqO7S48gzx6usgn6y719LurO+y0Yronu28R15+3JkhEy8D10D
 9mY022XSGF0hGwISycs3K9juUx91kuD0a9gjvNEEtxc++9GUgYhOJ7Hz+16DsjyVRjbcteIT
 lamWNSmDisrQtI/2d8Ce0B9FM66gRDZwyWqG6MVl6CMBJEs767Qx3fxKNh6y3jFzqcsl1cpT
 NZXOW28mKF/6QvdCZTRnkWcjamqdKAc0DfV9GeH0GaCpU9YXBNyXKjHR3wfaUzWrdP25kPGU
 bCiE6goMgxEycKaN6RKadzpjVBeSfn7N9rRbXy/lXusCBiO3r+DcY/qdH8H3CrBEEUKixkd8
 26JOwQmHSehu2zeASR0G1/zfk3i7PFyqGijTk861w6Kb1Nu176y+hMNnfKSUusd0L1X8Bsm/
 n9OFVi00taeKZzImBt6e65fYJl1tE1O22vUsyR+M4amIqQkgUQRJVdZpUTrgj9tC4xG2e4tt
 mkr10ImI7iZ2VVHcCmC3IvYMb3NLWzz4RXpbLTZjAKNmO2K87sCvaxr427ouxukQw97qy0PO
 7h91nKd4s+PFw8OSdfrVU1x8RFmprbcay175oXO1HQqP7Pn+iTa1YcPA+0ogg2lY88ZKLmNQ
 QXoEsQcAc+0Mu0xs1OpdBUBPf1XsqkuMJDubOOIjZaiJ/0ohze6lSJC6YF53FiL8n92UO/B2
 ZAC2euZxSOMVy37iVa8t4bwg48XLSoKED+Zzi7pTJVUerU0fYsPDjK2JNarw9xlm5P3c3tR9
 VrmH1dfncHwJkXUYFv60gldk08QpBRLgAOeyDp523Esp6ubhmnVxvj6MQAAMShNTXVjilHlJ
 c61icobVQ6mdVphkhzt/kv8y6VBwcY3Z2DOXUdFeTT3JGB+Q+OxsLSFectG9JIvt21eTu29Z
 VmQTrO1rQEd1mvvGG5XxTZzcD/P2N2xlQZ7gWSbK2xprWHxcsFqwhLe+dmaQuRen3IHSCR+l
 TjLFw2kJdD6mLfc35zHs+24SyegTsgJKXitnd7G7nLnozQ1Xk7a/bj7gNDsHAkk3DWu0tBrU
 X+NtxPgeszx0K/8N+t7f05uDVu66sxgG4g4nJFj4fNYkXUcmJiR+mIK1GnpNtAOk6jkbXMLQ
 zkR2d/OyAPlwkpmL2+MgYXjWT/Op6kpL8n/eW4Q1i8nuopAEqad6rpDhzF0uXKzrRjWZPlgm
 3Ea0/Rkuxt4y6kZ/QEqyCuaGLUbG0JVaDftmxq/5Ne7tKxLZWyrfNBczWJGlMu6RPGHqwBYA
 jPif4s6WDV35YN5OU7N13v67sflfsPRZJQdrE/cnxDFhulTYJU/85hCzSB9OGv7u3o/0e8gp
 Rdux5a/vZWCbWJ38+q1DwVZOTv8e84Ismu13OAOw4DMhtzpR8o+UjwQOfmgBeqlCjcTqejqO
 06VHTswp23aUbvTEAmD6Vt3+nfGEpSlLXaSdxx7hZ1pQBiQIlAagRhBBm1r2M5kUFrzmIq4L
 xgqg1JZrkT1oRZN1O9yYhz2U2OF4Rytdi9xUp+Uahxf8gBF4U7Rd82Y9ON6WS9CrfjD5ESAL
 HKWYwNQACQHQEuBUhrpJLin49/H6fKZHcK1L+HJZLSTrKpZTfjClvfNmsN2ui2BMMmCJCwoB
 ec600xFWmpjGt/xkDUVTCkWiieLaNSU7kTZmGU/voW09/LlXxjq7I2EBu5JMNlhzBuxhL+KK
 ++agCsqYSYdzJ4HwmXEjaQOxFNHwT87bCGjSP5T0EyFBLKVgKJcCAQXLj9+JNcdpbxpxRFDY
 Ibako+nieI+16RoTQ8DDRu4xImofZBYej7mcgqWWADTcuzBfGKuoYm/YLvgG+cI3aME6lvp4
 2bdSwi6YXyCj2W7DUnxd7wcynjKZloG/9jsOhd1VTq5FYygMEbqdoQty2VxmOxR5DuCI2cYN
 XIUn1pliLqW4GsYh/x+HzYE9X95NayenC3f6eDEK5EQuP8tAyJulusc7m5og71SpDpJQvB4g
 k6w5pZnvk2mn++TyzFmTAsGqzBFg5iOtFljPqOR/4dJWHLN9hYApWuKDBFCq9xgA9zp86der
 7qH3Lr0MytH+snI8NE0AsHVLIefNCNkP0O2R3jbCwwKSTPtPmbaxgRcnPyU6nyJv806p5zry
 /9sAvdQUF04EO9fC1wwRoRTZscqGGl9zfjC05FbgBj25APcT8hboJ3dA/ebAPG1bS2ckaEBf
 RwDh7XxMYUUMIT/nU1kcFhz2orQSC+yFZhApDNsaggsrQBD6n97Gyc5wUPsbAWq+mUSDta/n
 gQxjwpjZKIq7jimsDJVbhLa4TA9lkU8g4CvmTeKbDv4N7u9R6lTAivw8lA1a9b1GlkqKwK1m
 kNgOXHPQLcb3N4CPSh7zQTbv5VIA/tVS6ZJNQQRyf+gbPItyV1Aqy+jyCevCsPOCYFlkQo3d
 NirtX0SgmqLifY+JbbXIatUyx5XnK3c5kdAN8g0yQ4aYl4JqSacIXFX/kMPMbYiKmyj+ek+s
 WS/
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rSqAI6wXo/3+/18hyo2TKrPw5b1zdoMgy1knxilNoNJuA6ulfq
 eV7YkmPHrP4gr5N0tQ4OxoVJPwJE80lqQFm7X5X43SJDUO0VHAROoSj7cKqweQeBEWndQts5
 uIHZIObOHYPBxUi93l6BK0H9tl7N6M67CwmOvSpk0AcShaL49lqyl2Yzz0LqS0fmZ77FgCea
 Z0KvAnm9PZQwVtUi1zPBk4Y9Q=
X-Talos-CUID: 9a23:RZe7vG8yMhIiKJd1v8GVv2oEN/4LLFKe9inzAkzjSkhPFpGfE1DFrQ==
X-Talos-MUID: 9a23:O76jfAXShCkEQ1bq/GK3vSpjFuZG2JqjKHw2sZwkpcijNSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,243,1758578400"; 
   d="scan'208";a="252425141"
X-MGA-submission: =?us-ascii?q?MDGtSkRFjIG0tbOm5Zqly8LaBGSxpSlA6XXlWj?=
 =?us-ascii?q?Gfme2PH2UUqjWBQ41HcGxYnzH+f1jtQY5KDwm2aKgBPHysqSeLX60Ynf?=
 =?us-ascii?q?m5wwR+lOAtu6nIpTSDUj75VGbL0y4kQTizlgN/uEdJ3McgeWju7ssyv2?=
 =?us-ascii?q?t1jjO+yDvzvy7XDuvsTfcfWQ=3D=3D?=
Received: from mail-pl1-f177.google.com ([209.85.214.177])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:31:40 +0100
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297f35be2ffso89051725ad.2
        for <cocci@inria.fr>; Tue, 02 Dec 2025 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764703899; x=1765308699; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyAV6b1dCSPUCut9ORTRvQyMGZe7GCYluMBZNHP/w0U=;
        b=eBRQUecv4pdFUG5Fjzlz6mlc7to6/2y3JG0NJXNmmYz6nMb65AXOMRKeEJAeTiUk3x
         yNoVdif9B9/TKTV/foR6N9vw/jt7G5J7mT8xFtHGIDlFHYSpftEm+NwCf48UXqmULlvR
         3sDtscQaXIRK6ek9CW4siHth1GWtpmXR6lLsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703899; x=1765308699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyAV6b1dCSPUCut9ORTRvQyMGZe7GCYluMBZNHP/w0U=;
        b=adoMySnlY+tplpOpFfP/6RgttdkBKU3lKrfsHB7Kx5t1XpTePk2ZE64yvElQWv3wVy
         DcyYP1TiucCB6pbaQEq0Czb4ZVfWnPY0tKhCWinIxKXd/KO5x2zy+8uvZE56dPUgqb4a
         zH5st1RcgtBKVyH+utB+iSoy6p+rJBW6FqvK1T5kXO3SgcjvivfwKbHy/tUjewkpN+t0
         kzsbSTp3UFTjsMyFJl3aZKGkN751Ja8oEAp7b3dOTwju2cnTT+6zrfEBTYWy6vYaVcKP
         bHAkHU4lk1ls6Rb8dgbYIOmah9DPByt0/Xtqa9TcJIii6pU1Y/e/sV4+9gYpqWZ5H2wd
         jr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnzcPY9KGIF0MwSnVlmNlhxjI4WdNiJ7Mvb0wSP/CTU+kFWv2piFUThE9hSdih4sn8KvrM9g==@inria.fr
X-Gm-Message-State: AOJu0Yx6bE0nGwrwZEedWZTbRsMmPDMP9nsfqDNeE87muEvzApeGfgKJ
	+sLUSBBJ6/bygP2/s5O7rpYJ8nktFl4TIYXKuwMFBtgDneUooQ4QRHAacr/IzVlt2w==
X-Gm-Gg: ASbGncvP/9O5n32vruClprWr/3M3E78lYBTZCyWC2B4GgO3OlQv5IigWewCm7EWZYwu
	lFj/6W+TWShz3RamvF790ELFE8RIYWwiNojP3U5nH6/sPnNAVaIlETxnNPpaDj/TKZ/x55mbjse
	FaDOv3q29LGYuodAqXy9yqVzcRk06R8NYEbiFq2GY7emBYCvyS+7LXt6h9MBLnyB4eJKmkdFxVQ
	ajaApEQ6ngAcM2T6MWgw/dUvhns8njSjoMTbaMBj/vVRl2xKHfp0VkPrxf7x1PJSYrqTWLee7N2
	vRRGSNedcWayqkZoD58+1TyLZjj8UhpNjFf6Kuq7kEDBPvF+FhNC8+2DvQkKoSw2+l2Ef2WMPl0
	3nPMzESGkwlGR9swnl2vq6HaoynBhXN9EJGpMJMuuthZ6jJ757/DMj4FS/VEit3QHqUVZJ1bnxr
	TkQ6fcBHcNSW+rSTCNSrA9iM120n3bHYWr6LUeDyR8hRjk/KuPwqmU2xRQygtsMHsktRbYg2A=
X-Google-Smtp-Source: AGHT+IFwi+4LK0qpugw0KBj5fazsKFox+KJ1G9nPqHCdptaKIAv1XlFaC9KoFdl/LTA5slQRRkbFbw==
X-Received: by 2002:a05:7022:688:b0:11b:9386:8267 with SMTP id a92af1059eb24-11defd3855bmr389146c88.44.1764703898701;
        Tue, 02 Dec 2025 11:31:38 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcaed5f6bsm91630110c88.1.2025.12.02.11.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:31:38 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Brian Norris <briannorris@chromium.org>
Date: Tue,  2 Dec 2025 11:30:24 -0800
Message-ID: <20251202193129.1411419-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 1/3] PM: runtime: Stop checking pm_runtime_barrier()
 return code
Reply-To: Brian Norris <briannorris@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3250
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/20251202193129.1411419-1-briannorris%40chromium.org>

Apparently this test is the only code that checks the return code from
pm_runtime_barrier(), and it turns out that's for good reason -- it's
inherently racy, and a bad idea. We're going to make
pm_runtime_barrier() return void, so prepare for that by dropping any
return code checks.

This resolves some test failures seen like the following:

[   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drivers/base/power/runtime-test.c:177
[   34.559694]     Expected 1 == pm_runtime_barrier(dev), but
[   34.559694]         pm_runtime_barrier(dev) == 0 (0x0)
[   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:1

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/93259f2b-7017-4096-a31b-cabbf6152e9b@roeck-us.net/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 477feca804c7..1535ad2b0264 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -37,10 +37,6 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 	pm_runtime_enable(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
 
-	pm_runtime_get_noresume(dev);
-	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
-	pm_runtime_put(dev);
-
 	pm_runtime_get_noresume(dev);
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
 
@@ -174,7 +170,7 @@ static void pm_runtime_error_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
 
 	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
-	KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
+	pm_runtime_barrier(dev);
 	pm_runtime_put(dev);
 	pm_runtime_suspend(dev); /* flush the put(), to suspend */
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
@@ -225,7 +221,7 @@ static void pm_runtime_probe_active_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
 
 	/* Nothing to flush. We stay active. */
-	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev));
+	pm_runtime_barrier(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
 
 	/* Ask for idle? Now we suspend. */
-- 
2.52.0.158.g65b55ccf14-goog

