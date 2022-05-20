Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C55DC433F5
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=H3IiWYc/ld/ehqylGi7IXwob2x1CppU0/JTGX5iXWhE=;
  b=eZEj/eun+6p+cHpIBoEoVgjpWeYQxIYx5UdFkoGhZMHzw3MBdiRDaFgS
   m9QXUYfaAa/8shs/r+hOCFMk5DmWB2CTcbvQP74YJYGV5kuf4QBlrknYB
   /UeUENshKWaLqC46RdhBifkd577MLMOgdf5v458Eu8cdXawIz/jv9N6kY
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="5.91,238,1647298800"; 
   d="scan'208";a="37263391"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 10:05:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB68DE4375; Fri, 20 May 2022 10:05:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 27FC4E0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 09:47:34 +0200 (CEST)
IronPort-SDR: R3wlUHIBSbboiG4UYAO8BSbr2W8cG72oJIQfIMBiIfzaTdBiSJfIYvlsK6djeD956xZub/Vjqb
 bRkVg9kEgBLsdqdaPzlEDVPq6JbVU/GWIpVo1nllDXoVSSyp2BjmVOMNAZ16fJ/w1/4/VG7Jmz
 Xbp/RQ33Fw+rqVM89jQUeZWUw6PgObHUtmdPQXXaoYzkAZV49zbQDubxRWgiq37/fArT0i+WVl
 7lK6zyXP8wk7tIsN+cicAcKbYQqsxOGs+imOPVl3Epj/I31y2zdX3kvx6G6R+ffCTrwh8yhiDd
 dSfQ+KMAWdbFwkUa0vT7QLOw
X-IPAS-Result: =?us-ascii?q?A0BnBQCKRodi/z4rTJBagQmDc4EDTysDBwhDhE6JAIgPn?=
 =?us-ascii?q?HiBaAsBAwENPwECBAEBhQIChUAfBgEENBMBAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBAGBCDJkZoFBggQGAwEwDYI1KQGDZAECAgEjHQEBNwEECwsaA?=
 =?us-ascii?q?iYCAlcGhgQkrA+BMYEBgggBAQaCXoMrgVwJgRAshz+HJEOCDYQ/PoQPhAuCZ?=
 =?us-ascii?q?ZVFHTsDHDI5EoEhcQEIBgYHCgUyBgIMGBQEAhMSUx0CEwUHChwOFBwkGQwPA?=
 =?us-ascii?q?xIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHwsIAxofL?=
 =?us-ascii?q?QkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oCwMUDwEGAwYCBQUBAyADFAMFJ?=
 =?us-ascii?q?wcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAnEKKA0IBAgEHB4lEwUCB?=
 =?us-ascii?q?zEFBC8CHgQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxYZHRkBBV0GCwkiHCwLB?=
 =?us-ascii?q?gUGFgMmeQUKDCgBHZdDBgKDWFitcJJ9g1eBQ557gUOVHIsFhnWWZ6ctgXgla?=
 =?us-ascii?q?XAzGggmCoMjTgECAQIBDAECAgECAQIBAgEIAQEBAY4pFogphgdCMTsCBgsBA?=
 =?us-ascii?q?QMJhUUBiwMBAQ?=
IronPort-PHdr: A9a23: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
 i3fsow3y2w=
IronPort-Data: A9a23:qRCJQ6BBYRyxxRVW/+3lw5YqxClBgxIJ4kV8jS/XYbTApDN2hTBRz
 WEcX2/VPfqLM2L1ct0ga4S3/R4PucXWx4NlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0HqPp8Zj2tQy2YXgUlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYo3LUmcFU9
 IVAjJuLWwM4GvTou79eYgYNRkmSPYUekFPGCWO+qdeUy1Dacnzq2LNoAV1e0Y8wo7orRz4Qs
 6BDbm5XBvyAr7reLLaTSO5sj8IlIdLDJ4IHoXZk0C3YCvA9B5bOX80m4PcDg21t2ZkQRJ4yY
 eI+KjRkQFORaSQeZFM9Uog/rsaVpGDwJmgwRFW9/vNqvDOIl2SdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7ndITgYXTUC8peSli0m4QJRZJ
 lB8FjcSQbYasxGtX/zBDxCBp0WWug84Av5zSK4L91TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mNlefu5X1SDV5XFExqgGqeoQSCaZHFPfD5ZDcMQZVpZsoC7yG0mpkiXFr5e/LiJYsrdNRyY/
 txnhDNlwa4SldUM07in/FfBmHSqq4Shou8JCuf/Aj/NAuBRPtfNi2mUBb7ztKgowGGxFAHpg
 ZT8s5LChN3i9LnU/MFNKc1UdF1T296LMSfHnXlkFIQ7+jKm9haLJN4NumEvdBkzbJlbJFcFh
 XM/XysBvve/21P6N8dKj36ZVpxCIVXIT4+/DamFNrKinLAoLFLYoHoGibGsM5DFyxFxzvpkY
 v93gO6sAGoID6l9hD2wQ+Yb3Pckwyo+rV4/trirpylKENO2OhaodFvyGAHfM7xntfrf8W04M
 b93bqO39vmWa8WmCgG/zGLZBQlTcyVT6Unep5MFe+idDBBhHW19Wfbdzal4Jd5+nrxOkePV4
 nC6XFQezlfj3CWVJQKPY3FlSbXuQZcm9StjYXZ3ZAv01ihxe5ur4Ycea4AzIest+tt8wKMmV
 PICYciBXKhCE2yV5zQHYJDhh4V+bxD31xmWNi+obWFnLZ5tTgDE4PH+eQ7r+HVcBya7r5Jg8
 aahzhjcRYcfRgNkF4DQZe72lwG9un0UmeRTWUrUI4ALIR2wqtMzdnD816ZlLdsNJBPPwiqh+
 zyXWRpI9/PQp4IV8cXSgfzWpYmeDOYjTFFRGHPW7OjqOHCCrHaj24JJTM2BYSvZCDHv4Kyna
 OhYk6P8PfkAkAoYuoZwCe81n7k//8Doo6JGzwNiBzPNYkjyUuFsJXyP3M9usKxRx+YB4FPqA
 BnWp4VXaeeTJcfoMF8NPw55PO6N4u4Zx2vJ5vMvLUSkuCIupOibUV9fNgWngTBGKOcnK5ssx
 Oos5JwM5wqkhkZ4O9qKlHkFpX/XaGcBS74gsowGAYjtkUwtx00bOc7QDSr/4ZeubdRQMxBye
 2fI3vGb2uhRlhjYbn4+NXnRxu4M150BtSdDwEIGO1nUyMHOgeU63UEJ/Dk6JuiPIs6rDw6n1
 qlX20xJyWGm5DZwn89HQnytHAdaQhuU5iQdDnMXwXbBQRDAunPldQUA1SSlpSj1MF6wuhBA/
 amDz2L4TTftetq32CYuMaKgg+K2VsR/r2Uuh+j+d/lo3PAGjf7Nma62fm0MtgfmBsUqwkvKu
 YGGOQq2hbLTbUYtnkHwN2VWOXn8hvxJyKyujMyNJJ80IFw=
IronPort-HdrOrdr: A9a23:YRAJT6MCkuIYC8BcTuijsMiBIKoaSvp037Dk7SFMoHtuA6ilfq
 GV7ZEmPHrP4wr5N0tBpTntAsa9qDbnhP1ICOoqTNGftWvd1VdARbsKheHfKn/bak/DH4VmuZ
 uIHZIRNDS9Nykcse/KpA2xFsgp29XC+6i6je/Epk0dND1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,238,1647298800"; 
   d="scan'208";a="37257161"
X-MGA-submission: =?us-ascii?q?MDE/vGgVGUbcMsMnp5ycawVxvHCDzHYkqa3udi?=
 =?us-ascii?q?l+a7Hzwb/Su6LiZDX8PUJSKvSBt9KEDxIvEbnR3AWGaFIR8uHTCYRT4M?=
 =?us-ascii?q?A+GBhZazkYf4nSJ5MOa08Y4ANFFsspeFUtNoM9NGWmTf9PfG2a5ffUox?=
 =?us-ascii?q?Wuvruu+n7K7dkFkuFlL5yV1Q=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([144.76.43.62])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:43:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H3IiWYc/ld/ehqylGi7IXwob2x1CppU0/JTGX5iXWhE=;
	t=1653032618; x=1654242218; b=Oxp/tB09+Y7YLS7C4R0uQSMqQXmpOPP2f6jlywQEyatG6Et
	+ZZvqCwqcXoeRNvn0mCKIVCYc2Z2DipHzLpBhCRcg0OnwdR3X6m03v30X9VbyH+4VJO8khQsytOH3
	ZszNU1/g+gZZAOnq2jqJMNNvZoiMS+TXvMQWTFV5ZPodqPAECAizQvQjmb+7xJcVSfzoVtYA2oHuw
	xyUXLlh2RC2cRzYe6Uoa+mkScDO7sVR0+Tm5NVwE4MXpjb89TW/dZ5RLQ2GyDsfZrYyMpb1Qbez9R
	2gmknvxxq7mn6FWJwlQHEfS0rKsqN+DGhlWDdD/16AO3r44k359fF2HyBxn+OLdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	(envelope-from <johannes@sipsolutions.net>)
	id 1nrxIP-00HFfV-IF;
	Fri, 20 May 2022 09:43:37 +0200
Message-ID: <4a2ec549dfaa78af3bab6a1bf4dcb3aadc2797e5.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Fri, 20 May 2022 09:43:36 +0200
In-Reply-To: <alpine.DEB.2.22.394.2205191426480.2389@hadrien>
References: 
	<9a0a9798f3be1950e11155a87d357442122e1685.camel@sipsolutions.net>
	 <alpine.DEB.2.22.394.2205191426480.2389@hadrien>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] more precise switch/case matching
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 401
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/4a2ec549dfaa78af3bab6a1bf4dcb3aadc2797e5.camel%40sipsolutions.net>

Hi Julia,

Thanks for your answer!

> This one might work if you make the rule in two steps:
>=20
> @@
> expression E;
> position p;
> identifier OTHER =3D~ "NL80211_CHAN_WIDTH_(?!320)";
> @@
>=20
> switch (E) {
> case OTHER:
> case NL80211_CHAN_WIDTH_320@p:

Interestingly, I had actually played with that too, but didn't want to
make my email overly long. However, somehow I had not gotten it to work
with position matches either.

Your version does work, mostly (see below).

> @@
> expression E;
> position r.p;
> @@
>=20
> switch (E) {
> +#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
> case NL80211_CHAN_WIDTH_320@p:
> +#endif
> }
>=20
> A ... before the +if might be helpful if the above isn't sufficient.

That doesn't parse.

But I put a 'break' after the +#endif to catch the case I wanted.

> > @@
> > expression E, value;
> > @@
> > switch (E) {
> > +#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
> > case NL80211_CHAN_WIDTH_320:
> > ...
> > (
> >  break;
> > >=20
> >  fallthrough;
> > >=20
> >  return;
> > >=20
> >  return value;
> > )
> > +#endif
> > }
> >=20
> > it actually results in adding only the +#if line, never the +#endif
> > line, which is a bit surprising?
>=20
> Maybe it will work if you duplicate the + line in each branch of the
> disjunction.  Actually, it should have complained about that...
>=20

Indeed that works, but no complaints.


Now, I don't need this to deal with everything - we check this spatch in
our CI pipelines and compile afterwards so that we know it did the right
thing, so really we just use spatch because patches break all the time
when things just change slightly (context).

What ended up working for me is the below spatch. One thing I don't
understand there is the second @p match, it feels like in that case it
shouldn't match if there's no OTHER ahead of it, but it still does ... I
first thought I wanted "position q !=3D r.p" but that had the opposite
effect, making both spatches apply in the same place, rather than in
mutually exclusive places ...

Anyway, I think it works now, thanks for the ideas!

johannes

@r@
expression E;
position p;
identifier OTHER =3D~ "NL80211_CHAN_WIDTH_(?!320)";
@@

switch (E) {
case OTHER:
case NL80211_CHAN_WIDTH_320@p:
}

@@
expression E;
position r.p;
@@
switch (E) {
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
case NL80211_CHAN_WIDTH_320@p:
+#endif
  break;
}

@@
expression E, value;
position r.p;
@@
 switch (E) {
+#if CFG80211_VERSION >=3D KERNEL_VERSION(5,18,0)
 case NL80211_CHAN_WIDTH_320@p:
(
  ...
  break;
+#endif
|
  ...
  fallthrough;
+#endif
|
  ...
  return;
+#endif
|
  ...
  return value;
+#endif
)
 }

