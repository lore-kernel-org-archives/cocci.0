Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22215C02192
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2025 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lT3//djcMWgFDxORVVRfVUBZWP8Nh7IDkXPIP5pVhDE=;
  b=ahRwd5hSCOfRzuCCfl+RfI47He3JtbigFUk3W0sm8hF3nQu6Et10qA8O
   /bKtpSr1GG/strNHS85/IjBtpukww8484T08YetzMEqkvIHRJsTl/3pwk
   nB6pbAGYH/LjJ3tfCQyLfrtNJ69OQ3I9Vqb03YGLtoApiyX93dIZ1VbU3
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206718661"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Feb 2025 13:11:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A49B0E0D1D; Wed,  5 Feb 2025 13:11:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9AB1DE0260
	for <cocci@sympa.inria.fr>; Wed,  5 Feb 2025 13:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lT3//djcMWgFDxORVVRfVUBZWP8Nh7IDkXPIP5pVhDE=;
  b=cGp63Gik8gFNFT4K/IKP8n9d07KinwIxdAGHsT/ETJ067yTpSIg+fbJB
   qHdIfwLuz9Dkjo8XIVot8xPw1gyfuKn0UQxmjHz6IQjN6ZHjEy7EGVAC5
   4JMSE+VQgvw2RkXnc7sHG/+tFndi3xztJsk+IAxDgrgfYWPnGe72MJ4xA
   4=;
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206718658"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:11:42 +0100
Date: Wed, 5 Feb 2025 13:11:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <55fe2528-2405-4762-8e2c-f326810dc2ea@web.de>
Message-ID: <9cfd83f7-cc7-fbf-1432-c3ce47337987@inria.fr>
References: <55fe2528-2405-4762-8e2c-f326810dc2ea@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Increasing awareness for short-circuit evaluation
 consequences by SmPL disjunctions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2347
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/9cfd83f7-cc7-fbf-1432-c3ce47337987%40inria.fr>



On Wed, 5 Feb 2025, Markus Elfring wrote:

> Hello,
>
> Disjunctions of the semantic patch language are using short-circuit evaluation.
> It has got the consequence that the last element of the specified condition will
> only be checked if all previous parts did not match. Such a technical detail
> can lead to a recommended ordering of condition parts if you would like to care
> for optimal run time characteristics of SmPL code.
>
> The usage incidence might be unclear for involved case distinctions.
> How do you think about to clarify possibilities any further for the reordering of
> SmPL disjunction items?

What is unclear?  The disjunction branches are not reordered.

julia
