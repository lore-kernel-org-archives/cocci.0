Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0B7C53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6s5SzAkwTqv2cG0ZEuCiRJMYbGatFZIR2B9nCnRkYh8=;
  b=YZzgvIzRMTltUCWEVbHOkk/Hw+JlnRvT82ocogivXTr4jh0gZQkYlhhr
   7nlSkG3rnS/gnILFRaawdrH0MtOR695FYOyeRiYWXxTMQpKVCngBZTWLa
   oSNqB8XyUHDyJgLA1GIp5WudlngkY7wSO82p/COx28fgfzHLPSqnWlGUe
   8=;
X-CSE-ConnectionGUID: I2ePG4gZRjCxZTUQjIbNVw==
X-CSE-MsgGUID: ww2JwBrQSleavlJ/AkV3Ng==
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
   d="scan'208";a="287733126"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:53:57 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CDF4F803D0; Fri, 24 Jul 2026 10:53:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 129F281331
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 20:46:10 +0200 (CEST)
X-CSE-ConnectionGUID: NPd6nftTQZyGNLfvRZAqkA==
X-CSE-MsgGUID: YyYd4srhTLyTL97h1EOv0Q==
IronPort-SDR: 6a626171_7Mh0GI/tbVPcm0pVP6Iv+JcugYkLgtFx8VBCCm//7zyitps
 1aF52NRISWbxHIiSErwJvIow1hj+CSMRkXU4a/Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEBABZYGJqfDXYVdFaHgEBCxIMggULAoI/FoFTMwRUl?=
 =?us-ascii?q?QcGim+CGTACkiKBPz0CDwEDAQsBAU8CBAEBAQIEOIRGAo1gAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGT?=
 =?us-ascii?q?w1JARABBAEBggEBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQUCLF8CAQMSFQsBDQEbHQEDDAYQOyACEQEFARwGARIigmCCI?=
 =?us-ascii?q?wEGEAEDNwIBtleBAkKMPBYFAhaBAYINBtpoChkoDXWBYwECAgcJAQoBAYE3A?=
 =?us-ascii?q?YR3Kl0DgjqFI3WEAnongRiBEIR+gh+COYYwBIMukioBBwcfEggBHAYIAgJIF?=
 =?us-ascii?q?RIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCISA?=
 =?us-ascii?q?ikKAyAKCxIPAw0GBRUBAQcGAgIDAQQCBAwCBAUCAgUDAQMCBAYEAwMEAQEIA?=
 =?us-ascii?q?gItAwEDGQgJCAILBREYDAsFAgonAw8BCQMfAxQbCEUIBhYBGgcFBgs3FQUME?=
 =?us-ascii?q?QECGwIhBB0RCAMBGAQCAgIBCwMBAwEVBAgJBAwCEAoSFQMOAwcPAg0HLgsDA?=
 =?us-ascii?q?g4CCQgMFwICAgYCAwMDCgECAQEBAQEBAQgDAwMCAxkHBgMEBAEEBAMDAgMFA?=
 =?us-ascii?q?QMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbAxwGAQICAwIBAgMGAwcIAw0DB?=
 =?us-ascii?q?AIDAwMEAQICAQEBAgMBAwMEAwEDAwIBAwcCAgMDAwsBAgMDAwUDBQEFAwUCA?=
 =?us-ascii?q?gMFBQMFAgIKAgMDAwIBAwIcAwgDBgMSARADAwYBAwcDBwIEAwgEAwYCAwgDA?=
 =?us-ascii?q?wIJCAMWBgMDAwMFAQICAgMFAwMDCAgEAwMEAgIDDAIGAwMDAgMDBQMDBwIEA?=
 =?us-ascii?q?gMGAwMDAQMDBQECBwIDBwIBCwsIAwIEAgkHCQcBAgMLBAIEBgQNCQQCBAICD?=
 =?us-ascii?q?wQEBQMDBwEBAgECCAUGAwICEQUICgUGAgICHQMhAQMPBgEJBQIBBQ4HBQICC?=
 =?us-ascii?q?hIDBgIDBAUFAQMBCgELAQECAwMFBQMDBQcBAgQCBwMDAwQDAwMDAQECAgQGB?=
 =?us-ascii?q?AMCAwcDAwMDAwQDBQUDAgUCBAMFAwcCAwMCAQUDBwEEBQQKAQMDAwMFBQMCA?=
 =?us-ascii?q?gMDBAECBAYDBAIDAQIIBAYFAwMDBQIDAwICAgMDBQEFAgMDAwQDAwMIBwUDA?=
 =?us-ascii?q?wUCCQMDCQMDCwICAyECBQECAwMDBgMHAwMEAwMDBwcCAwIDBwMCBQIHBQMDB?=
 =?us-ascii?q?QMGAQMCAQMDCAsYAwsJCAcMATwMBwokBAQMKgEGDhQFBCUZZwcHAo1oI4JAA?=
 =?us-ascii?q?YEOgiiBUQEBAZU9jxGgIUkeCQEGAmCBZ4EKFQovm1+FfBozl1OTGZkII5Fwk?=
 =?us-ascii?q?keEPgIKBwcRJBKBMjqBXDMaI4EBbYFJUAMZD44hCQMWg2CPPQG8VzU1PgEHA?=
 =?us-ascii?q?gcPAoFzg3aJKoEggStJgUwBAQ?=
IronPort-PHdr: A9a23:nivrBh0zlrirJj2nsmDO7QwyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeBo600xwKRBdqTwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezYL5+N
 gm6oRjeusQWnYduNqQ8wQbVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQ
 LJbETorLXk76NXkuxfbQgSD/2URXGoLnBZQDAfL8B/1XpHqsivnreV9wzWVPdf3Tb8vRzuv6
 bpgRQLyhycGMz4593zXitB1galGrh+tuwBzzojJa4yOKvFwYr3Scs8bRWpZX8ZeSSpBAp+nb
 4ASC+YNJPtUo5Xhq1cLqxa1GAuiC/71yjJQhnH4w7M33fkvHw/F2wIvHdwOv3vbotjuKKsfU
 vq4wLXSwDnfc/9b3yr25ojSchAmpPGBRa9+ftDXyUkgDg/LjEufqYvjPziI0uoCrW+b7+x9X
 u+olWEnqA9xojayxssyloXFmp4Zx1TH+Chiz4Y1IMe3SE9/YdK+DJRQsCSaOpJwT8g/TG5mp
 Dw0xacauZ6nYicK0pInygbbZvGFboSF7BzuWeKRLDl3gH9rdrCyigi2/EW+xePwS9W53UtKo
 CdHnNTAqmwA2hPT5MWZRfVx40iv1DWA2g3d7OxPPEM6lbLDJpI/3rI9koAfvEfDEyPshkn6k
 a6bel8k9+Wm8+jrf6jqqoOGO4JwkA3yL6sjltKlDek3NAUFQnKV9v6m1LL5+E30WLVKgeMyk
 qneqJ3aIN4Upq+9AwNMyoYj6QuzAy6o0NkYk3QLNl1FeBWAj4jmP1HBPur0Auu4g1SpiDtrx
 vbGMaP9ApjVMHTPjLPscax+5kNc0gY/081T6pNOBrwBLv//Qkrxu8bZDh89PQy02eHnCNBl2
 4wAWmKPDKGZML7MvVOU+u4jP+2BaYwOtTbyLvgq/f/ujXsjlVABeqmp2IMbaGqkEfR+P0WZf
 X3sj88dHmcNogUxUO3qhUaZUT9TYnayR7gz6is6CIKgF4fDR5qijKaP3CehBpFWYHtJBUiWE
 Xj0b4WER+sMaCWKL8N8ijAEWqauS4gi2x+0rAL1xadpIvLO+iIGq5Lt18J76vXWlR4o9Dx0C
 92R03mPT21ph28IST870a5lrUxyzVeD1qd4g/hGGtBJ+/xJVQI6OYbBwOx5CtDyXxrMcM+GR
 lmoXNuoHS08QNQpz9ATZkZyAc+igQzb0iSyGrEbj7OFCIQv8qLE0Xj8P9xzxmrb2qc8l1UmW
 dNPNWO+ia5/6QfTA4nJnl2BmaizbaoS032FyGDW73eKvUgedAdvWKHBdXEZfErf69rjogvgR
 rmvQZImMRZFwIbWKKJMa5vvjFZbQP7LPNXYfnL3mmGsCBLOzbSJOs6iQWIRxiTSDwA6kh4St
 SKcMgQkByim5XzfEj1GFFTzbkeq+u57/jfzbEgzyQiRJ2lo16a0/BMTzaieTPQV16lCvC4ht
 zRyEVCV29PQFsrGpgx9caEaatQ4thMP6XzDqw96dqG6NL1mh1hWJxhqpVjz0xRxIphaitUur
 XVsygduf+bQ/Fpfdj/Q9JHqPrzaYj37/QqraqPa8l7b2deSvKwI7aJ8427iuQavHwIc/ml73
 sMdh2Cd45LMBSIcX431VgA8904piavdZ3wG7oXbkF1hNq/8kDLF3Zp9CegrxAv6J48HYfOsG
 wr7EslcDM+rfr9502O1Zw4JabgBvJU/ONmrIr7fgPbD1IdImTuniT8C+4VhygeX8DI6TOfU3
 pEDyvXe3w2dVj66gk3y+tvvl9ViYjcfVnG61TCiHJRYM6Bxc4gWUz/2e5zn7tp7jp/pHXVf8
 Q3rHEsIjfegYgHadFnhxUtV3EUTr2agnH61zDJ6jmtx9vLOjATBxu3jcFwMPWsYDHJ6gwLKJ
 o65x8sfQFDubwUtk0694l3mwqFAuKllB2zaQEMNZyqvam8/Ce2/sb2NZ8MJ45Qt2clOeMK7Z
 13SCrv0oh9BljjmA3Mb3zcjMTejppT+mRV+zmObNnd66nTDK4l2wl/E6drQSOQ0vHJOTTRki
 TTRGlm3PsW4tdSSmZDZt+miVmWnHpRNeCjvxImEuWO1/2pvSRG4mvmynJXgH21YmWf21NdkS
 H+Q9E6tMqHk0q27NaRseUwpTF7w5sxmG51vx5MqjcJY0nwbi5OJuHsfxD2rYJMLhOSkNSRLG
 GVYprydqBLo00BiMH+TkofwV3HGh9Bke8H/eWQOnCQ088FNDq6Qqr1Chyp85FSi/mezKbBwm
 CkQzfw25TsUmeYM7UAgzSuTH+pKRREJbQTjkh2J65a1q6AdNwPNOfCgkVFzm9ysFuTIrwJSV
 mujIs96TH9Y4cB2MVaK23r2oNKBGpGYfZcYsRualA3Fhu5eJccql/YEsiFgPHr0oXwvz+NTY
 QVG5Zihp8DHLmxs+Pn8GRtELnjuYNtV/DjxjKFYl8LQ3oa1H5wnFC9ZFJfvSPupFnoVu5GFf
 06DEzMyty3DQeKOTSeQ7U5nqzTEFJXjO3yMJXYfxMlvX1HHfB0Z0F1SBmxk2MNiXgmxjNTsa
 kJ4+iwc6jua4lNXx+RkOgO+GmbTqQG0ayslHZ2WLR5Y9AZHtA/eNc2T6P42HjkNpMXw6lzQb
 DbCOUIVVjJsOATMHV3oM7iw6MOV9uGZArH7NP7SefCVrvQYUf6UxJWp248g/jCWN8zJMGMxa
 p9zkkdFQ319HNzU3jsVTClC3S/OYcCG/k/konwnhs+6+fXvHgno4MHcbtkaecUq4B2wjaqZY
 qSdhyh3NGwAjstdlVfHzbEe2BgZjCQkJFzPWfwQ8CXKSqzXgKpeCRUWPjhyOMV/5KU5xgBRO
 MTfh4C9xvtig/UyEVsASU35l5Tje5kRO2/kfgCiZg7DJPGcKDbM2c2yfa6sVegakrBPrxPp8
 TeDTx28YnLazWSvD1b3drgSxCCDYE4E4ND7IksrUDKzCoqhM0LeUpc/jCVok+ds3iqYaT5Ca
 WogIx0R/O/XsH0Qg+0hSTYdtiY3c7ncw3TFv7eEeMRR7KUOYGw8lvoEsi5kk+QH4nFOHK4py
 HWO/Iwp/g/uk/HRmGA3CEIc8TgT1t7b4xkwa+KEqPwiET7F5Exft2zIU0ZT+4Y9WIG/5fwCm
 J+SyuryMGkQqdmM85kSDZWMep7XbiZzY120RnbCBQ8BB1ZHLEn5gEpQ2LGX/3yR9d0hr4T03
 YEJUvldXUA0EfUTDgJkGsYDKdF5RGFsl7nTl8MO6XekyXuZDMxHopDKUO6TCvTzOX6Yi7dDf
 R4B3bL/K8waKIT630VoblQykp7NHgLcWtVEoyspaQFRwg0F6H9lUmg6wF7ocCuo6X4XUOa2x
 1s411A4buMq+zPhpVwwIxuCpSc9llUwhcSwgT2Vd22UTu/4VoVXBizo8kkpZ8mjEkAlMEvox
 BIiaWyXItAZx6Ftfm1qlgLG7J5GGPoHCLZBfAdV3vaPIfMhzVVbrCyjg05B/+rMT5V4x25IO
 dahqWxN3wV7YZs7P6vVceBEzVZem/jW5nf5hsg+xQYfIwAG92bYK0tq8AQYc6IrISal5Lkm8
 QuZhz5KY3QBTdIvq/Nus1s/YqGOknmm3LlEJUS8ceeYKunK3gqI3d7NSVQ22EQSkkBD9rUjy
 sYvfX2fUEU3xaeQHRAEXSItAQ5QZstWsnPUeHTX2Q0o6Z1wNoS5UOvvSL3W3E71qketHQJsB
 4ZVq8pcRd+j10bXKcqhJ7kAm01F2Q==
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:6uG4Jq45nZvSVor1DQPXwOzXdLJyesId70hD6qm+c20xTiX+rb
 HSoB1/73XJYVkqKRYdcLy7Scq9qDbnhOZICOoqTM2ftWvdyQ2VxehZhOOIowEIWReOjdK1vZ
 0AT0EUMqyVMbEVt7eZ3CCIV/glhPeImZrGuQ4c9RtQpMNRBp2Ilz0Jczpz23cZeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AfjdBaGrppYDs3llKFKtz4BnmUeYdfiPbwmvsGn2?=
 =?us-ascii?q?pJkBNRqOve3aJ+4oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A6MTuoQ1YEhxtEuudmkqtKAuDejUj0rWfBBwWi5U?=
 =?us-ascii?q?6n9i4EX0vO26wqyrve9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152815236"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHzpdb+vVHh34y7KXuhaGD2Oy5T4l0/DyD94d?=
 =?us-ascii?q?WGvPHjjAAoeEvUUHvgjwnGmU/LEZPWV2xP+5KCt5o8+CYNF7lQiA9dyL?=
 =?us-ascii?q?DEENmMifpImGoJSSIxbtGKtD0KvHG+0LbaG+YKAGX4NXgFJ0lSIbDUP4?=
 =?us-ascii?q?B+rA4I2hI0o+Var2m43udp6w=3D=3D?=
Received: from mail-pj1-f53.google.com ([209.85.216.53])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 20:46:10 +0200
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so976871a91.3
        for <cocci@inria.fr>; Thu, 23 Jul 2026 11:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832367; x=1785437167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6s5SzAkwTqv2cG0ZEuCiRJMYbGatFZIR2B9nCnRkYh8=;
        b=LUqeIqOB6CNLlGcmj2KxrMpGEnLOHaxZCCK868SF/1eKPnc1vqOVQz39IJzP87Q5vk
         IFZ0MuYvvyVXP1Zf6SH2I6dKksoXbZWunfx/XJ+gluwcfq8aA/YKHFktULW7QGtVRA4j
         aRsdaKEfBW/2nahJcB3l/DErNPGw+RRQlWX3nAvK8DxI+BzVq8mn4wu6Z8OcPpIjyu1y
         rrzHIB3AfIPfnh25AowHV54yGihvyXCoNbe7lfs4n9JePEGamWFf4vU2TV+72dRs0b/G
         4X8MmlxLbENCVeKXIp07NW18jCKlhxzdr+ZnYdMCokXZTSL4mzqYLghOOTg4fF58Sk8f
         JC1g==
X-Gm-Message-State: AOJu0YwxjLYKQn0mQYOhZxSQ1LUpC8vLx/DQjV2MSF47RUCPYvgn8//1
	G/1sIeuiHitYJWwfSdD5WeL6RHKgcI0ZhyqAOPM3pyCJivYcqmPKek1n
X-Gm-Gg: AR+sD13+HAnB7rUxNE2i8DBqCHAvjCBTLUt+oiBIzjMn/RGdpDF1qH7NdkTqZFi+3+B
	dxHUtFrUC82D2v1w+/N7lWyBj4bZ5b0PeId+8ghdgWMktKGpuTXWT3oOKDjZaGYbdI5b6Gu8abj
	9CBQyST1QdN9t8m31mozSV0AliP2xSnkXhnEFtEBZ2A61NXoKIss2J7L6dkIJiU3TZtqDrKB+5e
	+2DEXxemlIxv22hL0uJg7gO0xmN657GYBJ+rsSjqRfytaCOs/EZ60qaixhLF6ki3s/f8rKfgHXU
	0KNgUI1zZiqInml10HjBVUYZihCwvtNfh3jWj5gy8/4302cT7gInMWAVhekX6lJxoVWNGZS2BJ6
	199CIcOK2sbO3cr5k0PxwsUuAlK62LnwBEX0Mh794/1wSUtSFKRHo3ipavh+V7qReTYhfvMQU
X-Received: by 2002:a17:90b:4b92:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38ec697d294mr3808455a91.16.1784832367424;
        Thu, 23 Jul 2026 11:46:07 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:06 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: cocci@inria.fr,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>
Date: Fri, 24 Jul 2026 03:45:07 +0900
Message-ID: <20260723184538.3888637-6-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH 05/36] drm/i915: remove conditional return with no
 effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3602
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/L4J-KRqDBHmykSKd4XSyvQ>

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 7 +------
 drivers/gpu/drm/i915/gvt/gtt.c            | 8 ++------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 8a019d3574df..90880be63a1e 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2658,13 +2658,8 @@ static int
 intel_hdmi_connector_register(struct drm_connector *_connector)
 {
 	struct intel_connector *connector = to_intel_connector(_connector);
-	int ret;
 
-	ret = intel_connector_register(&connector->base);
-	if (ret)
-		return ret;
-
-	return ret;
+	return intel_connector_register(&connector->base);
 }
 
 static void intel_hdmi_connector_unregister(struct drm_connector *_connector)
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 5056a5887b31..6bca40128d99 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -725,15 +725,11 @@ static int ppgtt_write_protection_handler(
 {
 	struct intel_vgpu_ppgtt_spt *spt = page_track->priv_data;
 
-	int ret;
-
 	if (bytes != 4 && bytes != 8)
 		return -EINVAL;
 
-	ret = ppgtt_handle_guest_write_page_table_bytes(spt, gpa, data, bytes);
-	if (ret)
-		return ret;
-	return ret;
+	return ppgtt_handle_guest_write_page_table_bytes(spt, gpa, data,
+							 bytes);
 }
 
 /* Find a spt by guest gfn. */
-- 
2.43.0

