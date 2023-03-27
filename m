Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0816C7619A
	for <cocci@archiver.kernel.org>; Mon, 27 Mar 2023 07:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=po1YB3zzwTvAeDk4QrRhzjRKjxgLVriihfkfulXN6N8=;
  b=AbdxZ+WUHQLC92XXb2eyQCXoal2m+TcbNke4wTVUHSoairhUJ0S8/hd6
   Bsh9usSclR7gzFJCpBVMW/CVeEn3DEnqSL1JaTj3zE9l285WfslA/a8mF
   uQC4UKo0XXnrJmsGMwgSTpHnYuBNX53kCdeQWDX+nYEXp7Mhz0chrlRBe
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,294,1673910000"; 
   d="scan'208";a="99196960"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2023 09:00:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BA5D7E0D46; Mon, 27 Mar 2023 09:00:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76591E0D42
	for <cocci@sympa.inria.fr>; Mon, 27 Mar 2023 09:00:50 +0200 (CEST)
IronPort-SDR: 64213f18_azAcjlkzEV/Ao9f28KpeDt5Q9o50P6fwUUMMEkLYyJa5f0T
 Mvbis+ZVZ5nTAMfqdZWFmSX3+MQxpfI5MTgzBcQ==
X-IPAS-Result: =?us-ascii?q?A0GIAADZPiFkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORAS4DhC+HLIwhhAKDFj4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnMChToCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHrUV/M?=
 =?us-ascii?q?4EBgggBAQaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgRUnDIM1iByCZ4Iqj?=
 =?us-ascii?q?lQBiD8KgTRzgSAOgT2BBAIJAhFrgRIIa4FtD0ACDWQLDm+BSgJkTIEXJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQ?=
 =?us-ascii?q?jc0EwZcASkLDhEDUIFGBIENgQEGASYkmmSCZwFSO0wmgWYLE5JYEY5lg0qeD?=
 =?us-ascii?q?jQHgiiBVYFZDJ8MBhMulwgOBpIjLoctkA8gp3qBeSSBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?YQMjwkBPj80OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 9igoiAYs+qCRNsyOLCWO6dDiFRd1Prmgw==
IronPort-Data: A9a23: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
 Qkix0DN
IronPort-HdrOrdr: A9a23:Y3/q6qsggNVom+pKYvhOTL2x7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,294,1673910000"; 
   d="scan'208";a="51322202"
X-MGA-submission: =?us-ascii?q?MDE095Mfr5I7jP5jDdu/Js3dFPDKS3cje1FHAM?=
 =?us-ascii?q?3lm3taO8AkTHZVRqgulBF+JBkRDEZn8TDBTR12Hubsdl4fkXm1wjkHTt?=
 =?us-ascii?q?ntxzfuXcWIWSUJZ7pAqgln45gM21R7R/TQRwsH09M56iJ4ztUzGMuPcQ?=
 =?us-ascii?q?FLh0D+YGZjMehXA/ka83/J8w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 09:00:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679900420; i=markus.elfring@web.de;
	bh=KYeQJ2iSIw9a5DBSevQ2cZUA9XyyUbgV/mRNUr390g0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=bCCpypFEM4nAjC6UZkz1BAR1HWeW1GDpQIePonFXaJhkL4SQ2WjXccB6xUUjv7y9E
	 iIhVU/VJDN5XoI/hA66QH68fnkScB96Qs5ER55coHxtAavjBudiQfaMAiCimRhPjdL
	 Jm0yqVs+vZPmkJJItlXGP/qWdk/9nJ470MBQmVd7xX9rhvL4BIDW/91yKz0pfUlGae
	 xmB9YkmY9MUaryRUIGOUSkqeHGlGrR2jAo+BVtnWb14uhqprpNgREEhjtr8K+1RKRa
	 DUZQitedbcmW+6zNYIH4xBONIpOOmGJZ23Er1bN1u4tLkf7iJbwuOeX9Uwu/Caiv10
	 dMgV03p+jLObw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1pmzIz0JJp-006tgb; Mon, 27
 Mar 2023 09:00:20 +0200
Message-ID: <57a97109-7a67-245b-8072-54aec3b5021d@web.de>
Date: Mon, 27 Mar 2023 09:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
 =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
 Eric Paris <eparis@parisplace.org>, Michal Orzel
 <michalorzel.eng@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Ruiqi Gong <gongruiqi1@huawei.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Ruiqi Gong <ruiqi.gong@qq.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
In-Reply-To: <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UbZa221zGxiEmjS2QIy5DbxqbaMm7xhJSQVsUsJPIcF6j0pQ65d
 KqJ2KKcRUkm6ycuIpLG8RdGImzVAyaKRfHr0wFuMf/f4OZluVSyVcWst+Ex2dV7kD1ZeV6p
 SoxGVdCcL41GwyqKMu4+5rogIYaRIkbQy56SS8Feh+59pAuPrZ14BvHNv3uRLWiU4Xs795z
 hVCknUSTIq/9X7/E0LLug==
UI-OutboundReport: notjunk:1;M01:P0:i0zK8yjhw3c=;qDQCqvIqtn9wxU2EugFQbfF/PUO
 naFChc1Pjp470JyJWBWGR6U6GDUsRq5vdTYZl2OeHizRm3+L8lsDrgpHEwRtAjAvDnklAT7GB
 ry773zAdkMmnzV5P3XFha92KzqwjKbvvp/0GgZ5/rKGh2Q5NnAF/OFtvqy2xXukFP2B5aHKaE
 55tqeDw7k8xXKOQNa15Df87byOWHX9XXQUToTTP5VoANf2HN8/OGTJJs/uciWHvzzfVXf62na
 fk3WS2DbnEkU3nJygpfQdB3T4DcGrR7lmFGYbx01E7cXcdJv6AA2wozdPOeizivbJQhjjhk4I
 BSptT/U/pu4F4N9bJ7dhh4MDvLyIaBtjQzKlyGrBBg0+E8gSBtBa6+K0gdhgh55TFVLPWq+8O
 3C+sbQxTJUYnbikH5zsYOGTr0Ntpppx1/7jRxX5kODR/dMNsBt9zTLo8YsF9SUx/4hqwCQXQA
 itSJ+y2jOcbZ++pekCFVv3KUSBqHMJgGTNdR2rxotJq+G4G3aUuMYMgJyPq+hMjh/CpwhMrMQ
 F0+z9nVGyrPBdtx8v+pc2tjnLCjM4sVgKyjMfnN8QRnuTGFGCcRvI1FXWFNHjf6KjzNxPqiYv
 /tNqIMhQHm1musEuSPkVIC6bpNs2G17nXDFg8q8kh9EpsYg/7vMenQ91IyOwt4BGxaeperjDt
 R//1YC/FYpZM8AsKEp1HgD8dA2/8MvfvPOZd6glmh1hGuxy1thY2mGM+f9DsxTJ6qMuSV3YsG
 xm19Ikdms7H0gIHADvX3YpBljc2DyonFCdAGtasK7hkI9isIZE5JogUGE3tXV5pY3H2rr3Bqb
 6yA8DTMz5WAAQPxYIwoP38jRRDihSee9u7jsenrVV+DSSipuh9LGbzQ7OKB+14u5OkBR4Eks4
 cxjQ1Bu414oFkEm+m9kN+HXaMHkmFz//ySGOhl0cGWSX7R7BDKVjx2p2V
Subject: [cocci] [PATCH v2] selinux: Adjust implementation of
 security_get_bools()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 963
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/57a97109-7a67-245b-8072-54aec3b5021d%40web.de>

Date: Mon, 27 Mar 2023 08:50:56 +0200

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Csecurity_get_boo=
ls=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

Thus perform the following adjustments:

1. Convert the statement =E2=80=9Cpolicydb =3D &policy->policydb;=E2=80=9D=
 into
   a variable initialisation.

2. Replace the statement =E2=80=9Cgoto out;=E2=80=9D by =E2=80=9Creturn -E=
NOMEM;=E2=80=9D.

3. Return zero directly at two places.

4. Omit the variable =E2=80=9Crc=E2=80=9D.

5. Use more appropriate labels instead.

6. Reorder the assignment targets for two kcalloc() calls.

7. Reorder jump targets at the end.

8. Assign a value element only after a name assignment succeeded.

9. Delete an extra pointer check which became unnecessary
   with this refactoring.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 security/selinux/ss/services.c | 52 ++++++++++++++--------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services=
.c
index f14d1ffe54c5..702282954bf9 100644
=2D-- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2964,53 +2964,45 @@ int security_fs_use(struct super_block *sb)
 int security_get_bools(struct selinux_policy *policy,
 		       u32 *len, char ***names, int **values)
 {
-	struct policydb *policydb;
+	struct policydb *policydb =3D &policy->policydb;
 	u32 i;
-	int rc;
-
-	policydb =3D &policy->policydb;

 	*names =3D NULL;
 	*values =3D NULL;
-
-	rc =3D 0;
 	*len =3D policydb->p_bools.nprim;
 	if (!*len)
-		goto out;
-
-	rc =3D -ENOMEM;
-	*names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
-	if (!*names)
-		goto err;
+		return 0;

-	rc =3D -ENOMEM;
 	*values =3D kcalloc(*len, sizeof(int), GFP_ATOMIC);
 	if (!*values)
-		goto err;
+		goto reset_len;

-	for (i =3D 0; i < *len; i++) {
-		(*values)[i] =3D policydb->bool_val_to_struct[i]->state;
+	*names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
+	if (!*names)
+		goto free_values;

-		rc =3D -ENOMEM;
+	for (i =3D 0; i < *len; i++) {
 		(*names)[i] =3D kstrdup(sym_name(policydb, SYM_BOOLS, i),
 				      GFP_ATOMIC);
 		if (!(*names)[i])
-			goto err;
-	}
-	rc =3D 0;
-out:
-	return rc;
-err:
-	if (*names) {
-		for (i =3D 0; i < *len; i++)
-			kfree((*names)[i]);
-		kfree(*names);
+			goto free_names;
+
+		(*values)[i] =3D policydb->bool_val_to_struct[i]->state;
 	}
-	kfree(*values);
-	*len =3D 0;
+	return 0;
+
+free_names:
+	for (i =3D 0; i < *len; i++)
+		kfree((*names)[i]);
+
+	kfree(*names);
 	*names =3D NULL;
+free_values:
+	kfree(*values);
 	*values =3D NULL;
-	goto out;
+reset_len:
+	*len =3D 0;
+	return -ENOMEM;
 }


=2D-
2.40.0

