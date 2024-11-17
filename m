Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0104AD68BEF
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2024 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BKujuxnK5OAnXfd/frGaRcUgP8VAdMOAqLA1IWN5AEk=;
  b=c7x9zVEmmMVX9Oc6SbDB3yEHiVNtLL4eYhU2cUNsTczO9ZZdPkVocYNS
   jgbZIhreNoWdfw+Y4I7/2Xax1XhDeW8X2fpbexrHijShpKte2DzSuqUnd
   1H//AflnG3qQ1u0Vn8HIPjrGKbVI8u4qMRUkpo7IMl4iMjXQ9MsQ9VR6N
   w=;
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
X-IronPort-AV: E=Sophos;i="6.12,162,1728943200"; 
   d="scan'208";a="194273564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Nov 2024 17:04:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD75DE0D1D; Sun, 17 Nov 2024 17:04:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A0182E00B7
	for <cocci@sympa.inria.fr>; Sun, 17 Nov 2024 17:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BKujuxnK5OAnXfd/frGaRcUgP8VAdMOAqLA1IWN5AEk=;
  b=UE/br9ppzr5v5xMLKfg0zk+DLB4yltLtua9ZUz/b6WjG+CGmhkzAnhp/
   oP+KsdWIpBw88u//JqsJVq2p6/9PerX6n0zd3SNZuYFC9RoYvcoakCDH8
   fob7BOj6u6DOqQQgFgnOmpxRQYUkwbg+ZjT6DNG0Y9a4bhOEYj3Exe6Fb
   4=;
X-IronPort-AV: E=Sophos;i="6.12,162,1728943200"; 
   d="scan'208";a="101835526"
Received: from unknown (HELO hadrien) ([50.226.245.43])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 17:04:22 +0100
Date: Sun, 17 Nov 2024 11:04:18 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5231db6d-7d76-4be9-a82c-5224babf8e29@web.de>
Message-ID: <d577a3b9-d43-19d3-15cf-2b11fb1ce59f@inria.fr>
References: <5231db6d-7d76-4be9-a82c-5224babf8e29@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Reconsidering special return statements (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2075
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/d577a3b9-d43-19d3-15cf-2b11fb1ce59f%40inria.fr>



On Sun, 17 Nov 2024, Markus Elfring wrote:

> Hello,
>
> Another special statement combination was pointed out also by Nobuhiro Iwamatsu
> for further software development considerations.
>
> [PATCH v2] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
> https://lore.kernel.org/linux-kernel/20241117053443.1148902-1-iwamatsu@nigauri.org/
>
>
> Would you like to become able to handle such source code places also
> by the means of the semantic patch language?
>
> @display@
> @@
> *return ...;
> *return ...;

What is the problem here?

julia
