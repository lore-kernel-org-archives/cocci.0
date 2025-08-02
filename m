Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C3EC87FD2
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=n6+JzzDrLf3sBa+kpJjcUHCFk1mo3IdJR80M3Bn01dA=;
  b=Ep9wSbjKd4d5AkzVyx9HW6y/KXmQiwpS8w5nahVII8yG+58ENclXK0fl
   UvrtZ6SV9e70mslbta4nv7fSylP4TCwC+tyroK+pJBhJ3q7n+j4xs0ve+
   1G1EiuCj5n3R5wyQvz5jeThVyv7THOwqI9rg053pdQWHlJ84c21Ai0gJQ
   Q=;
X-CSE-ConnectionGUID: nquQ0O4TS6yxHDH03WBSgw==
X-CSE-MsgGUID: blKeyn9LSoOHyL4efmYvmg==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233968383"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 19:38:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AEB75E0BE9; Sat,  2 Aug 2025 19:38:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F144CE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 19:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n6+JzzDrLf3sBa+kpJjcUHCFk1mo3IdJR80M3Bn01dA=;
  b=R/9cl7i4ANq1Yp391IDB8LSotmeuMW13434hKyXBXt0UCk8Wx4B8Ze7V
   nyuyffRUsQZr8Qtmr2ytOUc3Ysw0QKzDy0UpTRFWDPlHPKRVhVCEzOukN
   /QVSIfzw2kN92gdsPmff+tYNQbq8sCRDeYAkyqSbrKJRLRRDPWYrEd9xV
   0=;
X-CSE-ConnectionGUID: Xo1fOxE1Qwqb9D6VpMuGdw==
X-CSE-MsgGUID: fG5YCgCRTEWu8FAyuvby2Q==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122665793"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 19:38:34 +0200
Date: Sat, 2 Aug 2025 19:38:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, 
    Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
Message-ID: <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de> <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de> <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr> <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de> <alpine.DEB.2.22.394.2508021326250.3428@hadrien> <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de> <alpine.DEB.2.22.394.2508021353080.3428@hadrien> <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien> <c5042d2d-43df-4276-9611-da4f30763940@web.de> <alpine.DEB.2.22.394.2508021502250.3428@hadrien> <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de> <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de> <alpine.DEB.2.22.394.2508021803360.3428@hadrien> <51664351-746c-4d7a-ae45-2a610ba45176@web.de> <alpine.DEB.2.22.394.2508021822490.3428@hadrien> <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-665139815-1754156313=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2944
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508021935250.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-665139815-1754156313=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> >>>>>      The one in the if is matching with the call closest to it,
> >>>>
> >>>> I interpret this hit as a false positive.
> >>>> (The first lock call in the if branch is not the relevant companion call
> >>>> from the function implementation.)
> >>>>
> >>>>
> >>>>>                                                                 not the
> >>>>> call at the beginning of the function.
> >>>>
> >>>> This is an essential requirement for the discussed source code search pattern,
> >>>> isn't it?
> >>>
> >>> No.
> >>
> >> I hope still that a better common understanding can be achieved.
> >>
> >>
> >>>      I don't understand why you think that.
> >>
> >> The source code search pattern tries to find a pair of lock calls.
> >> Is the passed expression determined for the metavariable “y” after the second
> >> lock call was found at the beginning of the function implementation?
> >
> > I don't understand this at all.
>
> Does this feedback indicate another communication problem?
>
>
> >                                  Coccinelle doesn't care about the
> > beginning of the function, unless you start the pattern with a function
> > header or a ...
>
> Where does the statement “action_lock(&blockage1);” appear in the implementation
> of the function “my_action_test”?

It is at the beginning of the function.  But that the fact that x matches
&blockage1 n one place doesn't mean that it can't match something else
when checking for a match at another place in the code.  If you hava a
function like

int f() {
  a(1);
  a(2);
  a(3);
}

and your semantic patch is:

@@
expression x;
@@

* a(x);

Then all calls to a will be marked, because the pattern can march in three
different places, with three different bindings of x.

>
>
> > In all cases, Coccinelle looks at every node of the control-flow graph and
> > tries to match the pattern there.  It doesn't care about beginning middle
> > or end.
>
> But should the analysis tool care more for selected function call combinations?
>
> Would it be possible to determine that special control flow from an if branch
> would be inappropriate according to the mentioned SmPL code?

If you don't want a match to go over an if, you have to add the if to the
pattern to specify that.

julia

> Regards,
> Markus
>
--8323329-665139815-1754156313=:3428--
