Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E3CA0EFA
	for <cocci@archiver.kernel.org>; Sat, 23 Aug 2025 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Gtc+tpGMbUSggj5NKpjIDQ+0LeHaukEviv91+DJMi2M=;
  b=lWkfIdNLDArKgRPTzUDIU7ktx6DAVTocEMgbRLY3pnIAD94IQHc6KvDs
   beTGtJVW84GPSXUnQSu+FFdVzv7gXjLeYnvpDYUh7F/7/Rb4kbQoHrMK1
   MStvjGXh+TvI16DPYaD6tm49XmOxT7i3+Y6bzNY6LXw8sEWs3v11PU/ZO
   I=;
X-CSE-ConnectionGUID: O5DWomfgSdCrV4sGCQp+Mw==
X-CSE-MsgGUID: qQhYAabGRceri1m4pqYhfw==
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
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235840037"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2025 11:55:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A036FE0B0D; Sat, 23 Aug 2025 11:55:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EEC83E0172
	for <cocci@sympa.inria.fr>; Sat, 23 Aug 2025 11:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=Gtc+tpGMbUSggj5NKpjIDQ+0LeHaukEviv91+DJMi2M=;
  b=Lf0b2k4ZKkkwAtVLgOjdXXZ9l6R+8oSvCaPj37v7dxOEWYoggXVmWkS5
   xNU7j9kSexbQVON9vRT6+jOg16Q4v7iTzUhshxidfsmpnEvpQAC56NeqA
   o+JN3Z9dUyc2wHZhMfnMPLrmp7iECnn6I0NkAkg9sJUFOXkCNngAA7PCT
   E=;
X-CSE-ConnectionGUID: aamwfbypQ7yAkOteMiR5+Q==
X-CSE-MsgGUID: PcpVWOzhRfq8S/yVoz4szw==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235840036"
Received: from unknown (HELO smtpclient.apple) ([172.59.113.151])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 11:55:10 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 23 Aug 2025 05:54:59 -0400
Message-Id: <5E6FF0AD-40B1-40ED-A0E7-47552B565E4D@inria.fr>
References: <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
Cc: cocci@inria.fr
In-Reply-To: <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2977
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/5E6FF0AD-40B1-40ED-A0E7-47552B565E4D%40inria.fr>

The when exists is what you were missing. How you arrange the rest is up to y=
ou.
Sent from my iPhone

> On 23 Aug 2025, at 02:08, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>> An interesting difference display can be generated then.
>> Do such script variants indicate data processing difficulties
>> for the handling of SmPL exclusion specifications in combination with
>> a selected variable declaration?
>=20
> I guess that another SmPL script example will influence corresponding deve=
lopment ideas.
>=20
> // See also:
> // pci_bridge_release_resources()
> // https://elixir.bootlin.com/linux/v6.17-rc2/source/drivers/pci/setup-bus=
.c#L1711-L1767
> @adjustment@
> identifier var;
> @@
> -unsigned int old_flags;
> ... when exists
>     when !=3D old_flags
> +unsigned int old_flags;
> var =3D old_flags =3D r->flags & PCI_RES_TYPE_MASK;
>=20
>=20
> Regards,
> Markus

