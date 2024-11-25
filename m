Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA26D58D6A
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=z2xZgCfr0Q5G5tQbalXiOHQmkNBSuynBA+TlheUuoVQ=;
  b=Y6Cn8i55mKpoE5aUfgbtvkbqrHMnD0qo92LWjn0ihh5DLXKBMqyv5rhI
   sqDxOn6JXA6zNucN9jwahN+tBnEvwPCsjF0a0LZRhaPxo6I7CgTAbI0ac
   U2Os51MpQszkogVGwc9SS95GDSZmt2AxVQbfLbZMhmEAsy5J6F4Wb29g+
   M=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195725988"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 18:03:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B5A3E0D1D; Mon, 25 Nov 2024 18:03:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F3C7E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 18:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z2xZgCfr0Q5G5tQbalXiOHQmkNBSuynBA+TlheUuoVQ=;
  b=uHBuUM5QVEsg7up8I7QMiZBQRiZLaDH9mi6HYRA3+ER1634V7mSvsew0
   AxmOXBmVhYrWwnQQL2dD3xOOBcwWLSSEyFApzRnvc9LWalT9G9xpaJuXK
   ZaAkjtITm5y1QDJE+Ya5W8phegunKQb6TWqt33xP7VHx9Vxx9w8PbnyDP
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="102593198"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 18:03:13 +0100
Date: Mon, 25 Nov 2024 12:03:11 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <84112e0f-d7f3-4868-ac64-9b82a1925880@web.de>
Message-ID: <558e241f-c4b9-9046-9e86-5ddf723ff5e@inria.fr>
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de> <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr> <100663c2-6281-49cb-bb9f-55656dff80ca@web.de> <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr> <71494b2c-d690-4b58-ada0-59233e10c7a4@web.de>
 <a65c8579-de4b-c6f-f882-b62d667a839@inria.fr> <84112e0f-d7f3-4868-ac64-9b82a1925880@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Advanced handling of logical operator chains (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2121
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/558e241f-c4b9-9046-9e86-5ddf723ff5e%40inria.fr>



On Mon, 25 Nov 2024, Markus Elfring wrote:

> >>>> * Specifying a varying (or even unlimited) number of items for discussed boolean operators
> >>>
> >>>   e1 || ...
> >> * Does such SmPL code indicate that subsequent expression parts can be optional?
> >
> > Yes.
>
> I am looking for ways to express by the means of the semantic patch language
> that such a detailed expression should contain at least two operands
> which would all be connected with a logical OR.

Maybe you just want to disable the isomorphism?

julia
