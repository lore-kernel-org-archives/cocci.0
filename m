Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E2C47422
	for <cocci@archiver.kernel.org>; Fri, 26 Jan 2024 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aqLSIehADtqVd+7cmP+wqrqXX1pLc7t9NmJpjlC5oaQ=;
  b=G4kgGCW+jdLLb+EMdW3WAuoQZmJroFdp/If13y5p2K67CwV3UudpJ5ON
   T/n4h31GpiT/9fs5kuT3ymfdVKSbd1dffBzBJTjhs+Zky/EQqahgkYWRo
   NrSdhLwWBsGppMC+CR3xGw7ElSLlXeZfJlSe8wI1b/LVVzNV4aIrOo6RO
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148814352"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jan 2024 13:52:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 106F6E0CD7; Fri, 26 Jan 2024 13:52:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E113E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jan 2024 13:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aqLSIehADtqVd+7cmP+wqrqXX1pLc7t9NmJpjlC5oaQ=;
  b=RPTPM86b/f0p5/P33SlIA3+r7exxuZHuQaSYB4tPqu/6EIkYsZQmNsq+
   tsfI7PRy9xW6Gv/+LTMDGbEyU47JdfwjeHbYhnGM05Uo8AJroYvXeDJ3N
   MFJHI80dCk0kR1VuFGL2Q3Tbzu98R6PNdYX5oHqw+SqBTKZ1yY4ehe562
   s=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77920971"
Received: from unknown (HELO hadrien) ([163.173.88.253])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:52:42 +0100
Date: Fri, 26 Jan 2024 13:52:41 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <8a6c0b00-c65b-4c83-afd9-4023132a4183@web.de>
Message-ID: <51875417-549f-3fc-f661-15d87fa41140@inria.fr>
References: <8a6c0b00-c65b-4c83-afd9-4023132a4183@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1552244429-1706273561=:37156"
Subject: Re: [cocci] Clarification for input data of scripted SmPL
 constraints
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1490
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/51875417-549f-3fc-f661-15d87fa41140%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1552244429-1706273561=:37156
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 26 Jan 2024, Markus Elfring wrote:

> Hello,
>
> Some information is provided for the usage of ”scripted constraints”
> by the means of the semantic patch language.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5fdb1a247d3374ac30a3e565b2cc5167aeefc4e5/docs/manual/cocci_syntax.tex#L582-605
> https://github.com/coccinelle/coccinelle/blob/deb429dfae033e40aefc78729a585b00ae82808c/docs/manual/cocci_syntax.tex#L582-L605
>
> They tend to depend on a single input parameter.
> But how does the software situation look like if you would like to use contents
> from multiple metavariables (which were hopefully matched in combination)
> for advanced condition checks?

To a limited extent they can be listed in the ().

If there ... in the rule, it is often forbidded to use this feature, and
you have to use a separate script rule.

julia


>
> Regards,
> Markus
>
--8323329-1552244429-1706273561=:37156--
