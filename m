Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3302CC46467
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 20:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YWnNo6ULzV1M3coilbPGzg/xiPj1C8aTcjvcQnHxCIA=;
  b=Z0cP5dE5YDZFRLViNbVe06VMFxcFsqvz1rYfh8wj6+q25dBxW2t2C/9M
   TyTptpQ5+bbjh2oXKdu/6fli3D74+iEZ+Xc6D4gBGhXzXXmE/dTVge5vH
   BdLj5YfupnTvqI7N3B53jiXwc8fn54d9mmnk+pixq0OBpS9kYD759YGS8
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@mailo.com
X-IronPort-AV: E=Sophos;i="5.96,276,1665439200"; 
   d="scan'208";a="85104291"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 21:44:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25026E0138; Mon, 26 Dec 2022 21:44:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B0A3BE0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 12:42:18 +0100 (CET)
IronPort-SDR: 63a98889_ezlU/ssD/6onvchZl+vi7wziRarvg5I5k4neBmdI2BRUO7o
 eZKZ5yXJs851NiFxKDtKOJCzYNPzDQyeO4JG7pg==
X-IPAS-Result: =?us-ascii?q?A0EkAADch6ljmA82ttVaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIsgVwvBAtFhE+OeoIHIYVckgWFWIF+DwEDAQ1EBAEBAwSEfgKFEAIdBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBAQEBAQEVC?=
 =?us-ascii?q?RkFEA4FIoVoDYI4KQF1gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgJ+OQEBHQEBA?=
 =?us-ascii?q?QECASMPAQ0BATcBDwsYAgImAgIQRwYLgwaDACMHri96gTKBAYIIAQEGnUiBX?=
 =?us-ascii?q?gmBFCwBkCh6JxYGgg2EPz6IG4JnjmeKNAqBPX2BJw5kNwNEHUADRjIKQTULD?=
 =?us-ascii?q?EsrGhsHgQoqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmsJAgMiYQUDAwQoLQkhH?=
 =?us-ascii?q?wcVESQ8B1Y3AQQDAg8fNwYDCQMCH4FvJgUDCxUqRwQINgUGGzYSAggPEg8GJ?=
 =?us-ascii?q?kQOQjc2EwZcASoLDhMDUIFPBC+BZwYpKJ0Mp02fRIN4oSODVQGlPS2HIo93o?=
 =?us-ascii?q?nmFBYFpBi2BXE0jFYMiTwMZD44gGR6DO4pmPDE7AgcBCgEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:3hKQlq38xNnTfW+vHiWE5AqjBIAkLtp133Aq2lEZdPWaSK2lfu
 SV7ZMmPHjP+VAssRAb6LS90cy7Kk80mqQY3WB8B9iftUzdyRKVxeJZnO7fKl/bak7DH4dmvM
 8LT0E9MqyTMbEQt6bHCWeDfeoI8Z2q2OSBmfrepk0BcT1X
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="43652124"
X-MGA-submission: =?us-ascii?q?MDF49+uiuAYLBPxAVuJkoruwmlz5SoZfZXICr8?=
 =?us-ascii?q?NKlb84QrUuDhaLHk1mfj6LUoK4DZ3JYONfj8/bRUkLhxQzI3zXaV5Uzk?=
 =?us-ascii?q?1y1neeHrYvKZBxgStfEiseQqXQXKarEym+oy0lCElCybnLz18At6pWSU?=
 =?us-ascii?q?BpNK4fywV+JIuArbyUBYQQKQ=3D=3D?=
Received: from msg-4.mailo.com ([213.182.54.15])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 12:42:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
	t=1672054920; bh=YWnNo6ULzV1M3coilbPGzg/xiPj1C8aTcjvcQnHxCIA=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
	b=Gln8HDyj/aABbMvICwfdfe53atZENaGnl1/kSmfAamcnnFoKAxfaA4HuDIKd+PUvT
	 p3t6gBEAwVA6hmNG+yo4CobK73BBjCw5BLWBE863vjOli5kaYfctnUiUL8pZ0KirRf
	 5jxy1dCRqwefEtwu3xZXzcfMtLawOvJL/zmC3FTc=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
	via ip-206.mailobj.net [213.182.55.206]
	Mon, 26 Dec 2022 12:41:59 +0100 (CET)
X-EA-Auth: a6woBLnrOkV+3lXWrM5ZM9eYHe/lZWHP4yEvyptewATXyNr4NtmplLjB1RruF9rHBzT1ijIMI8MvzZSAvTqwZZuhdMqT2dJb
Date: Mon, 26 Dec 2022 17:11:52 +0530
From: Deepak R Varma <drv@mailo.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <Y6mIgLpxzr4KmbAz@qemulion>
References: <Y6hnpcLiHmJaQbeE@qemulion>
 <a31e9df0-1d15-9727-0a98-6c0cb2acdf84@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a31e9df0-1d15-9727-0a98-6c0cb2acdf84@web.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api/atomic_as_refcounter: include
 message type in output
Reply-To: Deepak R Varma <drv@mailo.com>
X-Loop: cocci@inria.fr
X-Sequence: 795
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/Y6mIgLpxzr4KmbAz%40qemulion>

On Mon, Dec 26, 2022 at 11:30:09AM +0100, Markus Elfring wrote:
>
> > … So, include the test "WARNING: " in the report output …
>
>
> How do you think about to use the word “text” instead of “test” in
> the change description?

Hi Markus,
Thank you for catching that. Just sent v2 with the correction.

./drv

>
> Regards,
> Markus
>


