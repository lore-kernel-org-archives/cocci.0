Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26A9C25B77
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AuzmulTXgdJN124haIdOVXq8/O9LLk1YFQdq+cMTv1Y=;
  b=TzpWiM48M2nB3Xx3WUuyO8BfHNhSa9BwMlTq2NcaJqyicQeKW/Wi5Fs2
   b3gZ8BFDffPQmr6ZYRoMDkx0XxYDqn/2o26Kf9+amjo2FGC9Ox7KzN+rF
   5ufIsj12Or7MYaQzy0n0dejGKLti3SN3zxfSjNRzKJr7x/fs57xB8LOF+
   E=;
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
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166822336"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 10:24:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DA95E0CCE; Wed, 22 May 2024 10:24:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B4B53E00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 10:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AuzmulTXgdJN124haIdOVXq8/O9LLk1YFQdq+cMTv1Y=;
  b=D5Dq+p1cHcgDBw1pi6NTuhr4T30I7SnAllDPqq1xeQbEmX5pVrlgTVqp
   /7y5eR+Zs6dFxDgm5O/7Bd/XTfKwAY6aRcG9QE0xbowr+slU3XxAl9hrv
   wsaIKHWW1IUFcF+efJttc8QhZcWRscQAj5FLpNVCS54LVOGvFS3SnaRX4
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="87646354"
Received: from unknown (HELO hadrien) ([83.151.142.234])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 10:24:53 +0200
Date: Wed, 22 May 2024 10:24:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de>
Message-ID: <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-963387485-1716366292=:7331"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1748
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/9b4af55-40c-3082-52f3-12b4b535376f%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-963387485-1716366292=:7331
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 22 May 2024, Markus Elfring wrote:

> > Source code parts can occasionally be repeated.
>
> Would you like to clarify how the data processing for scripts of
> the semantic patch language should be influenced by the program
> parameter “--no-loops”?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/477e7e12478bd317aa97ee79857d185601ab6f33/docs/manual/spatch_options.tex#L365
> https://github.com/coccinelle/coccinelle/blob/477e7e12478bd317aa97ee79857d185601ab6f33/docs/manual/spatch_options.tex#L365

--noloops mean that the back edge of a loop is ignored.  It can greatly
reduce running time.

julia
--8323329-963387485-1716366292=:7331--
