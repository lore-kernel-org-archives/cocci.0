Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA93C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XIs0wNh67OJSOPGsHLY2TVjFNjDK0527kWRXILAgW/s=;
  b=jOgw3J7cGjxznFvwWKSKUFb0ySuvxeXowcPCM59hA+ABRY+t4AcJPG9F
   wsOTqDwAdy00PRuFuk/UfvLfEZ74T0VKLk5RwIbatxHpDO70zJoQIDPlu
   lrlzKITa6l1TrAcGpPlWI4iKSq8Zqo8OpGEByM8IJB9bXnDnpF0Tqk2Q3
   U=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229847798"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 17:18:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29CAFE0AF1; Tue,  1 Jul 2025 17:18:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4DAEEE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 17:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XIs0wNh67OJSOPGsHLY2TVjFNjDK0527kWRXILAgW/s=;
  b=cgnS2GjMT5wq3uQBV8BwxuTYmHUQpF8Oesn6HROBpvq7ntSv+uo+7lTd
   RMsUUk2Irv/6Noz55/kiF8WJi1wcjPtEuEq8Qm/DlRUyQqZHuIryHOk1N
   4Pu79pt4De9c/NIorqpmCRHpcbK4E/JHjPVj4ohVnJC61E2TFqYQsmcf1
   0=;
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229847790"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 17:17:59 +0200
Date: Tue, 1 Jul 2025 17:17:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
Message-ID: <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de> <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr> <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de> <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2845
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/8a69338-c049-cce1-2d66-a9607c175270%40inria.fr>



On Tue, 1 Jul 2025, Markus Elfring wrote:

> >> Would you like to suggest the exclusion of a single return statement
> >> by a more appropriate source code search approach?
> > Requiring the presence of a declaration already excludes the case of a
> > single return.
>
> Variable declarations (and definition) can also be specified after
> a return statement, can't they?

In terms of execution, nothing happens after a return statesment.

And anyway, after the return is not the issue here.  You have a pattern
that at each node in the CFG searches for either a return or a variable
declaration.  In the case of a return it does nothing.  Since no node can
match both the disjunction doesn't have any useful effect.

>
>
> >                 If you want to exclude a single return after a
> > declaration, then the return should be put in the disjunctions with the
> > *s.  The *sl will again never match anything, because it's not coming
> > immediately after a {}.  It comes immediately after a declaration.
>
> Is the handling of curly brackets (for compound statements) still unclear
> so far?

I see nothing unclear.  You can write { sl }.  You can't write S1 sl S2.
There exists no representation of a list of statements that sl can bind
to.

julia
