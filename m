Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF80C27C47
	for <cocci@archiver.kernel.org>; Sat, 28 Oct 2023 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HJmgT59GiR6OzMSwui0eYovEJvdwenv9Y8hrHxeFg34=;
  b=GX3LjFUNboBTh3fZArkfBuUO8KlkjIZWj69qdZ5coOXPH9QLw+GXzWhX
   AECVLqTXHUj1yM7gy7Gz0GdYIXXZaOleiVWAyllAJtDnoQuysfhmo1c8p
   Fml8l5/zv9bzfBMV1HE9fpghnL2VX2LAwA4/4y3pCN1svOYwoknwFvNFj
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="133680423"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2023 11:10:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C0F7E0205; Sat, 28 Oct 2023 11:10:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DBCA2E00B7
	for <cocci@sympa.inria.fr>; Sat, 28 Oct 2023 11:10:39 +0200 (CEST)
IronPort-SDR: 653cd00f_1l8X0siqBKZEPvUrMS8ema7jjxEoxwBxNOS9LaCR1QENykC
 3LbiZn2Zsv873H7dOW720YUP936ayiT2CLP/dWQ==
X-IPAS-Result: =?us-ascii?q?A0GKBABuzjxl/wQP49RaHgEBCxIMQIQIB4FJMAQLSIRTj?=
 =?us-ascii?q?zyCJYQ7hzSHSohvgxY+DwEDAQ1BAQIEAQEDBIILgnQChxsCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3KwERgQyBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBEScECwsaAh8HAgJXBgEUAQGCe?=
 =?us-ascii?q?oIqAQMOIweoLoEygQGCCQEBBq9UHywiVYFfCYEaLogKAYVRhDUnD4FVRIE8g?=
 =?us-ascii?q?lIxPogegmiDdZgqXiIFQnAbAwcDgQMQKwcELRsHBgkWGBUlBlEELSQJExI+B?=
 =?us-ascii?q?A2BWoFRCoEDPw8OEYJDKzY2GUuCWwkVDDRNdhAqBBQXgRIEah8VHjcREgUSD?=
 =?us-ascii?q?QMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGSgsDAhoFAwMEgTYFDR4CEBoGDScDA?=
 =?us-ascii?q?xlNAhAUAzsDAwYDCzEDMFdHDFkDbB82CTwLBAwfAhseDSksAjsEDgMZKx1AA?=
 =?us-ascii?q?gELbT01CQsbBj4CJ55agy+DOsRmNAeCMYFegV8MnyMGEy+DbhOMcoYqDgaSS?=
 =?us-ascii?q?R6YICCoMYF6JoFZMxokgzZPAxkPjiAMFhaDc49IPzU7AgcLAQEDCYVGAQGDW?=
 =?us-ascii?q?oIpAQE?=
IronPort-PHdr: A9a23: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
 fIz
IronPort-Data: A9a23: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
 Ik=
IronPort-HdrOrdr: A9a23:4TXoBK0PBxhgHBli4669fwqjBGwkLtp133Aq2lEZdPUnSL36qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A8RzD4GrYBtLybBm2kbNiW27mUZwUI0TM7mjhHx+?=
 =?us-ascii?q?xA10zd+WZcHqa3poxxg=3D=3D?=
X-Talos-MUID: 9a23:y2yt2wX9ZzVROcnq/AbFowBmKfxy2pmVDVlXjJRYgJCbBAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="133680417"
X-MGA-submission: =?us-ascii?q?MDFZppdOzXMs6nHce8c5NYYULZsqPdk5L5WsvM?=
 =?us-ascii?q?57XjBIk2JN4LiukqtsbQ2lPzJvrUqQJmRfKUDOKtPP2ZKOlLDJE+IlEk?=
 =?us-ascii?q?pSG6m46obDDmLyn98IDskc8ESU6GwckPXD6FMmGpaYVQPI+QB+94ttEi?=
 =?us-ascii?q?TKL8G4Y+CMNNh9eBgNAcZUXg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 11:10:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698484230; x=1699089030; i=markus.elfring@web.de;
	bh=z8U6GTK4Bn9Ah8tiTEhMcLUD2n015npAva5WCDuhyf0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=vFtIOT54m0cdZEWtbeas+9VAjZd5rW06wlZOgZEIgpDh9j2jgACyS8kNLAegU06U
	 JQ8dss7EvTRndHjTsuoKfqTHP+THyxMKGZKLXQlHLAGaLqfRGMws7mC96WkSyOCI0
	 OyONhhD3FYRQXNHDje4TpISZkCwq9Sv9WiRcVVligMJodIz4JJH+i2hhbGzWKMwL3
	 KN0vlPereA4nP7hTmIyz5qrnu2/mlwG5eVE8QgX/QERaNxg2wmT7DZzpgONLa5nuU
	 w/E1xLJrODl4fNX0M0eduCp75WQP4Gq9cvPnkr7nFUsL+2gD7GV/j4b+dAAUDHoDB
	 Clnu17iGzu+Wd3N28g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1rQlYu1T4o-00fltX; Sat, 28
 Oct 2023 11:10:30 +0200
Message-ID: <a14cd105-15fb-4ce9-b118-78fe0c67e553@web.de>
Date: Sat, 28 Oct 2023 11:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7f3e9676-0d1a-4fc2-83cb-8b77f6dd0a56@web.de>
 <alpine.DEB.2.22.394.2310281043270.3096@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2310281043270.3096@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YgZOTunu6deMC2FcTcAps+nhzog0XgvckYcw46ZcAriEkyEvIoC
 TcK7PrM1CDsO0m1cxHHiqTff0omtyUTPzjM2cl47uRXSA67oVb5MJIVo+oATOI+Dk3w3cmd
 3O9mxMEcIG03sj/apCrIK4zLJVv+K/o6h8Z/N4b1MFnD6wqEwr5yCGHsojPBaEOK72amCdA
 3AZZGXc/SLv6qAQsi1/xw==
UI-OutboundReport: notjunk:1;M01:P0:hsWpp6TVaOU=;hGyO3PLPKIEQt5GIVIiY+9jDBQv
 i2M/B2z6SolrEt8AS8EIMlEo1RJyXGo7OZYrpfXTN2a5L0vO9u7fkyGRoifeIGNKBG2n/IxbC
 4JBY8Y5wSjyNAHPAko6ocCs3/c0K/UGHdaqxN9pOG26lpOSMxCovlTOiWkzDpBayLEMEw0b1V
 B03cuUDaMNYltU/5mkSb1yeO/JxN6gJAUAl3o8xWO6N1WQ6dN0VqA300ENU++m/YakuJXxIuz
 PMzxz1eK24OutozyDsD1N6KRllz6UMEDiOLXMZY91/BPEhfqf7F9/Pgq5hQgbKZmsJhQIn0+p
 XMzZy3DKBPrMCsGvi+6clBD55SgC2uErWJz+/aNmp3EiypAmCX+5u4y+ZN5VSYJrDazxjlI5L
 va4Bhy8xthsaM2Ajg2WmxIcByjEbazep1OEKjmcex3RPt9VA2HdxFHd0gtQGcaskvJCEroBQm
 4XOfjTuuZUW3dNLtEX7j0M6lBmZNuMILwfGWqfX+fLnLPMUWMzoJcd1V7Ti9CeQgo7xL7Rk42
 MMw5ZChJLvEMLs5Ervnxy3vYEa7qInygs9KCJhNjOyZxTK4wbHAPrwZ7uiNL42xl8V07+/n+0
 813hyK1VnJadJjLbX+H6NLYgS7bFHBibLYWOguv7A1b0t+N+xViXERORbVdfxeEq6Yh1I0ZaS
 cxzGAmR3SGI4hf7pbILahPRHH99LqThMF592C1+rSrOM4i2sTKCwY/s/pKMDdWJbpgZyOEcfr
 L5jTm/NLI0KlrW756LhVTbvolmEUdQMwsVtTrtNDlEugrc5wqvX/bXIMYWQy9zhD1srVtaCgQ
 fg/Y9iRNx/PIVn+b8e62sYO5Zg0PM/GXz4dSByaLVhtZ16nuWchU9nz6oOu+fgcFg/vrE8m61
 g2AUrnvG+O+y0y49Bhx/YRE3oLvi2yR5zreuRXzZKtciROl1WnhI/D4qhFFbFGu+/67VHWsqf
 mR8luw==
Subject: Re: [cocci] Improving support for Coccinelle data formats with
 parse expression grammars (or Packrat)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1285
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/a14cd105-15fb-4ce9-b118-78fe0c67e553%40web.de>

>> Would you like to benefit more from it
>> (instead of using tools like ocamlyacc and Menhir)?
>
> Me personally no.  But if you would like to implement something and show
> that it is somehow better than the current implementation,

Did other developers and software researchers demonstrate already
that other parsing algorithms have got more desirable properties?


> them please go ahead.

I hope that further collateral evolution will happen.

Regards,
Markus
