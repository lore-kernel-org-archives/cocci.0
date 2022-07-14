Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB800C433EF
	for <cocci@archiver.kernel.org>; Thu, 14 Jul 2022 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:references:in-reply-to:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0ttmnBweQXtnFPdwmNwmGLQhU6S6aiipAwaaip34dqs=;
  b=Y7E0jXjYxQpZrb1HOgZTFc+BNcpRqC+H+Ei2BrQ55eTy4VcohrHTixKD
   vUbQ5Xlpf2/y4DK+MZdpyDe9dIO4dDJVacB6yNxp4BinKFwml9ZxcpONF
   PD3XjL1kuzA+wmQPfc3D3FO6L1VC0FAfCaDm2sOcEObXLrH0DcWdzPtBy
   E=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.92,269,1650924000"; 
   d="scan'208";a="45584274"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2022 11:59:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0DF3E0264; Thu, 14 Jul 2022 11:59:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 65046E0260
	for <cocci@sympa.inria.fr>; Thu, 14 Jul 2022 11:59:38 +0200 (CEST)
IronPort-SDR: 8fFUSWN5MgEMV9eHMfq4QNgFSuMJK2tmDeHtuF12SwsQaRX0gFvO9h4G/AzsjWEzf1EAqUUhSs
 nxOlJcZgkMe5zuHj1CmXZQC4IB8R869ANWIfLEz4OFodPsYxPhhkL9T/WnGFTDiXCofG9mEVzL
 aYeUbNVFxQvu9h4uonvMXBN1C5x/5wKXi7pNpZLr7q3scicbf+yaVnzO5A53Olyda173PWm4md
 sax5jAC/K75k9N2Awx+xzo2gZzpVdnwlZtJqupbhoqyasVneyLMgd1s2iAQZoeywdeA7xOUm3H
 b9r3ytDXtTxhQlACqf5/ZFB9
X-IPAS-Result: =?us-ascii?q?A0ArBQC9589ifyvaVdFaHgEBCxIMQIFECwKCIoFXLgRQh?=
 =?us-ascii?q?BE9iH+IEIsyegyQPYF8CwEDAQsBAUACBAEBgVGDNAKFDgIdBwEEMAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBDQsJBwgKBw4OBWABYQMBR?=
 =?us-ascii?q?IFPgXQLAzENQBYBgV4pAYNjAQEBAQIBDAYRHQEbHQEDAQsGAwILDQICJgICE?=
 =?us-ascii?q?BMRAQUBHAY1hUABAw0jAwSQII8cgQRCijh6gRUFF4EBggkGhE0KGSgNajqBH?=
 =?us-ascii?q?wIHCQEIEm0sAY4Feiccgg2BS4JEMD6IGoJlBJstBA4LDwMDAiIDGi0jAQEKA?=
 =?us-ascii?q?gYGBAYDAQEFAwkCBAISAgIEBxcKEggUAwIGAh0FAQcFAwMSBgwRAQgGBgEEA?=
 =?us-ascii?q?goBAgIFBQwDAREDAgYCBAQEGBQEAgQHBgIJCQcFFgsECgIWARUCBgwFAwICA?=
 =?us-ascii?q?gICBBIHAQ0FAgIEBwcCBwYDAgkCAwUHAwEEBwwEDA4BAwEHAQQFAwsEAQEGA?=
 =?us-ascii?q?gkDBQgCAQIDCQEBBwQIAQECAgMCAQQCBwECBQMCAwgDAgMDAgEBBA0DBAMEA?=
 =?us-ascii?q?gMBBQEFAwIFAQMDAgEDAwIBBAMGCQoECAEEBAEBAQ8CBQcCBgMDAgICAgUBA?=
 =?us-ascii?q?gwCAQIEAwYGAgMQAQIEAQoBBQIDCAIHAwIGBAoEAgcCAgQBBQMNAQMFAgMBA?=
 =?us-ascii?q?QMDAgQBAgEBAwgBAwIDAwICAgIFAgMCAgIJAwQBBwMCAQMBBAMBAgoEBAMEA?=
 =?us-ascii?q?gIHAgcCBAcCAQIGAwUGAgIBBwEBBAoEAwMDAQMCBQICAwIGEgYGAgQBAwQCC?=
 =?us-ascii?q?gICCwIHAQECAQEBAQIDAgcFDAEBAQMCAwYCBQICAQEDCAgDAgEEAQUDAQQFA?=
 =?us-ascii?q?wcCAQUGAgkDAwkDAQEFAQMBCQMDAwIJAwECDAQDCAMDAgMEAgICAgEDAgcFC?=
 =?us-ascii?q?AQBBAkCAgIBAgICBAIBAxoBAgMFAgIJCwEEAgIDAQMBAQIIBAkEAgMEAgEBA?=
 =?us-ascii?q?wIBAgIBBQIOBgEBAQECAwMBAgMBBgcCCAIzEQEDAwMCAgUCAgECAwICDAEBB?=
 =?us-ascii?q?AIBAgECBgEDAQICAwEDAQICAwIGCQIEAQUDAwICAwEBBQ8FAgQCAQIGBQIBA?=
 =?us-ascii?q?QEEAQMEBAYCAgEDAwIOAgQBBAECAQEjAwQCAwEDFwECAQIDAwMEBgcFAgECE?=
 =?us-ascii?q?wECAQEBBQECAQEEAgQEBwoDAgIEAwMFAQECAwIBAQEHDAICAhMCEwMBBgEOB?=
 =?us-ascii?q?RQDAQEEAgIBAgIKAwECAgEDAgkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDD?=
 =?us-ascii?q?QICAQEBBQYNAwIDCAEMAgcDAgEDBQECAgIEAQIEDAkBAgIBAgQFBQMCAQgGB?=
 =?us-ascii?q?Q0FCQsBAQIBAwcEAxECBQMFBQMDAgEJAQUCAwECAQEDBAEDBAYBAQIDAgIBB?=
 =?us-ascii?q?gICAQEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEAgICAgIDAwgDAgEIBwUBBgECA?=
 =?us-ascii?q?QQDAgIBAgcBBAEJAgEDAwUDBAEKAw8DBQMBAwMCFQoFAQUIBgkCBAUCBQMCB?=
 =?us-ascii?q?AIDAwICCAMCBAMCCwMCBgMEAgcTBwIDAgIFAgICAgIFBAMBAgICAgICBQIEA?=
 =?us-ascii?q?gEFAQICAgECAgIEAQICBwQCAwEDBA4DAwQCAgcBAgIBBgECBwMBAgEEAwEBB?=
 =?us-ascii?q?AICBAECAgUCAgEEAQMBAgYCBAMKAgIDAgICBggDAwwJAgMFAgIFAQECBwQCA?=
 =?us-ascii?q?gsBBgIHAgIBAgMRAQMCAQQFBQMDAwkCAgMCBAICDAEBAQMCAgEFBQIEBw0CA?=
 =?us-ascii?q?gICBAICAgECAwICAQECAgQECRIBAQIDBgMEBgMFAwIKGAEGAgIBAQICAgMDA?=
 =?us-ascii?q?gYCAQIIAgUBBAUCAQICAgIEAQMGAgMBAgECAQICAwMDAgEEAgQDAwEBAgECA?=
 =?us-ascii?q?gIDAgICBQICARcGJwEBBRhMnShgCC6CSqxxlHphghNnoEmWVpIPlnenIAIKB?=
 =?us-ascii?q?wYQIxKBLIIVTSMVbII3TgECAQEBDQECAQEDAQIBAgkBAQKOHYNyimA/NDsCB?=
 =?us-ascii?q?gEKAQEDCYI6gwomEwsBhVSDKAEB?=
IronPort-PHdr: A9a23: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
 59cEtezu3Q6E/obDgJuG9lQef9K
IronPort-Data: A9a23:rMBYvK42WmJGSYcKHdUAvgxRtPnBchMFZxGqfqrLsTDasY5as4F+v
 mNMXm6DMvqKajDzet1zYNjjoEoBvpXSmN4yTgtl+ShkZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2OaEvfDjW1nX4
 Yyr/5WGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 NxJksaacEQEB6Tdm8oaaBIJLCN8IYQTrdcrIVDn2SCS50jPcn+pzvc3SU9qZssX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThE7kq2p9LwMrDZOvzvllp0zjDBPwOTpXKQqGM7thdtNs1rpwTQKaCP
 ZVCAdZpRCSHRTdMFlUaMp0Bnt+T13DUfjt68V3A8MLb5ECKlFAruFT3C/LRc8ODQcF9jEedr
 HjPuWX/GBATctKFoRKO9Xmnh8fUjCbjUcQTEqe5/7hkmjWuKnc7DRQXUR62o6D8hBLlHd1YL
 EMQ92wlqq1aGFGXosfVVhmf+lS9/TMlUstTPeoB41CyyKjIylPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXFGRpxEZ/E/VuP1TgpwXwqPnBbEFNUizX3iMRi0UKVF4cL/Lud14WtQVnNL
 ya2QD/Sboj/YOYO3qS/uF3F2nei+sOPQQky6QHaGGmi62uVhbJJhaT4uTA3Dt4adO51q2VtW
 lBax6ByC8hQUPmweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBkneho2bZ1bIWW3O
 hWL0e+02HO1FCv6BUOQS9LhY/nGMYC9fTgYfquJMYYUM8AZmPGvpXkwPRP4M5/RfLgEyPljY
 /93gO6jCnEVDakP8dZFb7Z17FPf/QhnnTm7bcmjkXyPiOPCDFbIF+ptGAbRNogRsfLcyC2Io
 o03H5bbm313DreiCgGJqtV7BQ5RfRAG6WXe8ZM/mhireVo4RgnMypb5ndscRmCSt/0Lz7+To
 yDiBBUwJZiWrSSvFDhmo0tLMNvHNauTZ1piVcD1FVr3iXUlf6i166ITK8k+cbU9pb5syPd1S
 78OfMDZWqZDTTHO+jI8a5jhrdw6JE77217WZyf1MiIie5NARhDS/oC2cwbq8h4IBHXluMY7p
 YqmyQ6GE4EIQB5vDZqNZf/2lwGxsHERlfhcRUzNJtUPKkzg/JI7eSP0h/4zZcoLLEyblDed0
 g+XBzYepPXM89dlqomX2fjcot7wQeVkH0dcE23K1pqMNHHXrji53ItNcOeUZjSCBm75/aOVY
 +8KnfzxNfswmkkT79hxHrNt+qIJ59X1oohcwAk5Tm7AaE6mC+85L3SLgZtPu6lKyuMLsAe6Q
 BjUqNxTOLHMNcG8VVBNf0wqaeOM0fxSkT7XtKxnLEL/7S5x3byGTUQCYEXW2XIFdON4YNE/3
 OMsmM8K8Ajj2BAkBdCL03JP/GOWI31cDqgq6sMADInwhlZ5w11Oe8aHWCr/4ZXKZtcVd0d2e
 Xmbg63Ng7kazU3HKiJhGX/I1OtbpJIPpBEakwNYdgrRwoLI1q0twRlc0TUrVQAJnB9J5OR+Z
 zpwPEpvKKTSojpliaCvhYx3992t2fFYxqDw97fNvGjQTk3tW26UaWNhYqCC+0cW928adT9el
 F1dJKAJTh6yFPwdHANrMaKmlxAnZdN0/wzG3sugGqxp2rEkNCH9jPbGiXUg8nPa7ABYuKEDj
 eZv9ed0L6b8MEb8ZkH955ayjdwtdfxPGICOrTyNMk/E8aEwtQxeAQSzFn0=
IronPort-HdrOrdr: A9a23:GSdr56NVxE1FcsBcTgujsMiBIKoaSvp037Dk7TEUdfUzSL3mqy
 nOpoVm6faQslwssR4b6La90cW7MBHh3L5zpZIcJLKzGBTh0VHYV72KjrGSvgEIeReOjNK1vJ
 0IG8Mfeb7N5BpB/L/HCWGDcurIq+P3l5xA692uqktFcRtncOVp4Qt/F2+gYzVLrcp9aabR1q
 Dw2iOKnVWdkL0sAPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,269,1650924000"; 
   d="scan'208";a="45584273"
X-MGA-submission: =?us-ascii?q?MDFGl1YYWCXgHQHAFQ052v4JsqB3m6pkti7zON?=
 =?us-ascii?q?TWYClbXilf72l2g0mIgdD0xUSYfPiHRCur9jVt12kCMZQV5W7zz89Dl5?=
 =?us-ascii?q?c2KH/bXIKAo6R/Qv9IiZE9+rLaCEcvMNnRiTkPEyougcKOfZxnHRrl6U?=
 =?us-ascii?q?6NORtihwJcYybkpBl3D/TmZQ=3D=3D?=
Received: from mail-ej1-f43.google.com ([209.85.218.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:59:37 +0200
Received: by mail-ej1-f43.google.com with SMTP id bp15so2479977ejb.6;
        Thu, 14 Jul 2022 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0ttmnBweQXtnFPdwmNwmGLQhU6S6aiipAwaaip34dqs=;
        b=iYXnMDWGbXh06gQH4Ea6B7lo9JYfL/H9fxi/iTZVVKKDsKoEHjEvaT1nHPk1ddTXk2
         2dYlZDXD4xolbZlXXmcHoLVVYhxtn4isBJkHzhGo/smpmAXwFkkeXMjwuj8AHrUVb3kz
         8We1e1yPYFtsADdFbzvbzFJ9QWDK9eHVBLtjP1XVVnU0XewXN3U7GKhavMgTm23yyeWj
         kWmS+4NtxbfumojUlq5ONpy1Wh8eOEhkIZOo57/1ZlM+1h+MbuhDfSW4LHgohF2PrpID
         At9fkSb1Zi8lmMglp1c7o+N+YTYDZmDR4vAw9FIA9UHBkAmhiPLR8oKGLnykD2+6FLfT
         573g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0ttmnBweQXtnFPdwmNwmGLQhU6S6aiipAwaaip34dqs=;
        b=w1xNepwjrjOy2+7zWKpUnPO1ZYpRBuQ4FNUhpZhoTwaIjnUZAIblH04G4gk16SjtVm
         XeZRYCIt6nc1MUTI92+Ii/rnZsE+E9+tnIUcZFMgg8Ufut6fotDqYjdN7RTTLX6ooxSG
         vaMK8WP8PgxATHo23WBrb4n3SSIsJtCeSlhNBSsHv7bwKSwA7NEBSWjxZdZrfTMsoSMO
         TkXWh3aFFf7SzRP/nGoh3v4TSYNA7V9AHv87bD5iwh15iwctirXyVGKdOiG7er2zcCba
         hxfIkYH80lNSgpKIiS4tr/ZEN9RhivfqIwoRNxIGgosjMq7CPVnFxioJYFRx+10K9sRj
         krMg==
X-Gm-Message-State: AJIora9qOnX7dmJIG7RauQrikJaYG6fG1bOGd5A44pNn16H+DLkHCVtj
	ChDmd8z9ZziqoOOI7IG24nzVl69XRAwMjA==
X-Google-Smtp-Source: AGRyM1uKKAyV8Oms/QLORE3EP4/yLYcRZ2QZ9B+wPVEixOAHDRNJgMvZ5DCazOzfJkKPWzwRylEgJQ==
X-Received: by 2002:a17:906:974c:b0:72b:8cea:95c2 with SMTP id o12-20020a170906974c00b0072b8cea95c2mr7929963ejy.65.1657792777117;
        Thu, 14 Jul 2022 02:59:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j12-20020a056402238c00b00437938c731fsm734625eda.97.2022.07.14.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:59:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1oBvd9-002Bpk-WA;
	Thu, 14 Jul 2022 11:59:36 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Coccinelle ML <cocci@inria.fr>
Date: Thu, 14 Jul 2022 11:52:08 +0200
References: <220714.86bkts2fz9.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2207141138450.3019@hadrien>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <alpine.DEB.2.22.394.2207141138450.3019@hadrien>
Message-ID: <220714.867d4g2ewo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] How do I disable formatting for the "+"-side of a rule?
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 492
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/220714.867d4g2ewo.gmgdl%40evledraar.gmail.com>


On Thu, Jul 14 2022, Julia Lawall wrote:

> On Thu, 14 Jul 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> How do I stop coccinelle from turning my "{ 0 };\n" into
>> "{\n\t\t0\n\t};\n"?
>>
>> I haven't been able to find in the docs how to disable formatting on the
>> "+"-side of a rule. I have a rule like:
>>
>> 	@@
>> 	type T;
>> 	identifier I;
>> 	@@
>> 	- T I;
>> 	+ T I =3D { 0 };
>> 	... when !=3D \( I \| &I \)
>> 	- memset(&I, 0, ...);
>>
>> Which produces the expected results as far as the patch is concerned:
>>
>> 	diff -u -p a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> 	--- a/builtin/for-each-ref.c
>> 	+++ b/builtin/for-each-ref.c
>> 	@@ -20,7 +20,9 @@ int cmd_for_each_ref(int argc, const cha
>> 	 	struct ref_sorting *sorting;
>> 	 	struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
>> 	 	int maxcount =3D 0, icase =3D 0;
>> 	-	struct ref_array array;
>> 	+	struct ref_array array =3D {
>> 	+		0
>> 	+	};
>> 	 	struct ref_filter filter;
>> 	 	struct ref_format format =3D REF_FORMAT_INIT;
>> 	 	struct strbuf output =3D STRBUF_INIT;
>> 	@@ -52,7 +54,6 @@ int cmd_for_each_ref(int argc, const cha
>> 	 		OPT_END(),
>> 	 	};
>>
>> 	-	memset(&array, 0, sizeof(array));
>> 	 	memset(&filter, 0, sizeof(filter));
>>
>> 	 	format.format =3D "%(objectname) %(objecttype)\t%(refname)";
>>
>> But I'd like for that to be e.g.:
>>
>> 	struct ref_array array =3D { 0 };
>>
>> Which is a common idiom both in this codebase (git) and elsewhere.
>>
>> Usually I can find an answer in one of the coccinelle.git's *.cocci
>> files, the man page, or the grammar PDF, but in this case I've come up
>> blank...
>
> Try --smpl-spacing.  I'm not sure whether it affects newlines, though.

Thanks, no it just changes the spacing of the "=3D", i.e.:

	+       struct ref_array array =3D {

v.s. with --smpl-spacing:

	+       struct ref_array array<TAB>=3D {

(Or similar, I think it's aligning to the "=3D" above it?)

But the rest is the same, i.e. a \n after the "{", the "0" on its own
line etc.


