Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341ABC6FD1D
	for <cocci@archiver.kernel.org>; Thu, 30 Mar 2023 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SwXZj8hB+YHNLOs3VcEbnolLHHMp8o4/elFLBs5n9j0=;
  b=KgS1MXCj9I1CGyq7SMrFytdUIp/DwduXtTXPlnhvo5zv1/5bP/xhxYPk
   3pRNHmCtKZYcaqLZkP3gZ27esWhFvGzxDt5aJPnp4laGuX3puiklhbm9U
   RcTIb5Gi0aaMvvI1ZWTvjw8LBlOeTLAQCmcUsnZuhqUKyR3+34wZc9PSn
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="99853456"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2023 11:02:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6052BE01D1; Thu, 30 Mar 2023 11:02:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B93DE019E
	for <cocci@sympa.inria.fr>; Thu, 30 Mar 2023 11:02:18 +0200 (CEST)
IronPort-SDR: 64255019_AfttfnvxXFUOGLYPoomT3N2iKCqlaU5/aCxY46TgFgI7Y3E
 Wldth7ltxiqKcSFoplgke+JXgGxcd0uAYT5XuxA==
X-IPAS-Result: =?us-ascii?q?A0GJAwDHTiVkhwsR49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORAS4DhC+HLJAjgxY+DwEDAQ1BAQIEAQEDBDiBU4JzAoU6Ah0HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoD?=
 =?us-ascii?q?YI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQMDIwQZAQERJ?=
 =?us-ascii?q?gEPHwYCJgICTAsGAQwGAgEBgnqCKAEDMQesHX8zgQGCCAEBBpwKHywiU4FeC?=
 =?us-ascii?q?YEULQGMTjaDNnonD4FVRIE8gRWBPm6EHIQAgmeZUwqBNHOBIA6BPYEEAgkCE?=
 =?us-ascii?q?WuBEghrgXxAAg1kCw5xgUoCZEyBLyUEDgMZKx1AAgELOzo/NQYDCyAGWGsCC?=
 =?us-ascii?q?SMREwUDCxUqRwQIOQYbNBECCA8SDyxEDkI3NBMGXAEpCw4RA1CBRwSBDXwKB?=
 =?us-ascii?q?gEmJJ1+NxwoCQqCdpJpsD00B4IogVWBWQyfDAYTLpcIDgaSIy6FT4FekA8go?=
 =?us-ascii?q?kuFLzWBRCSBXDMaJIM2TwMZD44gDA0JFYNuj0g/NDsCBwEKAQEDCQGBVYNwA?=
 =?us-ascii?q?QGDI4JYAQE?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlSP5L9fZIoSLPSh5WSc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:b2xi8KlKX/N93TAzztu/bX3coC3pDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="51679311"
X-MGA-submission: =?us-ascii?q?MDG3floFh9uKIUMg4Xu0xaH36xgsF4fr7ceV24?=
 =?us-ascii?q?2tsR9GY8pLT5g5G/JqzQLGFnEzGBtG6K/JD5dzGxfXuBombv+iUju3Ha?=
 =?us-ascii?q?VN92Y5Bi38xabq2LkCEOzhFdmEKWh+/uvxbcdP99sm83VA7SahyP0z7t?=
 =?us-ascii?q?Vv0im42zs7QyArQ/IfEwZBXA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:02:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680166936; i=markus.elfring@web.de;
	bh=Sc/fP/cB8By67qVNCt6XlSeWx1frrGkJU7XTDOK24Lw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=roNJ4gpga+I7R/ASmrMRi/HzG5IlYGoLzUMww0fagdB5oUmqpGJRRnhIqkcci+3dO
	 SRmHNgPQIcr8eK9Pk9+vLgQFYc/GhFDi4GRLCbfCZXzESYyqAoEdjyxXu/AJJ8V0y4
	 H5ZamN1Bl/cPCg2GKQB77yvM+qdFKpJkNUaCdPLczv3nNuZwbhOmlsQMNax32DGtz1
	 5aYf1mGvoDw7Eaeb5UT59JhJEgYc9dKMDTluQZxF+LZkKmDrKXZVaXeSEhbaUZOFoY
	 /4p2wyaJd8T4dKLJCyV9Ueqq6QRmysDH2hlrLn/FcZx6Fh/8EyqNZOmYwO/tw1VA2W
	 x6yLm6UcGIygA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1pnIsW28w0-0080i3; Thu, 30
 Mar 2023 11:02:16 +0200
Message-ID: <07b7cb49-58dd-f079-c866-8392699916dc@web.de>
Date: Thu, 30 Mar 2023 11:02:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
In-Reply-To: <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uEHkFvfXVZRtGV+lJZ1GQnd6kG1GGaXpmUIOFS0hrV4Knp2+/IU
 5s1y4gJV8KGr9fmiKTfad1UvTxWZY3lcZP3INxKDu42sE2vtlWgC20I+Q0/Rpxqueo5jGSk
 Mmr8bev2DSg6+gd0mp1PR478IX/wRX6PNXMw/567Kqhr6KVY+/xk+nBR9zoBnIT+kAKeenr
 YKuaZW5kaeYErelhqoGcg==
UI-OutboundReport: notjunk:1;M01:P0:osLdLfu8boY=;KGYthjB0Cx9mop/rPmHhQ/WrnY3
 UcGYrdfilKYtWz3IjKh7B3iSrYSK73J5qevbAVW3RI98XjXZZaN+7KHCK5mcVuwdEHr3i+sZb
 8f88b3vwnACFsIVz9OSdN8sW8X+z6wvI1AqbJmmPX2YHD+dsbAojl80H69jRqCvG/B5ZH8Mam
 H+AqZy/2HNDcojfPPWucly5I5k/15k1SjQPQsx43qnSBew0o+XkVJiQeyveaMEGqO7kgWbQoa
 2qlHj12UacvwmjQwp0LL6dK0mlZG2gCs6Ze4LJLg70ObW+WdPA28CVogbDLL+izfJmDiTJiDH
 /lvABsBxMsxt2Ant5HEnx4N73itKNgZ8XA5dj81F21oSKoSjuTz96Enmx3aWFau5unnCp/kvd
 384KriKigM8h80e4HoK5a0xxLBz+MiRdRqZu8V7IG1jGB466cn7OZCi/tYSgrzEDyFpwQNIgq
 2BcmSS6l5yKXoRhctK4jZY7+9pDNwHachv/fcO3r6E3dUpnLumPQ2EFafDhgpc9bxhqslsxBv
 WNTBxmE0KGXQuXtikni0cg08h1oMrbcP5dqHEnU5zE1xchVbVpsKwTOa1iU4d/j4ildPZN0Q1
 FFGqvxgKxBa7yIs0TlHTig9+HSkIGWRV3e7BHWjhlj1AutXUkncLIbPLmHKxZCkrskVpaGMGs
 TDd4NfnRxg+qnVOlws20lyYx/Be15hLXeerf9heatVrzfhXp1j5OZc6E1HHOQycpkuNIbXE7s
 4xfHkl+SArIN7t/XqdJSLqYsRiaq+Q3LO9HkuvTpEvYyWLQnTydYT2YKzbH/RrsPZL24Z2Bc7
 kNo5mtcqUB47KPaTDZT4hADxvtuFLiH/luaM+7aOxAFqOJciHw+MDpp/VZrfWIsbgYXxNSiQU
 uZBJa74h8FWBkTus6oHHU+6CuncNi+n9DKG8uvqJDy5Zda3sIQ/Sy9OrL
Subject: [cocci] [PATCH 4/4] overlayfs: Move some assignments for the
 variable =?UTF-8?Q?=E2=80=9Cerr=E2=80=9D?= in ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 992
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/07b7cb49-58dd-f079-c866-8392699916dc%40web.de>

Date: Thu, 30 Mar 2023 10:25:22 +0200

One local variable was set to an error code in some cases before
a concrete error situation was detected. Thus move the corresponding
assignments into if branches to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/overlayfs/super.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index df5628056d93..cdef9934faf6 100644
=2D-- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1903,10 +1903,11 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 	if (!ofs)
 		return -ENOMEM;

-	err =3D -ENOMEM;
 	ofs->creator_cred =3D cred =3D prepare_creds();
-	if (!cred)
+	if (!cred) {
+		err =3D -ENOMEM;
 		goto out_free_ofs;
+	}

 	/* Is there a reason anyone would want not to share whiteouts? */
 	ofs->share_whiteout =3D true;
@@ -1920,30 +1921,34 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 	if (err)
 		goto out_free_ofs;

-	err =3D -EINVAL;
 	if (!ofs->config.lowerdir) {
 		if (!silent)
 			pr_err("missing 'lowerdir'\n");
+
+		err =3D -EINVAL;
 		goto out_free_ofs;
 	}

-	err =3D -ENOMEM;
 	splitlower =3D kstrdup(ofs->config.lowerdir, GFP_KERNEL);
-	if (!splitlower)
+	if (!splitlower) {
+		err =3D -ENOMEM;
 		goto out_free_ofs;
+	}

-	err =3D -EINVAL;
 	numlower =3D ovl_split_lowerdirs(splitlower);
 	if (numlower > OVL_MAX_STACK) {
 		pr_err("too many lower directories, limit is %d\n",
 		       OVL_MAX_STACK);
+
+		err =3D -EINVAL;
 		goto out_free_splitlower;
 	}

-	err =3D -ENOMEM;
 	layers =3D kcalloc(numlower + 1, sizeof(*layers), GFP_KERNEL);
-	if (!layers)
+	if (!layers) {
+		err =3D -ENOMEM;
 		goto out_free_splitlower;
+	}

 	ofs->layers =3D layers;
 	/* Layer 0 is reserved for upper even if there's no upper */
@@ -1967,9 +1972,9 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	if (ofs->config.upperdir) {
 		struct super_block *upper_sb;

-		err =3D -EINVAL;
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
+			err =3D -EINVAL;
 			goto out_free_splitlower;
 		}

@@ -1998,9 +2003,10 @@ static int ovl_fill_super(struct super_block *sb, v=
oid *data, int silent)
 		sb->s_time_gran =3D upper_sb->s_time_gran;
 	}
 	oe =3D ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
-	err =3D PTR_ERR(oe);
-	if (IS_ERR(oe))
+	if (IS_ERR(oe)) {
+		err =3D PTR_ERR(oe);
 		goto out_free_splitlower;
+	}

 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
@@ -2052,10 +2058,11 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 	sb->s_flags |=3D SB_POSIXACL;
 	sb->s_iflags |=3D SB_I_SKIP_SYNC;

-	err =3D -ENOMEM;
 	root_dentry =3D ovl_get_root(sb, upperpath.dentry, oe);
-	if (!root_dentry)
+	if (!root_dentry) {
+		err =3D -ENOMEM;
 		goto out_free_oe;
+	}

 	mntput(upperpath.mnt);
 	kfree(splitlower);
=2D-
2.40.0

