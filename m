Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9543D68BCF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sexHDPgjBzlRDsC9DKNb3/V0UEUqtQgaRqgDidvvK9g=;
  b=eexcLXZuW0W49zRGvSHcs/qyseP1nKuf39aeg59FNSDALBwdgOwFUibv
   mPwWZnavp8Gip9svvR+Ki/CavvKzof6rSV+k50YSMrQuIdRCcZASQOV01
   YJJJn4gLE6lQDuypJPUgudSpAejkfaNkUO3J6ft+Ak9Tii3/sYWFOBI7N
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194141789"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 17:51:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BE8DE0D1E; Fri, 15 Nov 2024 17:51:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 281D4E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 17:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sexHDPgjBzlRDsC9DKNb3/V0UEUqtQgaRqgDidvvK9g=;
  b=T1zKs/P9bQdW4G6iCX2SwA2PIkKafWWt5B83CwCBB1n0SG2IJYneDCJS
   byzpnYlUBnIIUaOwp+ZpRMk4iO9dKeJtAmhnryBJGBjhMa9JYWhayogEr
   XSPl2rdSyjWCvhANsdF9L8OXVuNc2NRF2VaVZb7iFCme0spAiKYVztXcX
   c=;
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="194141778"
Received: from unknown (HELO hadrien) ([50.226.245.43])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 17:51:20 +0100
Date: Fri, 15 Nov 2024 11:51:19 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <87bba066-b262-4d07-aca7-4632f4e03816@knosof.co.uk>
Message-ID: <a8fad845-d218-9d77-ff9b-35a831f79e8@inria.fr>
References: <c1da3618-fdac-772b-133-a3e2df77d83@inria.fr> <87bba066-b262-4d07-aca7-4632f4e03816@knosof.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] new release, 1.3
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2003
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/a8fad845-d218-9d77-ff9b-35a831f79e8%40inria.fr>



On Fri, 15 Nov 2024, Derek M Jones wrote:

> Julia,
>
> > There is a new release of Coccinelle, version 1.3.  The most important
>
> Yay!
>
> > - Fix some C tests
>
> If you are looking to produce lots of detailed C tests,
> ChatGPT is surprisingly good
> https://shape-of-code.com/2024/10/27/c-compiler-conformance-testing-with-chatgpt-assistance/

Thanks for the suggestion!

julia


>
> --
> Derek M. Jones           Evidence-based software engineering
> blog:https://shape-of-code.com
>
>
