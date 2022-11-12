Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AE1C4332F
	for <cocci@archiver.kernel.org>; Sat, 12 Nov 2022 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t7zcFjwLX8TP6DjGCpLhhsDg3w7R0+MQPNkMNDKKDBA=;
  b=CvB4jSIxIz74tzf5zTD/DMFNGe9CMHGJ9ZsQCY58fF09+wSv38F85ExB
   BGtU1UUO1HhuPGwgwRMM/qfcrpeUt19tPtdRMJ+l4lnn7gbwmevKrT9Pq
   o8r9M8Kt+dm1iZzOtaTc3YjZZu13g8I4Eio2Dv3n4WVgh6wj4jpMGmYFo
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="77851431"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2022 10:42:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7DE03E039C; Sat, 12 Nov 2022 10:42:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B1E2E0092
	for <cocci@sympa.inria.fr>; Sat, 12 Nov 2022 10:42:28 +0100 (CET)
IronPort-SDR: 636f6a83_151pPxa+uNwYKkZE7sFk+Pyw6Pz34MAg3H2WzGgFx1hIH9t
 L2qYPAXyErdPNcrmeKOygXc+IY/R83uXUDKWLsA==
X-IPAS-Result: =?us-ascii?q?A0EpAwAoaW9jhwMP49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIsgQVTLgQLRYRPkGwxhCmHIIcwiGGDVA8BAwENQQECBAEBAwSCC4JzAoR8A?=
 =?us-ascii?q?h0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZC?=
 =?us-ascii?q?RcHDhAFIoVoDYI1In2BCAEBAQEBAQEBAQEBAQEBAQEBAQEWAkdTPQECAgEjH?=
 =?us-ascii?q?QEBEScECwsODAImAgJXBgEMCAEBgnmCbgEDDSMHqziBMoEBgggBAQaCYZklH?=
 =?us-ascii?q?ywiU4FeCYEULAGMXwmEJycQgVVEgTyCUzA+hESDV4JnjnWIaiYEDgMZKx1AA?=
 =?us-ascii?q?gELbQMKShsxJw4JHxwKBBcNBQYSAyBsBQo3DygvZyscGweBDCooFQMEBAMCB?=
 =?us-ascii?q?hMDIgINKTEUBCkSDSsnbwkCAyJlBQMDBCgsAwkhHwcWESQ8B1Y6AQQDAhAgO?=
 =?us-ascii?q?AYDCQMCJFRzAi4RFQUDCxUlCAVKBAg5BQZTEgIKEQMSDwYmRQ5IPjkWBid0D?=
 =?us-ascii?q?g4UA16BaQQ1Zp01NcUnNAeCH4FMgU0MnmYGEy6DZZMJDgaSFJc0IKdYgXgkg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIAwNCYQDiixANDsCBwEKAQEDCYVHAQGFKwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:Z09yXK0kGNCdcu0ILXZ7HQqjBGwkLtp133Aq2lEZdPUnSL39qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFgrX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="39558763"
X-MGA-submission: =?us-ascii?q?MDEeLPckcC/rK0UCQs6yBYpt4UyfOxfssNJS5x?=
 =?us-ascii?q?xz8xGBRTpT+7lf3NZmZiT5p/MZ5rSdtK1apR9RcT/EB3f22cQL8ucZ8C?=
 =?us-ascii?q?WqWHdYC7Kx+JB/mf+Ag7sLRIdyKKtlRphOCnFvRnCFLrKzQMWNLbmHMY?=
 =?us-ascii?q?znxms2YWDa+s37/rMIbaGKEg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 10:42:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668246145; bh=t7zcFjwLX8TP6DjGCpLhhsDg3w7R0+MQPNkMNDKKDBA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=QYZ+I5KrLUJZggnt/sRzfnLw+2LH/CxZHgY3SfGiBNqBRWJtDhxQhY0O09cpUawtx
	 0VBWqpw9hWzaq9qBHxx3f0pFE8/TI1pugCwKCHPYNVlXMTww2cuHbpzKC8x89/Neqk
	 eYnLrv5RttvVF8npB4r4QPpTjUCksy4epIDKz1aflS+P7FTRdlrwNNv+rAFRP33ouT
	 rZy1m5xS6ptXSJ3Xl/0Zj9TclCRxgqGNYUi0GMUEnmqRAuw+0RLK99je+7D4OqfD2+
	 fcOMnSRnjwtmkrAmfLTChdlAIDkL7RQtjeQ66Jf93xVR79FnwvQGU6Du1NXiHgIHKQ
	 vo/YV3P5Sn8Fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1oakk82t1x-00J4MS; Sat, 12
 Nov 2022 10:42:25 +0100
Message-ID: <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
Date: Sat, 12 Nov 2022 10:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: Markus Elfring <Markus.Elfring@web.de>
To: Elia Pinto <gitter.spiros@gmail.com>, cocci@inria.fr
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
Content-Language: en-GB
In-Reply-To: <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QtwNFsVCNkbxhbqnjwShc9L1s8lZDv27ko/c6Xo/wYihn5yLAyU
 EwAdYllBuSQUf0qYf11BwStTHTIl41xBh+8Y/QfWdA7lN7QknSkLziws0Db7bmTlLj78j9R
 g2oVKalCQiYMy5A+OuWKQzHiJaErb+uMvJBrlqcTT2E2o7rjfWgypBvJHc8KbSGQHhzsQSK
 4McR+6WD3Mlv61h/VTNXg==
UI-OutboundReport: notjunk:1;M01:P0:Bt/IbjI38XQ=;nh6J0yizo/9gy/yjixgGQUyCbUV
 cVPGHtXxy6Bv2AuNAt2zIEvP4d9hpmLMwAg6oXeNi161+pwTQllpOomONHq53dQvo1AW8oJ33
 2/TB6l+Q9ryeheP4/Xm0OQPjtzJUpvrpnIQ3k6rDAkyRYMLTx5lTwzj1KKpY+rOe2pr9vgNpz
 nuCZa3q1/QiMHbAbEgN1RY219daAUdTyBvvxriBoaDl9RhSxWO/VT/l7l4tPtMZ0MWi32o261
 JO6f+6UueOHHGDlETXIHgqngVYduyoJYMDGlt0CE4M3A4ulx2e2e9zz4DoRkRqLe44Bx30TSE
 x6VHXnqMRJnK2rJ9VHa4YF/YuBtWq32dSXuhJUmI9IrpxIhmZrQ6sPALmVSa/God2pFCZYt33
 7xk8fIeagNpXAxQTX0DqYpPbfbBF+atBe88cy8BnSiQwoYY13Md4J8Spgmn9vodhJnB/ySFFd
 0OO7hTJTCAAJYg+5gFwSLzpVKcv71egrWoxm5jZAs0+gtgXDTuc1xlcGM9/8OaOsOPHPhc/c/
 3mVqajMnPRIEcOV8HJghKTNYUdSzklb4u5HiJzixzqSSdPtC2sf/NQuMWWjDnkmabOXd5rIlu
 AnfflCEhIeqzO21oiYEAoUyPZGbR1++IKNsl1/UEQr0whxqL+AoyFmMKZIbbew8DGpEXwVUAB
 upOJ89GJfOFxDBl+DcTti1SrD4TztBT+/hcywGOts+xohzDebQU2Q41TRK6giJVaC+kS1gTTp
 HGmxeLOFp0sb0SbxZY8/x/iG9CshgrJaz+F7g9j1RaUMjFKjl737Jo2T4Ca/wwMvB9UvkZmyU
 aZH2ZvIKhGD1lgad4Cq+jcNQit1EPoAu64T9HrcE1QVzlPYvbRd1sOnw4T03xT49jUvJavczi
 yb+l61lnXe/w5LO5mY2GM25qgrFLhJ/+HyQUtovWKVhzSYx6sL5JglMkuPm4lhevGl8PG8Ryl
 VU3WEw==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 735
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/b73dc7c1-d5ad-dd23-f559-7b73939ed710%40web.de>


> Is it a bug

Would you like to clarify a related bug report for the software combinatio=
n =E2=80=9CCoccinelle 1.1.1=E2=80=9D?

SmPL script:
@moving disable decl_init@
type t;
identifier x;
@@
-t x;
+t
=C2=A0x =3D 'x';

Source file example:
void my_test_for_declarators(void)
{
=C2=A0char o, *p;
=C2=A0o =3D 'x';
}

Another test result:

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch move_a_va=
riable_declaration-20221112.cocci test_for_declarators1.c
=E2=80=A6


Now I wonder why the expected diff output is not generated so far.

Should data like the following be presented?

-char o, *p;
+char *p;
-o =3D 'x';
+char o =3D 'x';


Regards,
Markus

