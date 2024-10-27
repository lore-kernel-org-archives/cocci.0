Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67BCD13578
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6pvTpi779ja59y3DZgEv+5wbSaoh/9Cy7JGl3BYO+hE=;
  b=WcdwZcbmWVIUEpRMx91SWew1Qf5txy5x/r8BmozYMl8wlwb+wz5hOlyw
   /+8rkiQ/KmDxQ6vFdSkNWRiSJey3lleR/sZdEaHogXAU5batmwqTmcQuH
   yFjVNDDnfXwupe/7io9DEBZTSvvvWF58uqZx7i+eVMx0slOorrJCVA2JO
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190933224"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 19:11:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26758E0D1C; Sun, 27 Oct 2024 19:11:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8ED2EE00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 19:11:38 +0100 (CET)
IronPort-SDR: 671e825a_oNg21b5DgKEV8onz3m58bOTHsKTxjMmdNCZUh9mZ2T+Nm87
 /beLL8KYCZWR5l7CUB31tlnWROgG1Yu+F0Y4Mqw==
X-IPAS-Result: =?us-ascii?q?A0E9AADEgB5n/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB1t1MwQLSIRWiB2HMIF0MIQ7hzqHVYpLgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEggyCdAKKJwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAoEKCAuFNUYNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEPCxoCJgICVgYVAQGCfYIwAQMOIwevRoEygQGCDAEBBtpbHywiV4FjCYEaL?=
 =?us-ascii?q?gGFaYJiAYpgFxAPgVVEgTyDAz6EQ4NbgmmCVYgCiDlokUNSexwDWTIBVRMXC?=
 =?us-ascii?q?wcFgSsmLgOFSX+BO4FTAYMsSoNHgWE4SYJNaUs6Ag0CNoIkfYJQgSUEBYM6g?=
 =?us-ascii?q?jYdQAIBC209NQkLGwY9nBeFf8ZZNAeCOIFlgWMMn1UGEy+DcQGTTQ4GkniYd?=
 =?us-ascii?q?6khgWc9gVkzGiSDNlILDg+OIYQtzBJCNTsCBwEKAQEDCYVGAQGLMYFLAQE?=
IronPort-PHdr: A9a23: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
 iVgNVxApPuc4HEA6h2QM3NM5DxpILvd8xs=
IronPort-Data: A9a23:eiN3Kawg+e9vxyZEqJ56t+cgxyrEfRIJ4+MujC+fZmUNrF6WrkVSy
 mNJXW6GM/rfZmrzfd9+b4i//UoB7MTWydQ1SVBpqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmcc3l48sfrZ9Eo35quq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFO2wOlwEH8ZPrcZuflWBUpQ7
 u4heSIkO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyVo4YBtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QJ8APO/vBtuwA/yiRV0bjUAuSNdufTWM5Os2fCq
 ECF5mX2V0Ry2Nu3jGDtHmiXruTIlij6cJkDEaWxsP9smlyagGIJYCD6TnO+puSlzFGzUZRTJ
 iT45xYTkET7z2TzJvGVYvFyiCfsUrM0ArK8z8VSBMCxJqvoD8KxA28ZUnheZdZguMJeqfnGE
 LOWt4uBONCtmOT9pbGhGnO8sj64fyQYRYPHTTFRVhMLurEPv6lq5i8ijb9f/GqdkdD/Xz39q
 9xPQO7SmJ1L5fM2O26HEZwrTt5iSlUljuL42+kPYl+Y0w==
IronPort-HdrOrdr: A9a23:WwCMfKhZZ1yaG49E5chviGD5IXBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:Pmq6OWFGDLx7u9EkqmI991IKBv4KcUfcj2jxJ2SmEnRQGa+8HAo=
X-Talos-MUID: 9a23:AivhVQVVsaxjWezq/BvthAhQCp9k2P2zA1sgsM8ImYqdNCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190933220"
X-MGA-submission: =?us-ascii?q?MDEy0ENX6mDkyMsrC0h5EMAf9jdVwzhM98QbxP?=
 =?us-ascii?q?FBYdHyb9W9vap7Torz7HaxP/sU9RefvvH+uPTRkqKG80cqOZQAF7+Ebq?=
 =?us-ascii?q?eBUK6Wa8ILEgZUjTK/VygIE6weEIUxHD/O32GbUC/ubPs7Rpw3gOOZEu?=
 =?us-ascii?q?SFjoX6VwLFAQ4czm2D5A+meA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:11:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730052687; x=1730657487; i=markus.elfring@web.de;
	bh=6pvTpi779ja59y3DZgEv+5wbSaoh/9Cy7JGl3BYO+hE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uc+rywNL3ow9XxTGV8h5PICKN8U9LE1MZg3lb7Kv9sEyARDUN+o5M3quHZc1IzNh
	 XJDdUig7GEzOWb2HN+pulviRWuZtYiTelNPOzrF7ZAqvTiWtw3HEpG8jwMjGJHNlz
	 FUepoGHIi6stob+z1dWpKxowJirWIFxk0G03LzPJ3RSSACSRJvOnpNvCRHXYA68UR
	 M0IPuuZgLfLcVb1BZY3VFqpkDpvri00s47C8Ah24cIXMZMIle0oA3PnIFnSTUY3IB
	 saNJj9A3yf0TP+0Q6zeCfTLu1SWxmjU6KVWOswfBhyEV6aX8ZPvXW8uIa25xxqfDY
	 RXKD6rHY1Wq6638nLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1t60oq2A4l-0012T6; Sun, 27
 Oct 2024 19:11:27 +0100
Message-ID: <0120fa8e-3e7f-438b-864a-f2e3538c465b@web.de>
Date: Sun, 27 Oct 2024 19:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
 <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
 <alpine.DEB.2.22.394.2410271833310.3498@hadrien>
 <f63293b2-94a8-4c2e-933c-5b2f94f64bb2@web.de>
 <b776e513-b4f4-464a-a4fb-81a441e70e10@knosof.co.uk>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b776e513-b4f4-464a-a4fb-81a441e70e10@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M9W3VAH0W/f4R/e/cvV0qx5deg2UhElU4CJHk0/id1pzQEtkPmm
 kLKUcbQkEaIzitW2dqmk51Q6ZO2vL1NTYGc5zIcUPwhcidYtMXiF0cpV3PtKV7WSRzKxe/X
 vmQp/4Tvgmne3PJrestgCn45dv56Ly2Db1+MnTpl/ZZIk9bekG9BUBLiyfqpipU4D5PG7fu
 5sdXebSXpE/a96cQ0rJ9w==
UI-OutboundReport: notjunk:1;M01:P0:VIsgKKQOuvE=;BOvOquTYwmD4PaK7gJWNqc2Btkj
 nv7lazI4UXt6pW9VFQ9348yX1ps+zmTYeV7Q8wNK+bXoAPnH0b8W44hur+7GBxYsvdB30fhw3
 XZKQppQjBtTBUIjZlrwG7ipSDJCmU4yEYedQF5kFy0BAXu0FBVh54yofXeUiDjKjgUdf7VA+V
 y0GxGt6l5x7nvKUUgAWTAqap6/d+Inas6XCoUDT58U8xe9eiT9RLd3LxRpaaOdi9Oi9xTwGPB
 4Rqy2Et7Xa0KZP3TtmZoGArYwYDfLE/iNPD69GLhcNmZQ4yvuReT6DLQAj67qGtF0QaLi2ezT
 qdJ3XYHERPJLfVg0h8EWO6yOmnoa81Pvisz8icoqjxDaNAhthB1w3rGgmJ6dF04wlMrDYc26/
 h2yfbLZzqCwMy13GOYTp6p1LJC5WWEyLYdbN0xd3Y00EVLMPwPJ5EDE5ksc5bOZYU9Gsd+ugr
 KxtP4fpyuo8NfHuMjWH+0KjvNZM15shxcOUWyqiY3/Sp3r5AgbnLoqxzLkwQXcugi7fCmE0CZ
 0ob0oDJ5qrSO/tP2T0k3Je/10Sbmd0ijBl3OXJlT95Jr9zfepSrjeKPwyNFQoZHadvgP4rORd
 LGhkxyUJasO8O3GnAOpEr0f4aVIlvtwVmiOdrob1ceHAK+6o4VCtLtaHD804qsImkDLH+qhxp
 I+YLH5poMoikS9bhG2iq3ArPZH6cRVZDP/wdqXsSS7/KcpQ93KpB7bheBHY88/p717smOVoNi
 8LgrA4QA5CdCRBgixrecFniI2jRgBceVq5KTx0yF27W4FLCA+nr7GiXC9KlNb2QZ+QQg1F6i7
 0OJRwvalIgOyPOIqwlubiiIA==
Subject: Re: [cocci] Evolving experiences from evidence-based software
 engineering
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1954
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/0120fa8e-3e7f-438b-864a-f2e3538c465b%40web.de>

>> How helpful do you find the following information then?
>
> All these questions.=C2=A0 Have you finished reading my book already?
Yes.

Can this information source benefit any further from the running developme=
nt discussion?

Regards,
Markus
