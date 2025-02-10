Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E20C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YcsRE1liEUi2DYTXcFTQBV07VseciEHeblj0al+jAhg=;
  b=Tziu9pxKdiYYOAk8HFaTOoPekypCnHql13xriWLt956cINUGe2TkMtTd
   SOcaJup7MJVz4sIVqth+LIjk7lrs1yixpTdG44S55S5ZK7+Sg28KmnEp3
   ZAXgkVsW/dc9yC4e/k2nWL58iFL6s1VjvUEv/89fY/PWxZywnJnTMUuT+
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
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207512015"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 15:52:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4622BE0D1E; Mon, 10 Feb 2025 15:52:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A189CE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 15:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YcsRE1liEUi2DYTXcFTQBV07VseciEHeblj0al+jAhg=;
  b=k/gv0COhqUwA4CPcMqqmDbsu+aExiO0OL1mTubD/5l7wY/CqTnK5lI5U
   IOO/yaU9gTUEl48o6/G35p23uu+AcobZLcLZFcdQ1H1kVsLGidbXhDOry
   FfpR03At9Q4pCNm5ZQPkR1Q+ltQulS3UFQaQ88xGSB3c6YrbkG0p9c7yx
   w=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207512012"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 15:52:16 +0100
Date: Mon, 10 Feb 2025 15:52:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
cc: cocci <cocci@inria.fr>
In-Reply-To: <1507041832.8850908.1739198923533.JavaMail.zimbra@inria.fr>
Message-ID: <6c99f67f-11ed-c3c1-948a-155e22667e24@inria.fr>
References: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr> <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr> <1948830352.8646779.1739186619092.JavaMail.zimbra@inria.fr> <6a8d84cc-8bff-d68d-5d7b-fd567627149@inria.fr> <1932675609.8662032.1739187744210.JavaMail.zimbra@inria.fr>
 <b0221fbf-5e28-65c8-b5e9-9440e86bcd45@inria.fr> <1507041832.8850908.1739198923533.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Creating function definitions from function pointers in
 a struct with coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2394
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/6c99f67f-11ed-c3c1-948a-155e22667e24%40inria.fr>



On Mon, 10 Feb 2025, Fonyuy-Asheri Caleb wrote:

> Follow up question please:
>
> How can i match function pointer calls such as
>
> ctx->ops.my_function(int id, struct data_struct data);

When you call a function, you don't put the types on the arguments.  If
you want to specify the types, you can make metavariables of a certain
type like:

@@
int id;
struct data_struct data;
@@

julia
>
> or
>
> ctx->my_function(int id, struct data_struct data);
>
> I can't seem to get this working.
>
>
> Caleb
>
> ----- Original Message -----
> > From: "Julia Lawall" <julia.lawall@inria.fr>
> > To: "Fonyuy-Asheri Caleb" <fonyuy-asheri.caleb@inria.fr>
> > Cc: "Julia Lawall" <julia.lawall@inria.fr>, "cocci" <cocci@inria.fr>
> > Sent: Monday, February 10, 2025 12:56:20 PM
> > Subject: Re: [cocci] Creating function definitions from function pointers in a struct with coccinelle
>
> > On Mon, 10 Feb 2025, Fonyuy-Asheri Caleb wrote:
> >
> >> Thanks a lot Julia.
> >>
> >> It works now.
> >
> > Excellent :)
> >
> > julia
> >
>
