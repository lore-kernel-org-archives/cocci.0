Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06226C282CD
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 17:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BYfX7ahdAx14xenhiSbgtax3duc93F62obxPkYvV944=;
  b=aKNgd3IpkjJJsl0DmH1HlCNWaCky+eSIYt83l9h1t32FRpaFCHa5k84/
   bj1/GfWgckZF5VCbZdfVauyMhzixOC00n6kw6xSKg+AFM7TrFZ0ncPSpV
   fe9kjgO4ZA5ZkrGNmTiGJMqKVhCQRXELANtDx/QPOmQsqoJPA/YYc2F+T
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210955917"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 18:49:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDEEDE0D1E; Mon,  3 Mar 2025 18:49:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F1C3E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 18:49:49 +0100 (CET)
IronPort-SDR: 67c5ebad_dMs0H0DUC7lwDbobvOtUw48JirwMwE4SNFI7sFV81lw1Vhl
 lkoBE9YAUx9fX869kb9tZ9S2JToVghOe9gihpGA==
X-IPAS-Result: =?us-ascii?q?A0HTAAAf68VnfgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuHU4RvhAaBVoF+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDiBVIJ0AosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCA?=
 =?us-ascii?q?QMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHr1l/M4EBggwBAQaCa?=
 =?us-ascii?q?ddzHywiV4FlCYEaLgGFa4JjAYYmhDwnD4FVRIE8g0GECoQUgmmCM4E7L4M9q?=
 =?us-ascii?q?FiBTRwDWSwBVRMXCwcFgTk4AyAKNBQEGQIUHQ8GEARqeoJFaUk6Ag0CNYIeJ?=
 =?us-ascii?q?FiCK2oEBYNbhD2EQII/UYJCghFxgReIAoEthGodQAIBC209NwYDCxsGPaFuO?=
 =?us-ascii?q?oNObAcBUigTFDgmggSTDAkBk1+KP5ReNAeCOIFmgWMMn14GEy+XRQ4GknwBL?=
 =?us-ascii?q?odlkGoiqQ+BZzqBXDMaJIM2TwMZD44hDBaEC48KAbkTQjU8AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBiiACJgELgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:Ko0mmqvnZWMTo5W3LyaN+tP57skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHjJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniEhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:VkVKdGA+aM68Bs/6E3RD5UovI/liSVCez0rfPlTnCk9GQ4TAHA==
X-Talos-MUID: 9a23:pKzK1AY+CJQN4uBT5gXV3B5cGsJTuo+TLmAGjq8ossCvDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="110536960"
X-MGA-submission: =?us-ascii?q?MDEVNbKTbykqik4LcC8VOJmMXHxHGNtDgRggIV?=
 =?us-ascii?q?JpxDA63mSCW/cT5prhrhse1shLzkIWT00Te5ti8h0x8WIx7abMDDBoB0?=
 =?us-ascii?q?oPfsKniv7SCr6TuZ8EEW6nPyoYU6vN78BhbjBq4dVePFtxUkxxiorb6d?=
 =?us-ascii?q?95uQ6R+ArhN0vktbIJEtDdEA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:49:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741024148; x=1741628948; i=markus.elfring@web.de;
	bh=BYfX7ahdAx14xenhiSbgtax3duc93F62obxPkYvV944=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iHEXoSgxSkWYaxNEftQfb60FZ3dHehjWa130JFI5+xqgwqsgzXDpHyjdUp6QHdMG
	 3mQqWWoHtLQ5FeA4e82ZxP5z6jL1/NCgCRdQFxlKPYLkrRQUfPv0WT7iMQJ3JtA9R
	 lCRRwf+/9avb+EPhM/vwj7OkAfwLIex6hW57sn1DPaSd5rOBTjv+7mVLBVPe4GuqU
	 nWg2eUttDZKyuyU0azchzYmbhkEOoTO12ftSzF0HRuWacyvmtwQbht3juOALsMYGy
	 Ax5chNSrQHR30CTC3GXbUiaPwrl1LJklUPGQT7U1oVUlecRZBaAqxSVdH/tsyVEU7
	 DIQR0UFvE/agd7KX1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVGA-1syhgU02a2-00vk09; Mon, 03
 Mar 2025 18:49:08 +0100
Message-ID: <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
Date: Mon, 3 Mar 2025 18:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Simona Vetter <simona@ffwll.ch>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
Content-Language: en-GB
In-Reply-To: <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/k+Xgzr03sFsIQP6/rLbeZ9jBhiTPWWxBW6gyeBMvI3JQbgT9I
 +Y4HgV3wwul18HU6cxSHtB8d2/74o/f4jJeELUakevzSrfaT/yrefYE+E69JzCmstH3zI9B
 yCXvBjH/00Ethv40lD4gvrb27rewWNHvaVZD8rEcm6QJqUD39A6qXWVCQM/2UAZMD6auaU/
 Bo+9LSx5ABwtoAYcX8jDw==
UI-OutboundReport: notjunk:1;M01:P0:bCQY/gSiTXQ=;NrnBi0ajv0riYdZVXn2UBWmn5ea
 M82WcDJ4E/ee4P/thkOyeYYVcChOy6tBfYIORjnJ+WkomlUTPak3+AU3bO7h0jI2gOnXzd7Jj
 hPlcusnKwPXN3NwslXFcJQk7aTN3ZIO3tMIcD+7Ydmc2Y617hJRiRLivLSdgYMcXr71v8a56O
 GNKzkwshWPd8607X9m1vrI9zUmtICtFIgWyGbud4/YWSw+ZwizFiM15d4RYo89eIocHZUFKB8
 nw/JLJs23W169Enq1R/yGeK0deAJ6lcJP+UZ5fIrhkatEcUjQRBGXu8qp0FmsjJxK67begUje
 9Px9nW5cOCUeO+B+tueW+PfC37/ePfewRfRCYxe4KQa/KO4ipC1wVWVmHIckrQxD6gH8q/3Ly
 u5b90ixqgOjkFMn2Uvp8YvF7w2YNdVMtfJ1LWpOj5unkHuJKdCNi+w3eJtIlUc75jLPlXZ0hJ
 9vwcicSUF4surrmDbV+4e+FNaAnEDZgo/FNn0A+yQzMx6YsIfHGe1W+HSHAss7sBM9xwH6vbu
 c5qY9EU49WyD3Ay1Gim2CntSow4Yg7HVq7+rzx1uWqh0155zPT+k1AUxViQvnBzEcIUhaq57j
 WW2/lMMCsTCaihI7etFgBEF9WwNc/YhfpNh5gTIobXjcl3v+b3DGHS27/XdlgFkxg9o15XeWp
 VV+eklQzrVyTy4YqI6H/HJFY2Uuf1GAPdWP2U5AKDZDWya/LIvOwqpqbCCyLSiC/TcPTS8cQq
 1XK3mst42oeSXog9tCktRFDnHMkDPobERTTz6fgPluYhCla8OXueIieDuzURlE7NkR2r7hILF
 9Isayjln6IEF7+1DcF5l5amZuiTjCwg/o16396OfatSC7MVqKltQqNj88Zlbt34JvRXas0t/0
 JAsRi3RNHdb+xHNcootnMZILnt7giqutnUi6GEzFtQKN0NvFvheGisMozARhC0tYJWMEuqs0B
 EXtrOEEll2D8+WkP3onpQnO3oEZxPr/dx8ezhceq7HlXEhLGLl9rSgFEuRFZW05XmYd1GK8ur
 21wfdvxF4eQzOu+Eara2WDoRTb1ciZ9JlMZa0ZKKS0RuvEBcf0q+ufctkz3DoCdAgtLgbuq32
 1D49SwOCB+VfBsXjluLhg81hrb0s0inxWt4kFePmt9vP5180WtOVHyEC4KGiBgMjHzWSCu/qI
 ZTGAgL8li12HjjW3eAtwJSmKHESyr+3aLMTBagLkLbtZZblgEx1H4sL22NaC1nQKbc4TEwry1
 w5yxsVyW3uvlnnwP+ySuAIGbpdtMKVZY9zoWpp2D73gVpGQu2kF3HeJ8hsEfMGGJP7OFlrCuM
 go08a/YhtFNuWP3ULkCGZUdgNlVMD3ovNPG/ZH5lXfB9vNFV+vtxGNu1E2/rtmbYfXmfovCB5
 9ckjVMfYdTJKsdz58F8bBjEc2xdRsbyeVzBxu0I5TN1YtxrFFJa3JvMgbSR15LoCyAhbu2NM7
 hEuoQSnekcH7za5vUZ96XWIUMLZk=
Subject: [cocci] [PATCH RESEND] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2483
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Apr 2023 18:38:54 +0200

The label =E2=80=9Cout_prevalid=E2=80=9D was used to jump to another point=
er check
despite of the detail in the implementation of the function
=E2=80=9Cnouveau_gem_ioctl_pushbuf=E2=80=9D that it was determined already=
 in one case
that the corresponding variable contained an error pointer
because of a failed call of the function =E2=80=9Cu_memcpya=E2=80=9D.

Thus use an additional label.

This issue was detected by using the Coccinelle software.

Fixes: 2be65641642e ("drm/nouveau: fix relocations applying logic and a do=
uble-free")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouve=
au/nouveau_gem.c
index f77e44958037..d87e1cb2c933 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -814,7 +814,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void=
 *data,
 			reloc =3D u_memcpya(req->relocs, req->nr_relocs, sizeof(*reloc));
 			if (IS_ERR(reloc)) {
 				ret =3D PTR_ERR(reloc);
-				goto out_prevalid;
+				goto out_free_bo;
 			}

 			goto revalidate;
@@ -929,6 +929,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void=
 *data,
 out_prevalid:
 	if (!IS_ERR(reloc))
 		u_free(reloc);
+out_free_bo:
 	u_free(bo);
 	u_free(push);

=2D-
2.40.0


