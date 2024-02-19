Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B04BC48260
	for <cocci@archiver.kernel.org>; Mon, 19 Feb 2024 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ejFYFxpwJaD1XHTyHtRSu2JiuFzqQ/49/DVJ0WMTMN4=;
  b=Xfzi+j0lNBFGh3XFLRWtbtNNNvHuY3E1JtZzD8DO6f2Mt14i7XffPYjx
   CgpHfTa1lphlmXGaEXXX0VlVXZovFQX/XVKwFThlWKl6My0DtyP3RM3Fl
   UB8sXJlN8DrLI6jg16Sq9wYWmA3lBTWkYoqyGgvuJw9ZS1MAzr7W5C09g
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="152557724"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Feb 2024 08:36:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F64AE0CD7; Mon, 19 Feb 2024 08:36:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 81F11E008A
	for <cocci@sympa.inria.fr>; Mon, 19 Feb 2024 08:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ejFYFxpwJaD1XHTyHtRSu2JiuFzqQ/49/DVJ0WMTMN4=;
  b=cj3IBhYQR1XbkE7BAE43wLkbnXkdHIkA+knH1CR+e2UOIaRjNTpLzmkN
   XgM0clgv0OWx58fw44QivB88iTzZsLO4QTCgunaYAqUz7OnMgjQBTOuTi
   Ul0cKajA0GjS7tO8JlCS6L52fjISLHJy6WonhFjYGmoFiPaoJW7RGt4Jv
   g=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705359600"; 
   d="scan'208";a="79981066"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:36:17 +0100
Date: Mon, 19 Feb 2024 08:36:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <407f678d-05a3-425d-a93b-dac350e9c731@web.de>
Message-ID: <bcdf429d-a35e-e4b4-b2b6-5e455a8f6035@inria.fr>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <12009cea-f93c-4a80-a95f-9bde16dc78a5@web.de> <4bd9de70-de02-4fea-9d41-095304edf4fe@web.de> <38d77d89-ffb7-d495-ff80-898861d46d32@inria.fr> <5afbaf9d-892b-4105-a54a-35f1e40e6749@web.de>
 <6a89e704-5561-4f44-b9d7-7c8f78976e71@web.de> <alpine.DEB.2.22.394.2402180908440.3095@hadrien> <30fef057-5f06-47bd-8b62-1bb6fc3fb946@web.de> <alpine.DEB.2.22.394.2402181707300.3095@hadrien> <407f678d-05a3-425d-a93b-dac350e9c731@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking the search for a repeated condition check with
 SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1584
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/bcdf429d-a35e-e4b4-b2b6-5e455a8f6035%40inria.fr>



On Mon, 19 Feb 2024, Markus Elfring wrote:

> > In the former case, it first matches stmt at the end of the semantic patch,
> > that can be anything.  In the latter case, it first matches the if,
> > then binds stmt, and then can easily recognize stmt earlier in the code.
>
> How will the chances evolve to achieve consensus on the desired
> evaluation order for the shown source code search and transformation code
> according to the semantic patch language?

We are not going to change the entire underpinnings of Coccinelle so that
you can have the pleasure of saving 10 characters.

julia

>
>
> > There will be no changes in this respect.
>
> There are several open issues in some waiting queues with the potential
> to improve the development and data processing situation considerably.
>
> Regards,
> Markus
>
