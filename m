Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E2C83F2C
	for <cocci@archiver.kernel.org>; Sun,  3 Sep 2023 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LX/POozcKwOft7oE5CkcykUVcthSYa54uI8EbyTd004=;
  b=aQVJY6k01KDBKqw2xoeT2k6cWbPFkCYaiXKkIZqaFWemJwGK+vI6+sU5
   WXOmgjiHIauF1SwfI7Ez11ylwsRFgoXyT3CGO9ec5nYmzvW0gYg3UT4ib
   gnQKphGcWik1bJ+kXxaGF05r/4j8Oyn0b6TrkiRPXUrmLer3qE9v+j7d9
   0=;
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
X-IronPort-AV: E=Sophos;i="6.02,224,1688421600"; 
   d="scan'208";a="124060632"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Sep 2023 10:34:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 532B2E0CCA; Sun,  3 Sep 2023 10:34:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 471F7E004E
	for <cocci@sympa.inria.fr>; Sun,  3 Sep 2023 10:34:52 +0200 (CEST)
IronPort-SDR: 64f4452b_giOSQxze/9SwzjjJ3f+nITXUPSBfvoCWnBm3BbWulqzzL02
 W0QY5D8jWGBf7sQC8v8IZhfNU81JsGYFEtML09A==
X-IPAS-Result: =?us-ascii?q?A0GyFgAeRPRkhwMP49RagQmBT4I3dgNTMAQLRwiESpEzM?=
 =?us-ascii?q?IQ8jn2KQ4FAPg8BAwENPQQBAgQBAQMEOIFTgnQChm4CHQcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjcpARFkg?=
 =?us-ascii?q?QgBAQEBAQEBAQEBAQEBAQEBAQEXAg06PwECAgEjBBkBAREmAQQLCxoCJgICV?=
 =?us-ascii?q?xsBAYJ6AYIpAQMOIwcNBqdCfzOBAYIJAQEGr1QfLCJVgV8DBoEXLYgIAYl/J?=
 =?us-ascii?q?w+BVUSBFSeCUzE+gksXAQECgV5Ngw6CZ4lhhUWGQYkbKoEICF6Baj0CDVQLC?=
 =?us-ascii?q?2WBFYJHAgIRJxMTBUVxGwMHA4ECECsHBDIbBwYJFxgVJQZRBC0kCRMSPgSBc?=
 =?us-ascii?q?YFTCoEGPxEOEYJHKzY2GUuCZgkVDDROdhArBBQYgRQEah8VHjcREhkNAwh2H?=
 =?us-ascii?q?QIRIzwDBQMENgoVDQshBVcDSAZMCwMCHAUDAwSBNgUPHwIQGgYOKgQOAxkrH?=
 =?us-ascii?q?UACAQttPTUJCxsGQAInoDtwgk6BQcZ4NAeCMYFdgV4MihWVCgYTL4NukykOB?=
 =?us-ascii?q?pI0mCyNYZpkgWM6gVwzGiSDNk8DGQ+OOYNeM49IPzULMAIHCwEBAwmFRgEBh?=
 =?us-ascii?q?gABAQ?=
IronPort-PHdr: A9a23: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
 CaA97aGRnm5n+PJxjc1CHJz
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:JmMrXa85JHMeCXTo3ftuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:lulex28s/23tWgadNY2Vv2MES/kdfXrx9Xf3AWGcWVhNTbmfWHbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3Aidemfw/rYNTa0wuSwHEAYVaQf+h3w5z3JHA0rbk?=
 =?us-ascii?q?DuO/HaiV/ABWi3B3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.02,224,1688421600"; 
   d="scan'208";a="64950168"
X-MGA-submission: =?us-ascii?q?MDFd2WvQwkIpUH4F9RTl+ZSfbca/mvlNHR5b2Q?=
 =?us-ascii?q?8RBvT9kheUZeOtoYfd2N6yAEbuTRL6Bj0t7OSVMdv6oO02QgootW6R09?=
 =?us-ascii?q?kl5JjB4tX+puZFqyImD4CHxnvJLpHJPMVXkp7HzVreVlEs4gGI9feWtB?=
 =?us-ascii?q?9B1zUApg5bPfH3p6U4g1uAFA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 10:34:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693730075; x=1694334875; i=markus.elfring@web.de;
 bh=LX/POozcKwOft7oE5CkcykUVcthSYa54uI8EbyTd004=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=jn8Z1ano+Klw4ZkOHuurgWNabFbstsuKilfV0mW/Dj1RSoh74B3UrrvfCzuqdtF7cGdDsiV
 5ltloX0QZFJ/68oDJkLCozbJsVtB6kjMuilzOB6B1kmbXFTMD7OqwSH8VSW9IVtUzf+OV3RBZ
 qcxEEEg6QdbIDz5jUX8jMDazVAeLz2DTnyUTE/r7+zby8CQnnjviPmZfRcpsagM25dlfjxi/+
 DWx5bPur6NQKyj6GZLWfmXBaOC0CyBcWsUudVrDFpm5FWWdLDOiwAVnII26dc6q8vX0/E9Wza
 ymUEV72+0yOU1sG4z1bLn5SMcPghNq13OXJNFlyaJLN/bTsvqx9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1qNX5m1Es5-00KHqm; Sun, 03
 Sep 2023 10:34:35 +0200
Message-ID: <a9c2e240-eb0d-449c-ace2-d723a891500b@web.de>
Date: Sun, 3 Sep 2023 10:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr
References: <7e3fdd0f-e691-4ebd-9de9-4fbdb6ece973@web.de>
 <alpine.DEB.2.22.394.2309022008310.3175@hadrien>
 <205fad47-dbef-4cfe-885b-69a2a0d4b09b@web.de>
 <alpine.DEB.2.22.394.2309022032260.3175@hadrien>
 <1326a929-8a48-4113-981c-df6dc3220474@web.de>
 <alpine.DEB.2.22.394.2309022101230.3175@hadrien>
 <852c86a4-403b-49f5-b307-c47fcf6da68a@web.de>
Cc: Thomas Adam <thomas@fvwm.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <852c86a4-403b-49f5-b307-c47fcf6da68a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TeNzR7sbEM8hYYVmeZYzZgWhIWl5qeY73pnOdmr9CZxF13FKXCR
 +783eBT5mCLN7bU3/4bNm/t2CtxK2z8OozXNSsbclIC+gmg8tgRcYr+m4oK3GK3Bs+/Uxp9
 7aQ5V8lpafEaFC/+LgZddL86rO+kW+pjv0gR34DlO9LRgWTTj1juo5+VLVe10u1tQsKBMMG
 6VwuPasMZB03kxTOUgkvA==
UI-OutboundReport: notjunk:1;M01:P0:qVieWc72AGg=;qS2mlJB9nE6W9QfTW+r+O4w4B3v
 knwtjPRfL3FxfkpTkgIW8oo4ZPg3FKw6WF/vwA2v/6lYHbqlQXia1WZ9uAmZXdXmXzShxoeMo
 +ifhu9QigtMOxac7lpvlLiwmZuA/nvhu4JAMx4FlE4NLiexxYtwVa4HIiqcqbdWzuPVDh3R7N
 cmdWN0K49+a1VPnwnoASlTSPm1wzsl3/tvRGMhusnrii4WyYI0wLqtV5NeK4iIOd8u46SzEPJ
 Jw6lFUe19BR5GEtVtazSYP0CGWWa7IRE6hWeTz/wCapcQJpfX7eaLwe5/Bz4tpKRNA//jN0Pn
 Z/thvlUg1qfRnPQWdF51DI9CPDASCL7494fYmfISnbiNXj2wN13SBJ7Cfcv9rNm49ns4DZ3pL
 5wdVJMaz0vwnYsEso4Rg+l7ByqYS/94AkM2kqEIzE0YRv6vobuhYj6mq3UNPXWrfZP9hBLSpp
 2yQ7m1b7ldhjp0tJ380MV40xp1jwA0fLRn+XYKm1DuFC9TcAuXrddo7z/FvZx27Gww5o9alPd
 JFBEKjwrcSHBE9ZmUwRONSuyfGxqCa4+oXRCPDzsckQa83IFY9hXbasFmkhAsqWlq2IBx6LdJ
 eVClyzlFZkvh86BRJtj9/EqMfVjZerLC2Zk1ij0U35VZdV0027QHhdxDop8YOM8rrSw98KHjY
 FLM0cRFrA/sbV4kiPCBegpi26CrHHhbzQIl1Iunu/I8WxloONPS5EI1WbdqVuF65sCpxCAiOo
 K3eYXIR2OB2+jXHXwVHGfjBrF6IANWGRafZYD3+OTZNerKB4hmloSird0Dtl/vztcsPB5qfvT
 +ouKThRWeGeURvOQtHCINj+D5y4X6j5w5BFmHDBf9Ar/DAT2yrTs+FQHBYPAp4po8FSUoeUL2
 FqWNPaRd3wNgC9VO8OJwbty3Y4jl5fgcjZfPxxSjoM4WvRxgFZk5APmT1cQVLs0JEgp91MA9f
 0E7s2g==
Subject: Re: [cocci] Checking an analysis approach for the avoidance of
 duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1237
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-09/a9c2e240-eb0d-449c-ace2-d723a891500b%40web.de>

> How will the chances evolve for the clarification of the test result
> that the following SmPL script variant does also not find known source c=
ode?
>
> https://github.com/fvwmorg/fvwm3/blob/c9d00184ac3ab534e0f0ba5683106879a3=
5857f6/fvwm/colorset.c#L955-L975

@display@
statement s1, s2;
@@
*if (tint !=3D NULL)
*{
* ...
* s1
* cs->tint =3D GetColor(tint);
* s2
*}
*else if (tint =3D=3D NULL)
*{
* ...
* s1
* cs->tint =3D GetColor(black);
* s2
*}


Will any case distinctions be adjusted in the implementation of the Coccin=
elle software?

Regards,
Markus
