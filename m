Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E02C433FE
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=wP2u3cXWgX6mBoxuOvSg5WtkmS4MddOM3TRwYsZ57Z8=;
  b=YGdYj4085rTT0CodI3dX43M2m+qOoh4WkemiMd2BYQxl37LUl7s6icLF
   uGgikx/OfnSouZ6XPWfk/U7ON0GK9DnMt6caiUj2p4950rKHB+dHaEF/W
   hOZVHKDRqD6lNwud2K+LmudDSZZhYl9z5CrK1nsEH11YKF6KD6MiiNy0s
   s=;
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
   d="scan'208";a="55115572"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 11:18:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 61DD2E027C; Thu, 29 Sep 2022 11:18:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ACD17E0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 11:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wP2u3cXWgX6mBoxuOvSg5WtkmS4MddOM3TRwYsZ57Z8=;
  b=b7bxgkpUw7HJ9zYBmebypBgHU1GFXnqgaTp7rHQk8lXMo14JK9Du2jK1
   VF7pb8Fr7/PpDvySXhkNd80k0SpPFXIPpgu6iNynsZESKZ1kY+wm3uYvl
   QZUEMQbVrBwlcvR+Wx801gKdm0OCnfe2kIiDd63vdtnK65a/wqwflYkBc
   I=;
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55115548"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 11:18:34 +0200
Date: Thu, 29 Sep 2022 11:18:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
In-Reply-To: <trinity-ccfe7d99-bf56-490a-88bf-74fad2b21b9c-1664442456545@3c-app-webde-bap27>
Message-ID: <92e58a54-fa4a-e726-4613-8c8c7bb79522@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de> <alpine.DEB.2.22.394.2209282125470.2984@hadrien> <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de> <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
 <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27> <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr> <trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657@3c-app-webde-bap27> <8076a3d9-6a67-5e48-4046-8f33f261f4bd@inria.fr>
 <trinity-ccfe7d99-bf56-490a-88bf-74fad2b21b9c-1664442456545@3c-app-webde-bap27>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1765008699-1664443114=:3818"
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 607
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/92e58a54-fa4a-e726-4613-8c8c7bb79522%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1765008699-1664443114=:3818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 29 Sep 2022, Markus Elfring wrote:

> > > > Huh?  Why would I want to use identifier?
> > >
> > > I interpret the SmPL rule “lock” in the way that source code should be found
> > > that fits to calls of selected macros (or functions) which get addresses passed
> > > from data structure members.
> > > The address determination would usually start with the evaluation of a variable name,
> > > wouldn't it?
> >
> > Sure, but in &a->b->xyz, the type of a is useless
>
> The item “a” can be used for a member access operation.

Anything can be used for anything, but it's not useful in this context.
We are interested in the object a->b which has a field called lock.

> > in figuring out whether this is a pointer to a lock,
>
> Such information should be provided by the identifier “xyz” (at the end
> of discussed expression variants), shouldn't it?

No, xyz is just an offset from the top of a structure.  To figure out what
type the value at that offset has, you need to find the associated
structure.  So you need the a->b part.

> > and in relating this expression to other expressions, perhaps with the form
> > &q->xyz that may refer to the same lock.
>
> I find the indicated concern unclear.

A single object could be called a-> b or it could be called q, eg in
different parts of the source code.  We don't care what it's called.  We
care what its type is.

> > > How would you like to improve the desired scope (or name) resolution further?
> > > https://en.cppreference.com/w/c/language/scope
> >
> > What is wrong with it as it is now?
>
> I got the impression that the representation of corresponding scopes is still unclear.

There is no real representation of scopes in SmPL.  But the type inference
does not rely on what is expressed by the semantic patch.  It just looks
at the C source code available and does the best it can.

> > > > and second the thing in the matched position is not always an identifier,
> > > > as in &a->b->lock.
> > >
> > > How would you call the item “a” then according to such an expression example?
> > > Which terminology would you prefer instead?
> >
> > a is an identifier.  It is also an expression.
>
> Would you find the SmPL term “idexpression” more appropriate then?

In the above expression, a can be matched by a metavariable that is
declared as identifier, expression or idexpression.  And if the type of a
is indicated in the metavariable declaration, the word expression can be
omitted.

> > But is not not useful in this semantic patch in any case.
>
> I find the double negation confusing in this wording.

The second "not" was a typo.

julia
--8323329-1765008699-1664443114=:3818--
