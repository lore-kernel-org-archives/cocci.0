Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2186BC282DE
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BvAmhIp672FcTh8QydCVgJQ9OGkof1lTKDgnIKxGf1A=;
  b=afBDa5WOqlYHNtodOhg1gpnJ0DPz58Tev+mLSOfqBq66+2al6MleX13u
   0VGhtF+twNDIVAgiqbJ1X4Tp5NteJVV0EBRFv736rCYwRPqTo0JQNmTK7
   GO0dZ1Jdf0pgX+vevHnvhUdegGDc5mRd02D32fqmLqDU69Uu8rqWX7y5e
   g=;
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
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211491577"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6AAFE0D1F; Thu,  6 Mar 2025 10:08:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 506F1E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 15:17:37 +0100 (CET)
IronPort-SDR: 67c85d01_bF1XmblecqglSW56nYnPhD0K5Cz+GgR/Y1wN/Gp8TEyyQMg
 qE+On8tWPK60VwLBGsr6laDChqlLFQ/XponhQ5w==
X-IPAS-Result: =?us-ascii?q?A0GjAgBLXMhnfDGAVdFagQmBU4JEfVozBFOEGjyIfIZTM?=
 =?us-ascii?q?4FuA44XhDWLSIFAPg8BAwELAQE5CQIEAQEDBDiESAKLFgIeBwEEMQgOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw4SKYV7DYJiAYEkY?=
 =?us-ascii?q?QIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0fX?=
 =?us-ascii?q?gEBAQECAQwGER0BGx0BAwELBgMCGAICJgICIhEBBQERCwYTIoJhgi8BAw4jA?=
 =?us-ascii?q?wQNkmqPQIEFQopEeoEVBQIWgQGCDQbaXQoZKA1sA4FiAgEGCQEKF28uhHUpT?=
 =?us-ascii?q?g6COB0BhVuEDXongQOBJYEVgyo+gmEFgV2DW4JpBIIvgWmDPpVggQ2RdQgHM?=
 =?us-ascii?q?QgBCRMGCgJLCwoSAwQDBAQBAgsTCQMDAg4CCAMCCAYZAT8MBgQTCgMKCwcFH?=
 =?us-ascii?q?woICAQRCigDIgQOKwoDNQwLDx8VAQgGAgIEBAIEAgoCCQICCAcCFAMCBAQCA?=
 =?us-ascii?q?QUSAwsBBQYFAQEECQ4CAgMDAgIBCAICAQECEwEEAwEHAgUDBQMKAQEBAgEEF?=
 =?us-ascii?q?AYDBQMDBwMEAgMCBgIEBQUCAgMDAgMBAwMCAQIDCRAPFgICAwQCBgIBBCYCA?=
 =?us-ascii?q?RUFAgMEAgIHAgIDAQIBAgICBAIEAgIGAwkIAQICBwECAgIDFQIFAQQJAwMFE?=
 =?us-ascii?q?gwgAwICAgIDBwoDBQIBAQIEAwMDAwwNBwIDAQIBAwUDAQIBAgkDBgICAwMEE?=
 =?us-ascii?q?hkFAwIPAwIBBQQCCBALBwEBDxQFBAkFFQMGAgMDFgsEBQMDAwEIBA8OAgILA?=
 =?us-ascii?q?xcFAQEHAQMNBwEDBAQCAwMJAgEQAQMEAgkCBAECCgICAgICBAEBBQQCBAMCB?=
 =?us-ascii?q?QICAQgEAwMDDQQDCAgDBQMMEgICAgkCAwECAwMDBA0IHQUJEQsCCQMEDQIEA?=
 =?us-ascii?q?gIBBgMGCgYUAQISAgIGDAQDAwgDAgMCAQECAgIBEQIJCA0FCQUGAgIVAwIDC?=
 =?us-ascii?q?AEJAxECFAEGAggDBwEBBAICChEKAQECAgEGJQIBAQITEwcDCAICAgIGFgwBB?=
 =?us-ascii?q?QcDBw8FBQQCAhYDAxEEBBACAgMDAgEBFAYVAQUCAwYLAQYBAgUEAgMEAhICE?=
 =?us-ascii?q?RMDAwQGAwECCg0CAgIJCgEFBAMHBQIfAwMCAgULAggCAgUCBQcDCQ4BAgUDB?=
 =?us-ascii?q?AkCFAIQAgICCBYCAgIFHAMmAgQDAwMDCwECAg4JAwQ3BhEEAgMDAg4BAgILA?=
 =?us-ascii?q?QICBAIDAQQHCQMDCQoHAQoNBwIKBgIJEAECAhADAgICAgYHDgMCEw8FBgYCC?=
 =?us-ascii?q?gcNCwIBAgITAgMJBgMFCgMHBAoNAhUCFQUDHwECCAkLAgcRAgUSAw4FAwICE?=
 =?us-ascii?q?QQCAwMFAwEHARcDBwgCAgwCAgICBQIFAgUXEQ0EAwMDAggBBBUGAwkIKhsSA?=
 =?us-ascii?q?QEFAQkCAwIDBAgDAwMCBgwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDA?=
 =?us-ascii?q?gQFBAEFAhMNAgMZAgYDBhEJDAIGCAcJAwcBAQECAgIIAQYFDAkCAwQCBQQEA?=
 =?us-ascii?q?QEIAwMEBgIBAwICAgEECQEBAQIKAggKAQkTBAMIAwMDAwMFAQICCAQRBQUCA?=
 =?us-ascii?q?QUKEwwKBgMGAwQCAgILBwIDAwMCBwELIwIBAwICBQICAQUDAgIGBAMCAQEJA?=
 =?us-ascii?q?gMCCAECAgECAgIEAQcBBAcGAQECBAICNAIBAwkCBQEBDgICBAICAQICAgQCB?=
 =?us-ascii?q?AECBgsEBQ0BAQIBAgIBAQEEAQgDAQEBAgIDAwUDBQgPDQEBFwsdAwQFAgIBA?=
 =?us-ascii?q?QEBAhMCAgELAQIBAQMaAgEDAwQBCwIBAQQfBBYCAgICAgQDAgIDAgILEyUBA?=
 =?us-ascii?q?gMFAxMCAgQCAQICBQUFAQMEERUDCQEDAgUEAgIGAgQGCgIHBAIaBAICAgEDB?=
 =?us-ascii?q?AYDAQIIAgIHBAIDBgMCAgECAgcYAgIZAQMBAQICAgQCAgIJCgQFBAQEAwICA?=
 =?us-ascii?q?gEMAQEDAQIDAgICAgEDAgIBAQIDAQIFBg0CEgIBAxEIBAICBwICIw8LAQECA?=
 =?us-ascii?q?QECBgYCAwMDCgMBCgECAQECBgIBAhUFAgIBAgQBAgMGBC8dAgkDIw8DCwkIB?=
 =?us-ascii?q?wwBPAwHCigENgEUFAcGJRgBZwcHoHcBOoNQc4E5F4FnBkqSa4NQAbAHB4Qeg?=
 =?us-ascii?q?WOCN4d+lTBNE5czkxGYfo4Flg+EdQIKBwYEDSMSgTQCNoFcMxojgzdPAxkPj?=
 =?us-ascii?q?i0Wg1jIWEM1PAIHAQoBAQMJAYFVg20IAR0TCwGKFIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:jhAQG6lxq/fmAKg9cAqHQU7o5gwuIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfDTyAbvreMGL1fNp2Ponk9hwFsZ7VyNJkSwc9+yFmEVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayaz58B56r8ks14ayp4G5A5TTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN13Vk4HPIRJ3dpMX01Ex
 /Y4NQ4BZSiM0rfeLLKTEoGAh+wmJcjveZwa4zRukWCfAvEhTpTOBa7N4Le03h9q3pEITauYP
 pBJL2Y+BPjDS0Un1lM/BJsgnevugnD+fD1E7laUo7cny2fWxQ11lrPqNbI5f/TQHJwOwhnI/
 TmuE2LRCDUIK4ykyGe81ne8p9TdggjjZbA2PejtnhJtqAbOnzRMWUN+uUGAifK+gUW/c8lOL
 lQdvCsot6k7skKxJuQRRDW9qX+A+wEZAp9eT7x85waKxa7ZpQ2eAwDoUwKtdvQ/7sAHRDV78
 WOywf/jNzZPrYOZQkqSo+L8QSyJBQAZKmoLZCkhRAQD4sX+rIxbsv4pZoYzeEJSpo2lcQwc0
 wy3QD4Ca6L/ZPPnOo2+9FHDxi2p/93HEl9z6QLQUWaoqAh+YeZJhrBEC3CLvJ6sz67AETFtW
 UTofeDAtoji6rnTzUSwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbZpdIGayO
 RON4V8AjHO2AJdMRf8nC25WI5R6pZUM6fy+Bpg4k/IXMsguLFDXoEmCm2bOhTCywRREfV4D1
 WezKpv1VSlLV8yLPRK5QOAS1bJjxyY1gwvuqWPTnnyaPU6lTCfNE98taQPQBshgtf/siFuPr
 753aZDRoz0BC72WX8Ui2dRPRbz8BSJmXciuwyGWH8bfSjdb9JYJUKGNnul8Idc190mX/8+Rl
 kyAtoZj4AKXrRX6xc+iMRiPsZu2Bc0j/0EodzchJ0ip0HUFaIOipvVXPZgucLVtsKQpwfdoR
 rNXM4+NE9ZeeAThoj49VJjaqJA9VRKJgQnVATGpTgJidLFdRivI2OTeQC3RyAc0ABCK6PQO+
 4+b6luDQL4oZRhTM8LNWff+k3KzpSc8ncxxbWvpI/5SWkPmz6ZyIQesjPVte8AoAjfAzwu8y
 Ay5L0o5p+7Mgolt6/jPp/mOgLmIGttEPHhxPjfk/5fvEgLF7E+P/JRmbN+YWRz8CEbl57SEZ
 8hO6vP3bc08g1dBtrRjH4ZRza4R48Xlo5lYxF9GGErnQkuKCLRyBGuvxuhK67Nww4FGtTuMW
 k6g/sdQPZOLMpjHFH8TPA8UUfSR58oLmzX97eUHH2ui3XVZpIG4aER1OwWArAd/L7EvaYMs/
 roHif4ssge6jkInD8aCgiVq7F+zF30nUZg8l5QkEYTu2xsKyFZDXMTmMRXIwqqzMvdCDkp7B
 QWvpvvmp69dzU/8YXYMBSDz/e5Ct68v5jFO7nE/fmqspPSUp8UKzCVw8Cs2RDt71h9o8fx+E
 Uk1OlxXJZehxSZJhs9CVV+CAwtqXUaTxmHt+VkwyUncQ1eiDGDWHlZgO+zXpEE92EBfdwh94
 7u35jvEUzHrXcepxQo0exdvhMLCROxL1D/puZ6YDeGaOZglOxz3r7SLZ1dUmyD4AMg0ulLLl
 dNq8Ml0d6f/Eywa+I8/NKW3ypUST0qiCFFZYPQ84p4MI37QSAuy1ReKNUq1XMFHfN7O0E2gD
 v1RNtB9bAu/2AmOvwIkK/Y1eZEsp8EQ5f0GZr/PDkwFueHGrjNW7bThxhKnj2ovG9hTgcIxL
 73KTA27E0uSuGB1nlHcp8wVK0u6Ztg5PDfH5t6Xy9lQNZw/s7BLS3oQg5+UpHSeNTV18y2E5
 D3jY7Dk9M086IBOsba1LIB9KVSVE/3RWt6M0jiPiPVVTNaWMc7xpwIf8VbmGAJNPIouYdd8l
 JXTkdv7wHL6uK0SVkbHkaKgDIhM3925B8BMA/L0LV5bvCqMY9Dt6B094FKFKYRFvddex8u/T
 S66VZeUWfsKfexCnVt5RjN7ERkPL4jWNILbujKbvfCALjM/wD73Boqr2lGxZF4KaxJSHYP1D
 zHFnsqH5/daid9pLwAFDfQ3OK1ICgbvdoV+fuKgqATCKHejh26Dnb7QlRAAzzXvIVvcGebY5
 aP1fDTPRC6Qiorpku4A65dTuycJBklTmeMzJ0IR2+BnggCAUVIpE74vDoUkOLp1zArJy5DKV
 BPcZjADCAL8fwh+XzfS3dDBZjqbV8syYorXBzpw802tPnL8QMvKBbZ67S5v7ktnYjapnqntN
 dga/Wa2JRSrhI1gQeEI/PGgnON73bXgy2kV/Vzm2dnHa/rE7W7mCFQ6dOaMacDGLy0JvEDCJ
 GxwWmUdBU/nGAj+FsFvf3MTExYc1N8qI/PEcg/XqOszea3CpAGD9BE7E+7227wHKs8NIdbig
 FvpEnCV7Tn+NmM74MMUVhFAvUOwIf2OF8m+aqTkQGX+Wk12BnsPZ6s/oMbEcC3uFMOz3b8Qe
 vlALkXS3Hi4FX0=
IronPort-HdrOrdr: A9a23:NTD3tKpcXM0TburfWfmilQoaV5rQeYIsimQD101hICG9vPbo8f
 xG+85rqyMc6QxhJ03I/OrrBEDuewK4yXcY2/h0AV7mZnichILKFvAf0WKB+UyZJ8SWzIc0vt
 YDT0E9MqyLMbETt7eY3ODSKadY/DDoytHOuc7ui1hqVh9jcKxt4kNUDQyBAlRqSAQuP/YEPa
 vZyM4CiTTIQxoqhweAaUXtndKvmzQGrvPbiGY9dmMaAcC17Q+V1A==
X-Talos-CUID: =?us-ascii?q?9a23=3AMJ7T/2rcTKnZH64Q6YFJyqLmUdl/fUzcxSb3H3T?=
 =?us-ascii?q?mJWxbQp2Id1ObwKwxxg=3D=3D?=
X-Talos-MUID: 9a23:msHTNgouTIjtPW6Kd4IezztGJtg42KXzMWQIgbQ9qdavLRFCHx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,223,1736809200"; 
   d="scan'208";a="211347833"
X-MGA-submission: =?us-ascii?q?MDGtpzayD+LPq3h+kJuxfLwmyKu/rI9lRvHtk/?=
 =?us-ascii?q?cUaYTRoZ0n2bWo6p6H9UUK29NdYHxIo57B8OtHAyYjbG0PdHvdq6S5Bg?=
 =?us-ascii?q?E7uMX1Ot1ux3igD1yPbODrLHSrIK2EKrR3sPS5OMFUY/HAgckfhL4E4N?=
 =?us-ascii?q?rZ/OKakxugJNZgbopVzqWjDg=3D=3D?=
Received: from mail-wm1-f49.google.com ([209.85.128.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:17:36 +0100
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bcc04d4fcso12767615e9.2
        for <cocci@inria.fr>; Wed, 05 Mar 2025 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741184255; x=1741789055; darn=inria.fr;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvAmhIp672FcTh8QydCVgJQ9OGkof1lTKDgnIKxGf1A=;
        b=Do1xbgZJTG5RwI0u39Tv+rM1D+ZqO6rKfyRN8LPBLps6EbuTclOPm5PdY0TPP66N14
         x3dxPaBUyHNI7hFW7SqZYRds5g2PWHnm62sNI/kSd0q3RIYNmLdbhUY6lsluzck/9pZg
         cZeNY+8g0jtEVzsrSOLwAMf59ttSwS5i2DX0J+DoytILI0BZUEN6BmfL8jenFb8h476G
         0hXQTQowVbhANcBsQURkQlYevSmIxHQxTqfvNTz8T/JtF38hWIylPJtn2YN1S3l3nMPX
         iwGyMWlGsg2t2jiDEwsvVo4BmDfcdF7jgUepQvsk9LJClUzXp6QnABKPkV0JhnHvzWq6
         lfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184256; x=1741789056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvAmhIp672FcTh8QydCVgJQ9OGkof1lTKDgnIKxGf1A=;
        b=LpREYKbYCKHqLjr1p3DjNTKh3eudKLuiR5IrtmmkPszrJ306+DCvBGMWrX7HIBeF9l
         zJBLKKqp4RU3XLQ7143+dWWk66jXyAyR6l9OcmLYK3NOmri5/+lX4VhrRwjwD55jYMM3
         sr2bUSxRfWaGtfig6r8seZIGbMib/x6AlohCL/5Sy6dJ+3XgG+dfCUujwzHaFAP75yxl
         g1e/jV16mXCK0J9BKZ3a790/OJwdWmz3iekuV6i/FyfCzv8urE5Wj73Zy10oepTm3X6c
         nItPPZhIwyvrw6lY3TpRZm8AE1enWWNXjl0d+6k2Fq3PKQf22zSPwKPrea8AthZA0yN2
         oO+A==
X-Forwarded-Encrypted: i=1; AJvYcCUZrKLhyuNl2t3HmJVSE68Fvq/KkKOEBaZBaeQHmw6bJHMptX1XGzMqNzMuM/s3YXrwKI0BBw==@inria.fr
X-Gm-Message-State: AOJu0YzvsSu1U7IzTbBi4ewR1lcfgB5XUeosagy3w74IRR5K68ipEm8W
	dvFFTHk2tzxtwpyyoDQPI3ZzMWKwRFkzl5v7KsX6P+HQWJOK0LPx
X-Gm-Gg: ASbGncvmiDSukfkPEw6NTG4yBJMBpX/v8BIZJSw8W/sdaP9sL7QlkoufFsZdNzAGh7x
	zMis3bJxyPUOidPlr+rqUpsS0aHhR81+c8mdAicwmbp53Qn+uy4c3iqMRlB4gIWzlYAVpwfiIaX
	ebiaYmEiuiNvKBOxFW3dsOPjLA49ykwo80kUgeWmow1bMSbdOyPZ8Hw03q5AI36w6jiB5WKzRUJ
	fj8Idcdv5LOzN0xIjTw0bQDtRSiHDfl28OlFOxj/enUApIKgoxEQxZXS1vz1cNTNQnBVq2r8piL
	75cJFplV9IHqI0Z9Yqesf4szDUu7ncQEuCEo7GxmcYYvj50xgLmQsInNZRhMVMpQsnnWDzet6TR
	QkT5FA64=
X-Google-Smtp-Source: AGHT+IHvrbtQypROMlLTHn2hwI/hJh1CATinBr60gY+FLSdoAnk3R75qGQ0/XKEyAvFG+ldQ1Dh+tA==
X-Received: by 2002:a05:600c:35d4:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43bd298f9fbmr29484425e9.11.1741184254319;
        Wed, 05 Mar 2025 06:17:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4291ffbsm18687465e9.15.2025.03.05.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:17:33 -0800 (PST)
Date: Wed, 5 Mar 2025 14:17:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, kernel-janitors@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jeykumar Sankaran
 <jsanka@codeaurora.org>, Jordan Crouse <jordan@cosmicpenguin.net>, Marijn
 Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>, Vinod Koul
 <vkoul@kernel.org>, cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20250305141732.26b91742@pumpkin>
In-Reply-To: <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	<1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	<13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
	<54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
	<k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
	<29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
	<e665514b-5a62-4afb-b267-7c320e4872af@web.de>
	<4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RFC] Clarification for =?UTF-8?Q?=E2=80=9Cundefined_?=
 =?UTF-8?Q?behaviour=E2=80=9D=3F?=
Reply-To: David Laight <david.laight.linux@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2556
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250305141732.26b91742%40pumpkin>

On Wed, 5 Mar 2025 11:51:59 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Mar 05, 2025 at 09:40:43AM +0100, Markus Elfring wrote:
> > >>> The address of a data structure member was determined before
> > >>> a corresponding null pointer check in the implementation of
> > >>> the functions =E2=80=9Cdpu_hw_pp_enable_te=E2=80=9D and =E2=80=9Cdp=
u_hw_pp_get_vsync_info=E2=80=9D.
> > >>>
> > >>> Thus avoid the risk for undefined behaviour by removing extra
> > >>> initialisations for the variable =E2=80=9Cc=E2=80=9D (also because =
it was already
> > >>> reassigned with the same value behind this pointer check). =20
> > > There is no undefined behavior here. =20
> >=20
> > Is there a need to improve the wording precision?
> >=20
> > There are words which denote a special meaning according to aspects of
> > the programming language =E2=80=9CC=E2=80=9D.
> > https://en.cppreference.com/w/c/language/behavior
> >=20
> > Dereferences of null pointers are treated in special ways. =20
>=20
> This not a dereference.  It's just pointer math.

And the 'fun' starts because NULL isn't required to use the all-zero
bit pattern.
Regardless of the bit-pattern, things like (void *)(1 - 1) are valid
NULL pointers.

Of course, while C allows this, I doubt NULL has ever been other than 0.
(It was 0 on a system I used many years ago where the O/S invalid pointer
was ~0.)

I know Clang has started warning about arithmetic on NULL.
I wonder when it is going to start warning about memset(p, 0, sz)
for anything that contains a pointer - equally invalid.

	David
