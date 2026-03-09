Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DF6EFCD9F
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Hz1hJUwC6N3smegrQxjMoXkEvYOWDYjikvQz9Sfuh0U=;
  b=LCgu7QOFbUeSYttEqjbD/xkdnsPe4wgjfKtNzdpXxMhKtOak/V08KWAj
   H6JvgLr0R6fSE20a8UIhzexJotxUV6pdSKeyClJmik2WE7R4HdaO1drcL
   /3TAAlbhQYWWyA6n0fCoj+/4RyDCA3PEKmBFLViLTn8IEqIf9+EXm+cni
   w=;
X-CSE-ConnectionGUID: KV+PyIG9R3OsgQWX3kmiIQ==
X-CSE-MsgGUID: 4ricwlrVQTKuhdbA/rEmLg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267037031"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 10:14:02 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 59BA4832B8; Tue, 10 Mar 2026 10:14:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8970A831E6
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 17:10:23 +0100 (CET)
X-CSE-ConnectionGUID: 35G3u243RCyVQjahGhq8Dg==
X-CSE-MsgGUID: ic7T0/JkQ2+Mwwd704wfiQ==
IronPort-SDR: 69aef0ee_oJBGGJjv0gECWI3b05bDMVFvfzEG3QVKLdTsM1kuafq5ql/
 rytGCIhSUZ4ZPhQYJH7A0MARCLjk2praJdPg69Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GVCADu765pchxYTy1aglmBblOBB18zBAtJlkwDMDmKe?=
 =?us-ascii?q?5Bhg1ICDwEDAQ09EgIEAQEDAQOFAAKNIQIeBwEEMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABgQyGTw2CYgGBExF0MAIBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAg1+AQEBAgFAAQE3AQQLCyElDwEQNgYBEoMDgiIHEQMPJwMBBAyvO?=
 =?us-ascii?q?oEBggwBAQbbLw2CVQMGFAGBOIg1HwGGDyCDRXonG4INgUqCdT6CH0IDgSaGW?=
 =?us-ascii?q?yKCJoEOHZJ+UngcA1ksAVUTFwsHBYEjEDMDIAovLQIUDSIPGgUtHXAMJxIPH?=
 =?us-ascii?q?RcUH1gbBwUSISqBSniCAQ+GankDLl4aDiICKBIDWTgSPgtaBYIkAwttPTcGD?=
 =?us-ascii?q?huPIT6CMwFYCS0qAlBIl3aPEqAdcYQmhHCHLo8+hhYzl16TDYgpkF0ijWeEC?=
 =?us-ascii?q?ZcvgX4kgVwzGggmCoMiTwMZD5Z5O8QJJDUCATkCBwsBAQMJhUMmE4tuNIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 V0OzK+qdewu
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:f7pa9a+Nq8jWq8/7Ln9uk+DcI+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+sjztCWE7wr5N0tMpTntAsm9qDbnhPtICOoqUYtKPjONhILAFugLhrcKgQeAJ8SUzIBgPM
 lbAspD4ZHLYmST0KvBkW2FL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3AYuHJjGjUEDScMnVZpYrlnZA6YTJuKSDyl2qKfxS?=
 =?us-ascii?q?CIndXcb+cSXCQ4fNInJ87?=
X-Talos-MUID: 9a23:rHjkIwjzYTvpIIn9VbFLF8MpNcw33/zpKkM0y9YjpNaIanQsJDmctWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140836634"
X-MGA-submission: =?us-ascii?q?MDHVhNPKjXWAnjE6CMmX8tk5u8UbmgfvIXjdq2?=
 =?us-ascii?q?LVoKwhixrEieW9OddXSoxPqdYumHJq0LaTKkGASkAzEr00Zs2Mgkle6q?=
 =?us-ascii?q?hsl1gXIPNkKdOmJ+qdn+jhbYviyBCia28GgPrpytqfzNtEMv01OrD9zR?=
 =?us-ascii?q?3kdT9/8jxMbbJZ2iZbwT756g=3D=3D?=
Received: from ms.lwn.net ([45.79.88.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:10:23 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 69AA840C9C
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 69AA840C9C;
	Mon,  9 Mar 2026 16:10:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: LIU Haoyang <tttturtleruss@gmail.com>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: LIU Haoyang <tttturtleruss@gmail.com>, cocci@inria.fr,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308100851.341-1-tttturtleruss@gmail.com>
References: <20260308100851.341-1-tttturtleruss@gmail.com>
Date: Mon, 09 Mar 2026 10:10:18 -0600
Message-ID: <87v7f5vv9x.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] docs/dev-tools: fix a broken URL in
 dev-tools/coccinelle.rst
Reply-To: Jonathan Corbet <corbet@lwn.net>
X-Loop: cocci@inria.fr
X-Sequence: 3366
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/N9DZ9ziqa3mxCjGNbiMZZg>

LIU Haoyang <tttturtleruss@gmail.com> writes:

> The original supplemental documentation for coccicheck is
> https://bottest.wiki.kernel.org/coccicheck, which redirects to a not found page,
> thus change it to https://bottest.wiki.kernel.org/coccicheck.html,
> which adds a suffix to original URL to make it direct to the right page.
>
> Signed-off-by: LIU Haoyang <tttturtleruss@gmail.com>
> ---
>  Documentation/dev-tools/coccinelle.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 2b942e3c8049..f73ccf5397f3 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -61,7 +61,7 @@ Supplemental documentation
>  
>  For supplemental documentation refer to the wiki:
>  
> -https://bottest.wiki.kernel.org/coccicheck
> +https://bottest.wiki.kernel.org/coccicheck.html
>  
>  The wiki documentation always refers to the linux-next version of the script.

I'll apply this - a working URL is better than a broken one.  But is
there really nothing better to link to than a page that warns "OBSOLETE
CONTENT" at the top?

Thanks,

jon
