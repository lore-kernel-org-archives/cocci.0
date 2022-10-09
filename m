Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184D7C433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6P/TgtUTts0ZR88zS3mFZl2W9fcYmx1MNzAGXpvglDs=;
  b=T3KTwjKCBU2Uwae3hcr6iiiCHQEG9Iqxm9bDCAYRhwhJ2g1a55c6ehVX
   kJiiSneGbGUXlZyiIlsNqUhFmWM6ZvjwPlpTOzi8+NKtdpp0E8EEuRYBP
   cCXUR/HmkqzlTqsKXiuPsLHNdBSMZEvmuevEZxCWGi/zz09PNa3L194Xg
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56685985"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 19:00:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D80C3E0290; Sun,  9 Oct 2022 19:00:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9708BE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 19:00:46 +0200 (CEST)
IronPort-SDR: 6342fe3e_Yw/0nO2oQMw1NCqbdufUmn/PfCqcErEUquQFRq8zJ5YWgCE
 qzg7mazDj/hMfCwqhJHWUYyItyi+oABxDxVYYRw==
X-IPAS-Result: =?us-ascii?q?A0D3BAA0/UJjhw4P49RaHQEBAQEJARIBBQUBQIFPgiSBA?=
 =?us-ascii?q?VYuBAtFA4RLkRhpgz+OPYwsCwEDAQ03CAECBAEBP4FTgnMChHQCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOBQsFIoVoD?=
 =?us-ascii?q?YI1KQGDZAECAgEjHQEBESYBBAsJAhoCJgICVwYNBgIBAYJ5AYJsAQMNIwcMj?=
 =?us-ascii?q?2ScF4EygQGCCAEBBoFAAYMNHywiU4FcAwaBESyQMCcQgVVEgTyCTAcwPoJLg?=
 =?us-ascii?q?XmDV4JmlG6FRiYEDgMZKx1AAgELQjYYAxQDBSEHAxkPIw0NBBYHDAMDBSUDA?=
 =?us-ascii?q?gIbBwICAwIGEwUCAk00CAQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVA?=
 =?us-ascii?q?hAIAggmFwcTGBsZAQUyJw4JIRwKBBoNBQYTAyBvBQo4DygvaSsdGweBDCooF?=
 =?us-ascii?q?QMEBAMCBhMDIAINKTEUBCkSDy0HKXEJAgMiZQUDAwQoLAMJIR8HKCQ8B1g6A?=
 =?us-ascii?q?QQDAhAiPQYDCQMCJFl1AjERFQUDDRkmCAU3GgQIPAIFBlMTAgoSAxIPBidJD?=
 =?us-ascii?q?0o+PZoGg02CH8IJNAeCG4FGgUkMiWmUaQYTLpZoDgaSCpcQjUCVEYUegXgjg?=
 =?us-ascii?q?VszGiSDNhIBOwMZD44gGYQMhGGFTD80AgE4AgYBCgEBAwmFRwEBhUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:9/PS4qxXfdbx5/3TmT0EKrPwCL1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bHYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="25892808"
X-MGA-submission: =?us-ascii?q?MDFLWwb5/Q2MsYUJnP78ANeaDFTjH53qqGFKHW?=
 =?us-ascii?q?qZoMJnWqb9vWGz+6Sc6JAD5qowFRe053RUlsQRplRCvW8WsOC3ogmTZ+?=
 =?us-ascii?q?wQOW+xLmVdRgPvC3Kg321U4VosdS8XGdi2mBpFI1v4aSSzoQlj3hcYw/?=
 =?us-ascii?q?D+ZZUBnomYhf+5zChSg2dXPw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 19:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665334843; bh=SOXv13H2KxVQkttv31p4f0d+GbQEdSFbrb13HZ3ORMs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=txGqF8xnoHy0PhRILowhlAbbJ85uMGlZnasQVQFOHdCwSGt1R/dTD7wABGCjtfUYb
	 CP/9hIHRe842C9S3ZQDRJfLTmoPBcKPw9G8DnyWY1q6LzDTosAj1apfepgl9ZDKFtC
	 fcCgna1/Ih5e8h1OTvn4KTzXMBB3lcCq1S60UZSdZXnWa/Lbt+qK7rjA24jesJ06SW
	 RHqa71oamRa1d34+MMl35FfOX8bw5n7C8KMAmfMQxtuknV80KxZ8xoT9s4a/Al4IC4
	 QNHSMDIHhde1lR06f/hh0ietAfEwgMW2wxdAAPP2yh30ZO3+xshAlTo/7nq4wTgoi8
	 HTq+wdSk9RLkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMp8K-1oR0Dn3VG0-00IsHV; Sun, 09
 Oct 2022 19:00:43 +0200
Message-ID: <9c2e72af-e465-aa35-a631-c4f9762143f9@web.de>
Date: Sun, 9 Oct 2022 19:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-GB
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr
In-Reply-To: <Y0LiyBxZ0pU+NOPR@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:97b08z/QvlSwCJ03fyjwaTpFGwoiZMRAugXWlR4NhXQ2sgbVQ1N
 1srplZizlpHfdKvU0OyFvaZ7CJKMNCZINImeGrQkC7JuA/C0e1Ha1XG3MNiKhclGx3HblBk
 KjMsXju2wts4x5VKZ3JVBedio7PzxiyRhwTWqZTWuQ3Rf6zDk8ASJKFJPkPk93AjZ8K0ENa
 CJMi+xWfITF/HBBFQl4dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZerOiQwTxKw=:KjWPs0j9v3zxexD26NDIFL
 Mu+dafHDo28EJfu1JP3PPxG4P2HFCZNaGDGWalIeaPu/GGd1Du7Ruv8i/kG15Y09TqLKdMB1D
 fwZLNBDNTiapWGxIhFni8W5Ja0nUhp1g2PBAfrvJRC8QUAa5aSOwG7T6lMB6Amqld+ZfvjYZQ
 GiGFKzsNAEJQoc39JAf1/3UW145GpErm4qXNBLxlZy1J23ArXUCAWljPBnj3Wh+btaYm5x3Ts
 KFWG4N8Q9v7RW21qzBzZOhjjYSsrtZkibMDoTtQ3wz3oXtL8tGhe+zzC3DDjkME+uhPUyH9pg
 rdXAmLvVWnfkXjQEZBt0//l284nHz0WzLpF4UKNPTfePNgzx8/JEWYLZldnHsQ8EJiwH+fnGx
 eUE2TjJD+h5V1h3NXLeJY6d1jqQH3FG9QfIf4v5XzHNSLe1Wf6DmXYWzML26eJVG6QvKjX9K6
 0Vsx14xltbk7PClscpKCjVbmo3zbhlpXnfoDWu3pfXwprqBI9HqNuAmOIR82MaN7ufKnoYLLi
 uTcFjrZxbLlhvQOxvG8L/YSTOsTqlz4LTsyuNyiWd6fYkCdTcBGoLcQ26aeVRlXrDLHCYwnsF
 Ol00i151GsXMvHmBCAxA8FiEMQBRQYyBjBvxenhHWxOsZ9X/Jyub3li7nDYGJXxQAX61xmL6O
 SlMy7CS83J+pMW/lJ/SvaRNQghtf1z88CV2DDWA4At5fqWTgZaE0ZKbmhL3GNNVL2BYhRafML
 V1KcIPbgXXO06TInO5oNRAAukGQ1/BWguKFEz7olA9f751Sv4VxcJDJ9Ik+T5dLtH7C5jsWZ8
 1rPSsSzyEx1GBd4GuHmjmaPLJ0tSoXF/AZnj5qzgDQ8bt8bnwigNZaleeFj8w9o+0+5rcCVK9
 +/W9nY4DajAeF2gl453BiTB6dxYJhw8zD8tRUrqO7cxjrMZaT8jqN4yGW70I+qwDllTIjbNAt
 tR2GSsIcFi2l9VPH6PoDABAVJjH0CxblxgZsw8cZz2Bbwv8Wjigj1XTIxxwQ5reFl6Fo56+M6
 HNg2DfkOveQawPQxjPYr9md2NJQAijtUED911iuJJzALo9qfn2v0o0qhOmxOnitCoWXtax13C
 A0kBNhqNjhwLgK6HcFu/TdyO0qU3rwAzSvdt1yFOXcacMkkA552/NwF6dLOikdkTqkwI2FaJp
 3gB0ONYBrRwl5c/T/D+1Zvwrb92M4Cq565zwKcc7f85Cc1qJjQ0DHzdq4Hqq9Fl5dxWA97hZH
 17Sd36Cvt2zeW4pMw6XL9nMUaDftwNwERYoE2EoGYZInkNAS/Xg+YsNGNuqqzGUYrZT76BG6C
 fVCzb3KjwrFXDlHecSUjFpDJNZNxMo3gZlUlAP5ry3BjYUMZTR090PuSIpgbV3FeT5SdaSlY5
 WS5sZ57ZnXh3EUv8qlXSOMIc/4gYBGDFa4lMMYNz8tDoBSm1p1KKukeJihKlQuJYS57J9N3xG
 qAW6E4uqM8eJZXphpAB6mL5V9hWpnHPA2zKhd01W+vB1tl9pUVq7+Nh7qWarQAY7TQm0tftPi
 eSkfD419QMs+Bapb0Bhvbwta0KveiV3rL18TvarANqjRG
Subject: Re: [cocci] Replacement of random functions for Linux
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 634
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/9c2e72af-e465-aa35-a631-c4f9762143f9%40web.de>

> I've got a fairly simple rule that works on easy contrived examples:


You published that you are working on the topic =E2=80=9Ctreewide cleanup =
of random integer usage=E2=80=9D.
https://lore.kernel.org/lkml/20221007180107.216067-1-Jason@zx2c4.com/



> @@
> identifier get_random_u32 =3D~ "get_random_int|prandom_u32|get_random_u3=
2";
> typedef u16;
> identifier v;


Your clarification request triggered that Julia Lawall pointed another
possibility out for such metavariable declarations an hour ago.



> @@
>    u16 v;
>    ... when exists
> -  v =3D get_random_u32();
> +  v =3D get_random_u16();

I would like to show further SmPL code variants so that you can choose bet=
ter
from corresponding run time characteristics of the Coccinelle software.


@replacement1@
identifier to_be_replaced =3D~ "^(?:get_random_(?:int|u32)|prandom_u32)$";
u16 target;
@@
=C2=A0target =3D
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_be_replaced
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_random_u16
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ()


@replacement2@
u16 target;
@@
=C2=A0target =3D
(
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_random_int
|
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_random_u32
|
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prandom_u32
)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_random_u16
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ()


Regards,
Markus
