Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F02C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QKOBc3WcjOz4IfasEwC8fB6DP0nSKk6t8bQTLGfe1wo=;
  b=WGYghH7Mzq4JdhX/LXxAMIZ7mIuTyO+ZYgEYU3MRi8GTv7LtAwxTBAT6
   wt8EZ6Mor1SXjy9LJGOG6Pq94DtGOFUsDgC22m+QpsDIhVXFVfkiAzlxz
   gQoDt0hLtNr5fEDfpEVgUNqqWLQf9WGFQmh4DGQGiM071XB8PTz8Eci+N
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213497825"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 14:45:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9CD4E0D1D; Tue, 18 Mar 2025 14:45:34 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9342DE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 14:45:32 +0100 (CET)
IronPort-SDR: 67d978fd_4pCg6tPjcfZOu7aDcfN1dAR42dcXe5Uc/ziUGgegFqvn7DO
 MbJ0TjLndekr1a0Qj3DJe9DCmowzXtLnLvBlwww==
X-IPAS-Result: =?us-ascii?q?A0GRAADvd9lniw4P49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDYhtaMwQLSAiETogdhzOBdC0DhDuZWYF+DwEDAQ09BAECBAEBAwEDOIFUg?=
 =?us-ascii?q?i5GAosfAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBATwFDgoxhXsNgmIBgRMRdDACAQEBAQEBAQEBAQEBHQINOkQBAQECASMdA?=
 =?us-ascii?q?QERJgEECwsaAiYCAlYGEwIBAYJ+AYIvAQMOIwcNBq1JgTKBAYIMAQEG2lwfL?=
 =?us-ascii?q?CJXgWUDBoEaLgGFbIJjAYVchQcnD4FVRIE8gwM+gkoXBBiBRoNbgmmCM4QeJ?=
 =?us-ascii?q?WeMHoI6gXqETYFVgwdXgnKMU1J7HANZLAFVExcLBwWBKUMDgQ8jgSIFNDQOO?=
 =?us-ascii?q?CmBY2lJOgINAjWCG3yCKGoEBYEkgjeEPoRBhVCCEYFdAwMiAYIwb3Ucg0h2P?=
 =?us-ascii?q?oRkLVCBTR1AAgELbT03CQsbBj2jDjuEPQh6ExQYgUUHfJMGCZNrnx00B4I4g?=
 =?us-ascii?q?WaBYwyKKZU1BhMvhAONCYY6DgaSfQiXfXmMDIF5lVGFXTWBMjqBRg8HMxokg?=
 =?us-ascii?q?zYfMAMZD44hGYNhM4RgsUlCNQIBAQE3AgcBCgEBAwkBgVWDcAEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 JdcEtezu3QqG/lcBkk3RbQ/
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:Qo3Zkqyue2H6zgqUFF7BKrPwj71zdoMgy1knxilNoNJuE/Bw8P
 re+sjztCWE7wr5PUtLpTnuAsS9qB/nmaKdpLNhXotLsmHdyReVxcJZnPbfKwSJIVyAygcl79
 YfT0EmMqyAMbEZt6bHCXiDYrIdKYK8gdmVbI7lph8HcegpUdAD0+4eMGmm+yZNNWx77PQCeq
 Z0z/A31waISDA4btmbGnJAZOTKvdvN/aiWGyIuNloI6BSukTjt07LxEwGZ0hACOgk/uosKwC
 zqkxHZ+q7miP2wygbd22jPq7xalcDs0MErPr3/tuElbhvtlye1b8BaV7qOsCtdmpDW1H8mnM
 PQoxApIsR07Gm5RBDHnSfQ
X-Talos-CUID: =?us-ascii?q?9a23=3Aq0KhAGsMTI9BlxN6AOQ3xafC6IsJciTy3G3sGXT?=
 =?us-ascii?q?hSmFqc4/PGQ6p8qhrxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AacBOHw/R6pwQdMR8mHhJr6eQf8dKvviUFRojraQ?=
 =?us-ascii?q?5psnDNA1IByWGgR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213497818"
X-MGA-submission: =?us-ascii?q?MDHVaWS+IR7mVpiNPifl8UJwa+1UcSulqV3h1G?=
 =?us-ascii?q?ojB3ZhckfG7mQ0ZihhNKV+iG393NCUkKk6wAXsqDqfO67eaXeLA7UN2C?=
 =?us-ascii?q?P31HzgVKrKmu8IPASAONLSy0ZRrRJUlT4h9Lt+1plh31GNufd0VJ4P9d?=
 =?us-ascii?q?s1OmJDMzlfvVVbIoyljnfYqw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:45:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742305531; x=1742910331; i=markus.elfring@web.de;
	bh=QKOBc3WcjOz4IfasEwC8fB6DP0nSKk6t8bQTLGfe1wo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hpxh2N6CYw2LJfa6TAcYQ6FoGtV2Df67CmeaM/Nk5Nr8jFEH/vb1MJP4B2rwEUax
	 DnGPscE4bWyEbHessayAverVDgTNk5X3jMq5YDgBCYLdFuCtRnlCxP/z0iH+9HNfQ
	 54QoLC+C62NQmQI9pvxBz2uLNxu8BDZAekSmrifZI/JcC0BwHLw21WZoiAqeG3LU0
	 5BY1+vbdc2dvJ8jOrFHCucSxvtNOftgLZRGGBzkPmKmaJC+zQzkGe3L/oZV0YMf+F
	 PnFlzloBoXcTGiHdgNJq6trvHX3T91CvWEroP3RBAty+M+9elDw0EoUyg4mCwMDbU
	 VOPFdl8xX2Q3Tyll9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1LsV-1tAdpQ27ad-0104GV; Tue, 18
 Mar 2025 14:45:31 +0100
Message-ID: <c375800d-0f89-4e95-87b9-0e35dc208913@web.de>
Date: Tue, 18 Mar 2025 14:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
References: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
Content-Language: en-GB
Cc: cocci@inria.fr, Ella Ma <xutong.ma@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0pdUdhEf0tpNeqyYTlSQLTqTbRWIThYGZogtiTBiZt/utqyOd9f
 YRzLE20nKucqWzRKKcUYbSngczXk4bDjNP2exhr9WpvGvJZZGbrzM27Lbwhofj2lOGwK9wx
 C8OpGC3AJntZVOKLHb29z/ugdsb7PHctdiqE+16ssJPhjN/+vaVxBzxd4t+TQbQDqwF48Vb
 70moyvWZa9K5pTmesatNA==
UI-OutboundReport: notjunk:1;M01:P0:wukPpoqOe/8=;fdnWKn3Sq/BSAPK4jK1LPiSVWHa
 FRvXfJbtDRI633W9k2ADnS+3F649lyHVqn9gcuL2OxEmxlp8V7442GVXqNuU15PHzEm4hyZBe
 0iaNpl8gdX662styNGCjDqr3mkRqqCjTvKyxABeMZ0sN2WDKPH3mkt8rpbHNnZoZquyw4BDqE
 /jInxX33yKhRdh2O+VFCcHTnavQP1EjnDDWefmYs8/tU+yyx8C3aVMdhVZjSyfM74VZY0aI+Q
 GGc8AUDLBRaRTbL/tFTQy/VgbWNsNLv0eNnm8aCt9G6g/oAfemFbrFJwaSFIsTtIZdez82Hzy
 DxBLiTdjAyYbKqIcQzrq66T0ejn1fortcS4Ey/lNJI8jG8v7WEFoyPVNyAeMD/+THnighhWr9
 b8kZZ7Edv9bqNJ6HCoKsrB6khelZdoUfoJv9OPHhEKbH30ntyiYDq8/K3jiBMrfxWtcHmGa7N
 rLxSRDJ0cYJ0MV5LdqT3An+8ef7cWv8GVQBGo5uYpaNHheUm+FMjNSgqBOgBVEYoIZTnppkBe
 1q9+Pa5B2ru3rE2F/lzmXLKXZxfHEmg/sdDbR5h4OwMrEwwMKLmDvctsPJ+G9ARzHcmn0XZCH
 bgqKMcXg+Hwfk2sDf0IsceLnZYgEzJJ/wtkkZmj2CHAyO3JRjUUeJbc8XYTkUGFiq2TzW8+fR
 HXq4+d6YWYKcOucXGJ0wRdhsgoISMEAPiOJXB5p9k7GuFh7Hg4omVpm0PQNyPpbDoK0qFcsw7
 sPEGEkMOJC2YSnPsI6oyzsJypJS0Ae6TO9CZFdun+yYbIhuR5G8ygKgiFriZQn8xvrAlvkFV3
 bdzt3SkcnjqEpoa7g73s0M6QaoO03EciBLkioOYRGR580TLPIpWPQpZN6SRC3Y591bz+Jdtzz
 4gtrO9g55fHNd9xhDAiQ3HJF4OFeOsoIctXOhJZ2gPg9H108tyrWNQFtTqUwMRQAsqpzNATc5
 lO/lOFGA52YAvDxZWroi6y/gaQOpXAw9urNwmAlIi0qc57T6GB0/JGhSsBLHl34/uWB2poTKL
 feA4GRHeLz5/N+I64EOcFrNBYI0RKmomjgTXyoTen67M65oyTTiUvhLhbhySXC3ApKgy+6us9
 mTkI1ML+V3gM+3XoLyszPKq+DOsb4L30XGpbMNbLz9mrvQW5juhXuixXIlN6sllLWzDm6rQts
 UeZDCQh7MDBfNUxAFJptWTWhDlaq5tqWAMGT8LW0PGOQIUVLOOKLZFY+afQ+umS+SlrqIcInt
 iCU81MVcmUUoWU+SOrb2AweLpJsyqVjciZndOK2EWD3Wq2WgsnLSDPmRzlgP9e9RY1yT3yM5L
 Cfx4azxzU1OZjcUeYKnbfbza+Ut6ft5twKQdWOkwhRJ03u6Nm32DQ0C5Eib459RQmF2lQUQh3
 W5hohOSlcaxVLqKPSlCr3V/bpf2uBLcI16N7zextBN+tv8ZAdKnT/pqCzbDb01k31JF2UhRdV
 8SKDDfq//nI3UUQFKNnufhVbORXSc1CuP22ee8q78UwnSzn17
Subject: Re: [cocci] Detecting Use-After-Free =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2619
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/c375800d-0f89-4e95-87b9-0e35dc208913%40web.de>

> I have found and tried to use the kfree.cocci semantic patch provided fo=
r the Linux kernel. However, when I run the command:
> spatch --sp-file kfree.cocci file.c
>
> Although I am certain that file.c contains a very simple use-after-free =
example, Coccinelle reports the following message:
> No rules apply. Perhaps your semantic patch doesn't contain any +/-/* co=
de, or you have a failed dependency. If the problem is not clear, try --de=
bug-parse-cocci or check whether any virtual rules (e.g., report) should b=
e defined.
>
> I also tried running it with --debug-parse-cocci, but I am still unsure =
how to proceed.

Please take another look at corresponding implementation details
and available software documentation.

* https://elixir.bootlin.com/linux/v6.14-rc6/source/scripts/coccinelle/fre=
e/kfree.cocci#L16-L17
* https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/dev-tools/coccinelle.rst?h=3Dv6.14-rc7#n71


See also:
[PATCH next] firmware: thead,th1520-aon: Fix use after free in th1520_aon_=
init()
https://lore.kernel.org/all/f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.m=
ountain/
https://lkml.org/lkml/2025/3/15/159


Another concrete test case:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250318 && time spatch --no-loops -D report scripts/coccinelle/free/=
kfree.cocci drivers/firmware/thead,th1520-aon.c
=E2=80=A6
drivers/firmware/thead,th1520-aon.c:221:18-26: ERROR: reference preceded b=
y free on line 220

real    0m0,747s
user    0m0,347s
sys     0m0,055s


Regards,
Markus
