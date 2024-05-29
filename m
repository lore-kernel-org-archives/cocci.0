Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055C4C25B75
	for <cocci@archiver.kernel.org>; Wed, 29 May 2024 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=44LtRPpJS9k50xR6wW/+Q9GMBsFbqhXkcW4HPHoBVP0=;
  b=OaNsivFtZzoPrVegE++KNl1jTVV9rGAOSgEgadAcOWr0bZ94jQdIgvON
   w7pTeLY5LuvENo4LxbbzzMiyh3IVmTiGsioAr01IyGhWXX8ExhTS7wQnS
   i8rDXu9Atrp/pbB+iwDzdIq/njRAevjY6hfOzCA4/SyX1d2FDvJZ1/rnl
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,198,1712613600"; 
   d="scan'208";a="168004612"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 May 2024 14:11:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0EDAE0CCE; Wed, 29 May 2024 14:11:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 692FDE004E
	for <cocci@sympa.inria.fr>; Wed, 29 May 2024 14:11:03 +0200 (CEST)
IronPort-SDR: 66571b57_uWuET3dc6JnSuULyYLcSd601k2/bnwpo0V/CpPsYCq0kr1N
 mzlVUJlLq53lX3o+V6kl/EjessvsQF++eW0UXyw==
X-IPAS-Result: =?us-ascii?q?A0FJAwCRGldmhwsR49RaHgEBCxIMQIFEC4JEfAZUMwQLS?=
 =?us-ascii?q?AglhCmPSIF1MIQ7jwmIcYFWgUA+DwEDAQ07BgECBAEBAwEDgUlCgnQCa4djA?=
 =?us-ascii?q?h4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4V0DYJnARB3F3QwAgEBAQEBAQEBAQEBAQEBAQEBARcCDTpCAQEBAgEjH?=
 =?us-ascii?q?QEBEScECwsaAiYCAlYGARQBAYJ8AYIvAQMOIwcNBrBWgTKBAYIMAQEG2lkfL?=
 =?us-ascii?q?CJXgWMDBoEaLoguAYV8hEAnD4FVRIE8gwM+gmEEgV6DW4JpmWOHRYRihztUf?=
 =?us-ascii?q?RwDWTIBVRMXCz4dAhYDGxQEMA8JCyYqBjYCEgwGBgZZNAkEIwMIBANCAyBxE?=
 =?us-ascii?q?QMEGgQLB3WBcYE0BBNEA4E3BolqDIMHAgUhgXUpgSKCeAgwE2wVgQkCgmWBa?=
 =?us-ascii?q?w5hiBpjgRCBRIFpAVFjHUACAQttPTUGAwsbBj2mD4RaLIJ6xQY0B4I2gWCBY?=
 =?us-ascii?q?gyKIZUnBhMvlzkOBpJomGMgjVabFIFlOoFcMxokT4JnTwMZD44hGYNhM8skQ?=
 =?us-ascii?q?TUCATgCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 IUDQPlXWQ5sfs4=
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:e7DF3qkQstZ53jZ0roV2JpkqGvLpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AiVAa0Gl0laOCGu7boDtmNPrbM3rXOW3h8FOKCRK?=
 =?us-ascii?q?6MHtKEaaFZA/Bx546gvM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AJB/HmQwrPJ/R7oduDC8JyVTxzSKaqPqFAWMStcR?=
 =?us-ascii?q?cgc6BMABKJ3S7hjWKE7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,198,1712613600"; 
   d="scan'208";a="168004598"
X-MGA-submission: =?us-ascii?q?MDEcJay/kkVy8tR3Eua+JJubd1vebGROqtn9Dc?=
 =?us-ascii?q?3r+tjsC/fcRm/osIOM4Qb36TMNScgo8qpQzu4VRISnKWpXD+2XnPDyX0?=
 =?us-ascii?q?msAJwkhq4DiYkvV7Nwh/mpGWjoZXYFHQT7+BTvbffyHrT+XtntoeJLeS?=
 =?us-ascii?q?NlDk7ryV0ARs7LH8G+rCw2IA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 14:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716984662; x=1717589462; i=markus.elfring@web.de;
	bh=44LtRPpJS9k50xR6wW/+Q9GMBsFbqhXkcW4HPHoBVP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZevaaE4ql5oMwDeAtKax+8qVeshkazxM7zf3aPBQMnRX8SCS1VXgqk/Urf5m/rFj
	 iZJPSDEYvrKpz97VsMCrrzTXBz5DwErGU+rW70IWyF0e7SwSVHNk6GV1M7EtYlSq7
	 TkkYLzz6uhIcBweXpuqo51fOD2VTvj3xvmbcxMTiIYFZ3cKa75DeEI4JWE8Q0T9HG
	 vwSo86L8LB+LE3lusuIojFISdZLGKTOJLG8slK5PpksGslTUPLhGJzfNj8hmg4Psi
	 dEhCpf/n2VdjDo3rqHsA98AuEgQkzTk1c6cf9bnryFxsKIp5tYdAX0P+DJ+QvdoRC
	 j1eXYrjUsHJCNIgsIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1sfHph0OkJ-00iz9j; Wed, 29
 May 2024 14:11:02 +0200
Message-ID: <2dc6a1c7-79bf-42e3-95cc-599a1e154f57@web.de>
Date: Wed, 29 May 2024 14:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZ9hv8fYAElNjOlZxlxgzZ5uTXJPSXI0yJ7CY9+cj+rh1R4+JUB
 w9Si27EzJB3aXTEaUeUEPYIg6j3KDz8JdT7b1ddjpYEVqtyLFX2u0595L/hEO9pZd7TfB0u
 YWhFU74wW9yLFcUELBx+bzj0yeWIESk8hVrM83cS1mYGnQMTnsqVHwVi8gOFoPMwl0XuszY
 tZFnexDE+zKLOHudZpwJA==
UI-OutboundReport: notjunk:1;M01:P0:utnD1sW6RAo=;WksEr1mpu6wx0BhlcFPjESewXKD
 /uWhdhKiIGoWO1Pm3MLwnae72M37VMqSYCf6EhMPLgF+J/bHiaqJZgORB9ErpWpxkbSPJtV5U
 d173krFB0NrrU0sUY4Z2poosFVMxesEhypj9nHhX3xs9YnbfTOIhVfZzEEhXXd4kfcF6FhyKs
 bftPhtjh/xNt0ABTtTjqnuDylIcQvo5xHAfle036uFbTP+xsmUJl2i61XsLThDzymceAUuloy
 v7vohESg11FDPBHkuHABus8M/TUhFgn/H67r2VKNrJN6EEnnBLSFA0nstLi1SfMvWZ2ffscvS
 Cl5hA8Fye9yP0GInM3VdLncICTc2q7kz47YBW0zoKzMona6rvqTUXTfTA/1bgxYaSWgePi1Zh
 Es/Tm7p1U47E3aLIdIL4IEFNkLTToruk4ou6CHLelfi0RATWcBhQn5rdnmR3IHt9r7aYUm+uz
 bjSpFcEOULoH6iVC2Mfy+MnJqdgdPHoi0MDLiE3OxhFn9vdUTvt7A68SoTmONAtpozHFmBGYH
 bp8VIfHfPuklIr0D322JyQd194s5xmnJbLmYMe7XQuQhY/ngGVbVzuN1s/O/DHhUIU+e8h2Ry
 6yrt9TYzJr0o+ueDSMZa4a3tj1B6Bi6TIAa6EjeZ0EFlq7loHKEgS5Smck2ou2/y9JrVJfMuS
 BOPFNaFSC7pWdvmV0Gjg0K4q5AuAwel2IoF+RvEwblwhNoWgP8by9p4a8yop7nSH8SlWHkVZv
 zPRNlt6/XFotpvkvsZOhFk6EK4PtrrkO/TvqhnaD38P/H1jLkqWLwdKUmy0wbFmsVpYRvlho4
 CHb+Q5KGZKQoXoEYV3B+7uvglPS9w+irmlNcAA4xf6mPA=
Subject: Re: [cocci] Looking at guard usage (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1766
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/2dc6a1c7-79bf-42e3-95cc-599a1e154f57%40web.de>

> I'm not the one to decide whether we should use cleanup for mutex locks.

Would you get further development ideas from another bit of source code an=
alysis
which can be performed also with the help of the following small script va=
riant
for the semantic patch language?


@initialize:python@
@@
import sys
delimiter =3D "|"

def format_data(places, item, input):
   for place in places:
      sys.stdout.write(delimiter.join([item,
                                       str(input),
                                       place.current_element,
                                       place.file,
                                       place.line,
                                       str(int(place.column) + 1)
                                      ]))
      sys.stdout.write("\n")

@find@
expression list el;
identifier item;
position p;
@@
 guard@p (item) (el);

@script:python output@
input << find.el;
item << find.item;
places << find.p;
@@
format_data(places, item, input)



Thus it seems that special =E2=80=9Cguards=E2=80=9D are used at 678 source=
 code places
of the software =E2=80=9CLinux next-20240529=E2=80=9D.
https://elixir.bootlin.com/linux/v6.10-rc1/source/include/linux/cleanup.h#=
L124

Will interests accordingly grow for further collateral evolution?

Regards,
Markus
