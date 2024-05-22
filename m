Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE18C25B78
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mHpSUN9lW5GGd0Bl8Au1pK+mlTk6JPwFqxX39mCClgM=;
  b=geMhxqDlb34LPfjiIzgu8QD2JU4rv3t8gVfs7Xz/EcpyGqHLmOUpamSn
   DQMkw24RRDA9HCWprMz8PIpFfrgCh7XdCNBU0jmq1ZXyy03rZfh0H6Ugr
   cNnC7dCGL/IzmQBvZmf/yuGqKFgqz0X1WUmdwUAn7ha2Ya+HtrhuPr7dG
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,181,1712613600"; 
   d="scan'208";a="166932342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 17:34:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB570E0CCA; Wed, 22 May 2024 17:34:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D5949E00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 17:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mHpSUN9lW5GGd0Bl8Au1pK+mlTk6JPwFqxX39mCClgM=;
  b=c7kRTs8n6kSN9/wozuoF97cGvn8sMuS9V3CIJdkPu0BuiP1c7izZbh2x
   zoyBBWSRRlBzEj3qxIzLyNxtQGfIO6Wt6O8NmQIARjo98x1WlIGkYmdVr
   Zw2Ls9E0Ma6Y8Gb5hXJBNmmFOFyPclV6IXrFCoCJ4ISztOp3F6pLUu+Fl
   g=;
X-IronPort-AV: E=Sophos;i="6.08,181,1712613600"; 
   d="scan'208";a="166932336"
Received: from unknown (HELO hadrien) ([217.116.228.14])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:34:50 +0200
Date: Wed, 22 May 2024 17:34:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <0bc588b1-afc9-453d-b79c-151963e88092@web.de>
Message-ID: <d51167c4-af9f-6b82-9ab8-9a807c98186b@inria.fr>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de> <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr> <0bc588b1-afc9-453d-b79c-151963e88092@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2060136022-1716392090=:4015"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1753
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/d51167c4-af9f-6b82-9ab8-9a807c98186b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2060136022-1716392090=:4015
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 22 May 2024, Markus Elfring wrote:

> > --noloops mean that the back edge of a loop is ignored.
>
> Should the program parameter “--no-loops” influence also the handling
> of Linux “iterators” (like “list_for_each_entry_safe”) anyhow?

No idea.
--8323329-2060136022-1716392090=:4015--
