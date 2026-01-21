Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959EECA5FD7
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dqG/njBSbx6/mYcdlZB0Q8EJUwxERKv5EAFqC4veqpI=;
  b=ZaPpOhjT1CAq8R8SdsbIEAflpSb98i2xfgs3359J9W3BrjDIYjkJoW50
   Vulxbmc83d3fKUElevnGGawT1JhDHQEij8eaehrB5DtRxT1di0X7DSgd6
   xUuYx4mXZnJQxW948/8PHU4aVPwjjlshye8bmMvbhLcVrQe0fvlNJL33l
   4=;
X-CSE-ConnectionGUID: ij+VO4NPT4qNp5sCJIfAvw==
X-CSE-MsgGUID: xoYz5Pp0S++7P6GoZdZgYA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259675793"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 15:45:26 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F005F819F5; Wed, 21 Jan 2026 15:45:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E2C28819F0
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 15:45:22 +0100 (CET)
X-CSE-ConnectionGUID: K8FUdEp+Q6mvW7NIUEfvXQ==
X-CSE-MsgGUID: MMDz6fRSRciRvfmmlODeFQ==
IronPort-SDR: 6970e682_Qvafwt/cTdaObQkmTY8sUCtUaUOK7IjOYUSlbryxjdL48+d
 C1/m6rZaV434Wk8Unc4VT1jf/6Ncgt1WAnz3T7g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HuAABA5XBpgAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8EAQELAYJAaCVZMwQLSYRYj1OCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IIMgnQCjQICHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjB?=
 =?us-ascii?q?BkBAREmAQQLCxoCJgICVgYBFAEBgn6CIwEGEAEDDycHsHh/M4EBggwBAQbaZ?=
 =?us-ascii?q?B8sIlmBZwkUgQsuAYVtgmUBhiqEPScPgVVEgTyCUjE+hEODW4JpgiaBDpQHU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEjQwMqLy0jDzwFLR2BIyEdFxMfWBsHBRMjUwYbBhwSA?=
 =?us-ascii?q?gMBAgI6UwyBdQICBIIQe4IBD4cFgQAFLm8aDiICQWsCAQttPTcJCxsEPY92R?=
 =?us-ascii?q?YEygguCc5MJsyk0B4I4gWeBZAyfbQYTL5dSDgaTBR6YaCKpH4F+JIFcMxokg?=
 =?us-ascii?q?zZPAxkPjiE+g3XHE0I1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23:RgwsvBJxeOc3bTD+etmcuNxsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEubM11BSQAd6GsLptsKn/jePJYSQ4+5GPsXQPItRndiQuroE7uTJlK+O+TXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL19I
 RmssQndqsYajZZtJ6s/yhbErGZDdvhLy29vOV+ckBHw69uq8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQwSX6HQTS2kbjBVGDRXd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54
 Kh1ThLjlToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+dlc6jDYd0VW3ZOXsdJVyxAHIy8a
 ZcPD/EcNupctoXxukcCoQe7CQSqGejhyCJHhmXu0KM53eouHg/J0hEgEdwQvnTZstf6O7sdX
 +2u0KnI1C/OY+9K1Tvj6oXFdA0qr/GWXbJ3dMrc0U4hGBnfjlWTtIzlJC6e2OsJs2iV9epgV
 OSvi2E6oAx2pTag3N0siorUhoIO0FzK+iF5wIgvJd25Tk57bsWpEZVOuC6BLYd5X90tTnhut
 S0nxbIIpYS1czIWyJQ72RHfcfqHfpCG7B/hV+ucJTd1iXBrdr+9hRu8/kytx+LiW8SpzFpHr
 SRLnNnQu30D0xHd5caJR/l980mu1ziC1Bzf5O5EL002k6fQNp0vwqYom5YNrEjPADX6lFvog
 KKUbEko5+il5/7pb7n+opKROJV4hw/jPqg0nsGzH/40PhYQU2Wa/+m3yaft8lfjQLpQi/07i
 qnZv47eJcQcvqO5BghV0ps/6xqlATapzs8XkWMaI11bYB6Hjo7pNE/SIP3gE/uznkqgnC11y
 /zYPLDtGIjBI3jZnLrvZbp97lRTyAs3zdBR/ZJUDbQBLer0VEDrrtzYDQI5Mxeuz+joDNV92
 JkeWWOJAq+WK67Tv0GH6fk1L+aReoAZoCz9JOQ95/7ykX85nkcQcrWu3ZQLdH+4H+9rI16ZY
 HrpmtcOC30Gvgs4TOzwiV2NSyRfZ3ioX64k/DE0FJqmDZvfRoCqmLGB2D20H5NMaWBCDlCBC
 nbpd4SBW/gXciKdONVtkj0CVbi7So8uzwuitAHgy7Z/KOrb4TUXtYj/29ht++3TiRYy+CRqA
 8iF3GGCUWZ0kGASSTIu0q5xrlRxyk2d3qhmgPJWD8Re5/ZOUgcnKZ7Q1eJ7BM7pVQ7bY9iGV
 k6qTcilATEwS9I828cAbUlzFNu8kh7OwyykD6cImLyOHpM06L7T0mDpKchk03jI27Etj0I+Q
 stBLWConLJy+RXOCYLRiEWZj6iqerwc3CHT8GeDynKDsllBXgBoXquWFUwYM2nLqdXwrmfLU
 LaqDfxzMBZFyMfELqJVY9ntpVRAXvbqftrENSb5kGC7Dhegx7WWbYOsdX9O8j/aDR0hmhoQ4
 G3OGAwwHCanrCqKKTV0Fk/0JW7o//N/rnyTUUI+iQ2HOR4yn4Gp8wIY0KTPA8gY2agJ7WJ48
 20c9DeV2tvXD4DFvA99ZOBGZth75l5b1GXfvgg7P5q6LqkkiERNOx9vsRbI0BN6Qp5FjdBst
 GkjmS97M6GFyxVscz2C3Jb/EqLaIC/+8UPncLbYj2nXy83e4aIT8LI9olTnshuuEx8H+m9kz
 sIT/n+S/JTMAyINXJi3XktkvwNiqeT8ZS8wr5jRyWUqMaSwtWra3Mk1AeI+1hu6V9JYLb/CC
 wL4VcEXbyS3AMotnVXhLhcNPeQIsbUxI9vjbfyNnqiiIOdnmjuiy2VB+oF0lEyWpWJ6TabT0
 pAJzuv9vEPPXirgjFqnrsH8mJxVLTAUEG2lzCH4BYlXLqRsdIcPAG2qLoW53NJ7z5LqXndZ8
 hakCTZkkIeMcACRcke78Alez0URrlS4lCH+wzE12zAlo6yD3TDflvz4fUlPMWpKSW9+yFb0d
 NLt1ZZABhfuNlVvz0jAhw6y3aVQqaVhInOGRE5Je3KzNGR+Su6qsbHEZcdT6ZQuuCERUeKmY
 FncRKSuxnlSmy7lAWZawyg2Mj+wvZCs1TlzkmGANzBeqHTDeMd/7QjS7prQSLQCu1hODDk9k
 jTRClWmapOM9M+XioyFn+SwTWOnWbVMfCOtwY7K507ZrSV6RBa4mf60gNjuFwM3hDT629ddX
 iLNtB/gY4Pv2sxWKMpfd1JzTB/54st+QMRll5cowYsX0j4cj4mU+nwOlSHyN89a0OTwdihFS
 TkOyt/TqA/rvS8rZleA3YHkTTOwxsV7Zt+1Snwb0GQx4ohGBbyV47pNgSZu6gDh90SLO6c7x
 2pbkrMn8zYCjvsMuRYxwyn4YPhaBkReMSH21lyJ4924sKRLdTOqeLm02lB5mIPpB7WDrwdAH
 XfhL817R2kqtJo5aQ+Kiy6WiMmsYtTbYNMNuwfBlh7Bi7IQM5ctjr8QgiEhP2vhvHojwup9j
 Bp03Jj8spLUTgcltK+/HBNcMSX4Is0J/TS4x4NXhMWLxMaCGpt7GzMEdITlR7SkHXhB0Javf
 xbLCzA6pnqBTPD6FBWc9VwggnbBCZGtOFmIKXNfwdgoF3z/bARPxQsTWjs9hJswEAunkdfgf
 ElO7TcU/lfkqxFIx7EgJ1zlX2zYvgvtdiYsRc3VMk9N9g8brRSwU4TW/qdpEipf5JHksAGdN
 jnReVFTFW9QEkXWAlf+Iv+x6NOG/+XQD7i7KObSJKWArvZBXu2Eg42i2M1q8lPufo2GbHxlE
 uF+0E1eW3t0XdvUkXMDRmQexSfKctLerwy25yl06Jm29viyHgno4O7tQ/NbY9Bo5gzziryIM
 PSIwn9wLzoBkJgLwDfewbwbljb+kglIcD+gWfQFvC/JFufLn7NPSgQcYGV1PddJ6KQ12k9MP
 9Tag5X7zOwwiPl9EFpDWVH7/6PhLcUXP2GwMk/GD0eXJfyHIzPM2cT+faK7T/VZkuxVsxS6v
 TvTHVXkO3yPkDzgVhbnNu8p7mnTJBtFpIS0aQpgE0DmS8/6LAK2Opl7gHx+wLE5gG/LKX9JM
 TV4dBAozPXY5idZj/NjXm1ZuyA8d6/ewXnftrSeccVz07MjGCl/muNE7W5vzrJU6HsBX/lpg
 G7IqdUopVi6k+6Jwz4hURxUqz8NipjY2Ccqcajf6JREXm7JuRwX6mDFQTEDvdh4EZvCv65Ky
 97AvL3+InFO/piHmKlUT9iRM8+BPHc7ZFDxHyXICQIeUTOxHWTYmlAbj/yYsHGY5MtfyNCki
 N8FTblVU0YwH/URBxF+HdAMF5xwWystjb+RiMNgDZuWqR7MWINFs5qBWv/AWZ0Hxx6GgLMCa
 xZamNsQyKwMO4e910EwMjFH
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jgrPW6pDmsjlSmtlHX/IRQMaV5r/eYIsimQD101hICG9vPbo8P
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWrbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AFvd4qWjJXTT2vURCmQS5lQqR3DJuUS3z8Xv9Owy?=
 =?us-ascii?q?BV2N3d+KzaGK99r1Uqp87?=
X-Talos-MUID: 9a23:EL02hwRIsd34BR+NRXTJoR1waslS2J6lCXoTn5ADv+6oOAJJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259675775"
X-MGA-submission: =?us-ascii?q?MDG4jonD2ozMlLFJucJiPAFjWh9qEMKHRVifTv?=
 =?us-ascii?q?Zh9M3Qlakoss4A7sHszCS7At0YefVSGWKUmWHh7fe/bEvTDT5TGzCYvy?=
 =?us-ascii?q?SQncbaUH9CNZRliW62WUfiLXq8+6jA69Qm8vqrJxEjetYDBF6P8GEcAN?=
 =?us-ascii?q?Ga4aZ76xldLFhGamHPQT6j1w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 15:45:22 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bYo-1vkDLk01GY-00DqdT; Wed, 21
 Jan 2026 15:45:18 +0100
Message-ID: <fb3420c5-a510-4d72-8d6f-6f0d44ad9289@web.de>
Date: Wed, 21 Jan 2026 15:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
 <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
 <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
 <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
Content-Language: en-GB, de-DE
Cc: Felix Gu <gu_0233@qq.com>
In-Reply-To: <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Up9j5BRqkgxJN3iULpMMdvyAVvaOm6RW/jnQbN7U19Fcno85H/3
 Ia6MUWQ69VPPH1Sztd1H+dO6I4n3d2l3BSm61xz+PZd8Ww2PfW2QGeZVn8WWTcdwTeHdEIh
 6XgEjdnxbsQbAYm6tN8N4emseZHtHSW+JLbZ0KHkxZLQzd+w3fM29lwJ4wJ0UQyFZK3/ocC
 WjdGEyeXiViltRvEYdghg==
UI-OutboundReport: notjunk:1;M01:P0:o2pI6Dkzz/4=;8ZKrtHxMvXhyu+7ytzzltHBCoSg
 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
 0aPVxQjDqfdiPLbCt4oT
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3293
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/oomwvxJ8R2Pts1eZcv3K0Q>

> Another SmPL script variant can be tried out:
> @refined_display@
> expression action;
> expression * pointer;
> identifier member;
> @@
> *pointer =3D action(...);
>  (
>  <+...
> *pointer->member
>  ...+>
>  );

Another test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --timeout 23 -j4 --chunksize 1 --no-loops -dir . =E2=80=A6/Projekt=
e/Coccinelle/janitor/show_questionable_statement_combination7.cocci > =E2=
=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_questionable_statement_c=
ombination7-20260120.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinel=
le/show_questionable_statement_combination7-errors-20260120.txt

real    56m58,910s
user    215m49,097s
sys     2m22,875s


The generated data would indicate then that 6018 source files of the softw=
are
=E2=80=9CLinux next-20260120=E2=80=9D would contain implementation details=
 for further
development considerations.
It seems that this source code search approach is =E2=80=9Ctoo simple=E2=
=80=9D so far.
How would you like to improve it for the avoidance of unwanted false posit=
ives?

Regards,
Markus
