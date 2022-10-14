Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00D5C4332F
	for <cocci@archiver.kernel.org>; Fri, 14 Oct 2022 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/p4lpnEjEnsTSKJyjgPS0LsAM8Ue81RoRDIcR4tyrus=;
  b=t40959EJt7kL8OQZ5aQqYBeSffaIM7a8xWZ3W0YRXnWjahqdMOen3qNG
   v4XTn6RjJDc8A2tI9u6gQidzRndyr9XbpW8V9fcpsDxR+Cf/Plb2hSL2r
   vvXJM+TvldmTLP+L7QEktydgTAFrBRAwEo5WxwFA6daKE6apmzxPKjUu7
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,184,1661810400"; 
   d="scan'208";a="65194909"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Oct 2022 14:33:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A24D9E0137; Fri, 14 Oct 2022 14:33:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39B3FE0038
	for <cocci@sympa.inria.fr>; Fri, 14 Oct 2022 14:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/p4lpnEjEnsTSKJyjgPS0LsAM8Ue81RoRDIcR4tyrus=;
  b=pNQkGbj4GrvvKBkfIU25EGRSmpflBML/M+ZA5AoNH+NyLMELNIMGRJ3B
   gbaZ6WPhYx3R8czYtfnuzFIwS+CrrQTglg9rJyDIkRYhxJQUVieWA7rm2
   gYUD0Y2KzE/jhx6ufmQiDIz/SmMYO4ZDC6NqOh4Jion0wlvOfIG9n1n1F
   s=;
X-IronPort-AV: E=Sophos;i="5.95,184,1661810400"; 
   d="scan'208";a="65194908"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 14:33:38 +0200
Date: Fri, 14 Oct 2022 14:33:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Andrzej Hajda <andrzej.hajda@intel.com>
cc: cocci@inria.fr
In-Reply-To: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
Message-ID: <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
References: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch adds zero or two lines after if statement
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 647
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/90ab83bb-6ac-488-251a-5f5dac2f2b6%40inria.fr>



On Fri, 14 Oct 2022, Andrzej Hajda wrote:

> Adding 'if' statement to the code does not add empty line after it, as
> expected, but if I explicitly add empty line spatch adds two lines, and this
> is unexpected. How can I convince spatch to add exactly one line?

Coccinelle is actually not intended to add any blank lines...

I will try to see why this adds two, though.

thanks,
julia

>
> Following script:
> @@
> @@
> + if (1)
> + printf("a\n");
> return 0;
>
> @@
> @@
> + if (1)
> + printf("b\n");
> +
> return 1;
>
> ##### EOF
> used on file:
> int a()
> {
> return 0;
> }
>
> int b()
> {
> return 1;
> }
> ##### EOF
> produces:
> @@ -1,9 +1,15 @@
> int a()
> {
> + if (1)
> + printf("a\n");
> return 0;
> }
>
> int b()
> {
> + if (1)
> + printf("b\n");
> +
> +
> return 0;
> }
> ##### EOF
>
> Regards
> Andrzej
>
>
