Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA395C4321E
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=L+T2dC/SDmt6l8WdO+wGI8tT8kmlnyrmMusGWPnBzvk=;
  b=oEJl7ZTD3T8huUbJ8Bl/JkLVWY6hiAP3N9q58CHDI2Ht1tTFfn4Kj3h/
   UiB69VgjNc6+979Pdfzijcqpe+mvJzZXzu3pL178tRY+h8pCwq4hnHczy
   e7lgbU5t7Gx504RUy03RBWDjecitb7uGaktoUFUbOYyQc4zkO2t9bJX75
   o=;
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
X-IronPort-AV: E=Sophos;i="5.96,216,1665439200"; 
   d="scan'208";a="81572547"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 08:40:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 638FAE0235; Sun,  4 Dec 2022 08:40:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC8DCE019E
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 08:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L+T2dC/SDmt6l8WdO+wGI8tT8kmlnyrmMusGWPnBzvk=;
  b=uscr0mJ6U00yBKCy+cLsY1a/L8o1QzihsPDb8y+ShHYanJm7ufDr4wy5
   9yAfzsJT98YVMaMW9kQAsYp21i65PkE1EnM6oD92rK8Rf2K5qWiUI3145
   6uPOHodbP+jekDj4TLCeaJ8M2VUR+A09cLEyqw3Jh+/v5S/XPZIc4Ps1t
   s=;
X-IronPort-AV: E=Sophos;i="5.96,216,1665439200"; 
   d="scan'208";a="41655356"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 08:40:21 +0100
Date: Sun, 4 Dec 2022 08:40:20 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for ++ of volatile variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 760
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212040832050.3337%40hadrien>



On Sun, 4 Dec 2022, Derek M Jones wrote:

> All,
>
> I want to find volatile variables that are
> the operands of ++, --, or the lhs of an
> assignment operator.
>
> The script below works for declarations
> within functions, but it would be more flexible
> if I could check whether the declaration of V_1
> was volatile qualified.
>
> I' having the usual problem that occurs when using Coccinelle
> after a long time away, I cannot find the example
> I need (assuming that it's possible to access the
> type information in the Python script, or some other
> way).
>
> Actually the line
> V_1 b E_1;@p_1
> does not match anything.  Is this because the assignment
> operators are not considered to be binary operators (they
> are)?

For the assignment operators, you should use:

assignment operator b = {+=,-=,&=};


>
> @ volatile_op @
> expression E_1;
> identifier V_1;
> position p_1;
> binary operator b = {+=,-=,&=};
> @@
> volatile int V_1;
> ...

The problem is the ...  That matches the shortest path between the thing
before and the thing after.  So you only get the first match.  With the
semantic patch as is, you get the |= line, and if you replace binary by
assignment, you get the line with the +=.

Intuitively it would make more sense to replace the ... by <... ...>.  But
that doesn't work either.  It matches everything, but they come out in one
match, with a list of positions, and you only print the first position.

Another approach is to replace the ... by ... when any.  Then you get
individual matches for each reachable assignment, and you get four
results.

But the much simpler and efficient solution is just to declare the
metavariable with the type you want, ie

volatile int V_1;

rather than

identifier V_1;

Then each occurrence is matched individually.

julia

>
> (
> V_1 b E_1;@p_1
> |
> V_1 |=  E_1;@p_1
> )
>
> @
> script:python @ expr_1 << volatile_op.V_1;
>                 loc_1 << volatile_op.p_1;
>               @@
> print("--- volatile op")
> print loc_1[0].line, " ", loc_1[0].column, " ", expr_1
>
>
> Some C source to test the script
>
> volatile int vi;
> int i;
>
> void f(volatile int p)
> {
> volatile int vl;
>
> vl += i+0x88;
> vl -= i+0x88;
> vl &= i+0x88;
> vl |= i+0x88;
>
> p++;
>
> vl++;
>
> i++;
> vi++;
>
> }
>
>
> --
> Derek M. Jones           Evidence-based software engineering
> blog:https://shape-of-code.com
>
