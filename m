Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BBFC4829E
	for <cocci@archiver.kernel.org>; Thu, 15 Feb 2024 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TpsF6bZsBoTndBRuRvbyNcGMN6t6qYAG3YjraczJ48U=;
  b=G3kN81rzJ+WCrEluXrQ1859VuDWKIEawljPTxfDQHk/qchgDUkNfEsvl
   YUQTcxc/3ib/q3VM0Eh2bT+nlLB+i/SfwL39OmUWj1JiX73GJi2YAQvog
   kiwDAHZkT+C9hu12UaLUxqpFC1e6JWq8164oedyGIh2ss6JOMuKH5/1E+
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="152057164"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2024 09:19:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5158FE0CD7; Thu, 15 Feb 2024 09:19:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F1B4E008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 09:19:07 +0100 (CET)
IronPort-SDR: 65cdc8fb_sMuVC5W83/1crj4nWk5rtIJdibjLS6Yu0ogTCh9eghhSARj
 4d95H6EDPG7FSPmc9A3INHRBQElsJEa+GV54PJQ==
X-IPAS-Result: =?us-ascii?q?A0EoAADpx81lhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4gVIyBAtIhFOIHYkcMIQ7hzeHTopGgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IILgnQCh1sCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBIxcHDhAnhWwNglUYgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBA?=
 =?us-ascii?q?gIBIx0BAREnBAsLGgImAgJWGwEBgnyCKwEDDiMHskeBMoEBggoBAQavWx8sI?=
 =?us-ascii?q?laBYQmBGi4BiCUBhSSFBycPgVVEgTyCUjE+hENNgw6CaIIYgzuZVlR/HQOBB?=
 =?us-ascii?q?QRaDRsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FVANDBkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAaBgwmAwMSSQIQFAM4AwMGAwoxBylVQQxQA2cfMgk8CwQMGgIbGw0kI?=
 =?us-ascii?q?wIsQAMREAIWAx0WBDIRCQsmAyoGNgISDAYGBl0JGgcPCQQlAwgEAyspAyEzQ?=
 =?us-ascii?q?REDBAoDEwcLB3iCCYE9BBNEAxCBNEKJagyBHwMZKx1AAgELbT01CQsbBj0Co?=
 =?us-ascii?q?UmBKTCCKC/EbzQHgjSBYIFhDJ84BhMvlzAOBpJemFiod4FkOoFcMxokgzZPA?=
 =?us-ascii?q?xkPjiAMDQmEC49HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3MyTaq55oye3c127DgPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:p1v+J21jBBEx0CU1ChSgYbxfOpwEf0zT1HrpG1K/WCVOb+26QwbM5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3Av5G8Lw33GmpbtVyEL6aEDuQBBTUj7pv0J2M/was?=
 =?us-ascii?q?8ocCVHhdcPDWdoBDoa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="152057148"
X-MGA-submission: =?us-ascii?q?MDHSyi3UQJh73vJLJhp1bjlh/420BIVcA2FHeZ?=
 =?us-ascii?q?ZmU1sgsLjx5hDj+ZNjOt69fYY2WXSExijHDAmqK+ObEjLNAEjxBFMi4m?=
 =?us-ascii?q?T4SFEYRiKXvgGcrTrNluPK12XFSmmmX8rBBNnAObVg4xWeWelPO5i6Hj?=
 =?us-ascii?q?e3WVNMYLSHY6Rk0IMMalNdVg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:19:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707985146; x=1708589946; i=markus.elfring@web.de;
	bh=bvd+BWgneX9LButCr72BqUUwZEeVR4WCP/wP7WXxn84=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TS44Ivvo/z5YdWWmhXwO0CO2uB7c8WtdQJDIIGEOmq2JlEuCgbx28vgsCC5l8LFX
	 WIGJHIfwRxlr0JKQGAkD1gtBfXA4TWFoFEaES+RGr+eo9sEvU2sG7YBHOkPoKIimT
	 TKzwiBjlLLvvoKr2qnblOueEs1cklygP2Bgtz+wvb9KL+/cCPdBcNyFLWSppTwJhN
	 8jzgK/HN1FMiukbk6tstGXSl0tE0WeS+HgChm7l2PVNfHHfdhuDWUmrp62C7Hs1hX
	 zrW2nIrekF0DdaELJbDQk5DN/dn3YI4oSDk7UxpKua5M8pUJpm6wPMYd3KtIOWiAs
	 1zXT772IoWIr0ErRyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP3CC-1rJyXV43IK-00PMyn for
 <cocci@inria.fr>; Thu, 15 Feb 2024 09:19:05 +0100
Message-ID: <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de>
Date: Thu, 15 Feb 2024 09:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vlsS2kbKLcCuim4ovs6qpbQF4k1odVy5WE/ypSmIJROaL2qB1RJ
 P+g6nRxgLOFu2im38OMlMQJ/NeG1eGSBJ752bF8waP842pYbywP8giwJxZyvNjTEGd1MK4B
 xBANcm9aH1eXdAfBuCTOwVw3X16g1tmi43COSOzHp4PQXoNhp8FDuXGRrjqN2zxbpQafzc2
 0xQ/h2tICBmpuxTcHg37w==
UI-OutboundReport: notjunk:1;M01:P0:LBPO6bm9QO0=;oEhaZRm6Tod4Rw+NiBrzCihk0s7
 MlqSHMC3jW2H5ens3n43eM1A2lF37mohuL62sBli+6rETH/nwSddZa5C9dtUPr1Sn8G15fha7
 jPZBqg1/T4MC3Mj7gzgpye/XUlSDF6rcOu1agnuFBa/Y4HXZliAmMkr5znx3cal60i9zFa0jh
 1DjnF/01a7l84X+jXHjhFVL3oeJSMRSBqdHbqQ2bUePKBpQbFOZuijIwa3LiX0yxYCVB7sdXw
 Kn2zPAuud+IRsZB9fYzt1wd79H3Q6pEsS022jUdwyGIwMKkelU7xWUj86EsmjiVBJj5ltKGvj
 qfTBGwLXe00lBvhQ0qCYbR89jce7BFHFn4XU2MA+hd2k1Yq66mlW28ItxxMN9SlWzpluqoRTT
 sQSP/yf7TKS8V1HtARgo8IvYGUMxu+dKrsuspZ5MGBJDWao1zYmlpojNQDQYgu+tCK+ZdfTO+
 pxFZ//U/VccqxUpwFj+oNES9NueSQMQImIGbOVkbSGfe6HLdi75+kHfUnqdP5V9LW+uH5J+0s
 2OpJOSWOUpo5XLqn//DBGcpfzUryAHSRV1zaeMktwKMaJdCl6smS4x91MnarFrWUUahEyvcW7
 IQ3nfdCGZu8BRnDRVINEInn3sqlH0n3KPy1GomrxtpTaDltcO8RVRSGT+cUF6m5XqUJuFVdLW
 GJg1qmZlTlDm9LPffL2z831KWZWLmRR/kRTEm5L2nl+w4PdM0dTVCZgxkVvOwFj4XGPLBA+mc
 5LvfhNlZ/eNJlCo6RRhKIJYblX8XXoWH+Uo6WehaNUo/ZsYX0UquhPt3tiZfNEXPs8ul+eGj6
 w+nTA0O9wklStw8jmlWkIpQGNt9GwHlfh4Qhw4/C3UjZE=
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1555
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/4bd9de70-de02-4fea-9d41-095304edf4fe%40web.de>

> I got into the mood to check also
> how good the following SmPL script variants would work

also together with the software combination =E2=80=9CCoccinelle 1.1.1-0068=
7-g0df3efff=E2=80=9D.


> @succinct_deletion@
> binary operator bo;
> constant c;
> identifier var;
> statement s;
> @@
> ( if (var bo c) return var;
> & s
> )
>  ... when !=3D var
> - s
>
>
>
> Another test result:

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch d=
rivers/md/dm-vdo/slab-depot.c =E2=80=A6/Projekte/Coccinelle/janitor/delete=
_redundant_if_statement3.cocci
=E2=80=A6
real    0m17,970s
user    0m17,754s
sys     0m0,080s



> @specific_deletion@
> identifier var;
> statement s;
> @@
> ( if (var !=3D VDO_SUCCESS)
>      return var;
> & s
> )
>  ... when !=3D var
> - s
>
>
> Another test result:

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch d=
rivers/md/dm-vdo/slab-depot.c =E2=80=A6/Projekte/Coccinelle/janitor/delete=
_redundant_if_statement4.cocci
=E2=80=A6
real    0m13,992s
user    0m13,348s
sys     0m0,071s


Which recent commits did improve the software situation for this issue?

Regards,
Markus
