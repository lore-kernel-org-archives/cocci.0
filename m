Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681B9D3C526
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=UVvoFz2a3siHVi/AMVSu80/OaBLrCMK1NZg65MuJZqI=;
  b=XPErU8MK6/pvBKwDr9ulH49gvecUG5wS7vUjXet7sogzgwFQvNvd/ocH
   mifoOlI1roFktMX9zKLeBsP8QFdjjHmaKwgJPIw95d7oPMeePsO+DJM6M
   PCTROVtmoiI2WVhPqrm42DriVgSYwx3L1pTWrhK10Xjn64asnn42DNQU6
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189460622"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 19:28:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9444CE0145; Thu, 17 Oct 2024 19:28:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F0E47E004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 19:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UVvoFz2a3siHVi/AMVSu80/OaBLrCMK1NZg65MuJZqI=;
  b=FjBR33zuRjv0VkejUIF7iZfpjVCFQYYSNGxjblrnKHzCih9lpYfMVPXA
   g4HWiJWak0hv/q1GBlaOTI87ePG07VYD+d3msomMqAq0nCnHbINmY7/hM
   2CMnx/tre088Ye4HMQoYgG5HQtoHbR9EBMr45S/wVOf3WXpJAGRYwZTif
   0=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189460615"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:28:40 +0200
Date: Thu, 17 Oct 2024 19:28:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ced9a857-0da6-4cfc-ad35-9095ea20771d@web.de>
Message-ID: <d69dc642-7a57-449b-170-a67c3a9fc1c@inria.fr>
References: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de> <ced9a857-0da6-4cfc-ad35-9095ea20771d@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1629111997-1729186120=:3143"
Subject: Re: [cocci] Challenges with selection of an SmPL Python version?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1913
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/d69dc642-7a57-449b-170-a67c3a9fc1c%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1629111997-1729186120=:3143
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 17 Oct 2024, Markus Elfring wrote:

> > I adjusted this SmPL script for another source code analysis approach.
> Another command parameter should eventually be specified for the desired
> data processing.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch --python /usr/bin/python3 drivers/base/auxiliary_sysfs.c …/Projekte/Coccinelle/janitor/list_free_attribute_usage_incidence.cocci
> …
> SPECIAL NAMES: adding __free as a attribute
> Using SQLAlchemy version:
> 2.0.32
> HANDLING: drivers/base/auxiliary_sysfs.c
> variant|incidence
> kfree|2

I can't test this because you use libraries that I don't have.  But it
looks the problem is just with your installation of python.  Maybe you
need to specify which version of python you want when you run configure.

julia

>
>
> Will any corresponding discussions become more interesting?
>
> Regards,
> Markus
>
--8323329-1629111997-1729186120=:3143--
