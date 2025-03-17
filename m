Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD18C28B30
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 11:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=0Qy+Z/+A8BGKnp+z6dNwksxygrsz+SfFUTQSPIK/HR8=;
  b=NkbdaenY+i+Zvf3VkThcSCsf2vBPVqsZX7B/THE7YrvL9dckL9r9viik
   X2x/FQuVJKxU9BL79IjUHbGeb9Z7lhvaEGSPlCrDXMkWpBNK7l/Hxs7jP
   ALFCvKCyUWt82uBrMboCikZvkqGCiRdUY7SS1fZJMOD5MDqhFRcimF1Bi
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,253,1736809200"; 
   d="scan'208";a="213246903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 12:55:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 446DCE0D1E; Mon, 17 Mar 2025 12:55:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8D0CE0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 12:55:12 +0100 (CET)
IronPort-SDR: 67d80da1_IaQMc5O8Q7OonkXWrKzRkJDZjPzv8njq3WCWeQagyYbr+Gz
 2JPe8iDfJpG5d/Ox8dYMfi/ntDRxt1G7MdaHwcg==
X-IPAS-Result: =?us-ascii?q?A0GyGACVDNhnjtiSqVFaHgEBCxIMQIFIC4JEgSsrNAcIS?=
 =?us-ascii?q?I1voROEBoNUDwEDAQgFRAQBAQMBA4UAiyACHwYBBDMGDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4V7DYJbO4IWLA2BRAEBO?=
 =?us-ascii?q?IFqgmeCVBEHrQWBNIEBggwBAQaCaNk4gV4HCYFIgViEFYJJGgEFbYRhhTcbg?=
 =?us-ascii?q?g2CUIcFOIV3gjOFJ551indIgSEDWSwBVRMNCgsHBYFsAzUMCy4VgUV6gkNpS?=
 =?us-ascii?q?ToCDQI1ght8giiETYQ8hD+FUIIRggWCMYZ7hGEtUIEVHUADCxgNSBEsNxQbB?=
 =?us-ascii?q?j5uB6EJgSeEPAgwXYFMlFaRLKFxgj+BZoFjiRGWVBozgUuVew6TAy6HZZBro?=
 =?us-ascii?q?1sHaYRogX0kgVwzGggcFIMiTwMZD44hGYQUyEtFMjwCBwsBAQMJkByBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rYKAZ6ovs7niXIOiWEBV8ScaV5u2L9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6La90dq7MArhHP9OkP8s1NKZMDUO11HYSL2KgbGC/9SCIVy2ygc+79
 YGT0EWMrSZYjZHZK3BkWqF+qMbsby6GdeT9IXjJhlWLT1CWuVF1UNUGwybGkp5SE1tHpwiDq
 eR4cJBun6JZWkXRt7TPAhPY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJ0x6s4+2
 StqX2y2kzjiYD39vbv7R6d031koqqu9jKFPr3MtiEhEEShtu9vXvUgZ1TNhkF3nAjl0idTrD
 CFmWZaAy000QKYQoj9m2qW5yDwlDkp8HPs0lmenD/qptH4XiszD45biZteaQax0TtUgDjS6t
 M044u1jeslMfr7plWO2/HYExVx0kakq3srluAey3RZTIsFcbdU6YgS5llcHpsMFD/zrNlPKp
 gYMOjMoPJNNV+KZXHQuWdihNSqQ3QoBx+DBkwPoNac3TRalG1wi0EY2MsclHEd849Vcegx28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBQnBNWqDSG6XZJ3v+0i92qIfzI9Fm91CIqZ4safasK
 6xLG9liQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AohOy0GtvxwGkeIQmuhhDQu4B6IsfK0bHz0/sAHa?=
 =?us-ascii?q?KKn9JeYCFZGaB3L1dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmrgUyA1uqeCXSGIOHLdjw5BYNjUj+pSRB1gnmIk?=
 =?us-ascii?q?8oO6OZSVpNi2ssQWvTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,253,1736809200"; 
   d="scan'208";a="213246889"
X-MGA-submission: =?us-ascii?q?MDFJ2qh83w79h6fdk+EVYajzDcTB/c/qvPjEhL?=
 =?us-ascii?q?oYJDEXVUkysB+yNINWYhmHekwEfg7wlBz8nWNY8PxkWG8xJFKHujI42m?=
 =?us-ascii?q?EvyESJn0P0pz7O8kikRzMOaF652wK99w1qz72yDpUdGqHHCp3g0Y3D2s?=
 =?us-ascii?q?TXS9jV/l747RDhTlEyi6he1Q=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 12:55:12 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742212511; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n00qt5CouzlPN+ENl6GENvbF3ynKX0roajGdZtGo8yV816wa4/BTArV+OGlkD4t/Hi
    P2s0RIFECMt8a04O4tD75IOXrhOXrS3ic5N7bppSvsffCQl7tZeXYcvi0NekhTSbMfzB
    d6yxjWvpElXEpGSyfwFlNRiK82ak2JbMOb/zm5NZczMh/Lpp+dMYYYVcBsSJdYJihR4/
    w2llEuqk6MANowxfgW5Fd6lNhQaRmjB3A2PE13X3zZWpPzc0zPHu6j1FkTN5AdAlyton
    rUxzNTeifM/DNgYN+nFyWnH5JsDZLyekxexi+ZEsmk1v4iWJ1tETvIQvx/kdYVoPEtbp
    ua+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742212511;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=0Qy+Z/+A8BGKnp+z6dNwksxygrsz+SfFUTQSPIK/HR8=;
    b=BhpTpPN6x07kUra1UAr1iZSICK7epnaG+nEOph0uP9F5bWLSQ7iaTo3KBvKuxa2q8+
    sGVHrevKzYQxmkp4HjeWCopemyDa81H6bT1+N5rgpi8fmry2htQb0iGbtg+2YNkgLWjc
    Mf52BQg430715N3wfiDtaxlKJMAgp2HqYTH1FnHlX0yVjwVhHW1mKiv0ks/0KkKxj97e
    K9NYyBD2Gh2001zYrcE/cbhpawvuqON8qZml+CfuoBEie7Xt6xR5UrC8taHuyOHylWlG
    BUCohFuQp8azcUHjRbdKwvKm4kAtv8mYtCIy++NxTBFVMc1VokxYd+35Qet4EB39lDfC
    A+sg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742212511;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=0Qy+Z/+A8BGKnp+z6dNwksxygrsz+SfFUTQSPIK/HR8=;
    b=XB5UvRJTwsYvjQmnM3oxFvG0OT6Q+jQyxzgnlzga1s2fhaTeYYBvssXeeMl2mY9Ksf
    ABRQzWBxvtbruIArx8M+9l9k782Hzh4sMQLP27pJC+ryrWN1hckXpD/7WWG7dfV5CFJf
    c+f50StnP//9tVmYg0QsduSll4xvSYXkM1xdGHxAoFYX4tcNV+oCKh9lARLNSbaEXyWW
    8orU7f0QRnufnOChlWsPWxKx7TTSOgwHQvqgmhoNOCU3Jr2WPtLgq6rM1SiBm9zgxoSS
    uA1lHo/JMAMQzR4eWg9N83koacDigMqrvTBE1Rot/dMTFS9ueY7skhDZYy66KjIWt0Ck
    GVLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742212511;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=0Qy+Z/+A8BGKnp+z6dNwksxygrsz+SfFUTQSPIK/HR8=;
    b=mUhRaXJriM5bsCBkVZg8MYBvr9FDtzDS35pJWgyfWOfbavQCuHpXv+3UtrLFk1k9ie
    duiIbQoNsIXYP4FyYpAQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12HBtBvu0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Mon, 17 Mar 2025 12:55:11 +0100 (CET)
Date: Mon, 17 Mar 2025 12:54:50 +0100
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Message-ID: <20250317125450.29e4b586.olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RylfJ8vOGbcrvYT9UqF2faA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: [cocci] make check results differ in gadget_sorting_hook
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2586
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317125450.29e4b586.olaf%40aepfle.de>

--Sig_/RylfJ8vOGbcrvYT9UqF2faA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

a copy of coccinelle built with ocaml-pcre and another one build without
ocaml-pcre give different results in make check in gadget_sorting_hook.res.
This is the only difference, Str.regex fails to pass while Pcre works.

Any idea why that is the case, with git commit cca22217d1b4316224e80a18d0b0=
8dd351234497?

 gadget_soa_select.res         : CORRECT
-gadget_sorting_hook.res       : CORRECT
+gadget_sorting_hook.res       : INCORRECT: diff token: any_sort_func VS so=
a_gather__particle_data_soa_t
+File <COCCIOUTPUTFILE>, line 21, column 1, charpos =3D 555
+  around =3D 'any_sort_func',
+  whole content =3D      any_sort_func(P);
+File "tests/gadget_sorting_hook.res", line 22, column 1, charpos =3D 624
+  around =3D 'soa_gather__particle_data_soa_t',
+  whole content =3D      soa_gather__particle_data_soa_t(P, P_soa, 0, NumP=
art);
+
+    diff (result(-) vs expected_result(+)) =3D
+    @@ -18,7 +18,12 @@
+
+     int main()
+     {
+    +  /* FIXME: this is a transitory gather-sort-scatter hook solution */
+    +  soa_gather__particle_data_soa_t(P, P_soa, 0, NumPart);
+    +  soa_invalidate_soa__particle_data_soa_t(&P_soa, 0, NumPart);
+       any_sort_func(P);
+    +  soa_scatter__particle_data_soa_t(P_soa, P, 0, NumPart);
+    +  soa_invalidate_aos__particle_data(P, 0, NumPart);
+
+
+       /* FIXME: this is a transitory gather-sort-scatter hook solution */
 gadget_triplets_typedef.res   : CORRECT


Olaf

--Sig_/RylfJ8vOGbcrvYT9UqF2faA
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmfYDYoACgkQ86SN7mm1
DoC0mRAAkewuO+LHx72to9sEwQ3kRPRQzI2Tk08N9ln8lpEfOOUb7Z4BxgGVO9dI
Aq+Zu0YrfqpbHA3ZEJNcUtfZ1oj6KEYWuX7r8+NJnGpFa6i9vsrhSqSWfpoMChCh
n9woHWi7JfraqG3AusQ1gN1o7IbjzpeNlJjpu+IbIdn/q9FZBjKjFr/dzRtonV1x
IR5NDW6Lrea6VynKXtxO2JOsMeuTRTtY8PRjosSCzOVz/Frxn2YDBf9J+ZDYeDfA
+ZUIaHXIawvRUvq3p8R0g2qzyNCNLcdDQ4k88in+tgxfRZ3DRQn2OjtYzS37DhPd
9rb7vOcKx/UG9V8VE2WaDhUcqb8uQXfHtp2fCJwMY9yS10mNvHEOe5hjXslGsqKT
pGADL2r0/wZt358CwmMlPanGaLSzerjQ3rU26I0V7SehHPeS20cWggLHb1f6/LwD
W66qrwBBC/GAt6YyLBC3RvDupMjjyfuUrnPV/Ls/UKZDrSlJS3j7A59vWtrNfREN
2auth+RPTJhDlXpkc/GgFwnjI9wFYQlNpEWE5CS0KH5v5RhboX2JCDoJq174j5/a
Zk5n3q3/OhTUvaC318LaVtL1YvHDnZnqFIIhDwXDeK9BJxEF7iQZEaButJ7EvwZP
oSfZNeSXXGegVzjaclD6bSpIO/e438uV3TmY/F43Z7XzwTPvNo0=
=AOoc
-----END PGP SIGNATURE-----

--Sig_/RylfJ8vOGbcrvYT9UqF2faA--
