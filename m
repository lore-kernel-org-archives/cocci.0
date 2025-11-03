Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E9ACCF9F8
	for <cocci@archiver.kernel.org>; Mon,  3 Nov 2025 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FDFWRRpBPqjnFN4FdqMold9xa9YJ0i6+6AV+kyday3Y=;
  b=ZKqizqCJPKwzvbjJmNM2DgzkCJ2F6f7cViZ7flpnbUyjN5mHcfQuZklb
   EpIcxNYcJh3PUjf99Kd7OMzM+FVXs/2lX3+JqburgyekgYRolRirKQYEf
   I/evREaCdYRuU+ZC7tzjRxzY2kdSpX7CVtB98Lv1HGmqLjc5udYEukmLv
   M=;
X-CSE-ConnectionGUID: 4ASRF1/ZRtGbl63KmOapFA==
X-CSE-MsgGUID: TqxPu1b3QgCTfKsOWDamqA==
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
X-IronPort-AV: E=Sophos;i="6.19,275,1754949600"; 
   d="scan'208";a="247191824"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2025 07:34:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C023E0B0D; Mon,  3 Nov 2025 07:34:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E7F42E0171
	for <cocci@sympa.inria.fr>; Mon,  3 Nov 2025 07:34:01 +0100 (CET)
X-CSE-ConnectionGUID: k7rphM+AT9+IDPXB3uB3yw==
X-CSE-MsgGUID: fTu3mtMWQAij6w8tKI3fjQ==
IronPort-SDR: 69084cd3_3FKMm3qAk5zvKmWuXifm+Ot0jniqB5pfQ7kIs2Qra7e/m6v
 7/tEhZaVydTWPKChctos1FexwA7Ue7pKMxs3dSA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FkAACJSwhpewsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYI/ZR0GWDMEC0mEVYgchzaCIQOBE4MomAqBVYFAFicCDwEDAQ00G?=
 =?us-ascii?q?gECBAEBAwSCDIJ0AoxTAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBQg4KMYZPDYJbgSxeSAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARQCDQczJAEBHgEBAQIBIx0BAREmAQQLCxoCJgICVgcUAQGCfgGCIgEGE?=
 =?us-ascii?q?AEDDycHDQawaYEygQGCDAEBBoJp13YfLCJZgWQDBoEcLgGFbIJkAYYnhD0nD?=
 =?us-ascii?q?4FVRIEVJwuCQAcxPoJhAwGBXk2DDoJpgiaBDoYngiUDkDpSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSBDAyo0LSMPPAUtHYEkIh8YEWA9F0CDSRsGaA8GgRIZSQICAgUCQDqBa?=
 =?us-ascii?q?AYcBh8SAgMBAgI6Vw2BdwICBIIZfoIPD4lCAgELbT03CQsbBj2UTSyBVQl0e?=
 =?us-ascii?q?gkKASkCgTI6AShlowWiezQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBiKNZpVzh?=
 =?us-ascii?q?UaBaDqBXDMaJE+CZ08DGQ+OIQwWhBE3hCnGVEI1AjoCBwEKAQEDCYVGAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 AYUh6z1J8IfO9+js3E=
IronPort-Data: A9a23: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
 N0AgKXOxMk9sfl5nc3A3ene
IronPort-HdrOrdr: A9a23:JhjjN6DjEN2VImLlHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOgbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMqySMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A3yTlWWluwn9EkMceP+Pgzwe2C77XOX6C1m/QBgy?=
 =?us-ascii?q?RNTcqaZGteXXL5Yk/gtU7zg=3D=3D?=
X-Talos-MUID: 9a23:TcFCRwrOF/etQDTt6EAezz9eKZxt/4GRMWkMk8sZ69WnFHd+OQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,275,1754949600"; 
   d="scan'208";a="129692668"
X-MGA-submission: =?us-ascii?q?MDHRwxUJbZaD8P5DGeJ4XlIxrSGFAFJWhjjB1x?=
 =?us-ascii?q?nF6dOVeO2Na89eLstSYFygo8eJqIpOJ3h2Vjre2oup6CYa53CExPXT5F?=
 =?us-ascii?q?4UE2QUJdfoEet+eoG8bczI4OwB4QlwLvXpzWaEwd84nxlQQFWZTq0uj3?=
 =?us-ascii?q?cBkbmOXWr+EsoM8t43RCvP8g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:33:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762151633; x=1762756433; i=markus.elfring@web.de;
	bh=FDFWRRpBPqjnFN4FdqMold9xa9YJ0i6+6AV+kyday3Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TirsodcFIaLp2j3ckOOAx6ZxV1I+6AXnCrtHgLGNJcQu9fuSRCAJOStFJDIrJAXQ
	 XxiGCfd22pZLxKlA3Iw2qsfvoGI+X9eJW0/L827+jns3mD+6rmhMPln5rF8Vtw+Mm
	 LjW+in3pXvcraIUBZLZ+/RaXZLR1Li9Lg0JrFxy7EP8nunjA35H7gQjdocss7vTl8
	 5lnPhRbTYBf5eADessUmKDgKr2C1jVO7pTMnDXWrzhHzIX0+JSYPacgWJrk2Xad0P
	 AesLlbOU3AHcaEy3w/nKLPlkMwKamJlhWmwf7IwGAVDaRniie8CL4a9e/diKnBmVu
	 1aAnsEbYXugE54lOig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1wGKn42yvr-00sqTz; Mon, 03
 Nov 2025 07:33:53 +0100
Message-ID: <61ead92e-c65e-4872-843b-4a71b395d486@web.de>
Date: Mon, 3 Nov 2025 07:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <52e58416-d75f-4a47-9555-88a99d664069@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <52e58416-d75f-4a47-9555-88a99d664069@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3HphL8XTD+722qQpntcp9h0A43AU817vtHyiJ6jUJApesylpz6z
 SOxa48YTGark50m6GXwRY2m8smsvjGHAUzPg0rRuiYFoaM/1nq+Tj1WG1u3exUVlnovN4c8
 N+S8kBsIlYiGtV2PXeEjIM+y5bDfDpjan0Dt8JsLQLAxtVV/YtLypJpmxuLyeAJQJyevBSW
 8J7qAKsKQ/bpkppqPTx8Q==
UI-OutboundReport: notjunk:1;M01:P0:shHsGJftLUI=;7V+T4VIQfUEOthUYkHQalxFxTdG
 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
Subject: Re: [cocci] [RFC] Detecting missing null pointer checks after
 memory allocations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3136
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/61ead92e-c65e-4872-843b-4a71b395d486%40web.de>

> I got into the mood to try another simple source code search out which
> can be achieved also by the means of the semantic patch language.

I would like to present further data processing approaches accordingly.
The application of a tiny function name selection was demonstrated
by an SmPL disjunction (which can be extended on demand).
Additional techniques can become more helpful for advanced code reviews.

* Further preparations would be needed in software infrastructures (ACID p=
roperties)
  if you would like to benefit more from parallel data processing here.

* It might be easier for a while to stick to a serial data processing appr=
oach
  like the following.


@initialize:python@
@@
import sys
records =3D []

def store_data(id, places):
   """Add data to an internal list."""
   for place in places:
      records.append((id, place.current_element, place.file, place.line, s=
tr(int(place.column) + 1)))

@searching@
expression size, source, target;
identifier action;
position pos;
@@
 target =3D action@pos(...);
 memcpy(target, source, size);

@script:python collection@
id << searching.action;
place << searching.pos;
@@
store_data(id, place)

@finalize:python@
@@
if records:
   delimiter =3D "|"
   sys.stdout.write(delimiter.join(["action", '"function name"', '"source =
file"', "line", "column"]) + "\n")

   for record in records:
      sys.stdout.write(delimiter.join(record) + "\n")
else:
   sys.stderr.write("No result for this analysis!\n")



A text file can accordingly be generated by the Coccinelle software. It ca=
n be
imported into a spreadsheet application. A Pivot table can be constructed =
then.

Would you become interested to take another look at the 71 called actions
(from 121 source files of the software =E2=80=9CLinux next-20251031=E2=80=
=9D) if they would need
the check for a failure predicate before copying data to affected memory a=
reas?
https://cwe.mitre.org/data/definitions/252.html

Under which circumstances will error detection and corresponding exception
handling be completed?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers#EXP34C.Donotdereferencenullpointers-AutomatedDetection

Regards,
Markus
