Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AA8C28B2B
	for <cocci@archiver.kernel.org>; Tue, 16 Aug 2022 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=YyGHPGnxYf9ps/EEAU68BKgHrSFQBgm91Who/+96JKo=;
  b=OKVqXrBL2+57R+EHxCvaVtE011tBnEv2GQ4kKxA/9A7ckXXM38+4cWJC
   9F3boDePQh6KM3TKcxfENDA9FvBO0UaheeIUPfrsY33rPbTNzbxIya5nS
   ce7zwiHK/VezbArPXpUIkR7w/hGoir5CslbEx71wR98HQScxxy98uLPL/
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
X-IronPort-AV: E=Sophos;i="5.93,241,1654552800"; 
   d="scan'208";a="48918384"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2022 16:26:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D1A5E4374; Tue, 16 Aug 2022 16:26:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 728DDE0381
	for <cocci@sympa.inria.fr>; Tue, 16 Aug 2022 14:35:37 +0200 (CEST)
IronPort-SDR: /jXG5+iYn6CWse1rMHz4kHk4zPhiousOYlHv6gOjZ4/UEAFUFNmpm4nWwQvpSyYX5bqD9VGeFL
 5re594PZLOh91BzEhSEgCdvsNHNHhysVa+VKXUHJaOTUA+4H1QCpKXc/i7VYUuzXUK4YEugEP1
 iloDAQc0LrVTf2tgE+ZUcgp0ZPExgCZV8KdRxAZtpjkYqrJk337H8z5a4l0b/NNIje8UXCYEi+
 yWOtRy3K7AWRfOhKSe9qRLWc/zSELkfZN+3ovUy8+insM6DZpwQ7F+QhkdXvRIeyE3QXNgNy2m
 a1sL84R3IJPoqpR+o0EiPpUb
X-IPAS-Result: =?us-ascii?q?A0D1AAB1jvtiXUHaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYFRUgcqcTYuBFCVXYQlhwwDgQaSPgsBAwELAQFAAgQBAYUHAoR5A?=
 =?us-ascii?q?h0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEGHAsJBxIGD?=
 =?us-ascii?q?w4FYAFhAwFEgU+BdAsDMQ2CNSkBg2MBAQEBAgESKAYBGx0BAwELBgULAQwuI?=
 =?us-ascii?q?xEBBQEIFAYTIoJbgm0BAw0lAwGbMoEEQoo4eIEXBReBAYIJBoJhgW4KGSgNZ?=
 =?us-ascii?q?wNbfgIHCQEIgSsBhk2ERoQzJ4EZgRCBPByCZz6ERBWDeIIuBJkEBAUUDwMDA?=
 =?us-ascii?q?iEDCQQHBSweAgkDIxEDCxARBw4BFgEECAEEAwEBAQ4CBQcCBgMDAgICAgUBA?=
 =?us-ascii?q?goCAQIEAwYGAgMQAQIEAQoEAgMIAgcDAgYECgQCBwICBAUDDQEDBQIDAQEDA?=
 =?us-ascii?q?wIEAQIBAQMIAQMCAwMCAgICBQIDAgICCQMEAQcDAgMBBAMBAgoEBAMEAgIHA?=
 =?us-ascii?q?gcCBAcCAQIGAwUGAgIBBwEBBAoEAwMDAwIFAgIDAgYSBgYCBAEDBAIKAgILA?=
 =?us-ascii?q?gcBAQIBAQEBAgMCBwULAQEBAwIDBgUCAQEDCAYCAQQBBQMBBAUDBwIBBQYCC?=
 =?us-ascii?q?QMDCQMBAQUBAwQDAwMCBwMBAgwECAMDAgMEAgICAgEDAgcFCAQCCQICAgECA?=
 =?us-ascii?q?gIEAgEDGgECAwUCAgkLAQQCAgMBAwEBAggECQQCAwQCAQEDAgECAgEFAg4GA?=
 =?us-ascii?q?QEBAQIDAwECAwEGBwIIAg4OCgEDAwMCAgUCAgECAwICDAEBBAIBAgECBgEDA?=
 =?us-ascii?q?QICAwEDAQICAwIGCQIEAQUDAwICAwEBBQ8FAgQCAQIGBQIBAQEEAQMEBAYCA?=
 =?us-ascii?q?gEDAwIOAgQBBAECAQEjAwQCAwEDFwECAQIDAwMEBgcFAgECEwECAQEBBQECA?=
 =?us-ascii?q?QEDBAQHCQMCAgQDAwUBAQIDAgEBAQcMAgICEwITAwEGAQ4FFAMCBAICAQICC?=
 =?us-ascii?q?gMBAgIBAwIJAgECAQUgAwEBDyQBAQICAgIDBAcCAQQGAw0CAgEBAQUGDQMCA?=
 =?us-ascii?q?wgBDAIHAwIBAwUBAgICBAECBAoJAQICAQIEBQcCAQgEBQ0FCQsBAQIBAwcEA?=
 =?us-ascii?q?xECBQMFBQMDAgEGBAUCAwECAQEDBAEDBAYBAQIDAgIBBgICAQEDAwQDAQIGA?=
 =?us-ascii?q?gIHAgMCAQQCAwMBAQEEAgICAgIDAwgDAggHBQEGAQIBBAMCAgECBwEEAQgCA?=
 =?us-ascii?q?QMDBQMEAQoDDwMFAwEDAwIUCgUBBQgGCQIEBQIFAwIEAgMDAgIIAwIEAwILA?=
 =?us-ascii?q?wIGBAIHEwcCAwICBQICAgICBQQDAQICAgICAgUCBAIBBQECAgECAgIEAQICB?=
 =?us-ascii?q?wQCAwEDBA4EBAICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEAQMBAgYCBAMKA?=
 =?us-ascii?q?gIDAgICBggDAwwJAgMFAgYBAQIHBAICCwEGAgcCAgECAxEBAwIBBAUFAwMDC?=
 =?us-ascii?q?QICAwIEAgIKAQEBAQICAQUFAgQHDwICAgQCAgIBAwICAQECAgUECRIBAQIDB?=
 =?us-ascii?q?gQGBQMCCBgBBgICAQECAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECA?=
 =?us-ascii?q?QICAwMCAQQCBAMDAQECAQICAgMCAgIDAgIBEAIGBgECAgICAgMCAgECAQUBA?=
 =?us-ascii?q?gECBAIHAgIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEAwQDAwUGB?=
 =?us-ascii?q?QwIAQUBAwEFHwMCAggCBwIBBQMFAQ8DAgIDAgIBBAoBAgMFAgQCAQIBBAkHA?=
 =?us-ascii?q?gQBAg0DAwgCBwUYAQICBwQMCgICAgUGAgQBAgEDAQIDAQIDBwICAwIEBQEEF?=
 =?us-ascii?q?02ZS4MfQS8pwSQHAYNUoCEELpZdkg6XAqMJAYQmAgQBAQEDBwYQIxKBQoF/M?=
 =?us-ascii?q?xojUCoBBoI2PhABAgEBAQ0BAgEBAwECAQIJAQECjh2DcopgPzQ7AgYLAQEDC?=
 =?us-ascii?q?YVGhUEBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:0bLSW6yegxqaj3lmJg56t+f6wCrEfRIJ4+MujC+fZmUNrF6WrkVSz
 jAZCz2OMv2IMzGkeot0Ot++oEwO6JXUytIyHQJt+VhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrVRbrJA24DjWVvd4
 I2q+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPh19
 NZXspyQEjwbL5/mvLk+Tj1pNHlhaPguFL/veRBTsOSWxkzCNnbumrBgUhxwMoof9eJ6R2pJ8
 JT0KhhXNkHF17/wmuvrDLcx7iggBJGD0Ic3uHJknWuBS/knXbjMRqzL4ZlT2zJYasVmQaaPP
 5FFMWAHgBLoW1pXOk1JVLcCu+703knNYixDjGyOqv9ii4TU5FUpjOKF3MDuUtiDWsxRmm6Kp
 2fM5W2/AxcANdXZxyDt2nmrjeTOtTjqXZobUry+7P9jxlOJrlH/EzUTXFq/5PS70wuwBY8ZJ
 EsT9S4j66M18SRHU+URQTW8nH2euR48AOFiAt8QzFyu147lxF6GUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjFFzYSLNnltzhWPiURX5PVPudgdfElRYu4iLTJUby0OQHow6QcZZm/WsQWmoq
 w1muhTSkFn6sCLm/6Cy/FSCjjD145aXE0g64QLYWm/j5QR8DGJEW2BKwQaLhRqjBNzBJrVkg
 JTis5XOhAzpJczS/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43bJ5ZKW+zO
 xKI6Vo5CHpv0J2CPf8fj2WZW5RC8EQcPYmNug38NYcQPMAgJGdrAgk3NBfJhQgBb3TAYYlmY
 cvBGSpdJXkdDqtjwVKLqxQ1gNcWKtQF7TqLHfjTlkz5uZLHPSL9YepbbTOmM79hhIvZ8V292
 4sOaqOilkQPOMWgOHW/2dBIdjgicyNrba0aXuQSKYZv1CI4SDF9YxIQqJt6E7FYc1N9zb2Vo
 y/jCx4JmDISRxTvcG23V5yqU5u3Nb4XkJ7xFXVE0Y+A1ydxbICxwr0YcpdrL7Ar+PYyn/FxR
 vgBPc6HB60XGDjA/j0ca7j7rZBjJEz731LQY3L9bWhtZYNkSizI5sTgIVni+SwIOSy96pkzr
 rim4QXETMdRXA9lFsvXNKmiwgrp73gQke5/RWXSJdxXdBm++YRmMX2jgfo+IsVKIhLGn2PI2
 wGTCBYehO/Mv45lqImT1f7Y99+kSrIsEFBbEm/X6aeNGRPbpmfzk5VdVOuofCzGUDym9ainY
 9JTxa6uPfACmmFMrNMgQbtmyKQJ5+zvqaVf+QJqESiZdF+sEL5hfiCL0MQT5K1AwrhV5Vm/V
 k6VoIIIPLyIPIboEgdUKlR4KOuE0v4Ql3/Z6vFseBf24yp+/bymV0ROPknT1HYMcuMtaI51k
 /08vMM26hCkjkZ4ONixiC0JpX+HKWYNUvl6u5xGUpXnjBEnlgNLbZDGUHSk5ZiOb5BBMBBvL
 GHJwqXFgLtYywzJdH9qTSrB2u9UhJIvvhFWzQ9dew7YxIKd3vJnjgdM9TkXTxhOykkV2exEP
 GU2ZVZ+Ir+D/ms1icVON4x299qt2PFEFo3NJ1o1eKnxSkCpUinALjR4N7jQuk8e9G1Yc35Q+
 7TwJKMJl9r1VJmZ48fwcRcNRz/foRhZ+QjLmcThFMOAd3X/SSSwmbegPALktDO+af7cRyT7S
 S1C8+N5aKm9PikVy0H+5092ypxIIC25yKd+rT2NMU/H8awwuN1/5NRWF32MRw==
IronPort-HdrOrdr: A9a23:MGRJ1q/iXNB5gM7Pvvluk+D7I+orL9Y04lQ7vn2ZhyYlC/Bw8P
 re5MjztCWE6wr5PUtLpTnuAtjnfZqxz+8Q3WBVB8bEYOCZghrSEGgS1/qB/9SIIUSXnY5gPO
 VbAtJD4bXLbGSS5vyKhTVQfexQveVvM5rFuQ4d9RpQpM1RBJ2Ilz0Jdjpz23cZeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,241,1654552800"; 
   d="scan'208";a="48903402"
X-MGA-submission: =?us-ascii?q?MDHNBpGt5ZgHR50xKwAjtS/mw77yFc8Ul7ZJkS?=
 =?us-ascii?q?G5+ftaWtYEo/dtbYS/3tFdFUjK66jfrs9dPB7ew+n6arOusdxqIz4+VE?=
 =?us-ascii?q?DqmGt4+YFoxv5xQY68y5EBRc6+H+U4L677PTs0FuMt01Pbl1tlIo8rdB?=
 =?us-ascii?q?M4qUWSQpXrhAG3C8GFJmwz7A=3D=3D?=
Received: from mail-ej1-f65.google.com ([209.85.218.65])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 14:35:37 +0200
Received: by mail-ej1-f65.google.com with SMTP id y13so18574116ejp.13;
        Tue, 16 Aug 2022 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=YyGHPGnxYf9ps/EEAU68BKgHrSFQBgm91Who/+96JKo=;
        b=abPfluazR4IubEu2Ve2X6oat1mwDaYGXafaZl6BEmQrCrttnIbZq/0c4iJYwi84QCX
         X+IkRrr+mssHQ1p4uWbgbukAvFLZ3AoVS3WvSCKMaejqK+cMGrIXlT8KRIbC9/ZWWccq
         Z6CQJ4Oako6Uck3BP1IcVgFjtq9yeYIaAACr9vKSqP+SkCQ/0zJa08sy5EGy9/BzlfhU
         uiE/3wTeGnVI60IdROX71Hn+JTCO980xOqHZkT31gE48S35Ec1Bl18T8moN2IHKqrCqN
         Kj08KpbIp4bPR15ouJo9o/F0o0Qky3LAv+0QSHH52eeHyFWwyiAC/24DwPaMcVpjL3XH
         2wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=YyGHPGnxYf9ps/EEAU68BKgHrSFQBgm91Who/+96JKo=;
        b=q9sGy7qT+AFEUWYJjq06TpZ6RP3rp2Vcr+wfqBrnQcS+2EnYetQUZNQeVUgbu2cmnf
         l9Y3IZ0u6MYJEpeJgTxTlxUnuh0dCe0hBhs1MVZyu3RvPWPD7/5g7IR1dDv3aN3wXvyP
         TYlIRj/qd24YTNQ9ed9tO9ThrCcAS5zetvqyug8LgpxKxQoseBCa+kVWPnxaqabNLSGT
         H2Z7hZlWDatywXeiXQc4amXpLWYekNSZe1RSpddJ1DyMYs0cTEXOqBIBeDQr34pL6xR6
         X+U+0THl4j/6z5Q8EVFv/ZtnWAYLw90zvYJVwxWdU8LVzhDfJxSvgHC7sHXr24jEsnIg
         Y/uw==
X-Gm-Message-State: ACgBeo15za1YPLgrNBLLrTToQJfA/aYjZamEzNZsU6WrftQQ3UmmTElL
	wc+vW7f8EMxjJmTCRYUsr7wcH+StB2jIGLwR
X-Google-Smtp-Source: AA6agR7G1XtfFDIg73Jj/dUkankQ52e3nnjV/QgEOBtZDTNu/1Xwrf6X+eOeFjpUrDEd1/pIC/5wYQ==
X-Received: by 2002:a17:907:9816:b0:730:73fc:1fae with SMTP id ji22-20020a170907981600b0073073fc1faemr13160682ejc.310.1660653336314;
        Tue, 16 Aug 2022 05:35:36 -0700 (PDT)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:f4b2:956:5d0:dd2a])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402115000b0043b986751a7sm8398335edw.41.2022.08.16.05.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2022 05:35:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
Date: Tue, 16 Aug 2022 14:35:34 +0200
Cc: cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
To: Julia Lawall <Julia.Lawall@inria.fr>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 508
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A%40gmail.com>



> On 16. Aug 2022, at 13:37, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>=20
>=20
>=20
> On Tue, 16 Aug 2022, Jakob Koschel wrote:
>=20
>> Hi,
>>=20
>> sorry if this question is not suiting here.
>>=20
>> I went through the documentation and most of the examples I could =
find, but wasn't
>> able to easily answer my question I'm wondering about.
>>=20
>> Basically: is there a way to match to *any* argument? E.g. make =
something match both of
>> the 'x' uses in the function calls here:
>>=20
>> int x =3D 5;
>>=20
>> function_call1(x, 12, 12);
>>=20
>> function_call2(0, x);
>=20
> f(...,x,...)
>=20
> or
>=20
> f(...,<+...x...+>,...)
>=20
> In the second case, x would be a subexpression of the considered =
argument.
>=20
> julia
>=20

Thanks! I really thought I tried that earlier but now it works.

>=20
>>=20
>>=20
>>=20
>> Based on that I was wondering if there is a way to say: match if the =
expression is
>> within an expression list. So if I for instance have something like =
this:
>>=20
>>  @main@
>>  type T;
>>  parameter list P;
>>  expression list E;
>>  expression E1;
>>  identifier func, func_call;
>>  @@
>>=20
>>  T func(P@E) {
>>    ...
>>    func_call(E1 in E)
>>    ...
>>  }
>>=20
>> (above is not valid syntax of course)
>>=20
>> Ideally I would like to make and get the parameters of 'func' that =
are used in any position
>> as arguments in 'func_call' if that makes sense?

Do you have any idea regarding the expression lists?

looking at the following code snippet:

test.c:

   int func1(int argc, char *argv) {
      func2(argc, argv);

      func3(argc, argv);

      func3(argv);
   }

what works is (only matches the first func3 call):

   @main4@
   expression list Es;
   @@

   func2(Es)

   @main5@
   expression list main4.Es;
   identifier func;
   @@

     func(Es);
   + // add comment


what doesn't work (matching on the expression list from the parameter =
list):

   @main4@
   expression list Es;
   @@

   int func1(Ps@Es) {
   ...
   }

   @main5@
   expression list main4.Es;
   identifier func;
   @@

     func(Es);
   + // add comment


Ideally I would like to 'find' all parameters used in a function call,
I also tried this:

   @main4@
   parameter P;
   expression E;
   @@

   int func1(..., P@E, ...) {
   ...
   }

   @main5@
   expression main4.E;
   identifier func;
   @@

     func(..., E, ...);
   + // add comment


But it throws: 'rule starting on line 41 contains unattached =
metavariables: main4.E'.

Any idea, why e.g. the second one doesn't work? If I print it with =
python the expression list
looks the same as for the first one.
Also in the end this boils down to: is it possible to match to any of =
the expression list elements?

Thanks,
Jakob

>>=20
>>=20
>> Any help is very much appreciated!
>>=20
>> Thanks,
>> Jakob

