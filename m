Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185CD1CDC6
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=05T7CcixS3umwoyt3Xx2UmgjbtUip4yfRFlv0kqijm4=;
  b=SIC1wZR1Kz5cRN8rZVz+x6lE7hwuSuCbji4J0EoFHVfiXOvjRdVkwGnY
   u4TBN9Zkdp2LEXKkNIp6dhXZ+ya1DvvdhZ5/+YO2YfGxUQavbAmzEXVIJ
   PDl40z7UupIhkxDii0K0LcBx3DCl4pblVOSdA41ZRXkaOgCVnepRGx8eu
   g=;
X-CSE-ConnectionGUID: gSyUdnxHTU+9UxKspx8+7Q==
X-CSE-MsgGUID: khaezOIPTUaRkgCB9Vnjmg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208,217";a="253498472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:20:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8C2DAE0137; Tue,  9 Dec 2025 11:20:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by sympa.inria.fr (Postfix) with ESMTPS id A363EE00A5
	for <cocci@sympa.inria.fr>; Tue,  9 Dec 2025 11:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:in-reply-to:references:subject:
   mime-version;
  bh=05T7CcixS3umwoyt3Xx2UmgjbtUip4yfRFlv0kqijm4=;
  b=A3LnJcvZ2w671B8GzorwWqhh4ONKCN7cKicnuisCkI2n+8ClVSz0D25w
   WfTJ9VAcOiBssXx7M//URAi9kZ6qXsvGFeEo95oz9wc4C7XM+d0ff0u84
   J89TdE24q36tsacGzIjHu3HC8XEJp0WN2yO6v1GJmFlwVB3YI0cZhZpPB
   Q=;
X-CSE-ConnectionGUID: tGshFxpVQhemJQ769NlGiQ==
X-CSE-MsgGUID: 1iJcZL8MQ8aD6JYafAuQ9Q==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208,217";a="253498468"
X-MGA-submission: =?us-ascii?q?MDEaLiXhcxOLZyrBKXeUHt/RIyYMxAYwxwQMMB?=
 =?us-ascii?q?Fb2dymSICe0xxd4vtaUIs0f+/JJV9MAJGixejUdSZGVdqkvSAGmMx5Ub?=
 =?us-ascii?q?SbLdnRMuLjkDl17tHXzaiUkhst0PWwJRlYmmV6memdTuB+QUN31HCqBR?=
 =?us-ascii?q?CgOBexwK71TigF+t3x2F5rSw=3D=3D?=
Received: from zcs2-store7.inria.fr ([128.93.142.7])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:20:06 +0100
Date: Tue, 9 Dec 2025 11:20:06 +0100 (CET)
From: Victor Gambier <victor.gambier@inria.fr>
To: cocci <cocci@inria.fr>
Message-ID: <27367873.74089117.1765275606598.JavaMail.zimbra@inria.fr>
In-Reply-To: <20251203030737.ED842147E24@quitefranklypodcast.com>
References: <20251203030737.ED842147E24@quitefranklypodcast.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="=_4ba007b9-818b-4a02-9c94-5c267b8a9431"
X-Originating-IP: [128.93.66.153]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraWebClient - FF145 (Linux)/10.1.14_GA_4838)
Thread-Topic: Spam warning! "Contravention en attente =?utf-8?B?4oCTIE1ham9yaXTDqQ==?= automatique sous 48h"
Thread-Index: UJwwEiY3fVYFE61oDrK2PufAwMJX4w==
Subject: Re: [cocci] Spam warning! "Contravention en attente
 =?UTF-8?Q?=E2=80=93_Majorit=C3=A9?= automatique sous 48h"
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3258
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/27367873.74089117.1765275606598.JavaMail.zimbra%40inria.fr>

--=_4ba007b9-818b-4a02-9c94-5c267b8a9431
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,=20
An email titled "Contravention en attente =E2=80=93 Majorit=C3=A9 automatiq=
ue sous 48h" was sent to the cocci mailing list. It is spam and should not =
have been distributed. Please ignore that original email and don't click an=
y links.=20

I apologize for the inconvenience,=20
Victor=20

> De: "ANTAI" <support@secure-mail.com>
> =C3=80: "cocci" <cocci@inria.fr>
> Envoy=C3=A9: Mercredi 3 D=C3=A9cembre 2025 01:09:17
> Objet: [cocci] Contravention en attente =E2=80=93 Majorit=C3=A9 automatiq=
ue sous 48h
--=_4ba007b9-818b-4a02-9c94-5c267b8a9431
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi everyone,</div><div>An email titled "Con=
travention en attente =E2=80=93 Majorit=C3=A9 automatique sous 48h" was sen=
t to the cocci mailing list. It is spam and should not have been distribute=
d. Please ignore that original email and don't click any links.</div><div><=
br data-mce-bogus=3D"1"></div><div>I apologize for the inconvenience,</div>=
<div>Victor</div><div><br></div><hr id=3D"zwchr" data-marker=3D"__DIVIDER__=
"><div data-marker=3D"__HEADERS__"><blockquote style=3D"border-left:2px sol=
id #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt;"><b>De: </b>"ANTAI" &lt;support@secure-mail.com&gt;<br><b=
>=C3=80: </b>"cocci" &lt;cocci@inria.fr&gt;<br><b>Envoy=C3=A9: </b>Mercredi=
 3 D=C3=A9cembre 2025 01:09:17<br><b>Objet: </b>[cocci] Contravention en at=
tente =E2=80=93 Majorit=C3=A9 automatique sous 48h</blockquote></div></div>=
</body></html>
--=_4ba007b9-818b-4a02-9c94-5c267b8a9431--
