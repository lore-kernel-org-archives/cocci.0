Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3307EC04A95
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0zIQ/OMBntXHACoifA1B2OSC2lvl3A4M95Gq56pz5Hc=;
  b=YWGDmcRBhUlgi4jbiaBq8u51R+M41NFUbZ1I9zInxAKciSx5zvpgYxbC
   frrJfTvTO4DM/qBZzTjDQMyKHHvtqvgF677Yj6wqYaBsDlq5aJ+XJ6rYV
   9U2VsKIu4tf4U3IFMa+YzHCu5Jc0ILq05TIhLNVh9xrbRm6DYhYWOyYYc
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67869494"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 14:26:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5D76E01D1; Sat, 22 Oct 2022 14:26:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A0537E004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 14:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0zIQ/OMBntXHACoifA1B2OSC2lvl3A4M95Gq56pz5Hc=;
  b=LFmyOCc3kRSQrucl9W5kjSUqxNBo7uQzN6LuBM+cR2Y5NoKCA0Rm+YPf
   Ol0LtsVZQYt3rDvuK4wIQiz4LAYYIQ30oKA2KXqhF8PXGiu4mYA3Jlfdb
   TLYvpYcmGjHmUogrGGZLnUew7W9RjCm2F7Yb2xqonfR+9x0DMxSSykRBG
   Q=;
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67869493"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:26:15 +0200
Date: Sat, 22 Oct 2022 14:26:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <eb2be587f68870a1394fef6cedb15d142a26a29a.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210221418000.2783@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>  <20220905090915.3569051-1-jtojnar@gmail.com>  <alpine.DEB.2.22.394.2209051246490.2731@hadrien>  <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>  <alpine.DEB.2.22.394.2209051427090.2731@hadrien>
  <CAFGSp1umoczUe4npSesAUOLgSq=9VkvLUOV3x1hSvSajqQkGfw@mail.gmail.com>  <alpine.DEB.2.22.394.2209051445570.2731@hadrien>  <CAFGSp1vuGyiT86c7vq9MmYWaP06vRLo4OLQTREpHK_fw8vfEyg@mail.gmail.com>  <alpine.DEB.2.22.394.2209052150160.3611@hadrien> 
 <CAFGSp1vDA7DBgmtQeYu255M_e9zQYCPVAryL15OikEz+Rf1qyQ@mail.gmail.com>  <alpine.DEB.2.22.394.2209052231030.3611@hadrien> <eb2be587f68870a1394fef6cedb15d142a26a29a.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-280520085-1666441575=:2783"
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 667
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210221418000.2783%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-280520085-1666441575=:2783
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Oct 2022, Jan Tojnar wrote:

> On Mon, 2022-09-05 at 22:35 +0200, Julia Lawall wrote:
> > Not so clear what the impact of this is.  I prefer tabs to be used
> > when possible.
>
> I very much prefer tabs myself but the choice of tabs vs spaces is not
> important. As long as they are used consistently. Unfortunately, that
> is not currently the case, which leads to various issues:
>
> Most importantly, when a developer edits a code with mixed indentation,
> they will almost certainly adjust the indentation in one direction or
> another. This means that the patches will include extra changes
> unrelaated to the main contribution, making them more difficult to
> review and retrospectively analyze.
>
> Additionally, different contributors may have different visual tab
> widths, which can cause indentation to “jump” making it harder to grasp
> the code nesting. Editors often allow to adjust this but users
> would need to do it in their text editor, Git client, e-mail client
> and maybe even GitLab. For example, the following image is what I saw
> when I reviewed the patch earlier from this thread in my Git client:
>
> https://imgur.com/VeM6jbN
> (I highlighted the actual nesting of the syntax tree with red arrows.)
>
> And that assumes all contributors use the same visual tab width.
> If that is not the case, the nesting will be mangled no matter
> how the developer viewing the code sets the width in their editor.
>
> ----
>
> It looks like the original codebase used two spaces for indentation (as
> seems to be the convention for OCaml [1]) but later, tabs started to
> creep in.
>
> [1]: https://ocaml.org/docs/guidelines#using-tab-stops
> Though, their argument against tabs is as fallacious as always.
> Their only valid point actually argues against mixed indentation,
> which could just as well be used to deny using spaces for indentation.

Thanks for your thoughts, but I'm sorry nothing is likely to happen on
this.  We don't have the development resources for this to be a priority.

julia
--8323329-280520085-1666441575=:2783--
