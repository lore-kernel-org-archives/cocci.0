Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69EAC28B28
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=O7PXEm7WwB1+SiXJmnD0VoYEJwR60biBtURYPJXWX6M=;
  b=gFqmSXF3NvopptwFMqIpzSmUS5THkvu2hlSo8BM8b3wMef6xwPOYLp/3
   n1mhnyjlAzkr7f5DMdxwMTCP7r4gkxGDfOmGf+h0IPe3qNxzWqQ8e5f8P
   SxAAGIiiUEutJOUfv+0L1Gy0YlKF4wnAv6vN5IV+1cQhT8OwvqIsZQ5XM
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213619313"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 08:44:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E9B69E0D1D; Wed, 19 Mar 2025 08:44:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C9072E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 08:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O7PXEm7WwB1+SiXJmnD0VoYEJwR60biBtURYPJXWX6M=;
  b=ud1eGqHn5eTHb2BmbcOb9wJEcuu/0Lq/pTjb4L3lpZcgUj02zMX8yyrv
   ZRr33KMtuyN9PTVMPKIOVf1VnP6QVD7sMzTwoToRBcCOcxeZDfz63boVl
   eSkNgZbNarrD+i/vKeywzDZL1nh25i15taimDiyFVu8IkBVTg0Hrk2fBI
   0=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213619295"
Received: from pd9ef1166.dip0.t-ipconnect.de (HELO hadrien) ([217.239.17.102])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:44:40 +0100
Date: Wed, 19 Mar 2025 08:44:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Kees Cook <kees@kernel.org>
cc: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <202503182023.D7C4D91@keescook>
Message-ID: <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr>
References: <202503180924.2135CF8FD@keescook> <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr> <202503182023.D7C4D91@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2635
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/8714afb-4938-9beb-9f0-4a4972f4b81%40inria.fr>



On Tue, 18 Mar 2025, Kees Cook wrote:

> On Tue, Mar 18, 2025 at 06:56:40PM +0100, Julia Lawall wrote:
> > I think you want
> >
> > Expression *m;
> >
> > A->@m b
> >
> > B would be an identifier
>
> But how does "B" get correctly type restricted? (Or in my example,
> "NAME"?)
>
> I tried:
>
> @direct depends on !(file in "tools") && !(file in "samples")@
> type TYPE;
> TYPE *P;
> TYPE *MEMBER;
> TYPE INST;
> identifier NAME;
> expression COMP;
> identifier ALLOC =~ "^kv?[mz]alloc";
> fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
> @@
>
>        \(\(P\|COMP.@MEMBER NAME\|COMP->@MEMBER NAME\) \& VAR\)
> -       = ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
> +       = ALLOC_OBJ(*VAR, GFP);
>
> This parses, but don't match (from crypto/asymmetric_keys/x509_cert_parser.c):
>
> 	cert->pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);
>
> But does match (via "P"):
>
> 	cert = kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);

What is the command line, eg --all-includes?  You can try
--verbose-includes to see what is happening with #include "x509_parser.h"

julia

>
> /me continues to scratch head
>
>
> --
> Kees Cook
>
