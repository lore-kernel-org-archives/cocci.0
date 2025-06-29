Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE215C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vCXwiHBFN33s7jcYq6F27fRPf0crjX3I5g+Yn1VEyEA=;
  b=V8xS+4EdwVaGFkbAW5SxfF7xlTEp/tokJATCbIofgN3ZC8LVZ9u48KDC
   QOrbqtf9c5YAXJ9b6x5WwISBXmDDnyy/H+ooZ4/ASrxDRajQwBW3F2Kwk
   xKrAp4GSEJSONXsp1u+WYA7NphyFmcvYU7qjbKNJjbLhI4t/zKeSV2Vbx
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208,217";a="229733344"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 10:01:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59906E0AF1; Tue,  1 Jul 2025 10:01:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9CE5DE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 19:41:56 +0200 (CEST)
IronPort-SDR: 68617ae4_49Hr/sGKnN2Yh4wxfBS+oQ66EV0vM371yxh9IcDEzviSXY0
 JXMnxZ/GGywVf9BLGvGWxjRXdWCHLsKO65/WQUg==
X-IPAS-Result: =?us-ascii?q?A0EkAADmeWFofC+AVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgUAxUoEAWjMEVIRViByHNIF0MItHMoZwhFh5hAeBVYFAPQIPAQMBC?=
 =?us-ascii?q?wEBSgUCBAEBAwQ4hEgCi3ICHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQE7Bw4SHguFNUYNgmIBgSRhAgUDOwEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCDR9fAQEBAxIRHQEbHQEDDAYDA?=
 =?us-ascii?q?gkPKgICIhEBBQEcBhMigmABgiEBBhABAzIDARAGlXuPQIEFQos+gRUFAhaBA?=
 =?us-ascii?q?YINBtpfChkoDW0DgWICAQYJAQqBNQGEdSlcgjwaAQUlSGsCDoRDgzl6J4FjR?=
 =?us-ascii?q?YE8C4EJgW8+gmEBAQKFOYJpBIIiRD4UHYRdhBiCZIw5AQcHMQkJEwYIAgJIB?=
 =?us-ascii?q?RASAwQDBAQBAgsJCgkDAwIOAggDAggGGQE/DAYEFQgJDwwfCgIIBBEKKCIED?=
 =?us-ascii?q?isKA1sVBRsIBgICBAQCBAIKAgkCAgUDBAIEDQMEAQEIAgIDKgQDBhsJCAILB?=
 =?us-ascii?q?RQWAgwEBwcyAxIBCAoGAwYDBAICAgsHAgMDAwcBCwsJAgEDAgIFAgIBBQMCA?=
 =?us-ascii?q?ggDAgEBCQIDAggBAgIBAgICBAEHAQ0BAQIEAgIkAgEDCAYBAQ0CAgQCAgECA?=
 =?us-ascii?q?gIEAgQBAgYLBAgBAQIBAgIBAQEEAQgDAQECAgMDBQMFCA8NARULGQMEBQICE?=
 =?us-ascii?q?gICAQcBAgEBAxkCAQMDBAELAgEBBBsEFwIWJAIZAgEFBQUBAwQLEAkDAgUEA?=
 =?us-ascii?q?gIGAgQOAgcEAhoEAgIBAwQGAwECCAICBwQEBgMBAgIHFwIEEQECAQMCAgIJC?=
 =?us-ascii?q?gQFBAMEAwICAgEMAwECAwICAQIBAQMBBQYNEgIBAw8IBAICBwICIQ8LAQIBA?=
 =?us-ascii?q?QYGAwMDCgMBCgEBBgIBAhIFAgICBAECAgYEJQECAQIBAQEFAgECAQIEAgcCA?=
 =?us-ascii?q?QILAQUCBgECAgkBAgECAgIBAgEBAgYCARUBAgICAgIDAQMGAgICAgICCQICA?=
 =?us-ascii?q?gIFAgUDAgMFAgUCAwMCAgMEAwkDAwgDBgQCAwEBAQIBAgICAQIBBQIDCQEBA?=
 =?us-ascii?q?wIBAgICAgMGAgUFAQMLBQkBAQIBAwUDAwQDBgEGBwQDAgQCAgICBAIBBQMDA?=
 =?us-ascii?q?gUBCwECBAIBAwMDBAQDAQICCgcFAgQBAQEBAgECAgoDAgUBAwMBEQMEAQYFB?=
 =?us-ascii?q?QYCBwkDAgIDAgMCBAMJBAIEAwMCAgIBAQoCAgECAQEDAwcGEAECAgIBDwIDA?=
 =?us-ascii?q?wQDBAYDBQkBAwcBAQEBAQIUAwIEAQQRBgQCAQEeARUCBwEEAyceAgICBwECA?=
 =?us-ascii?q?gICAwICAwMDAQIBAQIDBQEDAgIDAgECAQYCAwMDAgUDAQkFAgIDAQMBBQEEB?=
 =?us-ascii?q?AIHAQICAg4BAwICCQIHCQQEAgETEwICAgIBAgIBAgcBAQIDAgUFCAIBAQECA?=
 =?us-ascii?q?gMCCwICAQIBAgIDAgMCBgEJCAYBAgEBBQQDAwcCAyQDAwQFAwICAgIHAgQDG?=
 =?us-ascii?q?QINBgEEAwUDBQMIAwYCAgMPAwcGBwIHBAIEAgICAgwEAgMDBwUCAgICBAEBD?=
 =?us-ascii?q?QQHAQEDAgISAwEBAQIUAgkDIw8CARQIEz0MBy4EBAwqAQkLFAcGJYEAEJEIW?=
 =?us-ascii?q?4QjEywUgzoBAQGSJoNfjCKiZjsJAQYCYIFngQoVCi2Kd4EmlTwGVZc5kxYuh?=
 =?us-ascii?q?2WQcoslgmKVXIUuAgQBAQEDBwcRJBKBMjqBXHCBboFJUgsOD44hhAC9E0E1C?=
 =?us-ascii?q?zECBwEKAQEDCYVph2uBSwEB?=
IronPort-PHdr: A9a23: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
 5WrqiAYs+qMRNEwLK3UYqFOywoJ7p8=
IronPort-Data: A9a23:gabnbqzUyXFQUt0EUTZ6t+eKxirEfRIJ4+MujC+fZmUNrF6WrkVUn
 GYaUDzTbP+LYWWnLtx0Pt62oU9Q6sLVm4I1SANpr1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmAc3l48sfrZ9Usx5qWq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPtgLJNU0UtYbckueB6Gkdr8
 v4hJRsCO0Xra+KemNpXS8Fpj8UnadbuZcYR5i4mwjbeAvIrB5vERs0m5/cChGZ21p0IRKyOI
 ZZGAdZsREyojxlnNloJDpU4leKl3yOnWzJdoVOR46Ew5gA/ySQriumxb4CEIoLiqcN9pHmyv
 ULn0XvFUlIUaMSD2weCrViTr7qa9c/8cNlPTeXnp6ACbEeo7mgaFxQSUXOpoPyzkEf4WtRFK
 kVS9DBGhaM1/0eqZsLsWgWx5n+CpB8VHdRKe9DW8ymIw6vQphmcXy0KEmEHZ9shu8s7Azct0
 zdlgu8FGxRu8/q2FnaGqo2o7jW/Ig4wKm07aAQLGF5tD8bYnKk/iRfGT9BGGaGzj8HoFTyY/
 9xshHhj71n0pZ5Uv5hX7Wz6bySQSo8lpzPZCy3SV2Ohqxx8PcurO9Pu5l/c4vJNao2eSzFtX
 UToeeDPsoji7rnUy0Rhpdnh+pn0t55p1xWC2DZS82EJrWjFxpJZQahe4StlOGBiOdsedDnib
 Sf74FwMvcYIYSbyNfMuM+pd7vjGK4CwSLwJsdiEMbJzjmRZLlXvENxGPB7Jhj+0yhBEfV8XZ
 8bDLpf3ZZrlNUiX5GHrHr9CgOFDKtEWymTUSpT2hxWh2vz2WZJmYeZtDbd6VchgtPnsiFyNr
 b53bpLWoz0BCrGWSneMq+Y7cwtaRVBrXM2eliCiXrTfSiJ8BnobAuPcqZt5PdMNc1J9zLqQp
 inVt44x4AaXuEAr3i3WMCo4N+uzB8gmxZ/5VAR1VWuVN7EYSd7HxM8im1EfJNHLWcQ6pRKoZ
 5HpuvlsA8ijjhzC8jUZKIb49clsKEvtigWJMC6oJjM4evaMguAPFsDMJmPSGOsmV0JbdvfSZ
 5Wv0wraRdwIQAEK4AP+dqe0113o1ZQCsLsaYqYLS+W/vG3j9YFrL2r6ifpfzwTg7/nc7mPy6
 jt6yiv0aQUAT0HZPTUJaW25Q1+VLtZD
IronPort-HdrOrdr: A9a23:BqcWhKgBbRxq2OM9UdJDFp1gPnBQXhQji2hC6mlwRA09TyVXrb
 HIoB17726JtN91YhsdcL+7Scu9qB/nhPtICMwqTM6ftWrdyRaVxeNZnO3fKlTbckWUh41gPO
 VbAtBD4bXLbWSS5vyKmzVQfexQpOWvweSHgaPxwR5WIj2CqJsN0+66MGum+4FNKjVuNN4DGJ
 KQ689K4x6tY24eYMj+JlRtZZm4mzQDrvPbXSI=
X-Talos-CUID: =?us-ascii?q?9a23=3A/kpE1mkGLocKL9i/2YG8tFVOEO3XOXyei1SPJ1T?=
 =?us-ascii?q?kM1oqTrCOb3qX+pppuMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AcQOywA+vMITxEuagq2AB+5+Qf/1Xyb+OKW4SrcV?=
 =?us-ascii?q?FtZWcKT5NPGi3sx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208,217";a="229472906"
X-MGA-submission: =?us-ascii?q?MDEEAbnKDDys518kxmXstkwsABcjcGp5/BjKJ9?=
 =?us-ascii?q?F9FpkRf2c1dq0JWguk7ft+ChfKVK2jXqbNaufOjCZF7ZGUhCGW31acVz?=
 =?us-ascii?q?gvWWlry6n9sp71NT4vN3n3WFfuocVYUyjFxr5lgKm3Q+GwiUdq6yIJaQ?=
 =?us-ascii?q?M7ocTP/rf1vYVaSxWU2DsuPQ=3D=3D?=
Received: from mail-wm1-f47.google.com ([209.85.128.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 19:41:56 +0200
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453608ed113so14803865e9.0;
        Sun, 29 Jun 2025 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751218916; x=1751823716; darn=inria.fr;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCXwiHBFN33s7jcYq6F27fRPf0crjX3I5g+Yn1VEyEA=;
        b=SIyE3pKneFArB8BWltSjI+yyoQfS19Cmh2jm6sZ27V9KUUTz8PvBKdlzytTiZ9ffFm
         M/AiU4Mf0cSRnles5eVlIi4sSE1p4PHo3C4EyxVz6+uB3roCYXuwkGho/xX+UEbd2dwt
         GxpcrdXzaIC29D4+EKN5xoTg+D+kVqC5tApzxmkHL5eDIvWjuVTSPe4mJ35soFW5viEc
         NQRSDa1tqLUc+Uo5ieBgBkD+6Zsql7Myi7ztziRaFzbzkNDN7Sdw72IFXghqmDaMK61i
         OMxVd1I9PHfhYVz86dNk+ejL+CvcL5m8pU8ll1FNEof95Zu0mMEde2SBZOxZpkKTigEd
         ODNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751218916; x=1751823716;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCXwiHBFN33s7jcYq6F27fRPf0crjX3I5g+Yn1VEyEA=;
        b=vs7WVxRnD+7jCNLWoUkzdqeuYDm4zEKXPamwbLstPlyx/JIrRF1oQ2zBMYfe5/z+AL
         ZLg64z9eKxWcWLgk+ZDauJSwymVhQYPCDftELHaEGdcxYgEUYRYSWUOyIbGHIE180Qk4
         GTksKBFZM1Qo0IjBCI8SS1VQtDFb+/P4d9gfWMM3QjZ24TIXOF4Le5gKRK3+EDpaQzGT
         n8SR+46B0t09ZVhXUlV/674GwHef9qOiIFmfM4KyBs/iPMykB/0HxSUZffloO82EXpOs
         mhkBCgoH04g46f8c16tpvdMXBOl9PNkBugLxVwUjBTY4wNcvR98LZYy7UrHo1nd4qCxs
         jk9Q==
X-Gm-Message-State: AOJu0Yx5hAzdWOihFfYPxtsG1TqmEURGD1sN39lTf7HmaiAI9TEjtJek
	k0DpqZ6epX7fXRJM/Dx6UG1VKegzbJb6WYmllQ5F0YRYnYHrn9zpjNQFXA0vEQ==
X-Gm-Gg: ASbGncvV9Kh6J6QKCBP5Bp3OWB6916Z6b5UkrXUYpKlP9/nubavfmSW8ObWPmjp1cTk
	8DbNxh/l20lUV79dYoi54v8dt5KFkbMkZM1o+P7LzASkTMCa5XvdpcRLsovQNRLlPgRurY7mn88
	cu3ymPA60GxqAWwvnAMuzZVeheUT+JB8uq95oowfcTPb/WDuK3870EascI0y9dsUNWv4LfbTu6r
	IerqG9IECjcAqlpZ7h+HFcf/EdeSyqQ6EkY3/qBv6+jC8uYqxJNiSoc7mtHEzLJOd1bJUHhepBB
	ZW+74YLGmIMzZq9bTrUXRybfSIX8PqaDevkprOqPZfJnPukQqOgZ3x5y83U9Ge5inH+FUI1a+bA
	LZkBMrZxtOwBirh7/k/lFoQc=
X-Google-Smtp-Source: AGHT+IE+5prH76w9TUcS/ZV9s2w31O4DUQB+cDU9/UHZuaYsrle9eJrRHAfYAHAVC7r80iCst8Z5Ww==
X-Received: by 2002:a05:600c:8712:b0:453:86cc:739c with SMTP id 5b1f17b1804b1-4539188f383mr86369075e9.1.1751218915285;
        Sun, 29 Jun 2025 10:41:55 -0700 (PDT)
Received: from [2a04:ee41:3:2418::ffff] ([2a04:ee41:3:2418:ec97:de8:ed49:4bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5963csm8257583f8f.79.2025.06.29.10.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jun 2025 10:41:55 -0700 (PDT)
Date: Sun, 29 Jun 2025 19:41:49 +0200
From: devnoname120 <devnoname120@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
In-Reply-To: <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
 <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
X-Readdle-Message-ID: 55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="68617ae2_4516dde9_1255"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: devnoname120 <devnoname120@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2825
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/55f3b1f1-2537-4bc3-88d3-d7da1136060a%40Spark>

--68617ae2_4516dde9_1255
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here is my new semantic patch:

=40depends on file in =22include/linux/sched.h=22 exists=40
declarer name randomized=5Fstruct=5Ffields=5Fend;
=40=40


struct task=5Fstruct =7B
...
+=23ifdef CON=46IG=5FKSU=5FSUS=46S
+ u64 susfs=5Ftask=5Fstate;
+ u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
+=23endif
randomized=5Fstruct=5Ffields=5Fend
...
=7D

And here is the error:

=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h
SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declarer
SPECIAL NAMES: adding u64 as a type
minus: parse error:
=C2=A0=46ile =22include/linux/sched.h.cocci=22, line 12, column 0, charpo=
s =3D 247
=C2=A0around =3D '...',
=C2=A0whole content =3D ...


If I add a semi-colon after =60randomized=5Fstruct=5Ffields=5Fend=60 in t=
he semantic patch:

=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h
SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declarer
SPECIAL NAMES: adding u64 as a type
minus: parse error:
=C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 28, charp=
os =3D 246
=C2=A0around =3D ';',
=C2=A0whole content =3D randomized=5Fstruct=5Ffields=5Fend;

Paul

On Jun 29, 2025 at 19:26 +0200, Julia Lawall <julia.lawall=40inria.fr>, w=
rote:
>
>
> On Sun, 29 Jun 2025, devnoname120 wrote:
>
> > Hello,
> >
> > I'm trying to insert two fields inside a struct, right before the use=
 of the macro =60randomized=5Fstruct=5Ffields=5Fend=60. You can find more=
 information about the macro here: https://stackoverflow.com/a/72675757
> >
> > Here is the unified diff that I'm trying to convert to a semantic pat=
ch:
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9ea614e09f56..c153abffd4c5 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > =40=40 -1467,6 +1467,10 =40=40 struct task=5Fstruct =7B
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * New fields for task=5Fstruct should =
be added above here, so that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * they are included in the randomized =
portion of task=5Fstruct.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > +=C2=A0=C2=A0=C2=A0 u64 susfs=5Ftask=5Fstate;
> > +=C2=A0=C2=A0=C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > =C2=A0=C2=A0=C2=A0=C2=A0 randomized=5Fstruct=5Ffields=5Fend
> >
> > =C2=A0=C2=A0=C2=A0=C2=A0 /* CPU-specific state of this task: */
> >
> > Here is the file that it applies to: https://github.com/devnoname120/=
kernel=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa2778940659e246611/in=
clude/linux/sched.h=23L1470
> >
> > I tried the following semantic patch:
> >
> > =40depends on file in =22include/linux/sched.h=22 exists=40
> > =40=40
> >
> > struct task=5Fstruct =7B
> > ...
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > + =C2=A0 u64 susfs=5Ftask=5Fstate;
> > + =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > randomized=5Fstruct=5Ffields=5Fend
> > ...
> > =7D
>
>
> You can try putting in the metavariable section
>
> declarer name randomized=5Fstruct=5Ffields=5Fend;
>
> But I suspect it will still object due to the lack of a ; after
> randomized=5Fstruct=5Ffields=5Fend.
>
> julia
>
> >
> > However I have the following error:
> >
> > =E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --l=
inux-spacing include/linux/sched.h
> > init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coc=
cinelle/standard.h
> > SPECIAL NAMES: adding u64 as a type
> > minus: parse error:
> > =C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, ch=
arpos =3D 194
> > =C2=A0around =3D '...',
> > =C2=A0whole content =3D ...
> >
> > I also tried the following code:
> >
> > =40depends on file in =22include/linux/sched.h=22 exists=40
> > identifier END =3D=7E =22randomized=5Fstruct=5Ffields=5Fend=22;
> > =40=40
> >
> > struct task=5Fstruct =7B
> > ...
> > +=23ifdef CON=46IG=5FKSU=5FSUS=46S
> > + =C2=A0 u64 susfs=5Ftask=5Fstate;
> > + =C2=A0 u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;
> > +=23endif
> > END
> > ...
> > =7D
> >
> > But it yields the following error:
> >
> > =E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --l=
inux-spacing include/linux/sched.h
> > init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coc=
cinelle/standard.h
> > SPECIAL NAMES: adding u64 as a type
> > minus: parse error:
> > =C2=A0=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, ch=
arpos =3D 209
> > =C2=A0around =3D 'END',
> > =C2=A0whole content =3D END
> >
> > I'm not sure why I have this error and I couldn't find an answer afte=
r looking on the internet and reading the Coccinelle grammar.
> > Could you help me figure this out=3F
> >
> >
> > Thanks=21
> > devnoname120
> >

--68617ae2_4516dde9_1255
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div>Here is my new semantic patch:</div>
<div>&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40depends on file in =22include/linux/sched.h=22 exists=40</s=
pan></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
af00db;=22>declarer</span> <span></span><span style=3D=22color:=23af00db;=
=22>name</span> <span style=3D=22color:=23e50000;=22>randomized=5Fstruct=5F=
fields=5Fend;</span></div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span style=3D=22color:=23=
e50000;=22>=40=40</span></div>
<div><br />
&=23160;</div>
<div style=3D=22color:=23000000;font-family:Menlo, Monaco, 'Courier New',=
 monospace;font-size:12px;font-weight:normal;=22><span>struct task=5Fstru=
ct =7B</span></div>
<div><span>...</span></div>
<div><span style=3D=22color:=23098658;=22>+=23ifdef CON=46IG=5FKSU=5FSUS=46=
S</span></div>
<div><span style=3D=22color:=23098658;=22>+ u64 susfs=5Ftask=5Fstate;</sp=
an></div>
<div><span style=3D=22color:=23098658;=22>+ u64 susfs=5Flast=5Ffake=5Fmnt=
=5Fid;</span></div>
<div><span style=3D=22color:=23098658;=22>+=23endif</span></div>
<div><span>randomized=5Fstruct=5Ffields=5Fend</span></div>
<div><span>...</span></div>
<div><span>=7D</span></div>
<div>&=23160;</div>
<div>And here is the error:</div>
<div>&=23160;</div>
<div>=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --=
linux-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a declarer<br=
 />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 12, column 0, char=
pos =3D 247<br />
&=23160;around =3D '...',<br />
&=23160;whole content =3D ...</div>
<div>&=23160;</div>
<div>&=23160;</div>
<div>If I add a semi-colon after =60<span>randomized=5Fstruct=5Ffields=5F=
end=60 in the semantic patch:</span></div>
<div>&=23160;</div>
<div><span>=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-pl=
ace --linux-spacing include/linux/sched.h</span><br />
<span>init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/c=
occinelle/standard.h</span><br />
<span>SPECIAL NAMES: adding randomized=5Fstruct=5Ffields=5Fend as a decla=
rer</span><br />
<span>SPECIAL NAMES: adding u64 as a type</span><br />
<span>minus: parse error:&=23160;</span><br />
<span>&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 2=
8, charpos =3D 246</span><br />
<span>&=23160;around =3D ';',</span><br />
<span>&=23160;whole content =3D randomized=5Fstruct=5Ffields=5Fend;</span=
></div>
<div>&=23160;</div>
<div><span>Paul</span></div>
<div>&=23160;</div>
</div>
<div name=3D=22messageReplySection=22>On Jun 29, 2025 at 19:26 +0200, Jul=
ia Lawall &lt;julia.lawall=40inria.fr&gt;, wrote:<br />
<blockquote type=3D=22cite=22><br />
<br />
On Sun, 29 Jun 2025, devnoname120 wrote:<br />
<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>Hello,<br />
&=23160;<br />
I'm trying to insert two fields inside a struct, right before the use of =
the macro =60randomized=5Fstruct=5Ffields=5Fend=60. You can find more inf=
ormation about the macro here: https://stackoverflow.com/a/72675757<br />=

&=23160;<br />
Here is the unified diff that I'm trying to convert to a semantic patch:<=
br />
&=23160;<br />
diff --git a/include/linux/sched.h b/include/linux/sched.h<br />
index 9ea614e09f56..c153abffd4c5 100644<br />
--- a/include/linux/sched.h<br />
+++ b/include/linux/sched.h<br />
=40=40 -1467,6 +1467,10 =40=40 struct task=5Fstruct =7B<br />
&=23160;&=23160;&=23160;&=23160;&=23160; * New fields for task=5Fstruct s=
hould be added above here, so that<br />
&=23160;&=23160;&=23160;&=23160;&=23160; * they are included in the rando=
mized portion of task=5Fstruct.<br />
&=23160;&=23160;&=23160;&=23160;&=23160; */<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+&=23160;&=23160;&=23160; u64 susfs=5Ftask=5Fstate;<br />
+&=23160;&=23160;&=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
&=23160;&=23160;&=23160;&=23160; randomized=5Fstruct=5Ffields=5Fend<br />=

&=23160;<br />
&=23160;&=23160;&=23160;&=23160; /* CPU-specific state of this task: */<b=
r />
&=23160;<br />
Here is the file that it applies to: https://github.com/devnoname120/kern=
el=5Fxiaomi=5Fsm6150/blob/fce5582771e1254af065aaa2778940659e246611/includ=
e/linux/sched.h=23L1470<br />
&=23160;<br />
I tried the following semantic patch:<br />
&=23160;<br />
=40depends on file in =22include/linux/sched.h=22 exists=40<br />
=40=40<br />
&=23160;<br />
struct task=5Fstruct =7B<br />
...<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+ &=23160; u64 susfs=5Ftask=5Fstate;<br />
+ &=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
randomized=5Fstruct=5Ffields=5Fend<br />
...<br />
=7D<br /></blockquote>
<br />
<br />
You can try putting in the metavariable section<br />
<br />
declarer name randomized=5Fstruct=5Ffields=5Fend;<br />
<br />
But I suspect it will still object due to the lack of a ; after<br />
randomized=5Fstruct=5Ffields=5Fend.<br />
<br />
julia<br />
<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>&=23160;<br />
However I have the following error:<br />
&=23160;<br />
=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, char=
pos =3D 194<br />
&=23160;around =3D '...',<br />
&=23160;whole content =3D ...<br />
&=23160;<br />
I also tried the following code:<br />
&=23160;<br />
=40depends on file in =22include/linux/sched.h=22 exists=40<br />
identifier END =3D=7E =22randomized=5Fstruct=5Ffields=5Fend=22;<br />
=40=40<br />
&=23160;<br />
struct task=5Fstruct =7B<br />
...<br />
+=23ifdef CON=46IG=5FKSU=5FSUS=46S<br />
+ &=23160; u64 susfs=5Ftask=5Fstate;<br />
+ &=23160; u64 susfs=5Flast=5Ffake=5Fmnt=5Fid;<br />
+=23endif<br />
END<br />
...<br />
=7D<br />
&=23160;<br />
But it yields the following error:<br />
&=23160;<br />
=E2=9D=AF spatch --sp-file include/linux/sched.h.cocci --in-place --linux=
-spacing include/linux/sched.h<br />
init=5Fdefs=5Fbuiltins: /opt/homebrew/Cellar/coccinelle/1.3.0/lib/coccine=
lle/standard.h<br />
SPECIAL NAMES: adding u64 as a type<br />
minus: parse error:&=23160;<br />
&=23160;=46ile =22include/linux/sched.h.cocci=22, line 11, column 0, char=
pos =3D 209<br />
&=23160;around =3D 'END',<br />
&=23160;whole content =3D END<br />
&=23160;<br />
I'm not sure why I have this error and I couldn't find an answer after lo=
oking on the internet and reading the Coccinelle grammar.<br />
Could you help me figure this out=3F<br />
&=23160;<br />
&=23160;<br />
Thanks=21<br />
devnoname120<br />
<br /></blockquote>
</blockquote>
</div>
</body>
</html>

--68617ae2_4516dde9_1255--

