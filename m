Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E35C36002
	for <cocci@archiver.kernel.org>; Mon, 24 Mar 2025 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rEc55otJf7ICHqncJghVecmxsSzuMVTiFLZWCZNGMhU=;
  b=aTxlozJqll5tgEsjhU+X22R2UwU8QPML05SGLyhF8LEwoSuxQX4up8st
   eWNcyxc4TcPy1ZR2evhXa86COJ1+p9deZdCUjtrnbN4UP2qRNWgw/Zr7x
   en0PpoGKYjVwv6h8TXXK2CsV19QcymDO5xOt75paTsJGNMj3yirYiNsY6
   s=;
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
X-IronPort-AV: E=Sophos;i="6.14,272,1736809200"; 
   d="scan'208";a="214444031"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2025 13:30:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40C73E0261; Mon, 24 Mar 2025 13:30:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BA51AE007A
	for <cocci@sympa.inria.fr>; Mon, 24 Mar 2025 13:30:30 +0100 (CET)
IronPort-SDR: 67e15066_30Ypnrtb9zmXsFcqoUvgp2KjrB7+/mPzfgqPvON1XCVx7Ao
 vbhGlyT+UMALupgFJ3ziDKRLFin2HN0nQenQu/g==
X-IPAS-Result: =?us-ascii?q?A0E8AACeT+FngAQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDfVozBAtIBIRSj1GBdC0DhDuTfYVcgX4PAQMBDT0EA?=
 =?us-ascii?q?QIEAQEDBDiBVIJ0AosjAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINOkQCA?=
 =?us-ascii?q?QMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ9AQGCLwEDMQcNrXx/M4EBggwBA?=
 =?us-ascii?q?QbaXB8sIleBZQMGgRouAYVsgmMBhWyDfXonD4FVRIE8C4EJgi2IHoJpgjOBa?=
 =?us-ascii?q?oNAgWyKShwtgiWbNIFNHANZLAFVExcLBwWBOTMDKjQxFhwWfUM4gkRpSToCD?=
 =?us-ascii?q?QI1ghskWIIoagQFg1mEPoRAgkFPgkCCEXCBFIIwhUqBMoRdLU+CRh1AAgELb?=
 =?us-ascii?q?T03BgMLGwY9o0cBOoNQcgEBUjsBKyAmggTGFTQHgjiBZoFjDIoplTUGEy+EA?=
 =?us-ascii?q?5NDDgYykksuh2WQayKLaoF5my6BbQEzEIFMMxokT4JnTwMZD44hhC2EYLs/Q?=
 =?us-ascii?q?jUCAQEBNwIHAQoBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 /Qg3r7ya4geZNST5g==
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:/KLBVas5QkGuvtNQYtKTx0hH7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:8RXIiGwwLiNDZLo/iAGKBgURHsYkU1nk/UzOLnWqWFdyE7esTHafrfY=
X-Talos-MUID: 9a23:1Z/CxQUMYVfex0Hq/Dzpoy5wOddl2OPwBUQHjYhFg/CvdgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,272,1736809200"; 
   d="scan'208";a="112436666"
X-MGA-submission: =?us-ascii?q?MDH4SDj/4tfrTLRg5x+XRsGrz6JrPkm/E8huOl?=
 =?us-ascii?q?IqHns52y+KeCYXB9SzZRcmlwMEHpAaci5lso3XNhFpyKorgCN9CfAVKC?=
 =?us-ascii?q?UMd/wsuboAcSyHhSbH6LbeLIzdbCCo5pL7hqHBGMWygcmQ1Z1vuIGsvm?=
 =?us-ascii?q?ouSq45qRHzypYUWWo4DRgg5Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 13:30:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742819426; x=1743424226; i=markus.elfring@web.de;
	bh=rEc55otJf7ICHqncJghVecmxsSzuMVTiFLZWCZNGMhU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dOZUti1mOauygq02eBbZVYKvluyQZkNV411tWE/zylGK3jVjNS3xBo2CgSMcaekE
	 lacXA0kOSvpPNJ9lBt/WqD40/Fair9hngzFZ111XUuFNdosvC+DJ8nhDtkDlOiRFX
	 FUl/kraIQ2VrojgN/euMb7emLq/Cvu80VKYiEEZWRKpTwju9bW/8WswvprT30r/CU
	 GJ5dIYqzOJRXz+WHP74K2a8Q4s3NNSoFIyH+HKcUjc4UcLOMck/8+I4RVyIHqszkU
	 ecfuk0QQqIoKzl7bpr+0DIJALw9w9iao0RvlaKwWEdpzP0Dwapxz9M0VwW8d1On8K
	 7OLObY2Cb8sdnm4UiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1tAcny3Y1b-00wEH6; Mon, 24
 Mar 2025 13:30:25 +0100
Message-ID: <40a0ddb2-a2dc-4637-a899-65b84065032b@web.de>
Date: Mon, 24 Mar 2025 13:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Winkler <tomas.winkler@intel.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYYaUm0Hjzq9rr1Prs6gbeOzoVeO8auNDeOvHd8eS/g88fO3NLT
 qlzYAcUnP+Hgyiql+tSUJwVAYj55QpbsYJ+YkMMV8nmAK3KGoUxaZe8hzWnLs4lcuONzfY3
 HVCzxlWFFU/YPOUXDhuv1YDkSEklurYIoX588pFhm6WoPFJtnLh9FEh4q32VpqNE2bS8nLY
 nbjKxNI5DbPhS1LVyP8Hg==
UI-OutboundReport: notjunk:1;M01:P0:ybipT1OztxQ=;1HSNSUDbDwk97whTFPLjzBeRR05
 TMm3V9CSwlbB/NQ04y1Ot/sTP1/bDKdeSDHfNh2lyw16Njdbl2b6WnZG/a9QPkfp0/nIkQf8S
 yQvMoiQG6GvO8W2pQ6f0/xqVdNV0mn+YErYFPtWfoyJwkF8MtcGur0AaAu9P4Xem4U7AgRt4/
 Ofv+rGMPKdSGuxRX4NzjmNVoakhJsgUX+Bn/HZ4CD7FyJN+HixJLOy/XKjis6QrTp5pp9mf3p
 7DOBaW4/7qPh/786ep94tpR6ooQuNe1KwYLBD+rJbeKtWU1XIoLwRDegTUV/ePEB5ScDlvGB2
 gm0gTYTVooJwsNQOZittHTPZViVqaups9123++7dzMAMkfzBO2UCkviJMj/6P+E51J+zVPCWl
 Xrim8o2feea/hiAvIOrmGthNT36bfe/PgAF5eCB+InXzOJrTUmOGUij3pAY4YUfPZANaytZY1
 N2m4grtdjcI368MzOW90PIGWRaT/q5Os7zXAdSS5PSN3HROApWaHyezaQCsX2yLWH1Qs16X7A
 5eg+UFvXAXSeUFKdSyR7tWw7fAtAfkDWRanyqF1dujbzD5zuDTwX78xUCpJApKMrHF+qEfoFQ
 +NpUBh6GbNDfLzF21O5+MoReycfzVeWNGNZD+P7s5LaZQ0P8UNS7np4Elq4e9otjdLpfdMRLJ
 3ViJev7ArNB1PyGUnHUD0K6W3GB8TjQKT+yIWuW9/s2xfSzlDQ9BFyYgN3JsQQLVK4PWfOGw6
 QvfblnKBEbzMykveAoBvS92PGDGRJTQQ8qn9mpQhAYGmjQ6Zv/jsPSQCaK/rvnFmKUBmfBy82
 PZ1IYVYjAU+7Q5rE4RKpOC/3h6zRBhps7D/i2Eh9GDQhHbkHdQmwDUE9seGnxKye3oeC6Kw1i
 NoOcNW1YNtxNyM6AAuEolGELyNQI3zNLKUbxi0oyuxs+LiBmGCV0yxc3DX9UBvUUQgBBf/H1I
 Hbt+SdPCLBMHIfJxenzfmICwwkWZ34Cj50QRvBqOgiUGc4/MeAm9i6waYc3M/6pxSxerPT/qz
 6htkPat1UD2im+ODB3zisBGUKW5TxKHwtdva9y1nJH1hDNXgwKSyPCrlRIEqsD6tt/w1SBBM7
 XCplEXHOzoT3EhmwPi1sETM8j4Vbl0cj/SmcoqOwujkY6hDbkkwUHAHjmjBzls1KVmtq1UHBG
 y+uppdySMXjTVubmqI1KX4FzVjYjxmZUnsOjMPY6m46anHvLm+U4Mu5qJzrsEJy2WzmmD60Mc
 /NCbE10b/a3ch4i7kKVnoVUr4uv+ZaKJRitObEapghTD7m7UKIir0h6zRJUGh4M9ykgUojEXB
 zg1/m4GJGo3AKmX0cc++OvoK5C7EBq3pxSkM7LSmLj3SFOmfxyM7Ob44IySaTRskLHKubwC3m
 Qe+MysPSJvMb4qNQdgb2qn3va1zskPIv2BErt4HvHjIM8cqXT+1NCXL6QkFEc4DVfIDKv9ME3
 7j03QZ0e0ovjHPFMWGlHkAIMI4WeZLkYsEnFaBeAu8ttmuBeiFoXPqVCDhu7l4lwFNKXfYg==
Subject: [cocci] [PATCH v3] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2678
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/40a0ddb2-a2dc-4637-a899-65b84065032b%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Mar 2025 13:05:12 +0100

The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cmei_cl_irq_read_=
msg=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer.

* Thus use an additional label instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V3:
The label selection was adjusted according to the naming preferences
of Alexander Usyskin.
https://lore.kernel.org/cocci/CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR=
11MB6366.namprd11.prod.outlook.com/

V2:
* The summary phrase was adjusted a bit.

* The Fixes tags were omitted.

* The change suggestion was rebased on source files of
  the software =E2=80=9CLinux next-20250228=E2=80=9D.


 drivers/misc/mei/interrupt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index b09b79fedaba..78a01b402ea4 100644
=2D-- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -116,11 +116,11 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	if (!cb) {
 		if (!mei_cl_is_fixed_address(cl)) {
 			cl_err(dev, cl, "pending read cb not found\n");
-			goto discard;
+			goto discard_nocb;
 		}
 		cb =3D mei_cl_alloc_cb(cl, mei_cl_mtu(cl), MEI_FOP_READ, cl->fp);
 		if (!cb)
-			goto discard;
+			goto discard_nocb;
 		list_add_tail(&cb->list, &cl->rd_pending);
 	}

@@ -236,8 +236,8 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	return 0;

 discard:
-	if (cb)
-		list_move_tail(&cb->list, cmpl_list);
+	list_move_tail(&cb->list, cmpl_list);
+discard_nocb:
 	mei_irq_discard_msg(dev, mei_hdr, length);
 	return 0;
 }
=2D-
2.49.0

