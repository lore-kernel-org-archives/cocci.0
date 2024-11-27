Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5776CE77171
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KzpkxN9nUD988UPcQZS50oLKtPpbHNoSUURW309BxGk=;
  b=NKaDbIVNLUR+ASAr3SjToDUJ8aqzkB4J+b2iMxpTRKiYDwSdx2delout
   C4ICpcsMOdi4y9jVU2VzhKXPuEmI3c22yVFQsCignlS5wj5RTTqhNsf2a
   cjEgnWP6OyC5Vuz053uS0+9QM8j7wX9DgrigQFpF5V4kPsfppyO4KYATN
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@avm.de
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421265"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9517E0D21; Wed,  4 Dec 2024 23:28:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F8F3E00B6
	for <cocci@sympa.inria.fr>; Wed, 27 Nov 2024 16:29:29 +0100 (CET)
IronPort-SDR: 67473ad8_pMZmX3ZtfhSo0ZpJAVMoKVerVnJa1zyDktaCNkjUgIq3gCt
 6oYaDY0A+izkKhwASprPEwLAQdzBlo6itz4jhxw==
X-IPAS-Result: =?us-ascii?q?A0EPAACZOUdnj3f0KtRaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDfVozBAtIhFaDT4ROX4ZRgiEDgRORPBwzinmBfg8BAwENMRMEA?=
 =?us-ascii?q?QEDAQOFAAKKXAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBAQE5BUmFQQY0DYJiAYEkgSUBAQEBAQEBAQEBAQEBHQIIYwEBH?=
 =?us-ascii?q?QEBAQECASMPAQ0BATcBBAsLGAICJgICKysGE4MBAYJBIwewGnqBMoEBggwBA?=
 =?us-ascii?q?QaBCNsXgWQJgRouAYhLAYVpG4NieieBZESBFYE7gTc4PoRDg1uCaYJEZ1OCX?=
 =?us-ascii?q?3YlTYRpgj2BDYFvgg+IO3geHR0wgi6BN4lFUnscA1kyAUsKNQw4cSEsA4JHg?=
 =?us-ascii?q?jWBUoJGgRSDLhyBQgU3CoMHgTQ3Ag0CgkVzH4dkgQuDXmUvAwMDA4IjgRiBa?=
 =?us-ascii?q?4RFHUADeD03FBsGoWcBRoNIAXsECgUBG4EgCzIrGwELHgsGLJJqj3mjIAeCO?=
 =?us-ascii?q?IFljBaVSEWFSJF2kwCWG4Jgo1oLG4UogWc6gVwzGiSDNglGAxkPjA6CExkfg?=
 =?us-ascii?q?mSBEcggQjU7AgcBCgEBAwmRSIFLAQE?=
IronPort-PHdr: A9a23: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
 aSLHD7aQvRdguk5HV0=
IronPort-Data: A9a23:FJ6HY6gq1qA6ZePROjgK6U4pX161ThQKZh0ujC45NGQN5FlHY01je
 htvC2vSOPqIZGCmf4pwaI++/E8D75TTxtNjTwc/qXtjES9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtOg06/gEk35qir4WlH5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGUhAoGoIy2eRNO3AW1
 b8IIxFSbCuZiLfjqF67YrEEasULKcDqOMUWpHQmwTyx4fQOG8mZBfmQo4UEgHFp35Em8fX2P
 6L1bRJpKg/LYxxCIH8eFpd4kOrAanzXKmwG8QnI+/Fpi4TV5BMr0aboDdjFQ86LWORexAGd/
 l333XusV3n2M/TElGPZqyz07gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0e/X5RWN
 UlS9idGQbUOGFKDEIjjeBKSg3y+hA9Ee5lAGMxl6jqXxf+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQy69V5rlrAq9+pQSOOBMQDEYMVTQMpJTbpDvHmqYA3yBvRS5BvHcZZb+EZ+xmum
 VhmTwBn1t3/aPLnMY3gozgrZBr3+/D0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxJPEsrxTXcDUyXDcKAnoIF1Pz6vZWNE7qQMxd6TNCxz0pyXLkX14vGAneR0B3jgsI2G4M
 Sc/Rj+9FLcIYSL2NPEvC25AI8hvza/7CdXjWbjYb9cGeJF6dxSf9SpjLUWX2Wbgm1Qtj6AjK
 N+UdMysZUv2+ow5pAdas9w1iOdxrghnnDu7bcmin3yPj+HEDFbLEuhtDbd7RrxihE9yiFmOq
 44HXyZLoj0DONDDjt7/qNBOdgpUcSJlW/gbaaV/L4a+H+avI0l5Y9e5/F/rU9YNc319x7qQr
 EKuEFRV0kT+jnDhIACHICIrIrD2UJo16TpxMSUwNBz6kzIucKS+3pc5LpEXRLgA8PA87PhWS
 /JeRd6MLM4SQRv6+hMcT6LHkqpcSDqRizmjAQ+ZcRkkXps5RwX26t7uJQTu0y8VDxuIj8g1o
 pz+9waCQZM8WBlTPPTKTPeVy3Kwonkvt+ZgVGTYItRoWRvN8ao7DwfTn/MIM8U3BhGb/QSj1
 iGSGgU9idDWho0IrOnymqGPqrm2H9tEHkZ1G3fR6ZC0P3L4+lWP7JBhUuHSWxzgT0LxpbufY
 NtKw8HGMPEomEhAt6x+Ge1JyYM8/97emK9I/D97HXnkb0WZNZ04GyOohfJwj6xqwqNVnSCUW
 UjVo9lTBuivCfPfSVUUIFIoU/SH2fQqgQLt1PUSInjhxSpJ7bGCAFRzPR6NtXRnF4FLErgZm
 MUvhM1HzDaEqEsOEs2HhSVq5WizPiQ+c6E4hKo7Xq7vqCQWk29nX7KNKxXYwp+1b/d0DnILO
 R6R3arLuKRdzBHNcl01Dnn84tBejpUv5jFP4gUIHAmKqOHknd4y5gVaqh4sfzRWzzJG8uN9A
 XdqPEtLPpez/y9kqcxAfmK0ESRDOUGpwVPwwF43i2HpdUmkeWjTJmkbO+zW3kQm309DXzpcp
 pe09X3EVGv0QcTPwScCY05phPj9R9hX9AeZusSGHdyALqYqcwjena6iSmoZmSTJWfprqhX8m
 tBr2+JsZYnQFy0a+fQ7ArbH84UgckmPIWgaTMxx+K8MI3rnRwiz/jqzMGG0RNJGIq3b0E2/C
 vE2HPl1aTaF6H+soAwYVIk2GJ0luN4y5dEHRKHnGn5ejZubsQhSkczx8grQuTYVZutAwOgBL
 rHfTTagKlCrpGB1njbNpfZUO2DjbtgjYhb97d+P8+4INswitc82e3pv0YmPnm60NTF/9Em+p
 zLzZK7xzs1jx79znoDqLL5xOgWsJf73V8WK6AqWsekSXejQMMzLiRwZmmPnMytSI7EVfdZ9z
 paJj/Law2LHu+wQf13CupzcCZRM29q+bNBXPu3zMnNeuymIA+3owhkb/lGHOY57q8xc6uanV
 jmHRpOJL/BNYOhkxVpRdyR6ODQeAf6ubq7f+AWMn87VAR0ZiQH6PNer8EHyVl5idwgKBobfD
 zHlsPP/9/Faq4VxXCU/Pc9EOKMhAlHfWvoBTebT5AmoVjzixhvIv7b5jhMv5A3aEnTOQo6w/
 ZvBQQO4bxio/r3ByNZCqYFpoxkLFzBHjPItel4GsctD49xg4LXq8cxGWXnHNn1VrsA2/JTxZ
 TWLZXUnTynwNdiBndMQ//y7NjpzxMRXUjs6GtDt10qKbmG6CetsxZN/ozx47S4eliTLlYmax
 BJ3xpE0FhGvx9dlSI7/IxB9bfhPnpvn+57DxawxfwEezfrT7XXmGUGNxDZwaBE=
IronPort-HdrOrdr: A9a23:LQU0X6973N687qyOcq5uk+A6I+orL9Y04lQ7vn2ZKCY5TiX8ra
 vFoB11726PtN8uYgBEpTn+Atj8fZqxz/FICPAqTNWftVDd2FdAT7sP0WKB+UyaJ8SWzIc06U
 4KSdkHNDSfNzZHZb6R2miF+t8bsaW62au1gOLT0ndrexpnYaF47wt/FzCaHyRNNW17LJY8HJ
 qYwsZcvTKvdVQ7B/7Lf0UtWfHOoOvFkZrpCCR2ZCIP8hWElzmy6LX3CC6Z034lIlVyKc5Jyx
 mjrzDE
X-Talos-CUID: =?us-ascii?q?9a23=3A97EYempF1Wim6RuKSFqNYB7mUZ50bFrS5lTSGXW?=
 =?us-ascii?q?pUUYqWLa0Fl2r4qwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AXjF6XAyFaEeFzHkqsqU5cGACQQSaqLv0CV4IrJc?=
 =?us-ascii?q?WgtuFKA17YXCY1AuGYJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,189,1728943200"; 
   d="scan'208";a="196135636"
X-MGA-submission: =?us-ascii?q?MDHrTQlwkqHIzh0KppqzdTqmJxYY5QrR0qrU9v?=
 =?us-ascii?q?gsABDCU0Gr1HRXW+NyVGcgkFPzaz8U+S1kPRyUl+nGMNXnt8SGEA7Esq?=
 =?us-ascii?q?96/Ky+YYHUubSblfP1Ug3iubVEtiM7mobjgyHaMMzLdYqhi+XI/LN6qQ?=
 =?us-ascii?q?ectNWj0k1r9RM3uItb/riAEw=3D=3D?=
Received: from mail.avm.de ([212.42.244.119])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 16:29:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1732721367; bh=m7ZgS90R99dC49N9hkmQIj97rDW9mm1Y3O08gO3Qt0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s//k7UJ9oIsoi5ft8sdNKWHNu8OloiFvVc3rJgJFX9ZpMjVckSv4AGfMCCs/VVxwl
	 e6cn79XrXM8pDpRSUxATXe3cFBqNHvU1yDL9rfhO6aYWoUJDSYtc++yuYi5bmbY06A
	 wbzjSw4V9hefmTe2tbIMiF3xyaoMTbWcO3XHk0y4=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 27 Nov 2024 16:29:27 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 43CB880898;
	Wed, 27 Nov 2024 16:29:27 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 3534F18D90C; Wed, 27 Nov 2024 16:29:27 +0100 (CET)
Date: Wed, 27 Nov 2024 16:29:27 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, cocci@inria.fr
Message-ID: <20241127-maize-hippo-of-innovation-ad1c54@buildd>
References: <20241110013649.34903-1-masahiroy@kernel.org>
 <20241110013649.34903-6-masahiroy@kernel.org>
 <20241118-dazzling-gifted-bettong-133eb7@buildd>
 <CAK7LNATomVVvxHgy=e7rwq7EPgP7Z2UUERkyDJGQe63n6BuW3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATomVVvxHgy=e7rwq7EPgP7Z2UUERkyDJGQe63n6BuW3Q@mail.gmail.com>
X-purgate-ID: 149429::1732721367-34E14C62-FA316409/0/0
X-purgate-type: clean
X-purgate-size: 19083
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 05/11] kbuild: change working directory to
 external module directory with M=
Reply-To: Nicolas Schier <n.schier@avm.de>
X-Loop: cocci@inria.fr
X-Sequence: 2148
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/20241127-maize-hippo-of-innovation-ad1c54%40buildd>

On Tue, Nov 19, 2024 at 02:02:05AM +0900, Masahiro Yamada wrote:
> On Mon, Nov 18, 2024 at 11:47 PM Nicolas Schier <n.schier@avm.de> wrote:
> >
> > On Sun, Nov 10, 2024 at 10:34:33AM +0900, Masahiro Yamada wrote:
> > > Currently, Kbuild always operates in the output directory of the kernel,
> > > even when building external modules. This increases the risk of external
> > > module Makefiles attempting to write to the kernel directory.
> > >
> > > This commit switches the working directory to the external module
> > > directory, allowing the removal of the $(KBUILD_EXTMOD)/ prefix from
> > > some build artifacts.
> > >
> > > The command for building external modules maintains backward
> > > compatibility, but Makefiles that rely on working in the kernel
> > > directory may break. In such cases, $(objtree) and $(srctree) should
> > > be used to refer to the output and source directories of the kernel.
> > >
> > > The appearance of the build log will change as follows:
> > >
> > > [Before]
> > >
> > >   $ make -C /path/to/my/linux M=/path/to/my/externel/module
> > >   make: Entering directory '/path/to/my/linux'
> > >     CC [M]  /path/to/my/externel/module/helloworld.o
> > >     MODPOST /path/to/my/externel/module/Module.symvers
> > >     CC [M]  /path/to/my/externel/module/helloworld.mod.o
> > >     CC [M]  /path/to/my/externel/module/.module-common.o
> > >     LD [M]  /path/to/my/externel/module/helloworld.ko
> > >   make: Leaving directory '/path/to/my/linux'
> > >
> > > [After]
> > >
> > >   $ make -C /path/to/my/linux M=/path/to/my/externel/module
> > >   make: Entering directory '/path/to/my/linux'
> > >   make[1]: Entering directory '/path/to/my/externel/module'
> > >     CC [M]  helloworld.o
> > >     MODPOST Module.symvers
> > >     CC [M]  helloworld.mod.o
> > >     CC [M]  .module-common.o
> > >     LD [M]  helloworld.ko
> > >   make[1]: Leaving directory '/path/to/my/externel/module'
> > >   make: Leaving directory '/path/to/my/linux'
> > >
> > > Printing "Entering directory" twice is cumbersome. This will be
> > > addressed later.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > Changes in v2:
> > >  - Introduce a new 'srcroot' variable and clean-up code
> > >  - Reword Documentation/dev-tools/coccinelle.rst
> > >
> > >  Documentation/dev-tools/coccinelle.rst | 20 ++-----
> > >  Documentation/kbuild/makefiles.rst     | 14 +++++
> > >  Makefile                               | 80 +++++++++++++++-----------
> > >  rust/Makefile                          |  4 +-
> > >  scripts/Makefile.build                 |  2 +-
> > >  scripts/Makefile.clean                 |  2 +-
> > >  scripts/Makefile.compiler              |  2 +-
> > >  scripts/Makefile.modpost               |  6 +-
> > >  scripts/coccicheck                     |  6 +-
> > >  scripts/nsdeps                         |  8 +--
> > >  scripts/package/install-extmod-build   |  7 +++
> > >  11 files changed, 85 insertions(+), 66 deletions(-)
> > >
> > > diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> > > index 535ce126fb4f..6e70a1e9a3c0 100644
> > > --- a/Documentation/dev-tools/coccinelle.rst
> > > +++ b/Documentation/dev-tools/coccinelle.rst
> > > @@ -250,25 +250,17 @@ variables for .cocciconfig is as follows:
> > >  - Your directory from which spatch is called is processed next
> > >  - The directory provided with the ``--dir`` option is processed last, if used
> > >
> > > -Since coccicheck runs through make, it naturally runs from the kernel
> > > -proper dir; as such the second rule above would be implied for picking up a
> > > -.cocciconfig when using ``make coccicheck``.
> > > -
> > >  ``make coccicheck`` also supports using M= targets. If you do not supply
> > >  any M= target, it is assumed you want to target the entire kernel.
> > >  The kernel coccicheck script has::
> > >
> > > -    if [ "$KBUILD_EXTMOD" = "" ] ; then
> > > -        OPTIONS="--dir $srctree $COCCIINCLUDE"
> > > -    else
> > > -        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> > > -    fi
> > > +    OPTIONS="--dir $srcroot $COCCIINCLUDE"
> > >
> > > -KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
> > > -the spatch ``--dir`` argument is used, as such third rule applies when whether
> > > -M= is used or not, and when M= is used the target directory can have its own
> > > -.cocciconfig file. When M= is not passed as an argument to coccicheck the
> > > -target directory is the same as the directory from where spatch was called.
> > > +Here, $srcroot refers to the source directory of the target: it points to the
> > > +external module's source directory when M= used, and otherwise, to the kernel
> > > +source directory. The third rule ensures the spatch reads the .cocciconfig from
> > > +the target directory, allowing external modules to have their own .cocciconfig
> > > +file.
> > >
> > >  If not using the kernel's coccicheck target, keep the above precedence
> > >  order logic of .cocciconfig reading. If using the kernel's coccicheck target,
> > > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> > > index 7964e0c245ae..d36519f194dc 100644
> > > --- a/Documentation/kbuild/makefiles.rst
> > > +++ b/Documentation/kbuild/makefiles.rst
> > > @@ -449,6 +449,20 @@ $(obj)
> > >    to prerequisites are referenced with $(src) (because they are not
> > >    generated files).
> > >
> > > +$(srcroot)
> > > +  $(srcroot) refers to the root of the source you are building, which can be
> > > +  either the kernel source or the external modules source, depending on whether
> > > +  KBUILD_EXTMOD is set. This can be either a relative or an absolute path, but
> > > +  if KBUILD_ABS_SRCTREE=1 is set, it is always an absolute path.
> > > +
> > > +$(srctree)
> > > +  $(srctree) refers to the root of the kernel source tree. When building the
> > > +  kernel, this is the same as $(srcroot).
> > > +
> > > +$(objtree)
> > > +  $(objtree) refers to the root of the kernel object tree. It is ``.`` when
> > > +  building the kernel, but it is different when building external modules.
> > > +
> >
> > Thanks, I think it's nice that there is now such a clear definition.
> > $(srcroot) sounds fine to me.
> >
> > >  $(kecho)
> > >    echoing information to user in a rule is often a good practice
> > >    but when execution ``make -s`` one does not expect to see any output
> > > diff --git a/Makefile b/Makefile
> > > index cf1d55560ae2..e5f7ac7647a7 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -180,7 +180,24 @@ ifeq ("$(origin O)", "command line")
> > >    KBUILD_OUTPUT := $(O)
> > >  endif
> > >
> > > -output := $(KBUILD_OUTPUT)
> > > +ifdef KBUILD_EXTMOD
> > > +    ifdef KBUILD_OUTPUT
> > > +        objtree := $(realpath $(KBUILD_OUTPUT))
> > > +        $(if $(objtree),,$(error specified kernel directory "$(KBUILD_OUTPUT)" does not exist))
> > > +    else
> > > +        objtree := $(CURDIR)
> > > +    endif
> > > +    output := $(KBUILD_EXTMOD)
> > > +    # KBUILD_EXTMOD might be a relative path. Remember its absolute path before
> > > +    # Make changes the working directory.
> > > +    srcroot := $(realpath $(KBUILD_EXTMOD))
> > > +    $(if $(srcroot),,$(error specified external module directory "$(KBUILD_EXTMOD)" does not exist))
> > > +else
> > > +    objtree := .
> > > +    output := $(KBUILD_OUTPUT)
> > > +endif
> > > +
> > > +export objtree srcroot
> > >
> > >  # Do we want to change the working directory?
> > >  ifneq ($(output),)
> > > @@ -230,35 +247,33 @@ else # need-sub-make
> > >
> > >  # We process the rest of the Makefile if this is the final invocation of make
> > >
> > > -ifeq ($(abs_srctree),$(CURDIR))
> > > -        # building in the source tree
> > > -        srctree := .
> > > -     building_out_of_srctree :=
> > > +ifndef KBUILD_EXTMOD
> > > +srcroot := $(abs_srctree)
> > > +endif
> > > +
> > > +ifeq ($(srcroot),$(CURDIR))
> > > +building_out_of_srctree :=
> > >  else
> > > -        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
> > > -                # building in a subdirectory of the source tree
> > > -                srctree := ..
> > > -        else
> > > -                srctree := $(abs_srctree)
> > > -        endif
> > > -     building_out_of_srctree := 1
> > > +export building_out_of_srctree :=1

Nit: Adding a space between ':=1' for consistency?

> > >  endif
> > >
> > > -ifneq ($(KBUILD_ABS_SRCTREE),)
> > > -srctree := $(abs_srctree)
> > > +ifdef KBUILD_ABS_SRCTREE
> > > +    # Do not nothing. Use the absolute path.

Is this a superfluous "not"?

"Do nothing. Use the absolute path."?

> > > +else ifeq ($(srcroot),$(CURDIR))
> > > +    # Building in the source.
> > > +    srcroot := .
> > > +else ifeq ($(srcroot)/,$(dir $(CURDIR)))
> > > +    # Building in a subdirectory of the source.
> > > +    srcroot := ..
> > >  endif
> > >
> > > -objtree              := .
> > > +export srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))
> >
> > With this patch applied, the following breaks for me:
> >
> >     $ make O=build M=fs/btrfs CONFIG_BTRFS_FS=m
> >     make[1]: Entering directory '/data/linux/kbuild-review/fs/btrfs'
> >       CC [M]  super.o
> >     In file included from <command-line>:
> >     /data/linux/kbuild-review/include/linux/compiler_types.h:89:10: fatal error: linux/compiler_attributes.h: No such file or directory
> >        89 | #include <linux/compiler_attributes.h>
> >           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     compilation terminated.
> >
> > Adding 'ccflags-y += -I$(srctree)/include' to fs/btrfs/Makefile breaks
> > the build loudly.  I could make it build again with
> >
> > diff --git a/Makefile b/Makefile
> > index e5f7ac7647a7b..3d95911f1a68f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -555,7 +555,7 @@ USERINCLUDE    := \
> >  LINUXINCLUDE    := \
> >                 -I$(srctree)/arch/$(SRCARCH)/include \
> >                 -I$(objtree)/arch/$(SRCARCH)/include/generated \
> > -               $(if $(building_out_of_srctree),-I$(srctree)/include) \
> > +               $(if $(or $(building_out_of_srctree),$(filter $(srctree)/%, $(CURDIR))),-I$(srctree)/include) \
> >                 -I$(objtree)/include \
> >                 $(USERINCLUDE)
> >
> > but this does not feel good.  It building in-tree modules in this way a
> > valid thing to do?
> 
> Yes, it is a valid way.
> 
> This got broken with this commit, and fixed by the later commit,
> "kbuild: support building external modules in a separate build directory".
> 
> I will move the change for LINUXINCLUDE to this commit.

ah, thanks.  I should have seen that.

> > -VPATH		:=
> > -
> > -ifeq ($(KBUILD_EXTMOD),)
> >  ifdef building_out_of_srctree
> > -VPATH		:= $(srctree)
> > +export VPATH := $(srcroot)
> > +else
> > +VPATH :=
> >  endif
> > -endif
> > -
> > -export building_out_of_srctree srctree objtree VPATH
> >  
> >  # To make sure we do not include .config for any of the *config targets
> >  # catch them early, and hand them over to scripts/kconfig/Makefile
> > @@ -711,7 +726,7 @@ endif
> >  # in addition to whatever we do anyway.
> >  # Just "make" or "make all" shall build modules as well
> >  
> > -ifneq ($(filter all modules nsdeps %compile_commands.json clang-%,$(MAKECMDGOALS)),)
> > +ifneq ($(filter all modules nsdeps compile_commands.json clang-%,$(MAKECMDGOALS)),)
> >    KBUILD_MODULES := 1
> >  endif
> >  
> > @@ -1107,7 +1122,7 @@ export MODLIB
> >  
> >  PHONY += prepare0
> >  
> > -export extmod_prefix = $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/)
> > +export extmod_prefix =
> >  export MODORDER := $(extmod_prefix)modules.order
> >  export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
> >  
> > @@ -1799,14 +1814,10 @@ filechk_kernel.release = echo $(KERNELRELEASE)
> >  KBUILD_BUILTIN :=
> >  KBUILD_MODULES := 1
> >  
> > -build-dir := $(KBUILD_EXTMOD)
> > +build-dir := .
> >  
> > -compile_commands.json: $(extmod_prefix)compile_commands.json
> > -PHONY += compile_commands.json
> > -
> > -clean-dirs := $(KBUILD_EXTMOD)
> > -clean: private rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
> > -	$(KBUILD_EXTMOD)/compile_commands.json
> > +clean-dirs := .
> > +clean: private rm-files := Module.symvers modules.nsdeps compile_commands.json
> >  
> >  PHONY += prepare
> >  # now expand this into a simple variable to reduce the cost of shell evaluations
> > @@ -1948,7 +1959,7 @@ $(clean-dirs):
> >  
> >  clean: $(clean-dirs)
> >  	$(call cmd,rmfiles)
> > -	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
> > +	@find . $(RCS_FIND_IGNORE) \
> >  		\( -name '*.[aios]' -o -name '*.rsi' -o -name '*.ko' -o -name '.*.cmd' \
> >  		-o -name '*.ko.*' \
> >  		-o -name '*.dtb' -o -name '*.dtbo' \
> > @@ -1981,7 +1992,12 @@ tags TAGS cscope gtags: FORCE
> >  PHONY += rust-analyzer
> >  rust-analyzer:
> >  	+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
> > +ifdef KBUILD_EXTMOD
> > +# FIXME: external modules must not descend into a sub-directory of the kernel
> > +	$(Q)$(MAKE) $(build)=$(objtree)/rust src=$(srctree)/rust $@
> > +else
> >  	$(Q)$(MAKE) $(build)=rust $@
> > +endif
> >  
> >  # Script to generate missing namespace dependencies
> >  # ---------------------------------------------------------------------------
> > diff --git a/rust/Makefile b/rust/Makefile
> > index b5e0a73b78f3..742740816c4b 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -362,8 +362,8 @@ rust-analyzer:
> >  	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
> >  		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
> >  		$(realpath $(srctree)) $(realpath $(objtree)) \
> > -		$(rustc_sysroot) $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> > -		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
> > +		$(rustc_sysroot) $(RUST_LIB_SRC) $(if $(KBUILD_EXTMOD),$(srcroot)) \
> > +		> rust-project.json
> >  
> >  redirect-intrinsics = \
> >  	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 64cd046f8fd8..1aa928a6fb4f 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -3,7 +3,7 @@
> >  # Building
> >  # ==========================================================================
> >  
> > -src := $(if $(VPATH),$(VPATH)/)$(obj)
> > +src := $(srcroot)/$(obj)
> >  
> >  PHONY := $(obj)/
> >  $(obj)/:
> > diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> > index 4fcfab40ed61..6ead00ec7313 100644
> > --- a/scripts/Makefile.clean
> > +++ b/scripts/Makefile.clean
> > @@ -3,7 +3,7 @@
> >  # Cleaning up
> >  # ==========================================================================
> >  
> > -src := $(if $(VPATH),$(VPATH)/)$(obj)
> > +src := $(srcroot)/$(obj)
> >  
> >  PHONY := __clean
> >  __clean:
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index e0842496d26e..8c1029687e2e 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -13,7 +13,7 @@ cc-cross-prefix = $(firstword $(foreach c, $(1), \
> >  			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
> >  
> >  # output directory for tests below
> > -TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
> > +TMPOUT = .tmp_$$$$
> >  
> >  # try-run
> >  # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
> > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > index 12e7c15d099c..78d2ca4f25f5 100644
> > --- a/scripts/Makefile.modpost
> > +++ b/scripts/Makefile.modpost
> > @@ -111,13 +111,13 @@ endif
> >  else
> >  
> >  # set src + obj - they may be used in the modules's Makefile
> > -obj := $(KBUILD_EXTMOD)
> > -src := $(if $(VPATH),$(VPATH)/)$(obj)
> > +obj := .
> > +src := $(srcroot)
> >  
> >  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
> >  include $(kbuild-file)
> >  
> > -output-symdump := $(KBUILD_EXTMOD)/Module.symvers
> > +output-symdump := Module.symvers
> >  
> >  ifeq ($(wildcard $(objtree)/Module.symvers),)
> >  missing-input := $(objtree)/Module.symvers
> > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > index e52cb43fede6..0e6bc5a10320 100755
> > --- a/scripts/coccicheck
> > +++ b/scripts/coccicheck
> > @@ -80,11 +80,7 @@ command results in a shift count error.'
> >      NPROC=1
> >  else
> >      ONLINE=0
> > -    if [ "$KBUILD_EXTMOD" = "" ] ; then
> > -        OPTIONS="--dir $srctree $COCCIINCLUDE"
> > -    else
> > -        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> > -    fi
> > +    OPTIONS="--dir $srcroot $COCCIINCLUDE"
> >  
> >      # Use only one thread per core by default if hyperthreading is enabled
> >      THREADS_PER_CORE=$(LANG=C lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
> > diff --git a/scripts/nsdeps b/scripts/nsdeps
> > index f1718cc0d700..8ca12e2b5c03 100644
> > --- a/scripts/nsdeps
> > +++ b/scripts/nsdeps
> > @@ -19,12 +19,6 @@ if ! { echo "$SPATCH_REQ_VERSION"; echo "$SPATCH_VERSION"; } | sort -CV ; then
> >  	exit 1
> >  fi
> >  
> > -if [ "$KBUILD_EXTMOD" ]; then
> > -	src_prefix=
> > -else
> > -	src_prefix=$srctree/
> > -fi
> > -
> >  generate_deps_for_ns() {
> >  	$SPATCH --very-quiet --in-place --sp-file \
> >  		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
> > @@ -34,7 +28,7 @@ generate_deps() {
> >  	local mod=${1%.ko:}
> >  	shift
> >  	local namespaces="$*"
> > -	local mod_source_files=$(sed "s|^\(.*\)\.o$|${src_prefix}\1.c|" $mod.mod)
> > +	local mod_source_files=$(sed "s|^\(.*\)\.o$|${srcroot}/\1.c|" $mod.mod)
> >  
> >  	for ns in $namespaces; do
> >  		echo "Adding namespace $ns to module $mod.ko."
> > diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
> > index 7ec1f061a519..64d958ee45f3 100755
> > --- a/scripts/package/install-extmod-build
> > +++ b/scripts/package/install-extmod-build
> > @@ -51,6 +51,13 @@ mkdir -p "${destdir}"
> >  if [ "${CC}" != "${HOSTCC}" ]; then
> >  	echo "Rebuilding host programs with ${CC}..."
> >  
> > +	# This leverages external module building.
> > +	# - Clear sub_make_done to allow the top-level Makefile to redo sub-make.
> > +	# - Filter out --no-print-directory to print "Entering directory" logs
> > +	#   when Make changes the working directory.
> > +	unset sub_make_done
> > +	MAKEFLAGS=$(echo "${MAKEFLAGS}" | sed s/--no-print-directory//)
> > +
> >  	cat <<-'EOF' >  "${destdir}/Kbuild"
> >  	subdir-y := scripts
> >  	EOF
> > -- 
> > 2.43.0


Thanks, again!

Reviewed-by: Nicolas Schier <n.schier@avm.de>
