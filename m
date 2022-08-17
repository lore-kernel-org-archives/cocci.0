Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3BEC3F6B0
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=bL+yzLQjDhweLq/kzdKLiw0fLjmLwNDEXtCeV16XdXg=;
  b=i4wyMU0bSChNlNl63Q7MSBwL0K8ZAu3B/Uxp8Rf/c3bQMKSq89fKKoyp
   MxtoLRKkMVze7GQ2E9jbV2PdGs/aXLrSBBKrIbVVi1YqQaMwLihRpAgj5
   4e/aVKPNpFlV0aY7ZPHTqwpJp2WSGYayNEUxsb2KlcQ6yVcPOlPTI3sib
   M=;
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
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49037997"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 17:27:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DECE3E0385; Wed, 17 Aug 2022 17:27:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EEE1CE0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 16:50:44 +0200 (CEST)
IronPort-SDR: nJwATJ0ljmJ5zPciwlnbRdYeW7fcmQDCJOHYNMlqozn8golPVtxgiSf3xhGduzYmQK9hXjZpFV
 iUx78nM334JOijcnDIThtglxZVr9chwCPAWAssFB3Myrp95eEhDDg2Dq8g4K6yikPD8OhszYaF
 aIHUQJMeb3JkSBMGyZFvVkIAw0ORSiOjSw/lHqLBOF17/2OAi1/OS+gN83mznY86f0UHPCnK6W
 tziQx9JIeq7oJP42TzOxVqlthmM5GmgLQGsQchu27nx+4PA9UwEcJkf/hs0tJ665y5O3+n6pPb
 cNudiIcLCJgRRfLClwetRCPn
X-IPAS-Result: =?us-ascii?q?A0CAAADQ//xiXUPaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYFRUgcpAYEnLgRQkzWCJQOEJYcOA4EGkEMUgWgLAQMBCwEBQAIEA?=
 =?us-ascii?q?QGFBwKEeQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBB?=
 =?us-ascii?q?hwLCQcSFQ4FYAFhAwFEgU+BdAsDMQ2CNSkBg2MBAQEBAgESKAYBGx0BAwELB?=
 =?us-ascii?q?gULAQwuIxEBBQEIFAYTIoJbgm0BAw0lAwGbVoEEQoo4eIEXBReBAYIJBoJhg?=
 =?us-ascii?q?W4KGSgNZwNbfgIHCQEIgSsBhk2ERoQzJ4EZgRCBPByCZz6EDwESASEVg3iCL?=
 =?us-ascii?q?gSZEAQFFA8DAwIgAwkEBwUsHgIJAyMRAwsQEQcOARYBBAgBBAMBAQEOAgUHA?=
 =?us-ascii?q?gYDAwICAgIFAQIKAgECBAMGBgIDEAECBAEKBAIDCAIHAwIGBAoEAggCBAUDD?=
 =?us-ascii?q?QEDBQIDAQEDAwIEAQIBAQMIAQMCAwMCAgICBQIDAgICCQMEAQcDAgMBBAMBA?=
 =?us-ascii?q?goEBAMEAgIHAgcCBAcCAQIGAwUGAgIBBwEBBAoEAwMDAwIFAgIDAgYSBgYCB?=
 =?us-ascii?q?AEDBAIKAgILAgcBAQIBAQEBAgMCBwULAQEBAwIDBgUCAQEDCAYCAQQBBQMBB?=
 =?us-ascii?q?AUDBwIBBQYCCQMDCQMBAQUBAwQDAwMCBwMBAgwECAMDAgMEAgICAgEDAgcFC?=
 =?us-ascii?q?AQCCQICAgECAgIEAgEDGgECAwUCAgkLAQQCAgMBAwEBAggECQQCAwQCAQEDA?=
 =?us-ascii?q?gECAgEFAg4GAQEBAQIDAwECAwEGBwIIAg4OCgEDAwMCAgUCAgECAwICDAEBB?=
 =?us-ascii?q?AIBAgECBgEDAQICAwEDAQICAwIGCQIEAQUDAwICAwEBBQ4FAgQCAQIGBQIBA?=
 =?us-ascii?q?QEEAQMEBAYCAgEDAwIOAgQBBAECAQEjAwQCAwEDFwECAQIDAwMEBgcFAgECE?=
 =?us-ascii?q?wECAQEBBQECAQEDBAQHCQMCAgQDAwUBAQIDAgEBAQcMAgICEwITAwEGAQ4FF?=
 =?us-ascii?q?AMCBAICAQICCgMBAgIBAwIJAgECAQUgAwEBDyQBAQICAgIDBAcCAQQGAw0CA?=
 =?us-ascii?q?gEBAQUGDQMCAwgBDAIHAwIBAwUBAgICBAECBAoJAQICAQIEBQcCAQgGBQ0FC?=
 =?us-ascii?q?QsBAQIBAwcEAxECBQMFBQMDAgEGBAUCAwECAQEDBAEDBAYBAQIDAgIBBgICA?=
 =?us-ascii?q?QEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEAgICAgIDAwgDAggHBQEGAQIBBAMCA?=
 =?us-ascii?q?gECBwEEAQgCAQMDBQMEAQoDDwMFAwEDAwIUCgUBBQgGCQIEBQIFAwIEAgMDA?=
 =?us-ascii?q?gIIAwIEAwILAwIGBAIHEwcCAwICBQICAgICBQQDAQICAgICAgUCBAIBBQECA?=
 =?us-ascii?q?gECAgIEAQICBwQCAwEDBA4EBAICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEA?=
 =?us-ascii?q?QMBAgYCBAMKAgIDAgICBggDAwwJAgMFAgYBAQIHBAICCwEGAgcCAgECAxEBA?=
 =?us-ascii?q?wIBBAUFAwMDCQICAwIEAgIKAQEBAQICAQUFAgQHDwICAgQCAgIBAwICAQECA?=
 =?us-ascii?q?gUECRIBAQIDBgQGBQMCCBgBBgICAQECAgIDAwIGAgECCAIEAQQFAgECAgICB?=
 =?us-ascii?q?AEDBgIDAQECAQICAwMCAQQCBAMDAQECAQICAgMCAgIDAgIBEAIGBgECAgICA?=
 =?us-ascii?q?gMCAgECAQUBAgECBAIHAgQDAgECAgUCAgIDAQEGAgQLAQMCBwYBAwIHBQIDA?=
 =?us-ascii?q?QQDBAMDBQYFDAgBBQEDAQUfAwICCAIHAgEFAwUBDwMCAgMCAgEECgECAwUCB?=
 =?us-ascii?q?AIBAgEECQcCBAECDQMDCAIHBRgBAgIHBAwKAgICBQYCBAECAQMBAgIBAgMHA?=
 =?us-ascii?q?gMCBAUBBQIBAgUEAgIBAQIFAh9NmRxGgQITgksTHCm/doExBwGDVI51kS0EL?=
 =?us-ascii?q?pZekg6XAqMKhCYCBAEBAQMHBhAjEoEzCYEVcDMaI1AqAQaCNj4QAQIBAQENA?=
 =?us-ascii?q?QIBAQMBAgECCQEBAo4dDBaDUIpgPzQ7AgYLAQEDCYVGhTsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:1TpOlq2IvlCC8ONuLvbD5RF3kn2cJEfYwER7XKvMYLTBsI5bpz0Cm
 GYXCm+BMv+IM2LwL9glPIqxpB5Q6JCAnNA1T1E+3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywIbVvqYy2YLjW1PU5
 ouryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+4y5
 /lMtrywcgM4B7Dogu0gficDAxgraMWq+JefSZS+mcmazkmDfnm1hvswUwc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmeL9FLYEascLdKEHOKsduXUwl2mfAvc6aZ/GSqTOo9Rf2V/cg+gSTK6FO
 5NDOFKDajzqOCNAHlsIVakHnbqngCPYcT5HpU2s8P9fD2/7lVQtitABKuH9ftWVTMFRtlSZo
 2jc9iL4BAsbPZqR01Kt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgfVF/+rPvgz0DgBJRQL
 Esb/idopq83nKC2cjXjdyP7j1KFvT4cYN5BKvAe8giw55SP8z/MUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9GSL1GlC8/WPaBMQFEYMRTXRbElZdsrEPtKl2302fFI8yeEKgpoStQWmY/
 tyckMQpa1wuYSMj0qy6+RXKgWvpqMaWCAEy4QrTUySu6QYRiG+Zi26AtgezARVodt7xory9U
 J4sxpj2AAcmUM7lqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk3aphbJWGzP
 RSP6Wu9AaO/2lP6PcebhKrhW6wXIVTISLwJq9iPM4QQOskhHON51Hg/PB/Lt4wSrKTcufhnZ
 c3znTeEAnEdBqBqpAdatM9MuYLHMhsWnDuLLbiil0rP+ePHOBa9FOlYWHPTMbhRxP7V+G39r
 ocCX+PXmkU3eLOkPkH/r9VIRXhUdihTOHwDg4kIHgJ1ClQ2SD1J5j646ehJRrGJaIwLz7qXo
 SnjBREwJZiWrSSvFDhmo0tLMNvHNauTZ1piVcD1FVr3iXUlf6i166ITK8k+cbU9pb5syPd1S
 78OfMDZWqZDTTHO+jI8a5jhrdw6JE77217WZyf1MiIie5NARhDS/oC2cwbq8h4IBHXluMY7p
 YqmyQ6GE4EIQB5vDZqNZf/2lwGxsHERlfhcRUzNJtUPKkzg/JI7eSP0h/4zZcoLLEyblDed0
 g+XBzYepPXM89dlqomX2fjcot7wQeVkH0dcE23K1pqMNHHXrji53ItNcOeUZjSCBm75/aOVY
 +8KnfzxNfswmkkT79hxHrNt+qIJ59X1oohcwAk5Tm7AaE6mC+85L3SLgZtPu6lKyuMLsAe6Q
 BjUqNxTOLHMNcG8VVBPe0wqaeOM0fxSkT7XtKxnLEL/7S5x3byGTUQCYEXW2XIFdON4YNE/3
 OMsmM8K8Ajj2BAkBdCL03JP/GOWI31cDqgq6sMADInwhlZ5w11Oe8aHWCr/4ZXKZtcVd0d0f
 Xmbg63Ng7kazU3HKiJhGX/I1OtbpJIPpBEakwNYdgrRwoLI1q0twRlc0TUrVQAJnB9J5OR+Z
 zpwPEpvKKTSojpliaCvhYx3992t2fFYxqDw97fNvGjQTk3tW26UaWNjZqCC+0cW928adT9el
 F1dJKAJTh6yFPwdHANrMaKmlxAnZdN0/wzG3sugGqxp2rEkNCH9jPbGiXUg8nPa7ABYuKEDj
 eZv9ed0L6b8MEb8ZkH955ayjdwtdfxPGICOrTyNMk/E8aEwtQxeAQSzFn0=
IronPort-HdrOrdr: A9a23:1rK2qKk9TYGOc/Z/GUhildKtdYDpDfIP3DAbv31ZSRFFG/FwWf
 re5cjzsiWE8Ar5OUtQ+uxoXZPrfZqyz+8S3WB8B8bHYOCighrOEGgd1/qY/9SQIVydygc178
 4JGMhD4Z/LfCJHZK7BgTVQeOxQpeVvnprY+Ns2DE0AceipUcxdBstCZTpzancGODWuzKBWKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49034129"
X-MGA-submission: =?us-ascii?q?MDF3NzvL5+Yfw6RVu6Vhv1NEEW3e0EGlzvuxZs?=
 =?us-ascii?q?uJKREyVTE/ZjoYnDHrAuvJvo5miuAGxXcDqMQTZrwjYe7E3JEn30yOkv?=
 =?us-ascii?q?UoEL3bNoNsTQ+g8FHQPVePRXCkSnuF6U8QZQlFHTRzzZ1bUPPIWHQBJ/?=
 =?us-ascii?q?c/Z4XAEnaNCLXkTMbRJJSoaA=3D=3D?=
Received: from mail-ej1-f67.google.com ([209.85.218.67])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:50:45 +0200
Received: by mail-ej1-f67.google.com with SMTP id a7so25004126ejp.2;
        Wed, 17 Aug 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=bL+yzLQjDhweLq/kzdKLiw0fLjmLwNDEXtCeV16XdXg=;
        b=YSHAwS938CbzblMSPkHk6PI8RtZzaN/byhF+tjsp1Xb8GupQ/FGRwZow2Nk4d8E1+5
         2ntNnv9UFb9qUCIxxrsQrORZuFVEZ9Tb/1PWs/CZv9+5gESoO+hDYANlSJVdhx5yKCWK
         ERWbUAllDx8xhQUhQ/QVJNm1Lcvx6IPfv0XLKcVlKGWF/n3FXj4G8pAH15iS0CH4iyJ3
         UdRbkANO/5kmwxcUyJVgE/JwMtzzOgjBfWAqVnUD6KTQEk04hRlCZLv7NzAUdEcNVpxk
         AvUnIFzMfJ/+4tsWmEDZUnSpyKThu5aVzmTuzDHEa3kifP9x4Q4uZF/sDMibFzyKhV5n
         GjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=bL+yzLQjDhweLq/kzdKLiw0fLjmLwNDEXtCeV16XdXg=;
        b=veTGQ7k6EklB+nmnyJSrfMndfQcOBCvyV8pMb5w5xmgwI2bMVq72NFQN++/M+R1n1v
         zkhyS9rkNrK2QcQbPSjP4elKPH18KZZPqucGlq8J6mYw7MC9DskJEzHFQEBXUOaMncQo
         f7YBCUqe5VPKzRVQyshHig+7JFCMNikXKExe7FMoJuTFDg2DqYm2c5MdbHLV/Kw8iOX7
         lCaLLsUFeG2nrurU7KeLtlmYiBY9QcTNndmuMU/+XC8qD2+KxAvyzgGtQxcPf5b4Y479
         X1ucLScqZxAaFaU4t8g2RMls306qzubeQBciDD1taKBoO2vdci0z7Nkvr1zpnYE4Owtp
         TbmQ==
X-Gm-Message-State: ACgBeo2Omsb6+fm6K698Ff7oDSoVVsXpwabiX7gJWk4z3HadHVLuKnhF
	Vi/r+NaVQgMHs10Equ3JowQuRSZpJxKZmg==
X-Google-Smtp-Source: AA6agR7QYpLzYjSzenKmH+2ZBUyIKT/PGwC6KAin/zGkfAqcK94BIQ5KBypKb7rob4R80rb0K11M0g==
X-Received: by 2002:a17:907:868d:b0:730:f0ba:6328 with SMTP id qa13-20020a170907868d00b00730f0ba6328mr17069826ejc.444.1660747843902;
        Wed, 17 Aug 2022 07:50:43 -0700 (PDT)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:f4b2:956:5d0:dd2a])
        by smtp.gmail.com with ESMTPSA id fn3-20020a1709069d0300b0072fb3704e49sm6848977ejc.46.2022.08.17.07.50.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:50:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
Date: Wed, 17 Aug 2022 16:50:42 +0200
Cc: cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DFE05B0-AD73-42C5-87C3-F6ED651D8439@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
To: Julia Lawall <julia.lawall@inria.fr>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 515
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/4DFE05B0-AD73-42C5-87C3-F6ED651D8439%40gmail.com>



> On 17. Aug 2022, at 16:36, Julia Lawall <julia.lawall@inria.fr> wrote:
>=20
>=20
>=20
> On Wed, 17 Aug 2022, Jakob Koschel wrote:
>=20
>>=20
>>=20
>>> On 16. Aug 2022, at 23:07, Julia Lawall <Julia.Lawall@inria.fr> =
wrote:
>>>=20
>>>>>> Based on that I was wondering if there is a way to say: match if =
the expression is
>>>>>> within an expression list. So if I for instance have something =
like this:
>>>>>>=20
>>>>>> @main@
>>>>>> type T;
>>>>>> parameter list P;
>>>>>> expression list E;
>>>>>> expression E1;
>>>>>> identifier func, func_call;
>>>>>> @@
>>>>>>=20
>>>>>> T func(P@E) {
>>>>>>  ...
>>>>>>  func_call(E1 in E)
>>>>>>  ...
>>>>>> }
>>>>>>=20
>>>>>> (above is not valid syntax of course)
>>>>>>=20
>>>>>> Ideally I would like to make and get the parameters of 'func' =
that are used in any position
>>>>>> as arguments in 'func_call' if that makes sense?
>>>>=20
>>>> Do you have any idea regarding the expression lists?
>>>>=20
>>>> looking at the following code snippet:
>>>>=20
>>>> test.c:
>>>>=20
>>>>  int func1(int argc, char *argv) {
>>>>     func2(argc, argv);
>>>>=20
>>>>     func3(argc, argv);
>>>>=20
>>>>     func3(argv);
>>>>  }
>>>>=20
>>>> what works is (only matches the first func3 call):
>>>>=20
>>>>  @main4@
>>>>  expression list Es;
>>>>  @@
>>>>=20
>>>>  func2(Es)
>>>>=20
>>>>  @main5@
>>>>  expression list main4.Es;
>>>>  identifier func;
>>>>  @@
>>>>=20
>>>>    func(Es);
>>>>  + // add comment
>>>>=20
>>>>=20
>>>> what doesn't work (matching on the expression list from the =
parameter list):
>>>>=20
>>>>  @main4@
>>>>  expression list Es;
>>>>  @@
>>>>=20
>>>>  int func1(Ps@Es) {
>>>>  ...
>>>>  }
>>>>=20
>>>>  @main5@
>>>>  expression list main4.Es;
>>>=20
>>> Could you try
>>>=20
>>> expression list main4.Ps;
>>>=20
>>> It may transform the parameters into a list of expressions.
>>=20
>> I just tried:
>>=20
>> @main4@
>> parameter list Ps;
>> @@
>>=20
>> int func1(Ps) {
>> ...
>> }
>>=20
>> @main5@
>> expression list main4.Ps;
>> identifier func;
>> @@
>>=20
>>  func(Es);
>> + // add comment
>>=20
>> but that throws:
>>=20
>> meta: semantic error: incompatible inheritance declaration Ps
>>  File "test.cocci", line 45, column 24, charpos =3D 539
>>  around =3D ';',
>>  whole content =3D expression list main4.Ps;
>=20
> OK, there is a specific context in which this works, but it is only =
for
> generating semantic patch rules.
>=20
> You can do something like
>=20
> @r@
> parameter list [n] ps;
> type t;
> identifier i,f;
> @@
>=20
> f(ps,t i, ...) { ... }
>=20
> @@
> expression list[r.n] es;
> identifier r.i, r.f;
> expression e;
> @@
>=20
> (
> f(es,i,...)
> |
> f(es,
> - e
> + 0
>  ,...)
> )
>=20
> I'm not sure if that is exactly what you want to do, but perhaps it =
will
> give some ideas.

I just realized that you are no longer in the 'cc' in the email I send =
to Markus so I'm pasting
what I'm trying to do here:

Finally I would like to archive something like this:

void func(void) {

   int x =3D 0;
   int y =3D 0;

   func1(x, 0);
   func2(0, y);
}

void func1(int arg1, int arg2) {
   interesting_func(arg1);
}

void func2(int arg1, int arg2) {
   interesting_func(arg2);
}

In the end I want to, for example, turn it into:

void func(void) {

   int x =3D 0;
   // 'x' was used as first argument to interesting_func
   int y =3D 0;
   // 'y' was used as first argument to interesting_func

   func1(x, 0);
   func2(0, y);
}

void func1(int arg1, int arg2) {
   interesting_func(arg1);
}

void func2(int arg1, int arg2) {
   interesting_func(arg2);
}

Basically I want to flag create the matching from 'x'/'y' to the =
argument to interesting_func.

I was imagining if I could match the parameter list of any function =
calling 'interesting_func'
then I can also create a matching from x to that function call and do =
the rest of the correlation
in python somehow.

However I'm still failing to detect if any argument (arg1 or arg2 in =
this case) is used as
any argument in 'interesting_func'.

I hope this makes more sense?

I think I understand your example, and you are basically matching on the =
length of 'n' on the parameter list. I'm not exactly sure if that would =
work with what I'm trying to accomplish.

The more problematic case I *think* is matching the parameter list to =
the usage within that function.
In your example it is matching from a function definition to a call to =
that function.

so not matching:

f(x, y);

to=20

void f(int arg1, int arg2) { ... }

but matching the parameter to a function call within:

void f(int arg1, int arg2) {

    insteresting_func(arg1); // match arg1 here

}

Thanks,
Jakob

>=20
> julia
>=20
>>=20
>>>=20
>>> julia
>>>=20
>>>>  identifier func;
>>>>  @@
>>>>=20
>>>>    func(Es);
>>>>  + // add comment
>>>>=20
>>>>=20
>>>> Ideally I would like to 'find' all parameters used in a function =
call,
>>>> I also tried this:
>>>>=20
>>>>  @main4@
>>>>  parameter P;
>>>>  expression E;
>>>>  @@
>>>>=20
>>>>  int func1(..., P@E, ...) {
>>>>  ...
>>>>  }
>>>>=20
>>>>  @main5@
>>>>  expression main4.E;
>>>>  identifier func;
>>>>  @@
>>>>=20
>>>>    func(..., E, ...);
>>>>  + // add comment
>>>>=20
>>>>=20
>>>> But it throws: 'rule starting on line 41 contains unattached =
metavariables: main4.E'.
>>>>=20
>>>> Any idea, why e.g. the second one doesn't work? If I print it with =
python the expression list
>>>> looks the same as for the first one.
>>>> Also in the end this boils down to: is it possible to match to any =
of the expression list elements?
>>>>=20
>>>> Thanks,
>>>> Jakob
>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> Any help is very much appreciated!
>>>>>>=20
>>>>>> Thanks,
>>>>>> Jakob

