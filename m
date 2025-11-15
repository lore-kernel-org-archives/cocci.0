Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A044CEB2CC
	for <cocci@archiver.kernel.org>; Sat, 15 Nov 2025 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=I2sZ+uJtjBXtGDsNJwRiceWOiQBfAEt4JF4my33jKus=;
  b=KW5dZPstLbf0fHEsugZZlqWGINV/7P29dDk8FWW1gU6cF8qHrUOFNnKg
   2BCONwmS+8mjXR3niZXTkJ/7Ap38uT8YwKGS2tBvZq0h7Q/nRVEqetHkf
   68OZM5lhswKturG1yv4+fW4d84t6A6TjgXiFdDLAPQh91lRTXCxDj2Ohl
   U=;
X-CSE-ConnectionGUID: QymfBdh2Sze2eh7IG//YWw==
X-CSE-MsgGUID: mx/ChHeGR/SRY1Peqsdn/g==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249316702"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2025 12:43:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D44F5E0172; Sat, 15 Nov 2025 12:43:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 92C13E0171
	for <cocci@sympa.inria.fr>; Sat, 15 Nov 2025 12:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I2sZ+uJtjBXtGDsNJwRiceWOiQBfAEt4JF4my33jKus=;
  b=rwQ7ajOkTPJuPnrDNNWJI5GTTZaVANR3gUpVXA4XhtjbobWW4rU47bR1
   TyZV3nSwWfz5HKTEjFHx2g+c3Kb/sbK3HKmQP+uhRb1nITwHgLd7WxVN1
   M9Fmu6mHFMx3C1nGLUuob3ay72MVrxrT49Tw3GrtWV2mWSNyZxok+QpOw
   U=;
X-CSE-ConnectionGUID: ALFrwi/jRWKpITkNsVMNWw==
X-CSE-MsgGUID: eM7cW64STPulySmApOUsBA==
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249316696"
Received: from c-76-123-3-165.hsd1.va.comcast.net (HELO hadrien) ([76.123.3.165])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 12:43:07 +0100
Date: Sat, 15 Nov 2025 06:43:01 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5598c4eb-8c8b-4fbe-918d-78509448cc22@web.de>
Message-ID: <9d2415fd-116b-32bc-4f0-5b4555e5e752@inria.fr>
References: <a66f4836-8161-4d3e-b588-7990035ec436@web.de> <2010b4b2-9710-4501-9c51-3b3ccc30d6af@web.de> <5598c4eb-8c8b-4fbe-918d-78509448cc22@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-39685753-1763206987=:3373"
Subject: Re: [cocci] Reacting to negative source code search results with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3179
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/9d2415fd-116b-32bc-4f0-5b4555e5e752%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-39685753-1763206987=:3373
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 15 Nov 2025, Markus Elfring wrote:

> > How will chances evolve for further software improvements?
>
> Corresponding development ideas might follow another SmPL script example.

I have no idea what this is supposed to be an example of.

julia

>
> @my_test_search1@
> identifier action;
> @@
>  action(123);
>
> @script:python reporting1@
> id << my_test_search1.action;
> @@
> print(f"The call “{id}” was found.")
>
> @my_test_search2@
> identifier my_test_search1.action;
> @@
>  action(456);
>
> @script:python reporting2 depends on ! my_test_search2@
> @@
> print("An undesirable function call was not found.")
>
>
> Regards,
> Markus
>
--8323329-39685753-1763206987=:3373--
