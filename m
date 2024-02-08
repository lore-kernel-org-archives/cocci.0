Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6009DC48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CD7SmLtHqzQ3nogD04wXLKDYnBi+fVG2G9/Rlz75IOM=;
  b=UGjJzuESzEPv18h9TIg/4YM+9tVjoOxe75sDj3ZEuoH3NBn/Q71GaVih
   SYQ9gbgeLpJN9SWzaVh9YH4CAgY0AC/doHqWQlCNW1dObNNh5rBNh6vFW
   FvuK7SBv3RhCVpAWwS4wrUSSLX2NL3lJvn0HLtrGFb9ZA39sZdHWpNp3D
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150963848"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 14:24:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68377E0CD7; Thu,  8 Feb 2024 14:24:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9110DE008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 14:24:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:cc:subject:in-reply-to:message-id:references:
   mime-version;
  bh=CD7SmLtHqzQ3nogD04wXLKDYnBi+fVG2G9/Rlz75IOM=;
  b=ZzpDusaIxI2jw7tuV43TZVvjVVQGfq9LCMXJ2RAvQxLK6qppNzp6N7pv
   mrM2phehXqu4DzEMrIjZmj07gv7iRSd+LUUqr4aR2thvvOcsX2DfPveeT
   HM5i2zTwdOMv6vNyTFhR/0ncDStFG41TgeTjpB3O2Q6q1+2HY6/jpjDDJ
   o=;
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="79107622"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:24:56 +0100
Date: Thu, 8 Feb 2024 14:24:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr>
Message-ID: <55ea3e4-8ef8-b457-ea92-9d612ba9d943@inria.fr>
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de> <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr> <1f8cb65b-715f-404c-84f7-8eee6de02352@web.de> <e2189114-2fa3-1045-1ae1-fb308b8c5c1f@inria.fr> <cffc1d24-5bb3-4a90-9593-31d3905449e4@web.de>
 <510575-bbc0-442-85a3-3c2fa510aba7@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-966310466-1707398695=:3408"
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1518
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/55ea3e4-8ef8-b457-ea92-9d612ba9d943%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-966310466-1707398695=:3408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 8 Feb 2024, Julia Lawall wrote:

>
>
> On Thu, 8 Feb 2024, Markus Elfring wrote:
>
> > >>>> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci test2-switch_opposite_dependencies-20240208.cocci
> > >>>> …
> > >>>> meta: semantic error: position cannot be inherited over modifications: call_pos
> > >>>>   File "test2-switch_opposite_dependencies-20240208.cocci", line 28, column 44, charpos = 572
> > >>>>   around = ';',
> > >>>>   whole content = position find.call_pos, find.declaration_pos;
> > >>>>
> > >>>>
> > >>>> Will source code transformations become better supported according to
> > >>>> opposite SmPL dependencies?
> > >>
> > >> I would appreciate more constructive feedback for this test result.
> > >
> > > Once you make transformations, the positions of the
> > > changed code have changed.
> >
> > I propose to take the specification “adjustment2 depends on !test_switch”
> > better into account .
> > This case distinction is already working as expected for the
> > specification “virtual test_switch” according to another test case variant.
>
> And?  The fact that one case is the negation of the other doesn't do
> anything to imply that eg multiple matches cannot occur in the same
> function.
>
> > How will the handling of  “if … else …” constructs evolve further for SmPL code?

You need to figure out how to put the two cases in the different branches
of a single disjunction.

julia
--8323329-966310466-1707398695=:3408--
