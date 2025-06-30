Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3639FC8302D
	for <cocci@archiver.kernel.org>; Mon, 30 Jun 2025 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Pqv7gdEcDOnuCngHRUKjdGsaCl2tnYnGyELgA+NoRxE=;
  b=cWVgEJdS9CVgIEH/cRktv8HrSaM7dnMwyGHO5IuVtdzhDMPIJda91WPR
   GeEMsDDJn1wRVgxBiu2rnohM+oeKucUkAPzhPWjAV786IQPocmOugkoTJ
   Ngh6L8a3hqIxq6+2q6jLEiScMKJTqn9mRGrIvUQ5JpIo6CZmQwlrPcPeq
   4=;
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
X-IronPort-AV: E=Sophos;i="6.16,277,1744063200"; 
   d="scan'208";a="229556838"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jun 2025 11:24:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 393EAE0AF1; Mon, 30 Jun 2025 11:24:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2219BE0131
	for <cocci@sympa.inria.fr>; Mon, 30 Jun 2025 11:24:01 +0200 (CEST)
IronPort-SDR: 6862579d_CONjY5jKwJJ19FtpeDsBSkM0t/N8Ozt4FIFiewif4brbI6X
 rTbVyA8fp1CKfi9QlCaa98Y1LAwxtk/2iULd+xg==
X-IPAS-Result: =?us-ascii?q?A0FTDgBNV2JogwsR49RagQmEF4EGVDMEC0mEVY9QgXSEa?=
 =?us-ascii?q?4c8h1OId4NSAg8BAwENTgECBAEBAwSEdgEJAotyAh4HAQRHAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQE6Bw4KMYVBCDINgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAIBAyMdAQERJw8LGgImAgJWGwEBgn6CIgEGEAEDMgeyF?=
 =?us-ascii?q?oEygQGCDAEBBoJp13UfLCJYgWUJgRuGG4JKGgEFbYlxJw+BVUSBPIMDPoUQg?=
 =?us-ascii?q?w6CaYImgRaEeoQXjxpSeBwDWSwBVRMXCwcFgSBDA4EPI0sFLR2BJ3+BTRyDC?=
 =?us-ascii?q?YEOhCsrT4IkAXWBeUEZP4NTHgZtDwaBHxs2QAIBC209NwkLGwY9klSCZYFSJ?=
 =?us-ascii?q?5V7kTahQjQHgjiBZoFkDIkHlmIGEy+DcQGTWg4GkwIemGejY4VZgiKBXDMaJ?=
 =?us-ascii?q?IM2TwMZD1iCaIp6hBq8TEE1PAIHCwEBAwmFRgEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
 2AUTg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Xqtg2a5GAjQpw9c2oQPXwBbXdLJyesId70hD6qkDc20wTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmslqKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AkrZ9Tmj5FO8CTotkINZNKnX54zJucz7C6m/oA3C?=
 =?us-ascii?q?BBGM2aeeHS26B6Y92nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALnbq5w4/2yH2FPP4CxSjcldqxoxv4KWlOW0Li68?=
 =?us-ascii?q?M+JSkFylgeA+hlWqoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,277,1744063200"; 
   d="scan'208";a="120275760"
X-MGA-submission: =?us-ascii?q?MDHYNTyK1fVALaMZXNNRzSNbKwFFvBMXLjQQLZ?=
 =?us-ascii?q?AqzWDnGS61xXHcMRPuGCmTuIrbyDno6kVWrrZopLd6nQpXVZcAMPzHew?=
 =?us-ascii?q?CefFeX6HThxaCubcO59sI7S5WSIPyjlVOtRW//QmukQbsKfUSwuQSGI5?=
 =?us-ascii?q?jxL2A1ZjU32q/c7qGgTogb/w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:23:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751275420; x=1751880220; i=markus.elfring@web.de;
	bh=Pqv7gdEcDOnuCngHRUKjdGsaCl2tnYnGyELgA+NoRxE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F7uNfMfdrncDVAxQ/h1RgR09AZKhtd8zU9TGye/wUN31TNhMOSVJ5W0H18KWA+y1
	 +DKznFKxlO6TT8KRzWzKXaPjZB3hK+ZnoXmIWbUTCN2yTOnyac5e+6feViV8GaXvL
	 CTvm0hqjJkAsh/6T+mJcVyFL6bwXZztblD/k6ld3jOD8+0qGnposXFFj5y5YONbE8
	 Hz94qMAXS5wcbtsyOA0fA7j/isS9MRbTsd/QXOJT6PXS3n4I8A/kGkpgL4DgtGOec
	 FnGLyr4gw+qSGF5FiDoX+gAO3NnRL2Hu3vEzjBB39zT3OXadxQO4qP2VXREmfeWyj
	 DdTdQe4T5i0J1BR6lA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPU0-1uyOkj2kX4-00aBa2 for
 <cocci@inria.fr>; Mon, 30 Jun 2025 11:23:39 +0200
Message-ID: <5c19caaf-cba9-4db4-9aca-11075b1ca82c@web.de>
Date: Mon, 30 Jun 2025 11:23:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:G4XmCCFefECbMTQiwBMfvev7TP+RsXFz3yYkEzN2XYfLcq6yh3G
 7lD4Yyz2WrjrpC/Z5DE4jnc4MWt8gvAZvS8v0f+DBwLdRSvaBljYETc7bboES5wgnc6J6hG
 j1tbLHTW8Wz0e/n0EklDgJYQvWTuWgmUvG/2M2Xx7gTGxX1kbeAAlPj3XtwM7+ii2qZOzf7
 cRYOg1mdxAYIiMwnB01iQ==
UI-OutboundReport: notjunk:1;M01:P0:7Wh8Qa+bt30=;pw4BDPyIlHZIrICLKYippdNlNTg
 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
Subject: Re: [cocci] Data processing requirements by expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2823
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/5c19caaf-cba9-4db4-9aca-11075b1ca82c%40web.de>

Hello,

Expressions tend to be used in a lot of source files.
There are source code bases (like Linux) with amazing sizes.
Which computation system resources would you use if you do not like to wait days or some hours
on corresponding data processing results from static code analysis attempts?

Regards,
Markus
