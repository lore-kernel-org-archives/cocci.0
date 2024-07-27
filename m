Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A90C3DA4A
	for <cocci@archiver.kernel.org>; Sat, 27 Jul 2024 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Va1vJPX/ljPG58zHKyXht0zvCQ0MWMNhUP6/BBfwofA=;
  b=U6RXPyEC/8BIxB5Ox+KGo6gOh4kzKmjBpNPGJz+XmnfSwk4Ekb0jrfqp
   TIfWLjqV0oXINB8VQuZFKLvt8vJkdfndEz+PUJUdjGB4Rdl3ABI60ESQv
   a8o2W2znNPzMYmHNJtbYiSCDPG0YevC5J6V/X+L61eU6lkZP1WNgze2AS
   I=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,241,1716242400"; 
   d="scan'208";a="177208917"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jul 2024 18:19:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 161A7E0141; Sat, 27 Jul 2024 18:19:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F0EDFE0035
	for <cocci@sympa.inria.fr>; Sat, 27 Jul 2024 18:18:57 +0200 (CEST)
IronPort-SDR: 66a51df1_Uyj3qGGQn2EHX6yPL2Tve6fSPh3XDREZOXkyZjWgiqV0gng
 fBWIIdaLW1bO2tDO32K6hG+/hLe5jTs8euQ9p6w==
X-IPAS-Result: =?us-ascii?q?A0FMAAAUHaVmhwsR49RaDg8BAQEBCQESAQUFAUCBPQYBC?=
 =?us-ascii?q?wGCQ4FWMwQLSIRWj0uCJYQ7hzqHUYh1gVaBQD4PAQMBDUEBAgQBAQMEgguCd?=
 =?us-ascii?q?AKJPQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QE6Bw47hXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ8gjABAw4jB60zgTITboIMAQEG2lkfLCJXg?=
 =?us-ascii?q?WMJgRouAYg8AYYNhEcnD4FVRIE8C4JHMT6EQ4NbgmmSLIt7Jo13UnscA1khE?=
 =?us-ascii?q?wFVExcLCQWJTwqCfQIFIYF0JoEigncIgS0VgQgCglqBawxhh3ZigQ+BPoFfA?=
 =?us-ascii?q?UmBGIFgSiSDQxyBZYEkHUACAQttPTUGAwsbBj2nL4J5xVQ0B4I2gWKBYwyfT?=
 =?us-ascii?q?wYTL4Nyk0oOBpJumG4iqHGBbgopgVwzGiSDNk8DGQ+OIRkfg3WPAb0DQTU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBg1qBSgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:xpjpHKyyX1NJcjHra2K5KrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:9kns528cqmXZUBceGySVvxEOS+8Dalry91TvI02XU1k5RreoaGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AokNHNA05kF8ECGQrkaoEGNnS7zUjyL+gNk4Xn6c?=
 =?us-ascii?q?8usyNMhxVYS+DjA3we9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,241,1716242400"; 
   d="scan'208";a="177208905"
X-MGA-submission: =?us-ascii?q?MDGKVb0Dvk5o99S1x5WFBzgrwr2NojlEHHMlQE?=
 =?us-ascii?q?j8iIIwh/HDdvZ+dMC9bm1P6T1wnjYruQwO7zy9i7UkZia/cbnV8nRGZX?=
 =?us-ascii?q?vzjCSoDYZihlSMN5K2MwbRYyBlzBV7dABMuKy05JZV+Qs5aHgRLPVv+M?=
 =?us-ascii?q?xrh76wZyfmQpc02bXySzNG1g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 18:18:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722097130; x=1722701930; i=markus.elfring@web.de;
	bh=Va1vJPX/ljPG58zHKyXht0zvCQ0MWMNhUP6/BBfwofA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=evkLwok7ak+HThaACxGR+Ztn4IMsQzPHwXIrHot93rVK6mkk/E1dOKgLl1z6tfWI
	 AQOknTsos0jUCiI7yaWR1BCNT7FXeYAt6X2BxKw4ilpSzC9Af8eac5Q+kKo94CHEz
	 lg10eO75MA0SYzOEUrc7xNS7XlSY2h5jFdHExi8qjaNbB4+AMhF0aMJUlnyDxIhE/
	 TkKfE3n/SeVCWyE84oZAqYCkb378kxawkltsfzLlZqNmxzTxjvD3oT+m5oIRVn9p7
	 mIponxUSSyJtN54ANL1gjEBeKGa7ywDp2H70Ve1Jy6ZngL8m032FdS8Vv7vlCNJhr
	 l/k6wSIyhhscR7l2CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgAJ2-1s4hi02mas-00hrzp; Sat, 27
 Jul 2024 18:18:50 +0200
Message-ID: <74d26d15-2c7f-49d7-8081-3fdaedcac273@web.de>
Date: Sat, 27 Jul 2024 18:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rzq82HaUfEI8MlI6KYNEhTfN14Q/CoMwcRs4otVEAyqcPXj3SDv
 0dXCUyi65blo4nW0mpyveuMaytrbVNPmaL26R23a6croBpqqk2dJ5Jva6kZOsbiWQQykPDL
 h0b8u1gbAdFHSag4cUtO9SKRL4GoxlBfX2RUksI97/Q6IP2IRzCEjSTG3Um8Dk0OwmoDO/9
 mm157Qliu2nW0nrtKbZqQ==
UI-OutboundReport: notjunk:1;M01:P0:bcafBN7uKTc=;dzXTj3ZJWl2CDCbbcF+Qg3TVioF
 j5egZpXZ0tLoHgQEuRE+lm8ts3IloodhX3QSQiys8BJ4IaNweFNZT2WAjZEptRCMv7ciYavy2
 R3zoAyC9a4kJBmJd/fNrpqDNgOVC1siJ0b4TEY+IVaTLE6cJcewOwFFCOgmGVch0lQn3uv3ga
 isv0DI86sNRprou1YBD2x2noofgm0q4gzw8ApUxgsVMDIqdu81SHCL+ZD8EQgjVZ1FFIm1/Yt
 x7ciBuAhXUoziHw10N8YOM6G3UL+p42yAmgbBqZezqzUcQ4tkJjIvUIR84jvbOjc5NjH392vj
 eocbRQxgNfz9hijnIvnIU+wm/Trbq37PFFSPuirpGsBs3DCRFFBL8ba/8t1zeY77z3//eMrEZ
 f5MKXQUJ9UOy5JmdrijmCNk0L/hsNhr4KsZXG2KxtrYqf8LuWNdN/wxzjRe41xZWjkCzp20ZS
 hsCwfDNRm84Uno19NRWvFj02Q13RJsc6mDzgO2hPaZ71rSn/Xkr1XXi5WPudPFTqRm/JdjcRk
 ke0noDkZX8RHjBboBQzvNZZPZQApEawSs5ZDkK2AfDq/Pzn7bjGh39ua8Acyc1AAB+26MCxLj
 FAcmFMR9xv6ExXvrtk2r52/gP9jbNdP5W3Xgv0sMlCVWTWI3N2o3s9e7rf9J5Zz/qj0j1fR37
 McTRQGA/zmktXHTAY4Afbc/3wH6AuKdVKZTlymY5SVXq93FcWvFhdvQ16Y+0dIovwnDWJQTPG
 U+w2m+JExb5GfPEav+DbWQ8UulVIp7radj3u9sb/Rw/hPEdZbSnY3EzJDsjq939LjRhNZgWVB
 UOIIdDXUfZ/iZLru8NO09c7g==
Subject: Re: [cocci] Code adjustment challenges according to the comma
 operator (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1825
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/74d26d15-2c7f-49d7-8081-3fdaedcac273%40web.de>

> The above semantic patch does not parse because te ao e, is not a valid =
C
> term.  There is no term in the C language that ends with a comma.

I constructed another tiny script variant for the semantic patch language.


@replacement@
expression x, y;
@@
 x
-,
+;
 y;


I would like to point out that such a simple source code transformation ap=
proach
found 156 files from the software =E2=80=9CLinux next-20240726=E2=80=9D fo=
r possible updates.
Will further collateral evolution become interesting accordingly?

Regards,
Markus
