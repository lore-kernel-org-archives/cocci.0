Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D22C10F16
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=08GOV3J3f5qIOO9kOCR2PHNE1aJtH/Be+eUZkx0bW5k=;
  b=vi5RYMedMnaYn6Muxq4tdoFxxojFrHZChUQOOZ0nIOcqXBcCv3xIbxXZ
   FEBniW+WVcQR+ud684FVe4MAbmpyOcIKInpWZQWcPVGU+pHq3Y7UNJTtO
   LHfdk6tLjVJ9mSTai9o3Qeu8nIsZl/F3wjDDbNeSwcuNAbfuQe5GYpIdz
   A=;
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
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164673493"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 14:16:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4908CE0035; Mon,  6 May 2024 14:16:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 36311E0035
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 14:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=08GOV3J3f5qIOO9kOCR2PHNE1aJtH/Be+eUZkx0bW5k=;
  b=aJ66/5hQlpsICy4cuH+K/EYGk0mi4iFVmX7oXv4bKuYPg8S+qvurHL+g
   cnjkoi17bU2YnC6jInVw9Qpi4jn2HIKO2MQ5frtZy8dWnniR/k/66mKLs
   Wr3cQAyuo+zg/iLTVcErzSdmFFtbWEuDsJIn4vuYIPTY6jzkMXLQxezCB
   A=;
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164673486"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 14:16:43 +0200
Date: Mon, 6 May 2024 14:16:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <688dd1ab-acf6-4e0f-ab2f-aa682549760d@web.de>
Message-ID: <255638d4-292-c384-4d10-152a9583599@inria.fr>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <688dd1ab-acf6-4e0f-ab2f-aa682549760d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1705
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/255638d4-292-c384-4d10-152a9583599%40inria.fr>



On Mon, 6 May 2024, Markus Elfring wrote:

> > Be more concrete about what you are not able to do.
>
> Would you find another specific search use case easier to clarify?
>
> Example:
> How would you like to determine that an if statement was specified three times
> within an function implementation while the corresponding compound statement
> should contain a variable assignment and a goto statement (at the end)?

If you really are concerned about three identical if statements plced
anywhere, you can record their positions and then count them.  But it
doesn't seem like a genuinely useful thing to do.

julia
