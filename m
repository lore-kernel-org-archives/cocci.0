Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979EACD37B6
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VQtQW0cVx7Rq+w5O7lFIhuh+h3JdXYKLWhx8rvqDl1Y=;
  b=DlFu/ZYLs0fE9qCcX0p7j5pZuueMTqbgjaOFhsK3szPAk5wrmyPI5T03
   k7PYtqjUh6BVc12nlRg32GupzmBLlJsAKSXlGLhmojAtcyrwxqpVRjBCz
   hcFH6hoLQ6+Slq3LiRqf0aD98uMPuJ9jCI3Txd6b4VEx/oTHBaakb8l79
   A=;
X-CSE-ConnectionGUID: t2gDrMQQSjKACouN9d4Aow==
X-CSE-MsgGUID: RhWB0mRQRiuSkY2fWvx7qQ==
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
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276029548"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 14:55:29 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 14DAB805CA; Sun, 10 May 2026 14:55:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 15BE08029F
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 14:55:25 +0200 (CEST)
X-CSE-ConnectionGUID: namxz7NWRveTT45LBe8dpQ==
X-CSE-MsgGUID: OpY5WZr6SMqLJ86QWywq+w==
IronPort-SDR: 6a00803c_1jsZBkmSz0PSYlnPm6XG586EbXoiXVRWHKrtA0aXZWLncMe
 4VrY8CHzGSIFv1fWZr/VtolerC/SXmRcbqfxOeA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FDAgAIeQBqgwsR49RaglmCQYFmNAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYh5g1ICDwEDAQ1OAQIEAQEBAgSCC4JqCgKNMwIeBwEEMwYOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAToHDjuGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAhgOAgJWBgEUAQGCf?=
 =?us-ascii?q?oIjAQYQAQMPJwe1CIEygQGCDAEBBtpmHywiWoFnCYEfLoVygmcBhjGEQCcPg?=
 =?us-ascii?q?VVEgTyCUjE+iB6CaYImgQ6FL4lTUngcA1ksAVUTFwsHBYEjQwMqLy0jSwUtH?=
 =?us-ascii?q?YEjIR0XFR9YGwcFEiEqbktkLFwaAwMNITVZdQoBSQWBdAKCHhlfIy8DToEFA?=
 =?us-ascii?q?gELbT03CQsbBD2LPB0PmTuzKTQHgjiBZ4FkDJ9tBhMvg3EBk2AOkwsemGgiq?=
 =?us-ascii?q?R+BfiSBXDMaJIM2UAMZD446hBzDUkUyPQIHAgcNAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:DXNRtqIvR4R3Rj65FE+R7ZElxSXFcZb7ZxGr2PjKsXjdYENS02dVn
 2YeUGHTOf2CNjCge9tya9+2oRwP65PQn4VkGgJorCE8RH9jl5b5CIXCJC8cHQvCd5yZFBoPA
 +Y2M4SbcphsFhcwgj/3b9ANeFEljfngqoLUUbCCYmYtA1c9Fk/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSss9JOGjt8B5mr9lU155wehBtC5gZgPa0S5AeH/5UoJMt3yZ+ZfyOQrrZ8RbbSq
 9brlNmR4m7f9hExPdKp+p6TWlEKWLPbIT+VgXNQXaW46jAazsDl+vtT2FI0MC+7uh3R9zxD4
 IwlWa+YEG/FCpbxdNE1D3G0JQkuZPwcoOevzU+X6qR/x2WeG5flLm4H4EseZeX08c4uaY1CG
 GBxxJngoXlvisrvqI9XRNWAiewlJcz7Ltw5hUt+wA3lUasCa52TT73zsIowMDcY3qiiHN7bY
 NcFLyViZlLMbnWjOH9NUch4xr33wCCgNWQBwL6WjfJfD2z76QVr06X2dvfRdMaLQ8p9gUuS4
 G7Ll4j8KktFaoTFmGferRpAgMfohRKmZ7AISoad79pI0AOq+X0MEV4JAA7TTf6R0RLuA4kPd
 CT44BEGqaEt/UivZsv8WheiqTiFuAQdUpxeCYUS4waGwav8+BecHmFCTzhbadVgutVeeNAx/
 lqOgs+vGjFl9rGYIZ6AyluKhTW7PDgHckk9XzEJcTdZvv3JrdE/liuaG76PD5WJYsvJ9SbY7
 x3ikcTTr7AUkNJNyKixu1zK695NmnQrZl9rjuk0djj8hu+cWGJDT9LwgbQ8xagYRLt1tnHb4
 BA5dzG2tYji961haxBhsM1WQOHxvKbaWNEtqV9oGZ46vy+gk0OekXRryGgmfi9Ba55aERewO
 RO7kV0Jufd7YiH2BYcpOdzZI5pxl8DIS4+6Ps04m/IVO/CdgifcpXk2PSZ9HgnFzCARrE3IE
 cfHK5r8XS9FV8yKDlOeHo8g7FPi/QhmrUu7eHwx503PPWO2PSbPF+U2IxGVY/on7aiJhgzQ/
 pwNf4GJ0hhTGqm2KCXe7YdZfxhAIGkZFKLGjZVdVteCBQ56R0AnKfvamo06d6Jfwq96q+bv/
 1OGYHF+9mbRv3P9FFi1WihRU4+3BZdbhlAnDBMoJmetiiQCY57wzaIxdKkXXLgA9c5F/M5WV
 fU1Xti6PeRKQTHD5gZFR8LPk61/RjuWhCalHSmsUB4gdbFOGi3L/d7FeFP01S8sVyCYi+o3k
 4eC5Cj6H6URYhtEN9nHTs6vw3ean2kvqMgrU2TmetBsKVjRqq50ICnPv9oLCsArKySb4ACF1
 gyTUCwqlcOUr6AbqND21L259aG3GO5DH21fLWnRzZCyEQL4pmOD44txYNykTADndlHf2fudP
 L1O7vTGLvc4sk5AsNN8H5ZV3KsO3YbTiIEA/Dt0PkfgTgqNMaxhEEmkzMMUl6xqx51lgyWUd
 H+L2OFnPeSuBJu4Pn8XfBEof8aS58EywzPy18k4EG/+xS1w/YeEb3lsAgmxuHRdAYZxYawYw
 rYHmc8J6gaApAIgHfSYgwt1qWmdDHwyfJ82l5MdAbPUpBsikW9QRZ/iER3wwomFbtllPhMUI
 xuRvq7jhqtd9GXGYXEcBXjA5ssDpJdXuBtP0AYJNn6nkPX3l/YIgRtw92wsbwJ3lx9o7cN6C
 lJJBWZUe5qc2ihOv9dSeVysFyVqJgyrymaox3QnzGTmHlSVDErTJ2gDCMOx1UE+8VMEWANE/
 budmV3XYRyzcO7fhiINCFNY8dr9RtlM9yrHqsCtP+KBO7IYOTPFoKufVVAkmivdI/EapRP4/
 LFx3eNKd6fEGzYaoPQ7B6mkxL0gck24C1IYc85x3pEiPD/6Qy6z6wisOkrqW8JqJt72y2GaJ
 fFqBPpyU0WZ6H7TgBEdXbUBMp1lrs4PvdAiQI7mFUQCkrmYrwdqjq7uyzjDtDcrbelDwccZA
 aHNRg2GCV2V1Cd1mXeSjcxqOViYQNgjZS/g1ruLqMEPG5YysbxvQ3oTyZqxhW2eayF8ziKXv
 STCRq7Y9PNjwoJShLnREr1PKgG3CNHrXsGa2VqXn/FRS+jQIOHytw8xgXv2DTR8ZLc+dYx+q
 uWQjYTRwkjAgocTb0nYvJuwT49y+sS4WbtsAPLddXV1s3OLZ57x3kEl5Wu9FJ1uleFd7OmBQ
 y+TSpO5VfwRaudn6ExlUQpsODdDNP2vdYblnz23kNqUABtE0QDnEsKuxUW0UU5lLB03K7/MI
 S6qnc2x5+JojpVGXz4FIPBEP6VWAnHeXYkeStmgkgXAU0eJhAqOtIK3wFBkoXvOB2KfGcn33
 YPdS1KsPF6usaXP15dCv5Y0ohQTC21njPItel4GveR7kC2+EHVMONF13U/q0X2IuneaOFDEi
 DDxgK8KDCLgQXJbfB+67NmLssJzwAAREo+RG9Dr1xr8h+SK6EeoH7ZrsCtti5uzUiW21/mpc
 Lny5VWpViVcAfhVqSI7+fGxx+tqrh8fKrTk5mil+/HP790i7XnmGZCv8MehlcAKLi0VqHj2G
 A==
IronPort-HdrOrdr: A9a23:S+1cU6lmUMxsof1WdCeiqZN8PRvpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:F5drs266uHpu59YdxNss8kcRCtJ6VELn0nrsHxPlLUxkGLGNcArF
X-Talos-MUID: 9a23:cc0HGgpIuIeOBoMCJdAezxZ6BZpX0b7wM2UUtbdW5fC7JDNpeCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276029537"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGMD8LLLonKacWAfNP2eNl2j91wbxADbn/5o3?=
 =?us-ascii?q?ExBIH780AHLdRA0S1pDzodtbfK9rRFj23Wt53fwpXLmGjHLUxxvXfDIq?=
 =?us-ascii?q?fj3YOGxMTkI1d1D68WuxhTPKJwQu4BQUMlYfWcbrL7R0CZ8VM7ITkGfX?=
 =?us-ascii?q?mDSWsf2jF2tFDdi0rzS9b+tw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 14:55:23 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1whaiK3k2o-00TXwc; Sun, 10
 May 2026 14:55:22 +0200
Message-ID: <80eb8b28-fe71-4d21-b154-646d425fea46@web.de>
Date: Sun, 10 May 2026 14:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
 <569a2fa4-d655-4c26-836d-a86aedf4e0b9@web.de>
 <6614c14-3844-9774-24c3-e891ad57e9a@inria.fr>
 <f3e6a976-2ab6-428c-ac42-ccd2281774aa@web.de>
 <44e0e8aa-f4f5-be2c-3956-a15d1989eec6@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <44e0e8aa-f4f5-be2c-3956-a15d1989eec6@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I6uNVxhtrvS7dimX9Kv7zKXiAbGW/nEiTfGRLeFDRMqKy9CQEet
 TbHs8EJwUiv9tce08sw4bhfSqOVPsOv+eRl1J9O2UJpD8SBowWisd6HRR1yA/NDC152DtRu
 oN8gtQAeSculSV7nzINt5w/7TYYaBaOrh1ZzQZ65LWxG0JGVum1p4Y/4k1jyJDtTUpOMz7h
 r+6sQgmKDYrRN7VTSd3gA==
UI-OutboundReport: notjunk:1;M01:P0:dmQ4MytXUVc=;6mxdnOTybuVT97GcneSmJYWJvW9
 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
 wQ
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3497
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/prbg4yLPj8rflZ1WHppu4w>

>> Are there any agreements needed for involved technical details
>> before a better software documentation can be attempted?
>=20
> No.

Will development views evolve further accordingly?

How many contributors can achieve more desirable adjustments
also for the affected documentation?

Regards,
Markus
