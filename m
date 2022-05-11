Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47E1C433EF
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pStqKjjXaYNUKBIq5BLQtY4jj15+ccjBCplXrw+Htyw=;
  b=VHOUWRfvwDQ1vy6VcTSSIFDrymNw3hHaUyRBhNfLLrhx9uCYlYwmjpTU
   CrL2IIL6TSHZ0QYXQok9+ljcDB/EfiyttEWXirjBAciJTVCNmgKQkTPj7
   B7mXjhygk2ZQVxOaKy5Zb5tV9DghhbFj2NxX7/fsa0kNWaT58QMx3CHim
   M=;
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
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="35695535"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 09:44:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9185E0265; Wed, 11 May 2022 09:44:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E226E0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 09:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pStqKjjXaYNUKBIq5BLQtY4jj15+ccjBCplXrw+Htyw=;
  b=H1/ummHDGnXvl6MKrTMJ9mDyLGxKxoQR54lymKIp34V1SYzT9m68DvcJ
   FFFenZQf5KRJgBdzpgkzahIKPK8i7M11wRC7btbrwnTdoBuu00ExWXcZY
   i7SO9IKJ0LAjKUlaAZRNIyTOxJwhTwibp5lR/kTibWSsCIVAflOTHul1u
   Y=;
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="35695494"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:44:31 +0200
Date: Wed, 11 May 2022 09:44:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205110943320.2811@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com> <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com> <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com> <alpine.DEB.2.22.394.2205101236050.2667@hadrien> <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1921565022-1652255071=:2811"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 379
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205110943320.2811%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1921565022-1652255071=:2811
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 11 May 2022, Alessandro Carminati wrote:

> I'm planning to stop bugging this mailing list, but before that, please allow me a final question. That is related to what I have done so far.
> My current implementation is the following.
> ```
> @excluded@
> type T;
> identifier i;
> position p;
> @@
>
> (
>  T i@p(...);
> |
>  extern T i@p;
> |
>  T i@p(...,......);
> )
>
>
> @r@
> type T;
> identifier i;
> expression E;
> position q != excluded.p;
> position p : script:python(i) { p[0].current_element == i};
> attribute name __randomize_layout;
> @@
>
> (
>  T i@q@p;
> |
>  T i@q@p=E;
> )
>
> @rr@
> type T;
> identifier i;
> expression E;
> attribute name __randomize_layout;
> @@
>
> (
>  T i;
> |
>  T i=E;
> )
>
> @script:python@
> i << excluded.i;
> @@
> print (i)
> ```
> It is a suboptimal version of Julia's last proposition.
> It happens that in a file a statement I expect to be matched is not detected.
> Troubleshooting the issue, I see a behavior that does not fit the model I have in my mind. This suggests to me that things (coccinelle under the hood mechanisms) are more complicated than I think.
> back to the point:
> Running the script and printing only the rule "rr", which is the same as "r" without positions, the results presents a set of entries containing the entry I'm interested in.
> Running the same script but printing only the rule "excluded", I see that the result is an empty set.
> Finally, running the script using only the "r" rule, the entry I'm interested in is not there.
> Surprisingly (for me), removing the position constraints coming from the rule "excluded" (position q != excluded.p;) from the rule "r", the entry appears.
> My question then is the following: How can the rule "excluded" that presents an empty set influence the rule "r"?
> Speculating Julia's words on a previous answer I got, I guessed that somehow an empty set could be treated differently, so I added a line into the target c file to make at least "excluded" match one line. But it didn't make any difference.

Sorry, but I can't answer a question at that abstract level.  Please send
the precise example (semntic patch and code), and I will check on what
went wrong.

julia

>
> Alessandro 
>
>
>
> Il giorno mar 10 mag 2022 alle ore 12:39 Julia Lawall <julia.lawall@inria.fr> ha scritto:
>       Here is a suggested solution for all of the problems reported so far:
>
>       @r@
>       type T;
>       identifier i;
>       expression E;
>       position p : script:python(i) { p[0].current_element == i };
>       attribute name __randomize_layout;
>       @@
>
>       (
>       T i(...);
>       |
>       T i(...,......);
>       |
>       extern T i;
>       |
>       T i@p;
>       |
>       T i@p=E;
>       )
>
>       @script:python@
>       i << r.i;
>       p << r.p;
>       @@
>       print (i)
>
>       ----------------------
>
>       The problem with __randomize_layout is that the Coccinelle parser is not
>       recognizing it as an attribute.  You can force that by putting a
>       declaration in the semantic patch.
>
>       It seems that ... in a function parameter list does not match the ... in C
>       for a variable list of arguments.  That ... can be matched explicitly by
>       ...... so I have added another case with that.
>
>       I als combined all of the patterns into one rule.  By inheriting the
>       position varaible p into the python rule at the end, that python rule is
>       only executed if p is defined, which makes it select the cases of interest
>       and ignore the others.
>
>       julia
>
>
>
--8323329-1921565022-1652255071=:2811--
