Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8A6C531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bbSTvhrvJVaWNbYcerAizGhExjCM7xuViLJbvyJxqsY=;
  b=FJckQvtp2FR6SZmWqmLsNEqbBSjC6rnny6kPtclzuTO3h4pkAV+q+xwx
   8WCfiUExapzXoYjcTEhVTMEEmUWfCuADzUy0Gp6HQFqqnepPk2emuIy+u
   2ycVomOvp3eFRgGtTOEGuU6nmI+tqrMwzaVuPBQf3XFC5dd8khMn4D40z
   s=;
X-CSE-ConnectionGUID: e1IE5YGOQuiaRb580NOH/Q==
X-CSE-MsgGUID: dafz3/9fTvqdNIaqfuYTXA==
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
   d="scan'208";a="287734101"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:40 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 46910803D0; Fri, 24 Jul 2026 10:54:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B6547819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:47:20 +0200 (CEST)
X-CSE-ConnectionGUID: CxJlF4IAQlWtq+XstdR38w==
X-CSE-MsgGUID: je3IyN+aQqufgUH3hYEYaw==
IronPort-SDR: 6a6261b8_/qWBkTxavk0ZVhiBV32Bc+owmNasiZAbvPD/MYpApVqV/IW
 hPwcg1KjbqtFUGopjyNA0SA6Cek2WXJuTXZBPrg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqfC3YVdFaglkCgj8WgVMzBFSVBwaKb4IZM?=
 =?us-ascii?q?AKHU4pPgT89Ag8BAwELAQFPAgQBAQECBIR+Ao1gAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQUCLF8CAQMSIAENARsdAQMMBhA7IAIRAQUBHAYBEiKCYIIjAQYQAQM3A?=
 =?us-ascii?q?gG2V4ECQoxSBQIWgQGCDQbaaAoZKA11gWMBAgIHCQEKAQGBNwGEdypdA4I6h?=
 =?us-ascii?q?SN1hAJ6J4EYgRCEfoIfgjmGMASDLpIqAQcHHxIIARwGCAICSBUSAwQDBAQBA?=
 =?us-ascii?q?gsTCQMDAg4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEgIpCgMqCxIPA?=
 =?us-ascii?q?w0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEAQEIAgItAwEDGQgJCAILBREYD?=
 =?us-ascii?q?AsFAjEDDwEJAx8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEHREIAwEYBAQCA?=
 =?us-ascii?q?QsDAQMBFQQICQQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCAgIGAgMDAwoBA?=
 =?us-ascii?q?gEBAQEBAQEIAwMDAgMZBwYDBAQBBAQDAwIDBQEDAwMFAgIKBgkBAQEBAwICC?=
 =?us-ascii?q?AMHAwoJAgUDGwMcBgECAgMCAQIDBgMHCAMNAwQCAwMDBAECAgEBAQIDAQMDB?=
 =?us-ascii?q?AMBAwMCAQMHAgIDAwMLAQIDAwMFAwUBBQMFAgIDBQUDBQICCgIDAwMCAQMCH?=
 =?us-ascii?q?AMIAwYDEgEQAwMGAQMHAwcCBAMIBAMGAgMIAwMCCQgDFgYDAwMDBQECAgIDB?=
 =?us-ascii?q?QMDAwgIBAMDBAICAwwCBgMDAwIDAwUDAwcCBAIDBgMDAwEDAwUBAgcCAwcCA?=
 =?us-ascii?q?QsLCAMCBAIJBwkHAQIDCwQCBAYEDQkEAgQCAg8EBAUDAwcBAQIBAggFBgMCA?=
 =?us-ascii?q?hEFCAoFBgICAh0DIQEDDwYBCQUCAQUOBwUCAgoSAwYCAwQFBQEDAQoBCwEBA?=
 =?us-ascii?q?gMDBQUDAwUHAQIEAgcDAwMEAwMDAwEBAgIEBgQDAgMHAwMDAwMEAwUFAwIFA?=
 =?us-ascii?q?gQDBQMHAgMDAgEFCgEEBQQKAQMDAwMFBQMCAgMDBAECBAYDBAIDAQIIBAYFA?=
 =?us-ascii?q?wMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDAwUCCQMDCQMDCwICAyECBQMDA?=
 =?us-ascii?q?wMGAwcDAwQDAwMHBwIDAgMHAwIFAgcFAwMFAwYBAwIBAwMICxgDCwkIBwwBP?=
 =?us-ascii?q?AwHCiQEBAwqAQYOFAUEJRlnBwcCjWgjgU5yAYENgimBUQEBAZIakjSgIUkeC?=
 =?us-ascii?q?QEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5FwkkeEPgIKBwcRJBKBMjqBXDMaI?=
 =?us-ascii?q?4EBbYFJUAMZD5IjzBU1NT4BBwIHDwKBc4N2iSqBIIErSYFMAQE?=
IronPort-PHdr: A9a23:h3F8uRUKE8j79CIM7LvWP+yzEKbV8KwFXDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtuds6sP1rKO7OjJYi8p39WoiDg6aptCVhsI2409vjcLJ4qoL3O+B9PRKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvQu8UMnYduN6k9xxvVrndUeeld2H9lK0+Ukxvg6ci8+4Ju/T5NsPw77c5AVqv6f6U8T
 bNGCTktLn446s72uxTdVAWD/nQSXH0ZnRZRHQXL4wz0Uo/+vSXmuOV93jKaPdDtQrAvRTui9
 aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7WcMgETmRdQMleSy1BApu9b
 4QRCeoBIf1YpJT5q1cXsBeyGRWgCObpxzRVhHH5wLc63vwhHw/YwgEuAtwAvnfTotr3OqcdX
 u+7wbLUwTjAdf5axS3w5JTUfh0nvPqCXahwcc3UyUQ3Cg3KlFOQqYP8Mz2XyOsNtG6b5PdkW
 +2xjG4nrRx6rz+xyccvhInJiJ8Vxk7Y+Sll3Io4Id61RVV0Yd6hCpRQtiWaO5FqTcMlRmFlo
 SA3waAJtpCnZiYF0ognxwLBZPyddYiF+hbuWeSMLTp2in9ofLKyiRm2/EauyODxSM253UhFo
 CZYjtTBq3AD2h7d58SbVvZw8Uev1CiA2QzO5e9JIk85mKTdJpU8wbAwjoIevVrfEiLygkn7j
 6+bel869uS16unreLrrq5+EO4Nplw3yLr4il8ilDeglPQUCQXKX9Ou62bb+50P2Wq9Kgeczk
 qTBsJDVO8AbpqmhDg9QyIkj6hK/Ay6+0NQagHULNVxFdR2HgoTzNFHOJ/f4Dfi7g1uyijtk2
 /fGPrj5DpXMKHjMjqvhcK5j50JAzAc/19NS6pJOBr0fPf7+W1X9udPYAxMhNgy72efnCNFz1
 oMEXmKPB7eUP73RsV+G6OIvPveAaJMJtDrhL/Uo5OXjjXA8mVAHfKmp2YEbZ2y/HvRjO0mZe
 2bjgs8dEWcWuQozVPDliFqeXjFPZna/RLk85zE+CIK+F4jPXIGtgLqb3Ce6BJJafG5GCkqUH
 XfubIqLQ+0MZz6KIs99jjwEUqCsR5I52RGhqgD6zLlpIPDM9yIWqJzvzMJ16PPNlR8x7zJ5F
 8Gd3HuMT2Fwh28IXz020L1mrUxzxVqO0bJ0g/NfFdxU6PNJVhk1OYTAwOx9DtD+Qh/OftSIS
 FajWtioGT4/QdwvzdESf0tzHc2ugQ3G3yWwGb8ai6SGCoQt/KzE0Hb9P919y27I1KQ5lVcrX
 tZBO3C+iq5k7wjTCZbGk0WHmKaucqQRxDbD+n6bw2SB7wlkV1tSTKHEVDY7b1TfqdDR50XYT
 rboB65jeitMyM2BK+NpcNrmgE9bX7+3ONnfYGGw3WSqAhmF3K6XRI7rfXgNmiTbFEUA1QsU+
 CDCfSckCyjpgHjZBTwrNVv1f0bl96Eqp2m2QUw05wWLaVBx2b2o/BIcmf2bTbUUxL1S6wk7r
 DAhJ1+70Jf2Bt2G7yhse6MUNd4+7llajzqB710tFpOlJqFmwFUZdlIk7AvVyxxrB9AYwoARp
 3QwwV83cPrAuLsgXzaR3JSqf6bSNnG35hekLajfxlDZ1t+SvKYJ8vUx7Vv570myDkR31XJh3
 pFO1meEoI3QBV8fUpz/Txxvr0Ar95nVZyA848Xf0ng/ebKsvGr60skyTPAg1g7met5eNK2eE
 wqnHs4UCdX0cLRyygiBYRcNPeQU/6kxbIu9b/XT/qmtMa57mS6+y2RK5IcoykWX6y91UfLFx
 b4AyvCcmxOFDnLy0ArnvcfwloRJIzoVGwJT0ADCA4hcLu13dIcPUyK1JtGvg895jNjrUmJZ8
 1iqAxUH3tWocFycdQ612woYzkkRrXG9/EnwhzVpjzEkqLae1y3S0qzjchQAIGtCWGhlix/lP
 4G1i9kQWEXgYRIukVOp4kPzxq4To6oaTSGbTERGcTWsdzk6A/uYub+LYsoJ45Qt8G1WXOm6f
 VGGW+vluRJJmyjnHmZY2HU6b2Tw4sS/z0E80jvDaiou/x+7MYlqyBzS5cLRX6tU1zsCHmxjj
 CXPQ0K7NJ+v9MmVkJHKtqa/UXigX9tda3qOr8vIuS2l6GltGRD6keq0n4itHAs03zKhj4EyB
 HXgoxP1Y42t3KO/e7ECHAEgFBrn5sx2F5sr2IYzip8NgyBC3sTF1XUCmGb3d95c3OitCRhFD
 S5OyNnT7g//3URlJX/c3IP1WEKWxc55bsW7aGcbss4kx/hDE7zcrLlNnC8v50G9sRqUe/922
 DEU1fop7ncexeAPogskiCuHUPgeGkxRPCqkkBrtjZj2oaZZanv1KeDohRpWktWoDbXEqQZZE
 Hr0YZYtGyZs4943agqdli2urNu9Jp+MMJoarVWMng3FjvRJJZ5U9LJCnidhNW/n/DUkx+M9k
 R1yzMS/tYmDJX9q+fHxCRpZOzvpIsILr2u13OAOw4DMht7pQsgyf1dDFIHlRv+pDj8I4PHuN
 gLUVSY5tm/eA73UWwmW9EZhqXvLVZGtLXCeYncDnrAADFGQIlJShAcMUXA0hJk8Q0qnx8Lvb
 R0hvmhAtnb3rxJNzqRjMBy1AQK97E+4Lyw5TpSSNk8c4wJM6VqPaZTGv7JbECRR/5nnpwuIY
 D/+BUwAHSQCXUqKAErmN7+l6Izb8uSWMeG5KuPHfbSEreENH+fN35+k1ZFquiqdLsjadGc3F
 OU1gwAQOBIxU9ScgTgETDYb0j7Af9LO7gnp4TV594i+6Ki5B16pvNHSTeMUaZI2pVi3mfvRb
 bbBwnYkb28ChtVUgiaXrdpXlF8K1XM0L2H0Q+hQ63afEPKOxv0FSENFIyJrapkSs/pgjFcdY
 ZaJ1oOriuwqyaNrbjUNHV35xJPzO5RVcW/tPguVWBbVaObUYmCVi8DvP/HmGeUI3r5a70/s6
 WjHQR2kY2rm9XGhVgjxY7tF1HnJZUAD4NPhIkgxWzqkEYyuawXlYoV81TNkz7dp3iGWZTBAY
 2o7Lh0FuLSU6WkwbuxXPWtH4zIlKOCFn3zc9OzEMtMMtvAtBC1oluVc6XB8yr1P7SgCSuYn0
 C3V5sVjpV2riIztgnJuTQZOpzBXhYmKoVQqOKPX8YNFUGrF+xRF5HuZChADrd9oQtP1vKUYx
 t/KnaP1YDBMlrCctdMbHNTRIdmbPWAJNBPoHHvMDlJAQ2L2c27YgENZnbeZ8XjU5pk2p57wm
 YYfH79WUFtmc5FSQk9hHdEEPNJ2RmZ+ye/d3JNOvyPg6kWMF6A49tjdW/mfAOviMmOchLhAP
 V4TxK/gaJ4UPcv90lBjbV9zmMLLHVDRVJZDuH4EDEd8rUNT/Xx5VmB21Vjib1bn7XwdG+Pux
 kZu21tWbuEk9TOq6FAybAmvxmN4gAwqlNPpjCrEOib2N7u1VJpKBjDcskEwNtbjQV8wY1Hv2
 0NjMzjASvRaiL4qJgUJwEfM/JBIH/BbV6hNZhQdkOqWa/sf2lNZsiy7xEVD6IMt6LNnnQouN
 Iau9jdOh18lY9kyKqjdYqFOywoI7kprliCt3+E1hgQZIhRVmIt9UCENsU0McLIhInjxltE=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:I+v/LKAB+q0nlaLlHemI55DYdb4zR+YMi2TDGXoBLCC9Ffbo6v
 xG+c5w6faaskd3ZJhNo6HiBEDEewKlyXcX2/hqAV7BZniBhILAFugLhuvfKn/balbDH4ZmtJ
 uIGJIObOEYY2IK7/rS0U2XF5IPzrC8n5xARt2z856ud2xXgtlbnn5E48+gfHFLeA==
X-Talos-CUID: 9a23:ssJO52NZrfpho+5DczlF8GBIO+kcdkLB1TTgOFO0Mz05V+jA
X-Talos-MUID: 9a23:xDpJZgrk0wlM3KWVrWgezzNvb+Z5xeenMVkQn5o7m5KEBAFBMijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="287667098"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEsrK5lJDk7mdnORi/FPNqpU2cHeYVY+c/4oC?=
 =?us-ascii?q?EWIy0a37ZB8+xVg6sX5WztAT7tEUXFEP5y2pOfqG7uPReKDp5F0FfWk2?=
 =?us-ascii?q?bHMiHovzdp8uJk/7vZvtgEgy67rehx9Szr/qyjFHuRBw2w6cP6WQ0/+d?=
 =?us-ascii?q?71s/EtycDi9EdbITplgNiGJA=3D=3D?=
Received: from mail-pj1-f45.google.com ([209.85.216.45])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:47:20 +0200
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so918189a91.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832438; x=1785437238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbSTvhrvJVaWNbYcerAizGhExjCM7xuViLJbvyJxqsY=;
        b=PXht7P0ogOYZOoicPDxwBp6/oDQAo/5OmGHi7tH75pioXmrYXuyx6Qj+vHAZNBNzvS
         PHyowju9aY48K8U2FjqCMSfvJqmp/AKJmeqHm1/xHpBofN1hWdjEd/WnO3FHxZ1DQnL6
         Tse0fovcPesx9ZpLN/N0Hv4ftAMvLX7kjzSVgHs+GjkffqIjp7YJvN22KBaI6CebtAFY
         Qm8DJBxHYKsVtVEptrh8+mWDIW3uCt9F1zM5cj2rw3nxvcXuDeFfcvVrvfDZOhKYqeb8
         Zgvm6b92ZbWS/G0UBV20T0EJESqAVFCfLdQ/HJ0oerwwjnnyLFig5yHRnFR+A82Yvl+N
         YGvA==
X-Gm-Message-State: AOJu0YyTX/VJpM/nasy4btBV8MkI4zg4E28vXAbJYKwt5c0Nz5Qh8cIg
	NXbnbsMLM9DJay8vXWjFuFUF6Pf38WYZzL6qxSADBkFt4/1D/bku7LWM
X-Gm-Gg: AR+sD13jnxsNXA4fyk1SwdH4xNDdLic54RRjuCXHcrFAnQZ+jPLyU0KVEHmW3U4YQcR
	SX0Tv92wtncq6+MPjtsZUHoWKohIHcrbknAfJ6OKbMQKNsOTPS+SY75LHdePh6FG8LvkRisY2o4
	2ffW4UxJZTd+QwWpYHYQhrz6QXH2jow86ifi9fUo0i+UpTTekhsz1nNU8w6lXlVllc+I0sS3MCz
	9DbUsy2Tq5YjMmNOv+PwOk0f+luUH8s6EiBnmSo4mN8A5tG4AeepFKmFfC3K1SWBJIhUt4Sk4/B
	jmLhy9MxdJCrhwV7iQ+HK4z2jq0YNa54pvH5LpOw+hQc+cNmMhEMF757aLw+SrRzc1PL9hugW9w
	LA4cT1EId4EB0O+wT+AdDafeZVFuUBwiY4YecTjeJ32HFnLdelOEQjwXyco61Fl+188WZBLOgd8
	bKKEXBGw4=
X-Received: by 2002:a17:90b:1642:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38ec6a51c61mr3940118a91.20.1784832438557;
        Thu, 23 Jul 2026 11:47:18 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:17 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Date: Fri, 24 Jul 2026 03:45:35 +0900
Message-ID: <20260723184538.3888637-34-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 33/36] usb: typec: fusb302: remove conditional
 return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3628
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/koCBndh4TlEtl0iwg-D7gg>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 3319f6a2b0c9..d0ab247b24bf 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -314,11 +314,7 @@ static int fusb302_i2c_mask_write(struct fusb302_chip *chip, u8 address,
 		return ret;
 	data &= ~mask;
 	data |= value;
-	ret = fusb302_i2c_write(chip, address, data);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return fusb302_i2c_write(chip, address, data);
 }
 
 static int fusb302_i2c_set_bits(struct fusb302_chip *chip, u8 address,
@@ -375,12 +371,8 @@ static int fusb302_init_interrupt(struct fusb302_chip *chip)
 	ret = fusb302_i2c_write(chip, FUSB_REG_MASKB, 0xFF);
 	if (ret < 0)
 		return ret;
-	ret = fusb302_i2c_clear_bits(chip, FUSB_REG_CONTROL0,
-				     FUSB_REG_CONTROL0_INT_MASK);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return fusb302_i2c_clear_bits(chip, FUSB_REG_CONTROL0,
+				      FUSB_REG_CONTROL0_INT_MASK);
 }
 
 static int fusb302_set_power_mode(struct fusb302_chip *chip, u8 power_mode)
-- 
2.43.0

