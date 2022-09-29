Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8989DC07E9D
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rALwtPOm+byCyxHSAY55+xuPr17apoouJtqodmI2iVQ=;
  b=SzCfd+YNnfie9pjkCyFsxQoNrtUoXV+PPB0Y5HMzoex2fCEbiRwZk2dD
   cdXpXWB4TtG4U0JgelIkUSBWHkeuiI0EJ6iQxsm2UPZ1RG42bppi3Tf37
   CevqXU8K+3DkGNm0A6kAxr32bwXzRQyFSGSn5hqKAjBY6Yf8iPk0jPypP
   I=;
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
   d="scan'208";a="55091038"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 09:56:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9257FE028F; Thu, 29 Sep 2022 09:56:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8B13E0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 09:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rALwtPOm+byCyxHSAY55+xuPr17apoouJtqodmI2iVQ=;
  b=qNH58RXA9RCEV3Vnh4KCdjPR2vuxvbtFWAkC85K+N6EgRdjy3Hpll3XV
   19+4GVfGi7cNbFuRMvdwd19H/esXv/4wdEsdXYEoYXf+nyVw66kczE8aX
   RvfRdvvj6Op8pqMQU1lEyeRZDdDL6ofV4PMINdeG5h9hIEyr4wWQWzk8U
   4=;
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="24981043"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 09:56:31 +0200
Date: Thu, 29 Sep 2022 09:56:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
In-Reply-To: <trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657@3c-app-webde-bap27>
Message-ID: <8076a3d9-6a67-5e48-4046-8f33f261f4bd@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de> <alpine.DEB.2.22.394.2209282125470.2984@hadrien> <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de> <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
 <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27> <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr> <trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657@3c-app-webde-bap27>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-593725181-1664438190=:3818"
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 605
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/8076a3d9-6a67-5e48-4046-8f33f261f4bd%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-593725181-1664438190=:3818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 29 Sep 2022, Markus Elfring wrote:

> > > > In SmPL, if you want to declare a metavariable that matches an expression
> > > > of a certain type, you don't have to write the word expression.
> > >
> > > * Would you like to restrict the source code search to compound data types?
> > >
> > > * How do you think about to check if there are differences in the software
> > >   run time characteristics for the application of the metavariable kinds
> > >   “identifier” and “type”?
> >
> > Huh?  Why would I want to use identifier?
>
> I interpret the SmPL rule “lock” in the way that source code should be found
> that fits to calls of selected macros (or functions) which get addresses passed
> from data structure members.
> The address determination would usually start with the evaluation of a variable name,
> wouldn't it?

Sure, but in &a->b->xyz, the type of a is useless in figuring out whether
this is a pointer to a lock, and in relating this expression to other
expressions, perhaps with the form &q->xyz that may refer to the same
lock.

So we dont' care about the thing that is immediately to the right of the
&.  We care about the complete thing that is between the & and the ->xyz.
And that thing is an expression.

>
> > First an identifier doesn't have a type, it's just a sequence of characters.
>
> Can the view be appropriate that identifiers have got the data type “char[]”
> (or “std::string”)?
> They refer to additional information.

In Coccinelle those can be matched as expressions or as idexpressions (an
expression that if required to have the form of identifier).

An expression is a piece of code that has a value.  Hence an expression
has a type that describes that possible value.

An identifier is a sequence of characters.  Some identifiers are
expressions, but not all.

> How would you like to improve the desired scope (or name) resolution further?
> https://en.cppreference.com/w/c/language/scope

What is wrong with it as it is now?  The type inference of Coccinelle
follows the scope rules of C (like any type inferencer for any language).

> > and second the thing in the matched position is not always an identifier,
> > as in &a->b->lock.
>
> How would you call the item “a” then according to such an expression example?
> Which terminology would you prefer instead?

a is an identifier.  It is also an expression.  But is not not useful in
this semantic patch in any case.

julia
--8323329-593725181-1664438190=:3818--
