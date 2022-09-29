Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCA0C04A95
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5WIMjhPdBkmn2uwoDHQ0qBk60XNebzDJpZy0uiAfsEw=;
  b=HCo0r3Jnd2QlKt7L4ErRTilsUN/In8GDuarIBZEhcCTs0Vk/huwWyZEh
   0OZadYdITA4KuTITNY7VTUtaeZvUUVXNDhA1VO8kbTPAaKeaPvbtMLyW2
   RBxjWkavkLwi44EoQUKTuABTdrWGNe1Wb2JQ1yOOyuTYKbspVBxmqfc/U
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55056980"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 08:43:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5C90EE027C; Thu, 29 Sep 2022 08:43:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BB3EDE0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 08:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5WIMjhPdBkmn2uwoDHQ0qBk60XNebzDJpZy0uiAfsEw=;
  b=ARNe1puzGk+XVUfMoXu767/B/7myb30p1PUVVEOnab8LD2LGIGv/VOmv
   6NxnqoGO0Eb93SPKkWQyF7tguWyoryrnkuKQHJaTDfIsPBYcmdxSs2QGm
   zbe/HXgKtHz2RQ9x4udbUsMUml6kAC3xH1o63zi/DQ3nF/87HyLSMxw+1
   o=;
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55056977"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:43:16 +0200
Date: Thu, 29 Sep 2022 08:43:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
In-Reply-To: <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27>
Message-ID: <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de> <alpine.DEB.2.22.394.2209282125470.2984@hadrien> <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de> <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
 <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1195429664-1664433796=:3818"
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 603
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/59318b60-5c22-e774-6b2c-eb1463681ac3%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1195429664-1664433796=:3818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 29 Sep 2022, Markus Elfring wrote:

> > > > t is a metavariable that gats bound to the type of o.
> > >
> > >
> > > I would use the kind “identifier” for the metavariable “o” which is connected
> > > to a known data type.
> > > I would appreciate if the usage of your SmPL code can become clearer.
> >
> > In SmPL, if you want to declare a metavariable that matches an expression
> > of a certain type, you don't have to write the word expression.
>
> * Would you like to restrict the source code search to compound data types?
>
> * How do you think about to check if there are differences in the software
>   run time characteristics for the application of the metavariable kinds
>   “identifier” and “type”?

Huh?  Why would I want to use identifier?  First an identifier doesn't
have a type, it's just a sequence of characters.  So I would not know the
type of the expression, which is necessary for matching up the various
uses of the locks, and second the thing in the matched position is not
always an identifier, as in &a->b->lock.

julia
--8323329-1195429664-1664433796=:3818--
