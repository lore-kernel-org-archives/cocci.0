Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE08ECCF9E0
	for <cocci@archiver.kernel.org>; Fri, 24 Oct 2025 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vNk4BEJ1+zFzKlaGEgfvk/WG2mIJ7jZxQwicVPpfcmc=;
  b=c5Yxg7/10eK/8Mij3Pmb8FpXme2AI/Q/QJ1rdeTKgRRBgJQW95bbCs7q
   gCvMQVCIZNDdxZiGjniP4PUj/89RwtCHUcoa4LQFF+qZh1xic6DB79Y7u
   0SrqZMRCRGOhoNjChlMQelgW9qPKoajpGZhoz/cOFDbI2ygIMZ4tqUvQn
   U=;
X-CSE-ConnectionGUID: /VxC+GwLSdChSD2cuz6iSg==
X-CSE-MsgGUID: QyEZ6LRbQw2OQisPkmqzoA==
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
X-IronPort-AV: E=Sophos;i="6.19,252,1754949600"; 
   d="scan'208";a="246089304"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2025 19:03:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0429EE0264; Fri, 24 Oct 2025 19:03:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C0C50E0171
	for <cocci@sympa.inria.fr>; Fri, 24 Oct 2025 19:03:12 +0200 (CEST)
X-CSE-ConnectionGUID: UvcruAo+Rx+YFYDOlEXbWQ==
X-CSE-MsgGUID: 1TCUsacnRQ2ryRKdmSM3Cg==
IronPort-SDR: 68fbb150_ccKMjv2rz5BKy68UF53Zk4EJYw+h486bo/ctka8gKIT5fXL
 SbxOfQwH85dur2ns4fGFCUOdFg1o/Kl2VRUavsQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HGAADRr/togAQP49RaHQEBAQEJARIBBQUBQIE+BgELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRVj1KGX4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIIMj0QCH?=
 =?us-ascii?q?gcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7B?=
 =?us-ascii?q?w4KMYYgLw2CW4EsgSYBAQEBAQEBAQEBAQEdAkdnBh0BAREnNAImAnMBAYJ+g?=
 =?us-ascii?q?iMBBhABAzYHsAWBMoEBggwBAQaCadd2HywiWYFkCYEcLgGFbIJKGgEFbooYD?=
 =?us-ascii?q?4FVRIE8glKBfoQBgw6CaYImgQ6GKZIXgUocA1ksAVUTFwsHBYFjA4ELbjIdg?=
 =?us-ascii?q?SdBGHM9V4NJIWgPBoESg1OJRw+IAgIBC209NwkLGwY9lAaDeROWJZAGons0B?=
 =?us-ascii?q?4I4gWcFgV8MiQiWZAYTL5dSDgaTBZkGo2iFWYFvBC+BXDMaJIM2TwMZD414A?=
 =?us-ascii?q?SiEM8MaQTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 jAuvKf0NSsE7N/eu8cRVZC8FQ==
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:3U7eK6BdnqT5PgflHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AZQh6NmtAmDPDugWjnpHEDVvD6IsYbHbH0V7XYHW?=
 =?us-ascii?q?oSldHeZGyTXKg8pxdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A2AWcrQ90MMzyuFyRcXlZaJSQf55UyJm1AUsLq6x?=
 =?us-ascii?q?codi+FiB1ABLGpzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,252,1754949600"; 
   d="scan'208";a="129091468"
X-MGA-submission: =?us-ascii?q?MDEC0xuFykWq59Fsex9NZTc+Cezt3G1iFJimW+?=
 =?us-ascii?q?mILZDd+P0yS4FgxJoNJVE1SetlBiodTw0AZJIuHBkvdXslhSEu3uB0Iu?=
 =?us-ascii?q?GV4NdZM91XCK+N1HegPRH4PYsaExmu9vj1RQhUDDHs6PN1XgAvIN8Wfa?=
 =?us-ascii?q?eqSql2y7slKcM1bvvE+SRBDg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 19:03:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761325390; x=1761930190; i=markus.elfring@web.de;
	bh=vNk4BEJ1+zFzKlaGEgfvk/WG2mIJ7jZxQwicVPpfcmc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hd7w7yS8XZI3n+2ACo3Z5MRExuJ1yPJeOT8hh90o/AiG7u5SIMJ5AGnh1SIiJgaf
	 cMJBZJr96iRRZvrToQARma1n1rXm26eKFd0OrhJGrQcXXmVyhVIPWVg+YifdVZox3
	 Lqha9EmUzx877dOMgz6cb4hNdMmtYLcn4i05keCO2lC3Au8vEM6Pl2Nb24Z2J2F9K
	 FZM60sMWNN4k0a27jVOEVX7l14pwN+2pptWBJr6oldvcD4Lw+ZBdAT/KqJduP4X1E
	 6yzgMKzkRMwj8/WcW0LzewjVgrQrzXrV6dbxsp9mTZGIMQZGskTLNzJ4nJqCaa7+A
	 A/jXQAplwsZ8Dx+MBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.198]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1ue6u22u72-00nPYg for
 <cocci@inria.fr>; Fri, 24 Oct 2025 19:03:10 +0200
Message-ID: <78fb5154-dd7e-4d8c-918d-ce2f606334aa@web.de>
Date: Fri, 24 Oct 2025 19:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xObxCUBQDFg0GZY0fnah4u7HMaPtFVu8fbh6rUnn62p9Mw0ru7
 ifK2PjR/7fz9nCZ1dtUPXvb4dZw7bkB26cjYwhRGvGgML9GOWwI34x5rovoiPz6cjIM6X9S
 APIaTJdkY6KPeejxl/hFMS1/GDGFp3OeGNJI3s2M3D0Dq/9nvMw7gV9YMKvivoe7KaVaYLU
 wAjNOtjnTx1Tc233yiSuw==
UI-OutboundReport: notjunk:1;M01:P0:GxbR3XL5Xjs=;wEZJuIOxwmsddl58inp6FvXoO3E
 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
 zpXhwfbGBiUfHaiSN/xrXAVWd7IGAyLRX70=
Subject: [cocci] Checking another special test call for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3095
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/78fb5154-dd7e-4d8c-918d-ce2f606334aa%40web.de>

Hello,

I would appreciate if another source code transformation can be achieved
also by the means of the semantic patch language.
Thus I tried the following SmPL script variant out.

@display@
attribute name ABC;
@@
*ABC abc(xyz);


Unfortunately, I was disturbed by the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci show_special_test_call-20251024.cocci
=E2=80=A6
minus: parse error:=20
  File "show_special_test_call-20251024.cocci", line 4, column 5, charpos =
=3D 38
  around =3D 'abc',
  whole content =3D *ABC abc(xyz);


Under which circumstances will such data processing become better supporte=
d?

Regards,
Markus
