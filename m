Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A97C2BBCA
	for <cocci@archiver.kernel.org>; Tue, 25 Jun 2024 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zT3nd7NQ6d1JduF5g1vxwZcbeB6AsU61gQtEKXTLZvs=;
  b=Otk7Vd3ifHWOwlPtEjzYaXSyGPguJFJRPLYey/BG6oMtRFqpP+bkaoHY
   xuCeZWY/FnEh8uL9CnfHy0OPzSMNHFmS8EuB3dQxJEDzzoANFLkC9wBpx
   DxGHe/MWyUNZ2+A8h89+9KYJaah+58kujjoIJRfp+eMeDprFoIUk4YJj4
   4=;
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
X-IronPort-AV: E=Sophos;i="6.08,263,1712613600"; 
   d="scan'208";a="172305072"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2024 09:46:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2198E0BE9; Tue, 25 Jun 2024 09:46:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 46444E00B6
	for <cocci@sympa.inria.fr>; Tue, 25 Jun 2024 09:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zT3nd7NQ6d1JduF5g1vxwZcbeB6AsU61gQtEKXTLZvs=;
  b=I0MT7wdQ2EwY+0ZieYTs8jwKHBFYjflqavmh1xy0iOgU5YoiE9u/kC3m
   sDMd2A3cupJyIUuizK2JgEPVHMrgVZP6TlfjxsIuFq9PKFCre58zdet3r
   EMuNMOe9xxwc542z6YNOssMiAsw7hNwhu/NSQ5jNHN1bxkUfKeVoDbpwT
   A=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712613600"; 
   d="scan'208";a="172305036"
Received: from 203-174-183-243.bri.static-ipl.aapt.com.au (HELO hadrien) ([203.174.183.243])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:46:12 +0200
Date: Tue, 25 Jun 2024 17:46:07 +1000 (AEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel@gmail.com>
Message-ID: <35a285c7-bed4-8c72-15ea-e22a672d9373@inria.fr>
References: <c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Flatpak package for Coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1797
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/35a285c7-bed4-8c72-15ea-e22a672d9373%40inria.fr>



On Sun, 23 Jun 2024, Jan Tojnar wrote:

> Hello Julia and everyone!
>
> To make Coccinelle more easily available to a wider range of people, I
> have decided to package it using Flatpak [1], a distribution-
> independent package manager backed by Freedesktop.org and preferred by
> many developers of Linux desktop environments like GNOME, KDE or
> Pantheon. This will be useful for situations where Flatpak is more
> available or familiar than OCaml toolchain, such as for most GNOME
> developers.
>
> Eventually, the goal is to have it available in the Flathub repository
> but there are several (numbered) questions to resolve before that can
> happen.
>
> First, each app requires an ID [2] in reverse-DNS format. I think
> `fr.inria.Coccinelle` would be nicest. But I have also seen
> `fr.lip6.Coccinelle` floating around but that might be older domain
> name. And following the guidelines literally (you should have control
> over the domain), it would probably have to be
> `fr.inria.gitlab.coccinelle.Coccinelle` or
> `fr.inria.gitlabpages.coccinelle.Coccinelle` but that feels over the
> top.
>
>     (1) Is `fr.inria.Coccinelle` acceptable?

Yes.  The lip6 association is indeed out of date.

>
> Second, uploading a package to Flathub requires an AppStream [3]
> manifest, which contains items such as textual description of the
> project, categories, authors, links and information about releases. I
> took the description from the Coccinelle website but I am not sure what
> the copyright status is:
>
> > Coccinelle is a program matching and transformation engine which
> provides the language SmPL (Semantic Patch Language) for specifying
> desired matches and transformations in C code. Coccinelle was initially
> targeted towards performing collateral evolutions in Linux. Such
> evolutions comprise the changes that are needed in client code in
> response to evolutions in library APIs, and may include modifications
> such as renaming a function, adding a function argument whose value is
> somehow context-dependent, and reorganizing a data structure. Beyond
> collateral evolutions, Coccinelle is successfully used (by us and
> others) for finding and fixing bugs in systems code.
>
> Flathub and distro tooling combine metadata of software projects in
> their repositories into indexes and other derivative databases so they
> require the AppStream metadata to be distributed under one of several
> licenses [4] vetted for mutual compatibility (e.g. Creative Commons,
> Public Domain, or GNU Free Documentation License).
>
>     (2) Could you clarify who the copyright holder of the above
> description is, and if it can be shared under one for the licenses
> listed in [4]?

I believe that I wrote the text.  Unfortunately, it predates the websute
git repository.  Do you have any suggestion about the licenses?


>
> Third, it is preferred [5] to ship the AppStream metadata upstream so
> that other distributions can use it. Shipping the metainfo in the
> Coccinelle repository would require updating the file with a new
> version and date before each release but that can be integrated into
> the existing maintenance version script. No problem if you do not want
> that, we can maintain it locally in a Flathub repository.
>
>     (3) Do you wish to include the AppStream metadata in the
> repository?

I would hesitate at the moment to touch the version release script if it
is not necessary.  Currently, we have no maintainer for this code.
Someone new will start working on Coccinelle in the fall, and perhaps this
person could help with this.  But for now it seems safest not to
complicate the release process.

>
> Fourth, the Flatpak manifest can be also included in the Git repository
> to allow building Coccinelle from the repo in a Flatpak environment.
> This would improve access to the development versions of Coccinelle
> but, since people who need those are probably more likely to be able to
> obtain OCaml toolchain themselves, it might not be worth the
> maintenance burden. I can help but I understand if this is not
> something you want to bother with.
>
>     (4) Do you wish to include Flatpak manifest in the repository?

What is the maintenance effort involved here?  Because it is often the
case that if someone reports a bug, then we fix it and hope that the
person will be able to use the source code from github.

> On that note, having the Flatpak manifest in the repo would also allow
> us to have GitHub/GitLab CI (Continuous Integration) environment
> automatically build latest version of Coccinelle and allow users to
> download it without having to build it, just like Flathub will enable
> that for stable versions of Coccinelle.
>
>     (5) Are you interested in such integration?

Sorry, I don't understand the relation between 4 and 5.  Is there one
thing to do with two benefits?

> Lastly, one of the goals of Flatpak is to have upstream developers
> publish their software using Flatpak themselves, essentially creating a
> singular distribution platform for Linux systems. It is recommended [6]
> that I ask you if you want to submit Coccinelle to Flathub yourself.
> But I understand that you are busy and I can maintain the package if
> you will not.
>
>     (6) Do you want to maintain Coccinelle package on Flathub yourself?

I would prefer not to.

>
> I have opened a draft PR on GitHub so that external reviewers can give
> input on the patches before submitting them here (if desired):
>
> https://github.com/coccinelle/coccinelle/pull/370

Thanks.  I don't know anything about Flatpak, but I hope that if others
use it they will give feedback.

Thanks for this effort!

julia

> I have also created a PR to add Coccinelle to Flathub:
>
> https://github.com/flathub/flathub/pull/5354
>
>
> Cheers,
>
> Jan
>
> [1]: https://en.wikipedia.org/wiki/Flatpak
> [2]:
> https://docs.flathub.org/docs/for-app-authors/requirements#application-id
> [3]: https://en.wikipedia.org/wiki/AppStream
> [4]:
> https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html#tag-metadata_license
> [5]:
> https://docs.flathub.org/docs/for-app-authors/requirements#acceptable-but-should-be-submitted-upstream
> [6]:
> https://docs.flathub.org/docs/for-app-authors/submission/#theres-an-app-that-id-like-to-see-on-flathub-but-im-not-the-developer
>
>
