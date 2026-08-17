Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064ABC5B572
	for <cocci@archiver.kernel.org>; Mon, 17 Aug 2026 07:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=WNZ1E4rL+SU/YqoSMpvG/W9/4ld37Pvt6CrdV4W2B6A=;
  b=FRHw7DSSZoVBWL8H97D8526qrdElGt+CvQUwZ0I9MihGzDba0LrnIuvO
   aVvDHEaJkys7ncC+etnCAAKpNdYtikYR0j4Ijhfx71LxLmbfoH33xR+lw
   CTlHJN75wLFwp8cZWlZbRVFwApKqylSKj2aDXwSV9migJhpfoJC/Cjbq6
   s=;
X-CSE-ConnectionGUID: DgTbGVq/T5eADTcYMvsFUw==
X-CSE-MsgGUID: 0h9pw1jKRKuDNr5pUavJBA==
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
X-IronPort-AV: E=Sophos;i="6.25,228,1779141600"; 
   d="scan'208";a="290358528"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2026 09:58:16 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BB82D81619; Mon, 17 Aug 2026 09:58:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2B73D80EC2
	for <cocci@sympa.inria.fr>; Mon, 17 Aug 2026 06:03:47 +0200 (CEST)
X-CSE-ConnectionGUID: clu1f3PERzS4EwU3v4azjw==
X-CSE-MsgGUID: 3trQw645Qw2tnaLvYZbjZA==
IronPort-SDR: 6a828822_6o6t5XhVwWYvJ1eczEKQBLyiANB/ZDqjhdprLQG0C1MH9q9
 wWOmgVujlJWWhmxvEgbracSIB2FQ7roGSXE0LXw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GZBwDCh4JqfKvXVdFaHgEBCxIMggULgW5TgWkzBFSUK?=
 =?us-ascii?q?oIki3eHVYpPFIErPQIPAQMBCwEBTwIEAQEBAgQ4gRIBgzMCjWUFAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOE?=
 =?us-ascii?q?imGTw2CYgGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBQIsXwEBAQM6BgEbHQEDDAYFGC4QEhEBBQEcBoU4AQYQAQM3AwG5N?=
 =?us-ascii?q?ItvgRcFAhaBAYINBtpqChkoDXIDgWYCBwkBCgEBgTeEeCpPDoJAHwGFeIQCe?=
 =?us-ascii?q?icPgVVEhEA+hAYVhksiBIIigQyTEQgHMQkJEwYKAkgHBAoSAwQDBAQBAgsTC?=
 =?us-ascii?q?QMDAg4CCAMCCAYZAT8SBBMKDQsHBR8KAgwUCigiBA4rCgNWMAEIBgICBAQCB?=
 =?us-ascii?q?AIKAgMGAgIFBwIRAwQBAQgCAgMqAwEDGQgJCAILBREYDAsHMQMQCQMCHQ8IF?=
 =?us-ascii?q?wUIETQIBhYBGgYFBgsBIBYUAQUMEQECGwIgBB0BEAgDAQcDEQQCAQkDBBYEA?=
 =?us-ascii?q?hQKFB8DAgwCBggMFwICAgYCAwMDCgECAQcDAwMCAxkHBgMDAQEDAQQEAwMCA?=
 =?us-ascii?q?wUBAwMDBQICCgYJAQEBAQMCAggDBwMKCQIFAxsDGwUBAgIDAgECCAMHCAMIB?=
 =?us-ascii?q?QMEAgMDAwQBAgIBAQECAwEDAwQDAQYCAQMHAgIDAwMLAQIDAwUDAwUFAgIFB?=
 =?us-ascii?q?QMFAgIKAgMDAwIBAwIcCAMGAxIBEAMDBgEDBwMHAgQDCQIIAwMICAMXAwMFA?=
 =?us-ascii?q?QICBAMDCAgEAwMEAgIDDAUDAgMDBQMDBwIEAgQDAwEFAQIHAgMHAgEYAwIEC?=
 =?us-ascii?q?AcHBQILBAIIBA0JBAIEAgIPBAYDAwcBAQIBBwUGAwICEQEICgUGAgICHQMdA?=
 =?us-ascii?q?QIBDwYBCQUCAQUOBwUCAhgDBgEBAwYFAQMBCgsBAQIBAgoBAgQCBQMDAQMCA?=
 =?us-ascii?q?wIGAwMCBQUFAwkHBQ4JAQMDBgUCAgMCAwECCAQGBQMCAgMFAQQDBAMKAwMCC?=
 =?us-ascii?q?AMDCAMLAhoCBQMDAwMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBA?=
 =?us-ascii?q?wMICxUlAwEFAwMCAQMCBQMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFBQUEB?=
 =?us-ascii?q?QYCBAMIAQEFAwMLDQECBwwDDAYDBwMDBAQDAgUMAgIEAQcDCgcJBwMCAwgBA?=
 =?us-ascii?q?QsEAQMDCgMDBQIBAQcFAwYDBwIDAwMFBAUDAgsDCQILCQgTPQwHMgQ2ARQUB?=
 =?us-ascii?q?QQlgQCOJSCCSIENTphtjxOLeJRjNAeEIYFgBgygAzOXU5MZhT2TS6kYAgoHB?=
 =?us-ascii?q?xEkEoEyOoFcTSODN1ADGQ+OIQwWHINEzDkkNT0BAQcCBw4DC4Fog1sRjBUzg?=
 =?us-ascii?q?UwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:si01j6xuEvsA2vU898p6t+e2wirEfRIJ4+MujC+fZmUNrF6WrkVRy
 2EaWWDTM/eLZzShfNlwbIu2/B8BuJLTndRrHlRv+C00HyNBpOP7WeiUfxz6V8+wBp2aHRg/t
 63ySfGZcZtqFieEzvuJGuK8xZWp/fjQHtIQMMadZGYpA1MiEH5/4f5as7ZRqpZyhtSkCB+6t
 9r3osnOUHeowDcc3lg8sspvkzsx+q6v0N8klgZmP64T7AaBzyB94K83fMldEVOoGuG4IcbhH
 44v/JnhlkvF8hEkDM+Sk7qTWiUiXr7IMAGSvWFdUq6kjwIqjnRaPnETaZLwwW8O49m4t4gZJ
 Odl7PRcei9wVkH4o9nxZjEEe81IFf0fqeWfeRBThuTIp6HOWyOEL/yDlyjaN6VAkgp8KTgmG
 fD1tFnhx/1M7g676OvTdwViuigsBMLvIdoR4UlN9yPiUds5fMvdH6zY58ANiV/chugWdRrfT
 88QaD4qdBuZJhMWZQ5RB5U5k+OlwHL4dlW0qnrP/ftxszWVllUsluGyabI5efTSLSlRtkqdp
 37c7iLlBQsdN9yY1xKK93utgqnEmiaTtIc6TuzgraUy3gzOroAVIEYKT2Kk/6Xks1HkR9RWD
 1IlyCAsn4FnoSRHSfGmAkTg/y/a1vIGYPJbFOYx6SmW26/M6kCYAHIFR3hPcrQbWNQeQDUr0
 hqRkIqsC2Uw6fuaTnWS8rrSpjS3UcQIEYMcTSQAUFILuOHOmpMI0j/Qc419TKenjMKgTFkc3
 Au2QD4Ca6L/ZPPnOo2+9FHDxiqj/93HF1FsoArQWW2h40VyY4vNi22UBbrzvKsowGWxFwjpU
 J04dy62sb9m4XalynTlfQn1NOv1j8tpyRWF6bKVI3Xey9hd0yX+JNgPsW8WyLZBPcEDdjvkK
 E7VskU52aK/yECCNPctC6roU5pC5fG5SbzNCKqIBvIQOcMZXFHcrElTibu4hTyFfL4Ey/xnY
 c/znAfFJSpyNJmLOxLvH7tMgOZymn1lrY4RLLiipymaPXOlTCb9Yd843JGmN4jVNYvd+FqNo
 eVMfdCH0QteW+DYayzau9xbZ1MTIHRxQdi8p8VLf6TRakBrCUMwOc/3mLkBQo1Cm7gKt+Hq+
 nrmZFRU5mCijlL6KCKLSEtZVpXRYbhFo0gGYBMcZWST5yB7YKKEzrsuSJ8sTLx2qM1h1aFVS
 tcGSeWhA9NOaDfNxDBFZp/+sYBNJQWh3x6JNXGXSQplJp5peBPUy4W1Yiru6yg8IS6lvuQuo
 7Cb9136QLhSYy9AHcrpePaU4FfphkckmcV2RFruHtZIXkfnraxGCnbUteAlBu0yJTHo5Cqo5
 yzPDTg2/eDy8pIIqv/XjqW6nqKVOupZHG8BOkLE7LyzZBLozkD6zaBuCO+3LC3gDkXq86CfZ
 MJQ/fH2ENsDuH1o64NcMbJa/ZgS1uvVhY1x71pbRS3QTlGRFLlfDGGM3pBPuo1z17Zpg1aKd
 XzVyOZKG4eiGZ3DK0EQFjoHf+7Y9PAzmxvu19oXDnj+xhdK+OugbR0PETiK0DdQPZlkArMDm
 O0BgvMb2ya7qxgtM+uFsBxqynSxHiQAfpgj574nA97Nqws0y1t9T4TWJQ3o7bquNdhdEEkYD
 QWFpajFhoZzn1LOU1huMX73w+FY1I4Hl0EQ9XAOO2W2nsHhg9kp1iZw6hUydBxelT9c4tJwO
 09qFWB/GqHW9DFri/ZsDnGmQR1GDkao+0LK1FoCklPCfXSoTmDgKG4cO/6H2UIkr0ZwT2N8x
 66J7mTIShP4VZjB5TQzUktbtPDTd9x92QncksSBHc7ePZ0FTRf6o62pd0waggDGBJ4vuUj5u
 uVaxuZ8RqnlPyo2oadgKY2716wVeS+UNl55XvBt06MYL17yIAjo92C1FHmwXcdRK9jh00yyU
 ZVuL/0ScSWO7n+FqzRDCJMcJ7NxouUS2+MDXbHWPk8DjaqUq2t4kZDX9xWmvlQRffdVrZ8fJ
 L/SJhW4KU7BoVtPmmTIkttIBXrgX/kAez/H/b6U9McnKss9ld9CIGAI76uMnnSKMQFY0Qqek
 yHdaoT3keFz64ResLH9M6dEBg+LB8v5f72XwhKer+ZMQIjqCprIvVlErFPIAhlnZ+oNetVol
 IaitMz881PFsY0XDUHYucilPItY6fqiWNF4NprME0Bbui+ZSurA0gAm+V3kGadWkdhY2Nard
 zG4ZOS0a9QRfdVXn19RVARzDDcfDP7RQpr7hCbgscmJNAcR4TbHIPyj63XtS2NRLQ0MGp/mD
 z7Lq+Sc3c9ZoKtMFS07KalfWbEgG2DaWIwia9HVnhubBDPxglq9553TpSB54jTPUnS5AML25
 KzefSfHdTOwhbrpye9IuIkjrzwVC3dA2dMLRHw/wOIvqT6GDz8hF98/YKU2UsQe1mS40Zzjf
 zjCYVczESi3D3wObRz458+lRQuFQPAHPtDiPDEy4keIcGGMCZidBKd6vDJVi5usluAPEMn8Q
 T3fxpHxAvR16pRgROJW/vPixOk+maqcyXUP9kTw1cf1Bn7yxFnMOGNJRGJwue7vSqkhV3kn4
 UA6QGlFRAewTkuZ/QNIZStOAB9A1N/w52xAUMpMqeozf62UyeRBzLv0POSbPnjvqigVDOZme
 E4bjFdhL4xbNrL/dEfpVx8UbXdINM+2
IronPort-HdrOrdr: A9a23:0+3NAKmQJ4t01H8OZ4kUVGxTyPPpDfMuimdD5ihNYBxZY6Wkfg
 6V/cjzsiWE7Ar5OUtQ/OxoXZPqfZqyz/NICOUqUYtLsmHdyRGVxcJZnPDfKwSJIVyCygcl79
 YdT0EmMqyOMbEZt6bHCXiDYrQdKYK8gceVbI7lph8GcegNUc5dBmxCe2Wm+yNNKjWuLKBJZq
 a0145opyeAZX9SRt6gBncDU+TYzue75K7OUFopBwMH9ALLqDui5LvheiLorys2YndgwaoC7W
 OAtArl5qqy98i/wgLS0XTWhq4m5ufJ+59sBNGslsNQEynojz2lfJhsQaC5oTgpvPvH0idYrP
 D85zkhIuVu4DfrcmmupxyF4XiZ7B8er1Hj1H6Fij/Zrcb4XTI3DNcpv/MhTjLpr2QhofBh2+
 Zx02iYrppaCg6FtCnx/NTTTXhR5z6JiEtnv+4PrmBVFbETb7JctuUkjSVoOZoNBj/774g7EO
 9oFqjnlYNrTW8=
X-Talos-CUID: 9a23:OiPPp2PX8fglAO5DUy16rUBPIu0fYEaB4WjteFHkAHRrV+jA
X-Talos-MUID: 9a23:Ihi9qQbTHkHHEuBT7CP2vS48aJpR/P6yDkkpj6Q0scu2HHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,228,1779141600"; 
   d="scan'208";a="290330695"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEzURtdndDXPjt3xecDjJyeCeacGw/3CDsNwT?=
 =?us-ascii?q?MZSje2wmmg2NTzHQr9lKON8WrE42tL7NY1ZMAi2jxUVuR/HTYsKKbwF5?=
 =?us-ascii?q?/fy8JWxjIDoXIlTeeb4dhvGerryV6ZcmSf4QikHQA7x3f/9rhk73do9M?=
 =?us-ascii?q?aM8ENT9k/dvoooMywc6i6WsA=3D=3D?=
Received: from mail-pg1-f171.google.com ([209.85.215.171])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 06:03:46 +0200
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca80d708489so1558074a12.1
        for <cocci@inria.fr>; Sun, 16 Aug 2026 21:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786939425; x=1787544225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNZ1E4rL+SU/YqoSMpvG/W9/4ld37Pvt6CrdV4W2B6A=;
        b=gJns0cCzP+xbrQdTwfMF79ijplHNHFzQHpbRnDnuuzZ1fmt/KHy73buxg3HAFXojBc
         MUdxIru2TmgS9cBD/qkh29gtRHaJjxwPEHpv+tqkBkUKCEXBBO+EZxf+KtqL43izdKIZ
         eRSH3uxvcb96bvkZVvYCxp6YrzR7SNicUoozYc1vpk0I4Z92uMo5RhuuOUoeNw03bR13
         9/VgFtea2sogG8RYGcxXLtMiOq6yK8weCdIUYSSvSIui6mzQBBqGX081IXJVCD+SFDOz
         4fCyW1orVCwooy+fLSBDd34pDMhCu/B4R9OE9PWYBGjv5viZKAS76AO4lxcUoZ97UbhW
         VTJg==
X-Forwarded-Encrypted: i=1; AHgh+RobfDVIQc1cl6D3fph+/4bWzy3FJKs6lblHgm9JXOvpjFBhjPrKHJLHNh9HquZOccfhrwN1XA==@inria.fr
X-Gm-Message-State: AOJu0YxEL96F7CdVf4Jo2zyk2eZKl7u2ICCOL9MIvJVQkxbXU/5jArb2
	GOFuyAH+sOraiRaCXE2BszQPGGch+WaZ39VFPPw8WyPUG58Ch/cJitCk
X-Gm-Gg: AR+sD10eWXvgoyyLRh4v7g1W2QAcxsa689bnXeCl8sRtm/E4NSFr0q7xPuPwRjjTznK
	Pub06gUwRz6lmBJ2LcFJCeijy8ODwu/UINhi+I3mep7gyJXqzzvvfTyeGTDo7puVq0IkGuOmQH1
	NqRkmtqsWdjfY6pJdbk9l6+tWKKESrDobHriwRDpJtlsPxnnVZuW78CgNRNNQYxkMB76KUigswG
	UdNmyxBWCI+Buzm9MdrRme60lhOAvBJQRm/j1+pny2rmMDcTCPbqybyzM4ESIp74bQGEy20whWB
	PqkLMt60ylvmwwDQk0UuaTByOzj0IB5KgrbI6+F5PBcxkshOkCBbSNvbFRzNU4p+65t8BmnWVS8
	svWKc4bgKtc+ojaP/JhhKj7NsYY8Is4E8PkzU5LlcNzxWanMKF+zupoIS3MBo7ER5cEqJovcLOk
	16M7dflG6c5Gl+F6pMJpIIveigO+MHf/VcqrPj7ji54D0ATgPBaFVGcB9nSVTJ7JaPC7QSEpoMo
	mU46k0wpk11HathHS+aSZ98CHcEDSyhpwKE8PVV
X-Received: by 2002:a17:90b:5630:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-3931f24d641mr23244322a91.0.1786939424631;
        Sun, 16 Aug 2026 21:03:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5ab4:90f4:c0f9:b344])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14153064d86sm1615556c88.6.2026.08.16.21.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 21:03:43 -0700 (PDT)
Date: Sun, 16 Aug 2026 21:03:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cocci@inria.fr
Message-ID: <aoKDE_9t4yYLdmCt@google.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
 <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
 <5e96c91-164f-9ec5-43e4-474189e2a337@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e96c91-164f-9ec5-43e4-474189e2a337@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 02/21] HID: add documentation and Coccinelle
 script for FF registration race
Reply-To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3680
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/mIXazwh8p_Gwa6Bww21efw>

On Sun, Aug 16, 2026 at 08:52:51PM +0200, Julia Lawall wrote:
> > diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
> > new file mode 100644
> > index 000000000000..479f5d1e3184
> > --- /dev/null
> > +++ b/scripts/coccinelle/hid/ff_race.cocci
> > @@ -0,0 +1,34 @@
> > +/// Detect HID drivers that initialize force-feedback after hid_hw_start()
> > +/// when HID_CONNECT_HIDINPUT is used. This is a lifecycle violation as
> > +/// the input device is already registered.
> > +//
> > +// Confidence: High
> > +// Copyright: (C) 2026 Gemini. GPLv2.
> > +
> > +virtual report
> > +
> > +@r@
> > +identifier probe_fn;
> > +expression hdev, flags;
> > +position p1, p2;
> > +@@
> > +
> > +probe_fn(struct hid_device *hdev, ...) {
> > +  <...
> > +  hid_hw_start@p1(hdev, flags)
> > +  ...
> > +  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> > +  ...>
> > +}
> 
> 
> This seems unnecessarily costly.  The pattern can be just:
> 
> hid_hw_start@p1(hdev, flags)
> ...
> \(input_ff_create\|input_ff_create_memless\)@p2(...)
> 
> Or does it matter that struct hid_device *hdev is the first parameter
> of the enclosing function?
> 

I guess not. I was trying to limit the check to what looks like HID
driver probe function, but that would miss similar issues in helpers
that use different order or set of arguments.

Thanks.

-- 
Dmitry
